From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 19 Jan 2015 11:41:20 +0100
Subject: [linux-sunxi] [PATCH] ARM: dts: sun4i: Add Marsboard A10 board
In-Reply-To: <1421661748-8390-1-git-send-email-mamlinav@gmail.com>
References: <1421661748-8390-1-git-send-email-mamlinav@gmail.com>
Message-ID: <54BCDF50.2070702@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 19-01-15 11:02, Aleksei Mamlin wrote:
> This patch add support for Marsboard A10 board.
>
> The Marsboard A10 is a A10 based development board with 1G RAM, 1G NAND,
> micro SD card slot, SATA 2.0 socket, 10/100 ethernet, mini HDMI port,
> 1 USB OTG port and 2 USB 2.0 ports. Board does not use the AXP209 pmic,
> it does not have a pmic at all.
> Board also have 2 expansion 70 pin headers.
>
>
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>

Thanks, we've recently moved over from using a full node
hierarchy to using label references in board dts files, see e.g. :

https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?h=sunxi/dt-for-3.20&id=327f121fea91fd79d6b71f47a8e1bc62a7fd86e5

Can you please respin this to follow that style (the nodes should
be sorted alphabetically).

Also like with the u-boot patch, when submitting patches for upstream
they should not be send to the linux-sunxi list, sunxi dts patches
should go to Maxime Ripard (added to the Cc) with the linux-arm and
devicetree lists both in the Cc (also added to the Cc) note you do
not need to be subscribed to these lists.

This makes me realize that we should probably write a manual on
how to add a new sunxi board to upstream u-boot / a dts to the
kernel. Since you've just gone through the process, could you
perhaps write a manual for this on linux-sunxi.org, it is a wiki
so you should be able to add an account and create a new page.

Thanks & Regards,

Hans




> ---
>   arch/arm/boot/dts/Makefile                |   1 +
>   arch/arm/boot/dts/sun4i-a10-marsboard.dts | 192 ++++++++++++++++++++++++++++++
>   2 files changed, 193 insertions(+)
>   create mode 100644 arch/arm/boot/dts/sun4i-a10-marsboard.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 66a4282..20957b5 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -446,6 +446,7 @@ dtb-$(CONFIG_MACH_SUN4I) += \
>   	sun4i-a10-a1000.dtb \
>   	sun4i-a10-ba10-tvbox.dtb \
>   	sun4i-a10-cubieboard.dtb \
> +	sun4i-a10-marsboard.dtb \
>   	sun4i-a10-mini-xplus.dtb \
>   	sun4i-a10-hackberry.dtb \
>   	sun4i-a10-inet97fv2.dtb \
> diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
> new file mode 100644
> index 0000000..041dd95
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
> @@ -0,0 +1,192 @@
> +/*
> + * Copyright 2015 Aleksei Mamlin
> + * Aleksei Mamlin <mamlinav@gmail.com>
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
> +#include "sun4i-a10.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>
> +
> +/ {
> +	model = "HAOYU Electronics Marsboard A10";
> +	compatible = "haoyu,a10-marsboard", "allwinner,sun4i-a10";
> +
> +	soc at 01c00000 {
> +		emac: ethernet at 01c0b000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&emac_pins_a>;
> +			phy = <&phy1>;
> +			status = "okay";
> +		};
> +
> +		mdio at 01c0b080 {
> +			status = "okay";
> +
> +			phy1: ethernet-phy at 1 {
> +				reg = <1>;
> +			};
> +		};
> +
> +		mmc0: mmc at 01c0f000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +			vmmc-supply = <&reg_vcc3v3>;
> +			bus-width = <4>;
> +			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> +			cd-inverted;
> +			status = "okay";
> +		};
> +
> +		usbphy: phy at 01c13400 {
> +			usb1_vbus-supply = <&reg_usb1_vbus>;
> +			usb2_vbus-supply = <&reg_usb2_vbus>;
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
> +		ahci: sata at 01c18000 {
> +			status = "okay";
> +		};
> +
> +		ehci1: usb at 01c1c000 {
> +			status = "okay";
> +		};
> +
> +		ohci1: usb at 01c1c400 {
> +			status = "okay";
> +		};
> +
> +		pinctrl at 01c20800 {
> +			led_pins_marsboard: led_pins at 0 {
> +				allwinner,pins = "PB5", "PB6", "PB7", "PB8";
> +				allwinner,function = "gpio_out";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +		};
> +
> +		uart0: serial at 01c28000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart0_pins_a>;
> +			status = "okay";
> +		};
> +
> +		i2c0: i2c at 01c2ac00 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c0_pins_a>;
> +			status = "okay";
> +		};
> +
> +		i2c1: i2c at 01c2b000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c1_pins_a>;
> +			status = "okay";
> +		};
> +
> +		spi0: spi at 01c05000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&spi0_pins_a>;
> +			status = "okay";
> +		};
> +
> +		spi1: spi at 01c06000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&spi1_pins_a>;
> +			status = "okay";
> +		};
> +
> +		spi2: spi at 01c17000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&spi2_pins_a>;
> +			status = "okay";
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins_marsboard>;
> +
> +		red1 {
> +			label = "marsboard:red1:usr";
> +			gpios = <&pio 1 5 GPIO_ACTIVE_HIGH>; /* LED1 */
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		red2 {
> +			label = "marsboard:red2:usr";
> +			gpios = <&pio 1 6 GPIO_ACTIVE_HIGH>; /* LED2 */
> +		};
> +
> +		red3 {
> +			label = "marsboard:red3:usr";
> +			gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* LED3 */
> +		};
> +
> +		red4 {
> +			label = "marsboard:red4:usr";
> +			gpios = <&pio 1 8 GPIO_ACTIVE_HIGH>; /* LED4 */
> +		};
> +	};
> +
> +	reg_usb1_vbus: usb1-vbus {
> +		status = "okay";
> +	};
> +
> +	reg_usb2_vbus: usb2-vbus {
> +		status = "okay";
> +	};
> +};
>
