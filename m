From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Jan 2015 12:17:56 +0100
Subject: [PATCH 1/3] ARM: dts: sun4i: Add dts file for Chuwi V7 CW0825
 tablet
In-Reply-To: <1420661775-20424-1-git-send-email-hdegoede@redhat.com>
References: <1420661775-20424-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150112111755.GH4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Wed, Jan 07, 2015 at 09:16:13PM +0100, Hans de Goede wrote:
> The Chuwi V7 is an A10 (sun4i) based tablet with 1G of RAM, 16G of nand flash,
> microsd slot, 7" 1024x768 lvds ips panel, mini hdmi out, headphones out,
> stereo speakers, front & back camera and usb wifi.
> 
> It is clearly marked "CHUWI", "V7" and "Model: CW0825" on the back of the
> tablet.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

This is mostly looking good, as usual, but I have a few comments on
it.

> ---
>  arch/arm/boot/dts/Makefile                      |   1 +
>  arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts | 101 ++++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index a86f232..548520f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -445,6 +445,7 @@ dtb-$(CONFIG_ARCH_STI)+= stih407-b2120.dtb \
>  dtb-$(CONFIG_MACH_SUN4I) += \
>  	sun4i-a10-a1000.dtb \
>  	sun4i-a10-ba10-tvbox.dtb \
> +	sun4i-a10-chuwi-v7-cw0825.dtb \
>  	sun4i-a10-cubieboard.dtb \
>  	sun4i-a10-mini-xplus.dtb \
>  	sun4i-a10-hackberry.dtb \
> diff --git a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> new file mode 100644
> index 0000000..1960985
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> @@ -0,0 +1,101 @@
> +/*
> + * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *     You should have received a copy of the GNU General Public
> + *     License along with this file; if not, write to the Free
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
> +/include/ "sun4i-a10.dtsi"
> +/include/ "sunxi-common-regulators.dtsi"

This would be great to move to the C-preprocessor includes.

> +
> +/ {
> +	model = "Chuwi V7 CW0825";
> +	compatible = "chuwi,v7-cw0825", "allwinner,sun4i-a10";
> +
> +	soc at 01c00000 {
> +		mmc0: mmc at 01c0f000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +			vmmc-supply = <&reg_vcc3v3>;
> +			bus-width = <4>;
> +			cd-gpios = <&pio 7 1 0>; /* PH1 */

And use the GPIO header for the GPIO flags.

> +			cd-inverted;
> +			status = "okay";
> +		};
> +
> +		uart0: serial at 01c28000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart0_pins_a>;
> +			status = "okay";
> +		};
> +
> +		usbphy: phy at 01c13400 {
> +			usb2_vbus-supply = <&reg_usb2_vbus>;
> +			status = "okay";
> +		};
> +
> +		ehci1: usb at 01c1c000 {
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
> +
> +				interrupt-controller;
> +				#interrupt-cells = <1>;

I just merged a patch from Chen-Yu that add a DTSI for the AXP209, you
should probably use it to remove some of the boilerplate.

> +			};
> +		};
> +	};
> +
> +	reg_usb2_vbus: usb2-vbus {
> +		status = "okay";
> +	};
> +};

Would you consider switching to the label-based syntax instead of
replicating the whole DT tree like you did for the A31s DTSI?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150112/eabaf0b6/attachment.sig>
