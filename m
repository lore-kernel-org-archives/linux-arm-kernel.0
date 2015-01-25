From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 Jan 2015 17:48:46 +0100
Subject: [PATCH] ARM: dts: sun7i: Add dts file for pcDuino 3 Nano board
In-Reply-To: <1422199921-325-1-git-send-email-ats@offog.org>
References: <1422199921-325-1-git-send-email-ats@offog.org>
Message-ID: <20150125164846.GL8470@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam,

On Sun, Jan 25, 2015 at 03:32:01PM +0000, Adam Sampson wrote:
> Add support for the LinkSprite pcDuino 3 Nano board. This is a low-cost
> Allwinner A20 board with Arduino-style GPIO headers; it features 1G RAM,
> 4G NAND flash, 1 micro-SD, 2 USB sockets, 1 micro USB socket for OTG and
> another for power in, HDMI, SATA, 5V power for SATA devices, gigabit
> Ethernet, an IR receiver, 3.5mm audio out and a MIPI camera connector.
> 
> For more details, see: http://linux-sunxi.org/LinkSprite_pcDuino3_Nano
> 
> Signed-off-by: Adam Sampson <ats@offog.org>

Thanks for your patch.

> ---
>  arch/arm/boot/dts/Makefile                    |    3 +-
>  arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts |  203 +++++++++++++++++++++++++
>  2 files changed, 205 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7df26a2..c025724 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -479,7 +479,8 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-olinuxino-lime.dtb \
>  	sun7i-a20-olinuxino-lime2.dtb \
>  	sun7i-a20-olinuxino-micro.dtb \
> -	sun7i-a20-pcduino3.dtb
> +	sun7i-a20-pcduino3.dtb \
> +	sun7i-a20-pcduino3-nano.dtb
>  dtb-$(CONFIG_MACH_SUN8I) += \
>  	sun8i-a23-ippo-q8h-v5.dtb \
>  	sun8i-a23-ippo-q8h-v1.2.dtb
> diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> new file mode 100644
> index 0000000..a2b18de
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> @@ -0,0 +1,203 @@
> +/*
> + * Copyright 2015 Adam Sampson <ats@offog.org>
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
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	model = "LinkSprite pcDuino3 Nano";
> +	compatible = "linksprite,pcduino3-nano", "allwinner,sun7i-a20";
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins_pcduino3_nano>;
> +
> +		led3 {
> +			label = "pcduino3-nano:green:led3";
> +			gpios = <&pio 7 16 GPIO_ACTIVE_LOW>; /* PH16 */
> +		};
> +
> +		led4 {
> +			label = "pcduino3-nano:green:led4";
> +			gpios = <&pio 7 15 GPIO_ACTIVE_LOW>; /* PH15 */
> +		};

Where are the three other leds?

Also, usually, the last part of the label is what the led function
usually is. In most case, "usr" will be fine, that might be others
too, but the led number definitely isn't an option.


> +	};
> +};
> +
> +&ahci {
> +	target-supply = <&reg_ahci_5v>;
> +	status = "okay";
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&gmac {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac_pins_rgmii_a>;
> +	phy = <&phy1>;
> +	phy-mode = "rgmii";
> +	status = "okay";
> +
> +	phy1: ethernet-phy at 1 {
> +		reg = <1>;
> +	};
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins_a>;
> +	status = "okay";
> +
> +	axp209: pmic at 34 {
> +		compatible = "x-powers,axp209";
> +		reg = <0x34>;
> +		interrupt-parent = <&nmi_intc>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins_a>;
> +	status = "okay";
> +};
> +
> +&ir0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ir0_pins_a>;
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	bus-width = <4>;
> +	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> +	cd-inverted;
> +	status = "okay";
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&pio {
> +	ahci_pwr_pin_a: ahci_pwr_pin at 0 {
> +		allwinner,pins = "PH2";
> +	};

We usually declare a whole new node for this one...

> +	led_pins_pcduino3_nano: led_pins at 0 {
> +		allwinner,pins = "PH16", "PH15";
> +		allwinner,function = "gpio_out";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};
> +
> +	usb1_vbus_pin_pcduino3_nano: usb1_vbus_pin at 0 {
> +		allwinner,pins = "PH11";
> +		allwinner,function = "gpio_out";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};
> +};
> +
> +&reg_ahci_5v {
> +	gpio = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */

... and we override the pinctrl-0 property here.

> +	status = "okay";
> +};
> +
> +&reg_usb1_vbus {
> +	pinctrl-0 = <&usb1_vbus_pin_pcduino3_nano>;
> +	gpio = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
> +	status = "okay";
> +};
> +
> +&reg_usb2_vbus {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0_pins_a>;
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins_a>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2_pins_a>;
> +	status = "okay";
> +};

You probably want aliases for these two UARTs.

Looks good otherwise,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150125/d407b93b/attachment-0001.sig>
