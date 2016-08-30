From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 30 Aug 2016 09:32:06 +0200
Subject: [PATCH 2/4] ARM: dts: add TOPEET itop elite based board
In-Reply-To: <1472383269-3126-3-git-send-email-ayaka@soulik.info>
References: <CAL_JsqKY=VEZ+U11kY+XbMWuXhaFDr6GpnR3AXKd1U=9_=8fgA@mail.gmail.com>
 <1472383269-3126-1-git-send-email-ayaka@soulik.info>
 <1472383269-3126-3-git-send-email-ayaka@soulik.info>
Message-ID: <750b6941-7d22-971e-84c9-996deab9a7c1@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2016 01:21 PM, Randy Li wrote:
> The TOPEET itop exynos 4412 have three versions base board. The
> Elite version is the cheap one without too much peripheral devices
> on it.
> 
> Currently supported are serial console, wired networking(USB),
> USB OTG in peripheral mode, USB host, SD storage, GPIO buttons,
> PWM beeper, ADC and LEDs.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  .../bindings/arm/samsung/samsung-boards.txt        |   3 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/exynos4412-itop-elite.dts        | 148 +++++++++++++++++++++
>  3 files changed, 152 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos4412-itop-elite.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> index 0ea7f14..c7159ac 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> @@ -22,6 +22,9 @@ Required root node properties:
>    * FriendlyARM
>  	- "friendlyarm,tiny4412"  - for Exynos4412-based FriendlyARM
>  				    TINY4412 board.
> +  * TOPEET
> +	- "topeet,itop4412-elite" - for Exynos4412-based TOPEET
> +                                    Elite base board.                             
>  
>    * Google
>  	- "google,pi"		- for Exynos5800-based Google Peach Pi
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 48e1d4e..8f47aa0 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -135,6 +135,7 @@ dtb-$(CONFIG_ARCH_EXYNOS4) += \
>  	exynos4412-origen.dtb \
>  	exynos4412-smdk4412.dtb \
>  	exynos4412-tiny4412.dtb \
> +	exynos4412-itop-elite.dtb \
>  	exynos4412-trats2.dtb
>  dtb-$(CONFIG_ARCH_EXYNOS5) += \
>  	exynos5250-arndale.dtb \
> diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> new file mode 100644
> index 0000000..5688589
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> @@ -0,0 +1,148 @@
> +/*
> + * TOPEET's Exynos4412 based itop board device tree source
> + *
> + * Copyright (c) 2016 SUMOMO Computer Association
> + *			https://www.sumomo.mobi
> + *			Randy Li <ayaka@soulik.info>
> + *			
> + * Device tree source file for TOPEET iTop Exynos 4412 core board 
> + * which is based on Samsung's Exynos4412 SoC.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +/dts-v1/;
> +#include "exynos4412-itop-scp-core.dtsi"
> +
> +/ {
> +	model = "TOPEET iTop 4412 Elite board based on Exynos4412";
> +	compatible = "topeet,itop4412-elite", "samsung,exynos4412", "samsung,exynos4";
> +
> +	chosen {
> +		bootargs ="console=ttySAC2,115200 root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait";

Missing space after =

> +		stdout-path = &serial_2;

Instead of "console=xxxx", put everything here: "serial2:115200n8".

> +	};
> +	
> +	leds {
> +		compatible = "gpio-leds";
> +		
> +		led2 {
> +			label = "red:system";
> +			gpios = <&gpx1 0 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led3 {
> +			label = "red:user";
> +			gpios = <&gpk1 1 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		
> +		home {
> +			label = "GPIO Key Home";
> +			linux,code = <KEY_HOME>;
> +			gpios = <&gpx1 1 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		back {
> +			label = "GPIO Key Back";
> +			linux,code = <KEY_BACK>;
> +			gpios = <&gpx1 2 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		sleep {
> +			label = "GPIO Key Sleep";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpx3 3 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		vol_up {

No underscores. Add a name of class to the node names for all keys. Like
"key-home", "key-back".

> +			label = "GPIO Key Vol+";
> +			linux,code = <KEY_UP>;
> +			gpios = <&gpx2 1 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		vol_down {
> +			label = "GPIO Key Vol-";
> +			linux,code = <KEY_DOWN>;
> +			gpios = <&gpx2 0 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +	
> +	beep {
> +		compatible = "pwm-beeper";
> +		pwms = <&pwm>;
> +		pinctrl-0 = <&pwm0_out>;
> +		pinctrl-names = "default";
> +	};
> +};
> +
> +&pinctrl_1 {
> +	ether-reset {
> +		samsung,pins = "gpc0-1";
> +		samsung,pin-function = <1>;
> +		samsung,pin-pud = <0>;
> +		samsung,pin-drv = <0>;
> +	};
> +};
> +
> +&sdhci_2 {
> +	bus-width = <4>;
> +	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4>;
> +	pinctrl-names = "default";
> +	cd-gpio = <&gpx0 7 GPIO_ACTIVE_LOW>;
> +	cap-sd-highspeed;
> +	vmmc-supply = <&ldo23_reg>;
> +	vqmmc-supply = <&ldo17_reg>;
> +	status = "okay";
> +};
> +
> +&ehci {

Alphabetical order.

> +	status = "okay";
> +	/* In order to reset USB ethernet */
> +	samsung,vbus-gpio = <&gpc0 1 GPIO_ACTIVE_HIGH>;
> +
> +	port at 0 {
> +		status = "okay";
> +	};
> +
> +	port at 2 {
> +		status = "okay";
> +	};
> +};
> +
> +&exynos_usbphy {

ditto

> +	status = "okay";
> +};
> +
> +&hsotg {

ditto

> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
> +&serial_1 {
> +	status = "okay";
> +};
> +
> +&serial_2 {
> +	status = "okay";
> +};
> +
> +&pwm {

ditto

> +	pinctrl-0 = <&pwm1_out>;
> +	pinctrl-names = "default";
> +	samsung,pwm-outputs = <1>;
> +	status = "okay";
> +};
> +
> +&adc {

ditto

Best regards,
Krzysztof
> +	vdd-supply = <&ldo3_reg>;
> +	status = "okay";
> +};
> 
