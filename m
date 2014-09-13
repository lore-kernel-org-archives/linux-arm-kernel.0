From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 13 Sep 2014 10:11:19 +0200
Subject: [PATCH v3] ARM: sun5i: Add DT for HSG H702 tablet board
In-Reply-To: <1410422890-20284-1-git-send-email-wens@csie.org>
References: <1410422890-20284-1-git-send-email-wens@csie.org>
Message-ID: <20140913081119.GX31276@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Thu, Sep 11, 2014 at 04:08:10PM +0800, Chen-Yu Tsai wrote:
> This is a Q8 format 7 inch tablet with an Allwinner A13 SoC.
> It has 512MB DRAM, 4GB NAND flash, an accelerometer, camera,
> RTL8188-based WiFi, and micro SD slot for external storage.
> 
> It is likely made by a subsidiary of Hanns.G (Hannstar).
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> Note that checkpatch.pl is not happy about having the FSF address in
> the file. Given that the dts files are intended to be redistributable
> independent of the kernel, I think this error can be ignored.
> 
> Changes since v2:
> 
>  - Dual license under GPL/X11.
>  - Use extra fixed regulator for usb1-vbus.
> 
> ---
>  arch/arm/boot/dts/Makefile               |   1 +
>  arch/arm/boot/dts/sun5i-a13-hsg-h702.dts | 138 +++++++++++++++++++++++++++++++
>  2 files changed, 139 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b8c5cd3..94e61a6 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -406,6 +406,7 @@ dtb-$(CONFIG_MACH_SUN4I) += \
>  dtb-$(CONFIG_MACH_SUN5I) += \
>  	sun5i-a10s-olinuxino-micro.dtb \
>  	sun5i-a10s-r7-tv-dongle.dtb \
> +	sun5i-a13-hsg-h702.dtb \
>  	sun5i-a13-olinuxino.dtb \
>  	sun5i-a13-olinuxino-micro.dtb
>  dtb-$(CONFIG_MACH_SUN6I) += \
> diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
> new file mode 100644
> index 0000000..68c78e2
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
> @@ -0,0 +1,138 @@
> +/*
> + * Copyright 2014 Chen-Yu Tsai <wens@csie.org>
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
> +/include/ "sun5i-a13.dtsi"
> +/include/ "sunxi-common-regulators.dtsi"
> +
> +/ {
> +	model = "HSG H702";
> +	compatible = "hsg,h702", "allwinner,sun5i-a13";
> +
> +	soc at 01c00000 {
> +		mmc0: mmc at 01c0f000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_h702>;
> +			vmmc-supply = <&reg_vcc3v3>;
> +			bus-width = <4>;
> +			cd-gpios = <&pio 6 0 0>; /* PG0 */
> +			cd-inverted;
> +			status = "okay";
> +		};
> +
> +		usbphy: phy at 01c13400 {
> +			usb1_vbus-supply = <&reg_usb1_vbus_h702>;
> +			status = "okay";
> +		};
> +
> +		ehci0: usb at 01c14000 {
> +			status = "okay";
> +		};
> +
> +		ohci0: usb at 01c14400 {
> +			status = "okay";
> +		};
> +
> +		pinctrl at 01c20800 {
> +			mmc0_cd_pin_h702: mmc0_cd_pin at 0 {
> +				allwinner,pins = "PG0";
> +				allwinner,function = "gpio_in";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <1>;
> +			};
> +		};
> +
> +		uart1: serial at 01c28400 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart1_pins_b>;
> +			status = "okay";
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
> +				interrupts = <0>;
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		i2c1: i2c at 01c2b000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c1_pins_a>;
> +			status = "okay";
> +
> +			pcf8563: rtc at 51 {
> +				compatible = "nxp,pcf8563";
> +				reg = <0x51>;
> +			};
> +		};
> +
> +		i2c2: i2c at 01c2b400 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c2_pins_a>;
> +			status = "okay";
> +		};
> +	};
> +
> +	/*
> +	 * There doesn't seem to be a GPIO for controlling
> +	 * vbus, despite the fex file saying otherwise.
> +	 */
> +	reg_usb1_vbus_h702: usb1-vbus-h702 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb1-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		status = "okay";
> +	};

Sorry if I have not been clear enough, but what I meant was that we
could probably create a 5v regulator in sunxi-common-regulators. It
will probably be useful for other boards in the same case, so we'd
better put it there, instead of redefining it everywhere (just like we
did for reg_vcc3v and reg_vcc3v3)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140913/c789078a/attachment.sig>
