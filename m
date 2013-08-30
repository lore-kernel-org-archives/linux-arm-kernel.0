From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 30 Aug 2013 11:27:25 +0200
Subject: pinctrl-mxs fails to parse function definitions from different .dts
 files
Message-ID: <20130830092725.GG24802@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I hit a problem with pinctrl-mxs on an i.MX28 machine (based on v3.8,
but I'm sure it still applies to newer kernels). imx28.dtsi defines a
pinctrl function:

	i2c1_pins_a: i2c1 at 0 {
		reg = <0>;
		fsl,pinmux-ids = <
			0x3101 /* MX28_PAD_PWM0__I2C1_SCL */
			0x3111 /* MX28_PAD_PWM1__I2C1_SDA */
		>;
		fsl,drive-strength = <1>;
		fsl,voltage = <1>;
		fsl,pull-up = <1>;
	};

my machine however needs

	i2c1_pins_b: i2c1 at 1 {
			...
			0x30a1 /* MX28_PAD_AUART2_CTS__I2C1_SCL */
			0x30b1 /* MX28_PAD_AUART2_RTS__I2C1_SDA */
			...
	}

so I added a corresponding entry to my machine's dts. The problem with
that is the pinctrl-mxs driver fails to make use of the i2c1 at 1 node
because it goes through the device tree in the order
for_each_child_of_node uses and does (a bit simplified):

	fn = "";
	for_each_child_of_node(np, child) {
		...
		soc->ngroups++;
		...
		if (strcmp(fn, child->name)) {
			fn = child->name;
			soc->nfunctions++;
		}
	}

. Then it does some allocation and iterates a few times more using
for_each_child_of_node and creates the groups for all functions.

This results in i2c1 at 0 and i2c1 at 1 being counted as two different
functions as they are not defined in succession in the dtb. I didn't
look at how the code behaves during probe, but with i2c1 at 1 being defined
in my machine's dtb, i2c1 failes to probe with

	imx28-pinctrl 80018000.pinctrl: invalid group "i2c1.1" for function "i2c1"

and I get:

	# grep i2c1 /sys/kernel/debug/pinctrl/80018000.pinctrl/pinmux-functions
	function: i2c1, groups = [ i2c1.0 ]
	function: i2c1, groups = [ i2c1.1 ]

while when I move the definition of i2c1 at 1 into imx28.dtsi after i2c1 at 0
i2c1 probes just fine and also the pinmux-functions look right:
	
	# grep i2c1 /sys/kernel/debug/pinctrl/80018000.pinctrl/pinmux-functions
	function: i2c1, groups = [ i2c1.0 i2c1.1 ]

This is not intended, is it?

The obvious ways to fix that are either check all already found
functions when a new one is hit and not only the last or using a sorted
list. Any thoughts?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
