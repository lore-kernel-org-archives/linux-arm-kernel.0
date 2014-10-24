From: k.kozlowski@samsung.com (=?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?=)
Date: Fri, 24 Oct 2014 13:57:47 +0200
Subject: [PATCHv3 1/3] ARM: dts: Add board dts file for Exynos3250-based
 Rinato board
In-Reply-To: <1414150795-31105-2-git-send-email-cw00.choi@samsung.com>
References: <1414150795-31105-1-git-send-email-cw00.choi@samsung.com>
 <1414150795-31105-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <544A3EBB.3020906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.10.2014 13:39, Chanwoo Choi wrote:
> This patch add support for device tree sources for Samsung Rinato baord
> (Gear 2) based on Exynos3250 SoC.
> 
> This dts file support following features:
> - eMMC
> - Main PMIC (Samsung S2MPS14)
> - Interface PMIC (Maxim MAX77836, MUIC, fuel-gauge, charger)
> - RTC of Exynos3250
> - ADC of Exynos3250 with NTC thermistor
> - I2S of Exynos3250
> - TMU of Exynos3250
> - MFC of Exynos3250
> - Secure firmware for Exynos3250 secondary cpu boot
> - Serial ports of Exynos3250
> - gpio-key for power key
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/Makefile              |   3 +-
>  arch/arm/boot/dts/exynos3250-rinato.dts | 433 ++++++++++++++++++++++++++++++++
>  2 files changed, 435 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/exynos3250-rinato.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4a75e29..91cd4d0 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -67,7 +67,8 @@ dtb-$(CONFIG_ARCH_BRCMSTB) += \
>  dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
>  	da850-evm.dtb
>  dtb-$(CONFIG_ARCH_EFM32) += efm32gg-dk3750.dtb
> -dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
> +dtb-$(CONFIG_ARCH_EXYNOS) += exynos3250-rinato.dtb \
> +	exynos4210-origen.dtb \
>  	exynos4210-smdkv310.dtb \
>  	exynos4210-trats.dtb \
>  	exynos4210-universal_c210.dtb \
> diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
> new file mode 100644
> index 0000000..be0ba8d
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos3250-rinato.dts
> @@ -0,0 +1,433 @@
> +/*
> + * Samsung's Exynos3250 based Rinato board device tree source
> + *
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Device tree source file for Samsung's Rinato board which is based on
> + * Samsung Exynos3250 SoC.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +#include "exynos3250.dtsi"
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Samsung Rinato board";
> +	compatible = "samsung,rinato", "samsung,exynos3250", "samsung,exynos3";
> +
> +	aliases {
> +		i2c7 = &i2c_max77836;
> +	};
> +
> +	memory {
> +		reg =  <0x40000000 0x1ff00000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttySAC1,115200N8 root=/dev/mmcblk0p15 rootwait earlyprintk panic=5";
> +	};
> +
> +	firmware at 0205F000 {
> +		compatible = "samsung,secure-firmware";
> +		reg = <0x0205F000 0x1000>;
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +
> +		power_key {
> +			interrupt-parent = <&gpx2>;
> +			interrupts = <7 0>;
> +			gpios = <&gpx2 7 1>;
> +			linux,code = <KEY_POWER>;
> +			label = "power key";
> +			debounce-interval = <10>;
> +			gpio-key,wakeup;
> +		};
> +	};
> +
> +	vemmc_reg: voltage-regulator-0 {
> +	        compatible = "regulator-fixed";
> +		regulator-name = "V_EMMC_2.8V-fixed";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		gpio = <&gpk0 2 0>;
> +		enable-active-high;
> +	};

Hi Chanwoo,

I wonder if this regulator-fixed is needed. The LDO11 and LDO12 has
external GPIO control set up. So maybe this could be removed?

Best regards,
Krzysztof
