From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 4 Jan 2016 11:02:37 +0000
Subject: reason for Allwinner SoC specific pinctrl drivers?
Message-ID: <568A514D.7070102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

while looking at the Allwinner A64 SoC support, I was wondering why we
would actually need a pinctrl driver (file) for each and every Allwinner
SoC that we support.
Looking at both the A20 and the A64 doc I don't see any differences in
the port controller implementation apart from the actual
muxval <-> subsystem assignment, which is just data, right?
Comparing the code files in drivers/pinctrl/sunxi seems to support this,
as those drivers only consist of the table and some boilerplate code.

Now I was wondering whether we could get away with one generic Allwinner
pinctrl driver and put the SoC specific pin assignments in DT instead.
It looks like adding an "allwinner,muxval" property in addition to the
existing "allwinner,function" in the SoC's .dtsi would give us all the
information we need. This could look like:

	uart0_pins_a: uart0 at 0 {
		allwinner,pins =   "PB22", "PB23";
+		allwinner,muxval = <0x02    0x02>;
		allwinner,function = "uart0";
		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
	};

Would it make sense that I sit down and prototype such a driver?

We should keep compatibility with older DTs by keeping the existing
drivers in (or maybe emulating the current behaviour by providing just
those tables as a fallback) , but newer SoCs (like the A64?) would not
need a SoC specific driver, but just go with that generic driver and
appropriate DT properties.

I appreciate any comments on this, especially if I missed something
which would render this approach impossible or tedious.

Cheers,
Andre.
