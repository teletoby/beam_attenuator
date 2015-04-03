

module dummy_filters(n = 5, radius = 40.0, bottom = 0.5, height = 2.5, diameter = 25.4*1.5, border = 4.2) {
	for (i = [0:1:n]) {
		union() {
			translate([radius*cos(360*i/n),radius*sin(360*i/n), bottom]) {
				cylinder(r = (diameter+border)/2.0, h = height, $fn = 200);
			}
			translate([radius*cos(360*i/n),radius*sin(360*i/n), -0.1]) {
				cylinder(r = diameter/2.0, h = 0.1*2.0+bottom, $fn = 200);
			}
			translate([radius*cos(360*i/n),radius*sin(360*i/n), bottom+height-0.1]) {
				cylinder(r = (diameter+border)/2.0-0.3, h = 1, $fn = 200);
			}
		}
	}
}

module spindle_hole() {
	spindle_height = 10.0;
	spindle_diam = 5.5;
	spindle_sdiam = 3.50;
	translate([0.0, 0.0, -0.1]) {
		intersection() {
			cylinder(h=spindle_height, r=spindle_diam/2.0, $fn=200);
			translate([-spindle_diam/2.0, -spindle_sdiam/2.0, 0.0]) {
					cube([spindle_diam, spindle_sdiam, spindle_height]);
			}
		}
	}
}




wheel_diam = 64.0;

difference() {
	union() {
		cylinder(r = wheel_diam + 5.0, h = 1.0, $fn = 200);
		cylinder(r = wheel_diam, h = 3.5, $fn = 200);
		cylinder(r = 7.5, h = 5.0);
	}
	union() {
		spindle_hole();
 		dummy_filters(radius = 41.0);
		translate([-wheel_diam-4, -0.75, -0.1]) {
			cube([4.0, 1.5, 10.0]);
		}
	}
}
