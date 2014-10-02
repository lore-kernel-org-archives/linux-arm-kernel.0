From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Oct 2014 12:22:34 +0100
Subject: [PATCH] ARM: dts: add board dts file for Exynos3250-based Monk
 board
In-Reply-To: <1412211025-3459-1-git-send-email-yj44.cho@samsung.com>
References: <1412211025-3459-1-git-send-email-yj44.cho@samsung.com>
Message-ID: <20141002112233.GI5788@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 02, 2014 at 01:50:25AM +0100, YoungJun Cho wrote:
> From: Youngjun Cho <yj44.cho@samsung.com>
> 
> This patch adds new board dts file to support Samsung Monk board which is
> based on Exynos3250 SoC and has different H/W configuration from Rinato.
> 
> This patch is based on linux-samsung.git for-next branch and depends on
> [PATCH 0/2] ARM: dts: Add new board dts file for Exynos3250-based Rinato board[1]
> 
> This dts file support following features:
> - eMMC
> - Main PMIC (Samsung S2MPS14)
> - Interface PMIC (Maxim MAX77836, MUIC, fuel-gauge, charger)
> - RTC of Exynos3250
> - ADC of Exynos3250 with NTC thermistor
> - I2S of Exynos3250
> - TMU of Exynos3250
> - Secure firmware for Exynos3250 secondary cpu boot
> - Serial ports of Exynos3250
> - gpio-key for power key
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg366849.html
> 
> Signed-off-by: Youngjun Cho <yj44.cho@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/Makefile            |   3 +-
>  arch/arm/boot/dts/exynos3250-monk.dts | 592 ++++++++++++++++++++++++++++++++++
>  2 files changed, 594 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/exynos3250-monk.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5728918..0c8ae64 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -64,7 +64,8 @@ dtb-$(CONFIG_ARCH_BRCMSTB) += \
>  dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
>         da850-evm.dtb
>  dtb-$(CONFIG_ARCH_EFM32) += efm32gg-dk3750.dtb
> -dtb-$(CONFIG_ARCH_EXYNOS) += exynos3250-rinato.dtb \
> +dtb-$(CONFIG_ARCH_EXYNOS) += exynos3250-monk.dtb \
> +       exynos3250-rinato.dtb \
>         exynos4210-origen.dtb \
>         exynos4210-smdkv310.dtb \
>         exynos4210-trats.dtb \
> diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
> new file mode 100644
> index 0000000..9e94294
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos3250-monk.dts
> @@ -0,0 +1,592 @@
> +/*
> + * Samsung's Exynos3250 based Monk board device tree source
> + *
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + *             http://www.samsung.com
> + *
> + * Device tree source file for Samsung's Monk board which is based on
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
> +       model = "Samsung Monk board";
> +       compatible = "samsung,monk", "samsung,exynos3250", "samsung,exynos3";
> +
> +       aliases {
> +               i2c7 = &i2c_max77836;
> +       };
> +
> +       memory {
> +               reg =  <0x40000000 0x08000000
> +                       0x48000000 0x08000000
> +                       0x50000000 0x08000000
> +                       0x58000000 0x07F00000>;

Nit: please bracket list entries individually.

That said, it looks like this could be coalesced into:

memory at 40000000 {
	reg = <0x40000000 0x1ff00000>;
};

> +       };
> +
> +       chosen {
> +               bootargs = "console=ttySAC1,115200N8 root=/dev/mmcblk0p15 rootwait earlyprintk panic=5";
> +       };
> +
> +       firmware at 0205F000 {
> +               compatible = "samsung,secure-firmware";
> +               reg = <0x0205F000 0x1000>;
> +       } ;

Nit: useless space before the ';'.

> +
> +       gpio_keys {
> +               compatible = "gpio-keys";
> +
> +               power_key {
> +                       interrupt-parent = <&gpx2>;
> +                       interrupts = <7 0>;
> +                       gpios = <&gpx2 7 1>;
> +                       linux,code = <KEY_POWER>;
> +                       label = "power key";
> +                       debounce-interval = <10>;
> +                       gpio-key,wakeup;
> +               };
> +       };
> +
> +       regulators {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               vemmc_reg: voltage-regulator-0 {
> +                       compatible = "regulator-fixed";
> +                       regulator-name = "V_EMMC_2.8V-fixed";
> +                       regulator-min-microvolt = <2800000>;
> +                       regulator-max-microvolt = <2800000>;
> +                       gpio = <&gpk0 2 0>;
> +                       enable-active-high;
> +               };
> +       };

Why not put this directly under the root node? There's no reason to
group regulators simply because they're regulators, and there's only one
anyhow.

Mark.
