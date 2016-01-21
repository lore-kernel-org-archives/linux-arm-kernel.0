From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 21 Jan 2016 10:55:07 +0100
Subject: [PATCH] ARM64: dts: rockchip: Add GeekBox config
In-Reply-To: <56A041FE.7000104@suse.de>
References: <1453307913-8907-1-git-send-email-afaerber@suse.de>
 <6705185.M2rneQv8FF@phil> <56A041FE.7000104@suse.de>
Message-ID: <1969169.l2ZMdDHEV7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

Am Donnerstag, 21. Januar 2016, 03:27:10 schrieb Andreas F?rber:
> Am 21.01.2016 um 00:08 schrieb Heiko Stuebner:
> > Am Mittwoch, 20. Januar 2016, 17:38:33 schrieb Andreas F?rber:
> >> The GeekBox contains an MXM3 module with a Rockchip RK3368 SoC.
> >> Some connectors are available directly on the module.
> >> 
> >> This adds initial support, namely serial, PMIC and USB.
> >> 
> >> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> >> ---
> >> 
> >>  Hi Heiko,
> >>  
> >>  Here's an initial shot at a .dts for GeekBox.
> >>  GMAC was not yet working for me.
> >>  
> >>  Regards,
> >>  Andreas
> >>  
> >>  arch/arm64/boot/dts/rockchip/Makefile            |   1 +
> >>  arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts  |  48 +++++
> >>  arch/arm64/boot/dts/rockchip/rk3368-geekbox.dtsi | 242
> >> 
> >> +++++++++++++++++++++++ 3 files changed, 291 insertions(+)
> >> 
> >>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
> >>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dtsi
> > 
> > You might want to explain your reasoning for having a dtsi and an empty
> > standalone dts. I guess you want to add a second one for
> > module+baseboard?
> More generally, as mentioned in the commit message, it's a module, so
> automatically I did a .dtsi to allow for easy reuse.
> 
> At LinuxCon JP I had discussed with Grant Likely about whether it's okay
> to #include a .dts rather than .dtsi and don't remember getting a clear
> answer as we ended up drawing a line between hardware and FPGA.
> 
> And yes, I may later add a .dts for the Landingship - it would mainly
> enable more nodes, I envision. But I assume that we're not bound to just
> the Landingship with such a standard connector.
> 
> For now I'm more interested in incrementally adding further nodes to the
> module's own file.
> 
> > The interesting artifact here is, that the baseboard can actually be
> > used
> > standalone and the baseboard just extends it where in contrast a rk3288
> > rock2 for example isn't actually usable without a baseboard.
> > 
> > So I'm wondering if this really should be encoded in the dts or should
> > uses something like dts overlays instead to enable one geekbox module
> > to be used alone and in the "landingship".
> 
> Well, with the Parallella I made the experience that I used a single
> .dts initially, and it turned out to be a bad choice when we tried
> adding stuff to the DT while new hardware models surfaced - we still
> haven't managed to split it up and it's stuck in limbo without USB.
> I'd really like to avoid that going forward, so I'm trying to look
> forward here in keeping our options open with a clean design.
> 
> How would your overlay get loaded? Wouldn't that need some special
> kernel driver like for the BeagleBone? Not so attractive for a single
> optional baseboard I care about.

It wasn't meant as a requirement, more like a thought I had and wanted to 
discuss ;-) . So far I also only saw talks about devicetree overlays but 
never in action yet.

I would have hoped there to be some gpio indicating if it's connected to the 
"LandingShip" but that doesn't seem to be the case after looking through the 
schematics again.

In any case, going the regular way should be ok as well.


