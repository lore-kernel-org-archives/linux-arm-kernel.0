From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 1 Feb 2016 21:46:07 +0800
Subject: [PATCH v4 2/2] ARM: dts: imx6: Add support for Toradex Ixora
 carrier board
In-Reply-To: <1453675703-31594-3-git-send-email-marcel.ziswiler@toradex.com>
References: <1453675703-31594-1-git-send-email-marcel.ziswiler@toradex.com>
 <1453675703-31594-3-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <20160201134606.GG10671@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 24, 2016 at 11:48:23PM +0100, Marcel Ziswiler wrote:
> From: Petr ?tetiar <ynezz@true.cz>
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Petr ?tetiar <ynezz@true.cz>
> Reviewed-by: Stefan Agner <stefan@agner.ch>

Copy my Linaro mailbox is unnecessary.  The kernel.org one is good
enough for me to receive your patch.

> ---
> 
> Changes in v4: None
> Changes in v3:
> - integrated review feedback from Petr
> - integrated review feedback from Stefan
> - fix comment concerning Apalis GPIO usage as GPIO7 is only used for PCIe switch reset on Apalis Evaluation board
> - move I2C DDC handling into carrier board DTS where it belongs
> - simplify RTC alias
> 
> Changes in v2:
> - clarify exact Apalis iMX6Q/D SoM type in cover letter
> - clarify exact Apalis iMX6Q/D module type and Ixora carrier board in model
>   node
> - got rid of obsolete mmc aliases
> - working SGTL5000 audio/sound integration
> - working STMPE811 touch screen controller integration
> - integrated review feedback from Lucas
> - left and even added some more comments as I don't see why putting any
>   explanatory comments in dts' should be such a bad thing to do
> - completely got rid of the memory node as that is something typically filled
>   in by the boot loader e.g. U-Boot
> - without the regulators simple-bus it no longer boots
> - even though we supposedly shipped a few hundred V1.0a modules drop DCE UART
>   support for now and simplify file layout
> - replaced obsolete no-1-8-v by mainline supported voltage-ranges = <3300 3300>
>   usdhc property and yes card detects are indeed active low (;-p)
> - integrated review feedback from Stefan
> - fixed Ethernet PHY reset & interrupt (requires Micrel PHY driver to be
>   enabled)
> - fixed HDMI DDC (requires GPIO-based bitbanging I2C to be enabled)
> - fixed SPDIF
> 
>  arch/arm/boot/dts/Makefile               |   1 +
>  arch/arm/boot/dts/imx6q-apalis-ixora.dts | 275 +++++++++++++++++++++++++++++++
>  2 files changed, 276 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-apalis-ixora.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index a4a6d70..0d5e11b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -317,6 +317,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6dl-udoo.dtb \
>  	imx6dl-wandboard.dtb \
>  	imx6dl-wandboard-revb1.dtb \
> +	imx6q-apalis-ixora.dtb \
>  	imx6q-apf6dev.dtb \
>  	imx6q-arm2.dtb \
>  	imx6q-cm-fx6.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
> new file mode 100644
> index 0000000..28f3b34
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
> @@ -0,0 +1,275 @@
> +/*
> + * Copyright 2014-2016 Toradex AG
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License
> + *     version 2 as published by the Free Software Foundation.
> + *
> + *     This file is distributed in the hope that it will be useful
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "imx6q.dtsi"
> +#include "imx6qdl-apalis.dtsi"
> +
> +/ {
> +	model = "Toradex Apalis iMX6Q/D Module on Ixora Carrier Board";
> +	compatible = "toradex,apalis_imx6q-ixora", "toradex,apalis_imx6q",
> +		     "fsl,imx6q";
> +
> +	aliases {
> +		i2c0 = &i2cddc;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +	};
> +
> +	aliases {
> +		rtc0 = &rtc_i2c;
> +		rtc1 = &snvs_rtc;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;
> +
> +		wakeup {
> +			label = "Wake-Up";
> +			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_WAKEUP>;
> +			debounce-interval = <10>;
> +			gpio-key,wakeup;

Please take a look at the following commit, which converts the legacy
wakeup properties to the new generic one.

https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/dt&id=1c49ad21c2cae607193da4495489c751d7147df2

> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_leds_ixora>;
> +
> +		led4-green {
> +			label = "LED_4_GREEN";
> +			gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led4-red {
> +			label = "LED_4_RED";
> +			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led5-green {
> +			label = "LED_5_GREEN";
> +			gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led5-red {
> +			label = "LED_5_RED";
> +			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	pwmleds {
> +		compatible = "pwm-leds";

Have a new line between properties and sub-node.

> +		ledpwm1 {
> +			label = "PWM1";
> +			pwms = <&pwm1 0 50000>;
> +			max-brightness = <255>;
> +		};
> +
> +		ledpwm2 {
> +			label = "PWM2";
> +			pwms = <&pwm2 0 50000>;
> +			max-brightness = <255>;
> +		};
> +
> +		ledpwm3 {
> +			label = "PWM3";
> +			pwms = <&pwm3 0 50000>;
> +			max-brightness = <255>;
> +		};
> +	};
> +
> +	regulators {
> +		reg_usb_otg_vbus: usb_otg_vbus {
> +			status = "okay";
> +		};

It can be as simple as the following.

&reg_usb_otg_vbus {
	status = "okay";
};

> +
> +		reg_usb_host_vbus: usb_host_vbus {
> +			status = "okay";
> +		};
> +	};
> +};
> +
> +&backlight {
> +	brightness-levels = <0 127 191 223 239 247 251 255>;
> +	default-brightness-level = <1>;
> +	status = "okay";
> +};
> +
> +&can1 {
> +	status = "okay";
> +};
> +
> +&can2 {
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	ddc-i2c-bus = <&i2cddc>;
> +	status = "okay";
> +};
> +
> +&i2cddc {
> +	status = "okay";
> +};
> +
> +/* GEN1_I2C: I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier board) */
> +&i2c1 {
> +	status = "okay";
> +
> +	eeprom at 50 {
> +		compatible = "atmel,24c02";
> +		reg = <0x50>;
> +	};
> +
> +	/* M41T0M6 real time clock on carrier board */
> +	rtc_i2c: rtc at 68 {
> +		compatible = "st,m41t00";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&ldb {
> +	status = "okay";
> +};
> +
> +&pcie {
> +	/* active-low meaning opposite of regular PERST# active-low polarity */
> +	reset-gpio = <&gpio1 28 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&pwm1 {
> +	status = "okay";
> +};
> +
> +&pwm2 {
> +	status = "okay";
> +};
> +
> +&pwm3 {
> +	status = "okay";
> +};
> +
> +&pwm4 {
> +	status = "okay";
> +};
> +
> +&sata {
> +	status = "okay";
> +};
> +
> +&sound_spdif {
> +	status = "okay";
> +};
> +
> +&spdif {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> +
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	vbus-supply = <&reg_usb_host_vbus>;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	vbus-supply = <&reg_usb_otg_vbus>;
> +	status = "okay";
> +};
> +
> +/* SD1 */
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sd_cd>;
> +	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	/*
> +	 * Mux the Apalis GPIOs
> +	 * GPIO5, 6 used by optional fusion_F0710A kernel module
> +	 */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_apalis_gpio1 &pinctrl_apalis_gpio2
> +		     &pinctrl_apalis_gpio3 &pinctrl_apalis_gpio4
> +		     &pinctrl_apalis_gpio5 &pinctrl_apalis_gpio6
> +		     &pinctrl_apalis_gpio7 &pinctrl_apalis_gpio8

We can have a single hog group to contain all these pins, I guess.

> +		    >;
> +
> +	leds_ixora {

Drop this container node.

Shawn

> +		pinctrl_leds_ixora: leds-ixora {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD1_DAT1__GPIO1_IO17 0x1b0b0
> +				MX6QDL_PAD_SD1_DAT3__GPIO1_IO21 0x1b0b0
> +				MX6QDL_PAD_NANDF_D1__GPIO2_IO01 0x1b0b0
> +				MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x1b0b0
> +			>;
> +		};
> +	};
> +};
> -- 
> 2.5.0
> 
> 
