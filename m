From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Oct 2014 11:20:49 +0200
Subject: [PATCH v3 ] ARM: sun7i: add support for A20-OLinuXino-Lime2
In-Reply-To: <5431C8EF.3070809@gmail.com>
References: <54280AA7.1090401@gmail.com> <20140928164337.GB15315@lukather>
 <54295711.9010901@gmail.com> <20140929132543.GC4081@lukather>
 <54296D8B.3080304@gmail.com> <20141002124807.GC4039@lukather>
 <5431C8EF.3070809@gmail.com>
Message-ID: <20141006092049.GF4090@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Oct 05, 2014 at 11:40:47PM +0100, Iain Paton wrote:
> This adds support for the Olimex A20-OLinuXino-Lime2
> https://www.olimex.com/Products/OLinuXino/A20/A20-OLinuXIno-LIME2
> 
> Differences to previous Lime boards are 1GB RAM and gigabit ethernet
> 
> Signed-off-by: Iain Paton <ipaton0@gmail.com>

Almost good, see a few minor comments below.

> ---
> 
> changes for v2
>  add axp209 regulators node
> 
> changes for v3
>  add reg_axp_ipsout regulator
>  follow suggestion by Chen-Yu in
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/292645.html
>   on parenting the regulators which gives:
> [    0.879031] LDO1: 1300 mV 
> [    0.881986] LDO1: supplied by axp-ipsout
> [    0.886609] LDO2: 1800 <--> 3300 mV at 3000 mV 
> [    0.891202] LDO2: supplied by axp-ipsout
> [    0.895584] LDO3: 700 <--> 3500 mV at 2275 mV 
> [    0.900082] LDO3: supplied by axp-ipsout
> [    0.904300] LDO4: 1250 <--> 3300 mV at 2800 mV 
> [    0.908877] LDO4: supplied by axp-ipsout
> [    0.913481] LDO5: 1800 <--> 3300 mV at 2800 mV 
> [    0.918070] LDO5: supplied by axp-ipsout
> [    0.922474] DCDC2: 700 <--> 2275 mV at 1400 mV 
> [    0.927074] DCDC2: supplied by axp-ipsout
> [    0.931538] DCDC3: 700 <--> 3500 mV at 1250 mV 
> [    0.936159] DCDC3: supplied by axp-ipsout
> [    0.940253] axp20x 0-0034: AXP20X driver loaded
> 
> I gave up trying to build this on top of linux-next as over the last couple 
> of days linux-next stops somewhere around probing the sata driver, not 
> always in exactly the same place though. I don't get anywhere near the 
> previous mmc related issue.
> 
> This patchset is based on top of
> git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git sunxi/for-next
> 429823087fec3d3138c72f2910d36d3d8d0733a7
> 
> with http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/288901.html
> and http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283341.html
> added on top.
> 
>  arch/arm/boot/dts/Makefile                      |   1 +
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 230 ++++++++++++++++++++++++
>  2 files changed, 231 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 2f42b18..ea6c672 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -420,6 +420,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-hummingbird.dtb \
>  	sun7i-a20-i12-tvbox.dtb \
>  	sun7i-a20-olinuxino-lime.dtb \
> +	sun7i-a20-olinuxino-lime2.dtb \
>  	sun7i-a20-olinuxino-micro.dtb \
>  	sun7i-a20-pcduino3.dtb
>  dtb-$(CONFIG_MACH_SUN8I) += \
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> new file mode 100644
> index 0000000..5b60309
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> @@ -0,0 +1,230 @@
> +/*
> + * Copyright 2014 - Iain Paton <ipaton0@gmail.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *     You should have received a copy of the GNU General Public
> + *     License along with this library; if not, write to the Free
> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> + *     MA 02110-1301 USA
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +/include/ "sun7i-a20.dtsi"
> +/include/ "sunxi-common-regulators.dtsi"
> +
> +/ {
> +	model = "Olimex A20-OLinuXino-LIME2";
> +	compatible = "olimex,a20-olinuxino-lime2", "allwinner,sun7i-a20";
> +
> +	soc at 01c00000 {
> +
> +		ahci: sata at 01c18000 {
> +			target-supply = <&reg_ahci_5v>;
> +			status = "okay";
> +		};
> +
> +		ehci0: usb at 01c14000 {
> +			status = "okay";
> +		};
> +
> +		ehci1: usb at 01c1c000 {
> +			status = "okay";
> +		};
> +
> +		gmac: ethernet at 01c50000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gmac_pins_rgmii_a>;
> +			phy = <&phy1>;
> +			phy-mode = "rgmii";
> +			status = "okay";
> +
> +			phy1: ethernet-phy at 1 {
> +				reg = <1>;
> +			};
> +		};
> +
> +		i2c0: i2c at 01c2ac00 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c0_pins_a>;
> +			status = "okay";
> +
> +			axp209: pmic at 34 {
> +				compatible = "x-powers,axp209";
> +				reg = <0x34>;
> +				interrupt-parent = <&nmi_intc>;
> +				interrupts = <0 8>;
> +
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +
> +				acin-supply = <&reg_axp_ipsout>;
> +				vin2-supply = <&reg_axp_ipsout>;
> +				vin3-supply = <&reg_axp_ipsout>;
> +				ldo24in-supply = <&reg_axp_ipsout>;
> +				ldo3in-supply = <&reg_axp_ipsout>;
> +				ldo5in-supply = <&reg_axp_ipsout>;
> +
> +				regulators {
> +					reg_ldo1: ldo1 {

It would be great if the names of these regulators actually reflect
what they are used for on the board.

This one for example would be vdd_rtc.

> +						regulator-min-microvolt = <1300000>;
> +						regulator-max-microvolt = <1300000>;
> +						regulator-always-on;
> +					};

And new lines between each node would be nice too.

Thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/05e4a8a6/attachment.sig>