> >> diff --git a/arch/arm64/boot/dts/rockchip/Makefile
> >> b/arch/arm64/boot/dts/rockchip/Makefile index e3f0b5f..df37865 100644
> >> --- a/arch/arm64/boot/dts/rockchip/Makefile
> >> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> >> @@ -1,4 +1,5 @@
> >> 
> >>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-evb-act8846.dtb
> >> 
> >> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-geekbox.dtb
> >> 
> >>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-r88.dtb
> >>  
> >>  always		:= $(dtb-y)
> >> 
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
> >> b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts new file mode 100644
> >> index 0000000..eb24ecd
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
> >> @@ -0,0 +1,48 @@
> >> +/*
> >> + * Copyright (c) 2016 Andreas F?rber
> >> + *
> >> + * This file is dual-licensed: you can use it either under the terms
> >> + * of the GPL or the X11 license, at your option. Note that this dual
> >> + * licensing only applies to this file, and not this project as a
> >> + * whole.
> >> + *
> >> + *  a) This file is free software; you can redistribute it and/or
> >> + *     modify it under the terms of the GNU General Public License as
> >> + *     published by the Free Software Foundation; either version 2 of
> >> the + *     License, or (at your option) any later version.
> >> + *
> >> + *     This file is distributed in the hope that it will be useful,
> >> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + *     GNU General Public License for more details.
> >> + *
> >> + * Or, alternatively,
> >> + *
> >> + *  b) Permission is hereby granted, free of charge, to any person
> >> + *     obtaining a copy of this software and associated documentation
> >> + *     files (the "Software"), to deal in the Software without
> >> + *     restriction, including without limitation the rights to use,
> >> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> >> + *     sell copies of the Software, and to permit persons to whom the
> >> + *     Software is furnished to do so, subject to the following
> >> + *     conditions:
> >> + *
> >> + *     The above copyright notice and this permission notice shall be
> >> + *     included in all copies or substantial portions of the Software.
> >> + *
> >> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> >> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> >> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> >> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> >> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> >> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> >> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >> + *     OTHER DEALINGS IN THE SOFTWARE.
> >> + */
> >> +
> >> +/dts-v1/;
> >> +#include "rk3368-geekbox.dtsi"
> >> +
> >> +/ {
> >> +	model = "GeekBox";

Compatible should probably move here.


> >> +};
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dtsi
> >> b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dtsi new file mode 100644
> >> index 0000000..f083cdb
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dtsi

maybe also rk3368-geekbox-som.dtsi like the rk3288-rock2-som.dtsi. That way 
it would show clearly its status as system on module which then gets used 
somewhere.


