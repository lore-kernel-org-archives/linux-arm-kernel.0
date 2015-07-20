From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 20 Jul 2015 22:42:22 +0200
Subject: [PATCH 1/2] ARM: dts: add buffalo linkstation ls-wtgl
In-Reply-To: <1436878802-25712-2-git-send-email-rogershimizu@gmail.com>
References: <1436878802-25712-1-git-send-email-rogershimizu@gmail.com>
 <1436878802-25712-2-git-send-email-rogershimizu@gmail.com>
Message-ID: <20150720204222.GA21011@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 10:00:01PM +0900, Roger Shimizu wrote:
> Add dts file to support Buffalo Linkstation LS-WTGL,
> which is marvell orion5x based 2-bay 3.5" HDD NAS.
> Product info:
>  - (JPN) http://buffalo.jp/products/catalog/storage/ls-wtgl_r1/
>  - (ENG) http://www.buffalotech.com/support-and-downloads/download/LinkStation_Pro_Duo_Manual_web.pdf
> 
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                       |   1 +
>  arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts | 242 +++++++++++++++++++++++
>  2 files changed, 243 insertions(+)
>  create mode 100644 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index a8bf702..f3ddfa0 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -464,6 +464,7 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
>  dtb-$(CONFIG_ARCH_ORION5X) += \
>  	orion5x-lacie-d2-network.dtb \
>  	orion5x-lacie-ethernet-disk-mini-v2.dtb \
> +	orion5x-linkstation-lswtgl.dtb \
>  	orion5x-maxtor-shared-storage-2.dtb \
>  	orion5x-rd88f5182-nas.dtb
>  dtb-$(CONFIG_ARCH_PRIMA2) += \
> diff --git a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
> new file mode 100644
> index 0000000..6d021bd
> --- /dev/null
> +++ b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
> @@ -0,0 +1,242 @@
> +/*
> + * Device Tree file for Buffalo Linkstation LS-WTGL
> + *
> + * Copyright (C) 2015, Roger Shimizu <rogershimizu@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */

Hi Roger

Could you licence this under both GPL and X11? See the recent posting
by Benjamin Cama for the WSGL.

> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "orion5x-mv88f5182.dtsi"
> +
> +/ {
> +	model = "Buffalo Linkstation LS-WTGL";
> +	compatible = "buffalo,lswtgl", "marvell,orion5x-88f5182", "marvell,orion5x";
> +
> +	memory { /* 64 MB */
> +		device_type = "memory";
> +		reg = <0x00000000 0x4000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +		linux,stdout-path = &uart0;
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>,
> +		         <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>,
> +			 <MBUS_ID(0x01, 0x0f) 0 0xf4000000 0x40000>;
> +
> +		internal-regs {
> +			pinctrl: pinctrl at 10000 {
> +				pinctrl-0 = <&pmx_usb_power &pmx_power_hdd
> +					&pmx_fan_low &pmx_fan_high &pmx_fan_lock>;
> +				pinctrl-names = "default";
> +
> +				pmx_led_power: pmx-leds {
> +					marvell,pins = "mpp0";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_led_alarm: pmx-leds {
> +					marvell,pins = "mpp2";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_led_info: pmx-leds {
> +					marvell,pins = "mpp3";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_power_hdd: pmx-power-hdd {
> +					marvell,pins = "mpp1";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_usb_power: pmx-usb-power {
> +					marvell,pins = "mpp9";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_sata0: pmx-sata0 {
> +					marvell,pins = "mpp12";
> +					//marvell,function = "gpio";

Please remove commented out lines.

> +					marvell,function = "sata0";
> +				};
> +
> +				pmx_sata1: pmx-sata1 {
> +					marvell,pins = "mpp13";
> +					//marvell,function = "gpio";

Same here.

> +					marvell,function = "sata1";
> +				};

Otherwise this looks good.

	  Andrew
