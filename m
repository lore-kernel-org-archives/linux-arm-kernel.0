From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 13 Nov 2017 01:25:20 +0000
Subject: [RFC PATCH 0/3] pinctrl: sunxi: Add DT-based generic pinctrl driver
Message-ID: <20171113012523.2328-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

so far the pinctrl driver for supporting a particular Allwinner SoC requires
a hardcoded table in the kernel code. This table (for instance [1]) lists
all pins and puts names to each special function each pin can have, along
with the respective mux value to put into the hardware registers. That looks
like:
	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 1),
		SUNXI_FUNCTION(0x0, "gpio_in"),
		SUNXI_FUNCTION(0x1, "gpio_out"),
		SUNXI_FUNCTION(0x2, "mmc1"),          /* CMD */
		SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 1)),  /* EINT1 */
	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 2),
		....

On top of that we have the DT, which groups the pins and refers to the
function to use *by name*:
			mmc1_pins: mmc1-pins {
				pins = "PG0", "PG1", "PG2", "PG3",
				       "PG4", "PG5";
				function = "mmc1";
				drive-strength = <30>;
				bias-pull-up;
			};

This series here moves the data encoded in the table so far into the DT itself,
removing the need for a hardcoded table in the kernel.

The approach taken here is to parse the DT and generate the table with
the help of additional properties, then hand this table over to the existing
driver. This is covered by three basic extensions to the DT binding:
- allwinner,gpio-pins = <[nr of PA pins] [nr of PB pins] ...>;
  This tells the driver how many pins each port has (0 is possible as
  well). The sum of all of them is used to size the array. Also the pin
  names are deduced from it and generated. Each pin gets an entry for
  GPIO in and out, using mux 0 and 1, respectively.
- allwinner,irq-pin-map = 
    <[IRQ port] [1st IRQ pin] [GPIO port] [1st GPIO pin] [mux value] [length]>
  Maps IRQ pins to their associated GPIO pins, describing the pins that can
  actually trigger interrupts. There can be multiple of these maps, each
  consisting of those six values.
  Every IRQ capable pin in those ports gets assigned an additional function
  "irq" (see the SUNXI_FUNCTION_IRQ_BANK line above).
- pinmux = <[mux value] ...>;
  This property (in the pin group subnodes) tells the driver which mux value
  to actually write into the hardware registers upon selecting this function.
  For almost every group this mux value is the same for every pin, so we fill
  remaining entries with the last entry in that property, if this property
  has less members than the number of pins in this group.
For the A64, for instance, this looks like this:
  pio: pinctrl at 1c20800 {
	compatible = "allwinner,sun50i-a64-pinctrl",
		     "allwinner,sunxi-pinctrl";
	reg = <0x01c20800 0x400>;
	...
	/* No Port A, PB0..PB9, PC0..PC16, PD0..PD24, ... */
	allwinner,gpio-pins = <0 10 17 25 18 7 14 12>;
	/* The three ports B, G and H can trigger interrupts. */
	allwinner,irq-ports = <0 0 1 0 6 10>,
			      <1 0 6 0 6 14>,
			      <2 0 7 0 6 12>;
	...
	mmc1_pins: mmc1-pins {
		pins = "PG0", "PG1", "PG2", "PG3", "PG4", "PG5";
		function = "mmc1";
		pinmux = <2>;
		drive-strength = <30>;
		bias-pull-up;
	};
	...

The benefit of this series is two-fold:
- Future SoCs don't need an in-kernel table anymore. They can describe
  everything in the DT, and use the generic compatible as a fallback:
	compatible = "allwinner,sun50i-h6-pinctrl", "allwinner,sunxi-pinctrl";
  So this driver should be the last file added to this directory ever.
  Of course we can't remove the existing tables, to keep compatiblity with
  older DTs, but at least we don't need to add more tables in the future.
  The Allwinner H6 will be the first user of this driver.
- New DT consumers (other than the Linux kernel) could force usage of the
  new binding, if that's feasible for them. They would not need to add
  any SoC specific data into their code, instead have a generic driver that
  reads all information from the DT.
  A prominent example is U-Boot, which at the moment has *some* pinctrl data
  hardcoded, but wants to move to at DT based driver. Instead of copying the
  kernel tables and blowing up the code, we can add the new properties to
  U-Boot's DT copy and keep the code clean.

Please note that the new binding is indeed just an extension, the existing
driver just ignores those new properties and uses the in-kernel table, thus
working as before, without any restrictions.
So we can as well add those new properties to the kernel DT copy, which makes
it easier for other users to re-use the DT files.
The extended DT would add the generic compatible as a fallback, but keep the
existing compatible name in the first place. So existing kernel drivers
would match on the first string and use the table. U-Boot on the other hand
would not match on the specific string, but recognize the generic name and
pull the information from the DT.
This allows the very same DT to be used by both drivers (or both bindings),
triggered by the generic compatible.


Please let me know your opinion on this. The approach to generate the table
from the DT and re-using the existing driver leaves some room for optimization.
But I found it far easier to not touch the actual driver, since we need it
to stay around to support the old binding anyway.
If it seems worth the come up with a separate pinctrl driver which just
supports the new binding and makes the DT a first class citizen, let me
know - and give me some time to fully understand the inner workings of the
pinctrl and GPIO subsystem then.

Cheers,
Andre.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c

Andre Przywara (3):
  dt-bindings: pinctrl: sunxi: document new generic binding
  pinctrl: sunxi: introduce DT-based generic driver
  arm64: dts: allwinner: enhance A64 .dtsi with new pinctrl binding

 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |  58 +++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  27 +-
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c           | 412 +++++++++++++++++++++
 4 files changed, 496 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c

-- 
2.14.1