> >> @@ -0,0 +1,242 @@
> >> +/*
> >> + * Copyright (c) 2016 Andreas F?rber
> >> + *
> >> + * This file is dual-licensed: you can use it either under the terms
> >> + * of the GPL or the X11 license, at your option. Note that this dual
> >> + * licensing only applies to this file, and not this project as a
> >> + * whole.
> >> + *
> >> + *  a) This file is free software; you can redistribute it and/or
> >> + *     modify it under the terms of the GNU General Public License as
> >> + *     published by the Free Software Foundation; either version 2 of
> >> the + *     License, or (at your option) any later version.
> >> + *
> >> + *     This file is distributed in the hope that it will be useful,
> >> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + *     GNU General Public License for more details.
> >> + *
> >> + * Or, alternatively,
> >> + *
> >> + *  b) Permission is hereby granted, free of charge, to any person
> >> + *     obtaining a copy of this software and associated documentation
> >> + *     files (the "Software"), to deal in the Software without
> >> + *     restriction, including without limitation the rights to use,
> >> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> >> + *     sell copies of the Software, and to permit persons to whom the
> >> + *     Software is furnished to do so, subject to the following
> >> + *     conditions:
> >> + *
> >> + *     The above copyright notice and this permission notice shall be
> >> + *     included in all copies or substantial portions of the Software.
> >> + *
> >> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> >> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> >> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> >> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> >> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> >> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> >> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >> + *     OTHER DEALINGS IN THE SOFTWARE.
> >> + */
> >> +
> >> +#include "rk3368.dtsi"
> >> +
> >> +/ {
> >> +	compatible = "geekbuying,geekbox", "rockchip,rk3368";
> > 
> > you're introducing
> > - a new vendor name (geekbuying), so should update
> > Documentation/devicetree/bindings/vendor-prefixes.txt in a separate
> > patch
> 
> True. I did not check whether they're NASDAQ-listed either, but I assume
> no; haven't compared the downstream DT for what they might've been using
> themselves.
> 
> > - a new board, so should update
> > Documentation/devicetree/bindings/arm/rockchip.txt
> 
> Will do.

And as said above, the compatible should probably live in the dts, not the 
dtsi (see rock2).

> 
> >> +
> >> +	chosen {
> >> +		stdout-path = "serial2:115200n8";
> >> +	};
> >> +
> >> +	memory {
> >> +		device_type = "memory";
> >> +		reg = <0x0 0x0 0x0 0x80000000>;
> >> +	};
> >> +
> >> +	leds: gpio-leds {
> >> +		compatible = "gpio-leds";
> >> +
> >> +		blue {
> >> +			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
> >> +			label = "geekbox:blue:led";
> >> +			default-state = "on";
> >> +		};
> >> +
> >> +		red {
> >> +			gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
> >> +			label = "geekbox:red:led";
> >> +			default-state = "off";
> >> +		};
> >> +	};
> >> +
> >> +	vcc_sys: vcc-sys-regulator {
> >> +		compatible = "regulator-fixed";
> >> +		regulator-name = "vcc_sys";
> >> +		regulator-min-microvolt = <5000000>;
> >> +		regulator-max-microvolt = <5000000>;
> >> +		regulator-always-on;
> >> +		regulator-boot-on;
> >> +	};
> >> +};
> >> +
> >> +&i2c0 {
> >> +	status = "okay";
> >> +
> >> +	rk808: pmic at 1b {
> >> +		compatible = "rockchip,rk808";
> >> +		reg = <0x1b>;
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&pmic_int>, <&pmic_sleep>;
> >> +		interrupt-parent = <&gpio0>;
> >> +		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> >> +		rockchip,system-power-controller;
> >> +		vcc1-supply = <&vcc_sys>;
> >> +		vcc2-supply = <&vcc_sys>;
> >> +		vcc3-supply = <&vcc_sys>;
> >> +		vcc4-supply = <&vcc_sys>;
> >> +		vcc6-supply = <&vcc_sys>;
> >> +		vcc7-supply = <&vcc_sys>;
> >> +		vcc8-supply = <&vcc_io>;
> >> +		vcc9-supply = <&vcc_sys>;
> >> +		vcc10-supply = <&vcc_sys>;
> >> +		vcc11-supply = <&vcc_sys>;
> >> +		vcc12-supply = <&vcc_io>;
> >> +		clock-output-names = "xin32k", "rk808-clkout2";
> >> +		#clock-cells = <1>;
> >> +
> >> +		regulators {
> >> +			vdd_cpu: DCDC_REG1 {
> >> +				regulator-always-on;
> >> +				regulator-boot-on;
> >> +				regulator-min-microvolt = <700000>;
> >> +				regulator-max-microvolt = <1500000>;
> >> +				regulator-name = "vdd_cpu";
> >> +			};
> >> +
> >> +			vdd_log: DCDC_REG2 {
> >> +				regulator-always-on;
> >> +				regulator-boot-on;
> >> +				regulator-min-microvolt = <700000>;
> >> +				regulator-max-microvolt = <1500000>;
> >> +				regulator-name = "vdd_log";
> >> +			};
> >> +
> >> +			vcc_ddr: DCDC_REG3 {
> >> +				regulator-always-on;
> >> +				regulator-boot-on;
> >> +				regulator-name = "vcc_ddr";
> >> +			};
> >> +
> >> +			vcc_io: DCDC_REG4 {
> >> +				regulator-always-on;
> >> +				regulator-boot-on;
> >> +				regulator-min-microvolt = <3300000>;
> >> +				regulator-max-microvolt = <3300000>;
> >> +				regulator-name = "vcc_io";
> >> +			};
> >> +
> >> +			vcc18_flash: LDO_REG1 {
> >> +				regulator-always-on;
> >> +				regulator-boot-on;
> >> +				regulator-min-microvolt = <1800000>;
> >> +				regulator-max-microvolt = <1800000>;
> >> +				regulator-name = "vcc18_flash";
> >> +			};
> >> +
> >> +			vcc33_lcd: LDO_REG2 {
> >> +				regulator-always-on;
> >> +				regulator-boot-on;
> >> +				regulator-min-microvolt = <3300000>;
> >> +				regulator-max-microvolt = <3300000>;
> >> +				regulator-name = "vcc33_lcd";
> >> +			};
> >> +
> >> +			vdd_10: LDO_REG3 {
> >> +				regulator-always-on;
> > 
> > why all others also "boot-on" and this one not?
> 
> Good question. I had to fiddle with voltages and always-on / boot-on to
> get things to work so far, it kept probing with -EINVAL earlier.
> 
> According to the schematics, the PLL is behind vdd_10, so it probably
> should be boot-on, too. I'm now less certain whether some of the others
> should be boot-on though, in particular in light of RK3368 mainline
> U-Boot not existing yet and choices possibly being different there.

I'm fine with going the always-on/boot-on way at first. Sorting which 
regulators can actually be disabled can also be done later - especially as 
some components still don't do regulator-handling.


> Counter-question: Why does the -r88.dts have them all as fixed
> regulators?

Because the r88 board doesn't actually have a pmic ;-) . Just a bunch of 
individual (and mostly always-on) regulators on the board - thankfully I 
have schematics for it.


> I simply assumed here that the RK808-B is sufficiently
> compatible with rockchip,rk808?

I'd hope so.


Heiko
