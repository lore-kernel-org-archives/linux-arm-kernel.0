From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sun, 18 Jan 2015 13:05:14 +0100
Subject: [PATCH] ARM: BCM5301X: Add DT for Luxul XWC-1000
In-Reply-To: <1420666490-29276-1-git-send-email-riproute@gmail.com>
References: <1420666490-29276-1-git-send-email-riproute@gmail.com>
Message-ID: <54BBA17A.3040807@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

This looks ok to me.

I haven't noticed before, but you should also send patches for BCM5301X
to the linux arm mailing list at linux-arm-kernel at lists.infradead.org .
Could you please send this patch one more time and then in addition to
the arm mailing list.

Hauke

On 01/07/2015 10:34 PM, Dan Haab wrote:
> From: Dan Haab <dhaab@luxul.com>
> 
> Luxul XWC-1000 is a controller device based on BCM4708 SoC. The only
> unusual thing in its DTS file is "ubi" partition on NAND flash.
> 
> Signed-off-by: Dan Haab <dhaab@luxul.com>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
> Hello Hauke,
> 
> We believe you are going to collect BCM5301X DTS changes for 3.20.
> Please consider following patch.
> ---
>  arch/arm/boot/dts/Makefile                   |  1 +
>  arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts | 60 ++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>  create mode 100644 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 2ca4bab..a03afbd 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
>  dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b-plus.dtb
>  dtb-$(CONFIG_ARCH_BCM_5301X) += \
>  	bcm4708-buffalo-wzr-1750dhp.dtb \
> +	bcm4708-luxul-xwc-1000.dtb \
>  	bcm4708-netgear-r6250.dtb \
>  	bcm4708-netgear-r6300-v2.dtb \
>  	bcm47081-asus-rt-n18u.dtb \
> diff --git a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
> new file mode 100644
> index 0000000..946c728
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
> @@ -0,0 +1,60 @@
> +/*
> + * Broadcom BCM470X / BCM5301X ARM platform code.
> + * DTS for Luxul XWC-1000
> + *
> + * Copyright 2014 Luxul Inc.
> + *
> + * Licensed under the GNU/GPL. See COPYING for details.
> + */
> +
> +/dts-v1/;
> +
> +#include "bcm4708.dtsi"
> +
> +/ {
> +	compatible = "luxul,xwc-1000", "brcm,bcm4708";
> +	model = "Luxul XWC-1000 (BCM4708)";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200";
> +	};
> +
> +	memory {
> +		reg = <0x00000000 0x08000000>;
> +	};
> +
> +	axi at 18000000 {
> +		nand at 28000 {
> +			reg = <0x00028000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition at 0 {
> +				label = "ubi";
> +				reg = <0x00000000 0x08000000>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		status {
> +			label = "bcm53xx:green:status";
> +			gpios = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "timer";
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		restart {
> +			label = "Reset";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> 
