From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 8 Jul 2016 12:35:58 -0500
Subject: [RFC 3/4] arm64: dts: msm8994 SoC and Huawei Angler (Nexus 6P)
 support
In-Reply-To: <1467938467-21607-4-git-send-email-jmcnicol@redhat.com>
References: <1467938467-21607-1-git-send-email-jmcnicol@redhat.com>
 <1467938467-21607-4-git-send-email-jmcnicol@redhat.com>
Message-ID: <20160708173558.GB7896@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 05:41:06PM -0700, Jeremy McNicoll wrote:
> From: Bastian K?cher <mail@kchr.de>
> 
> Initial device tree support for Qualcomm MSM8994 SoC and
> Huawei Angler / Google Nexus 6P support.
> 
> The device tree and the angler_defconfig are based on the
> device tree from the Google 3.10 kernel tree.
> 
> The device can be booted into the initrd with only one CPU running.
> 
> Signed-off-by: Bastian K?cher <mail@kchr.de>
> Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
> ---
>  arch/arm64/Kconfig.platforms                       |  13 +
>  arch/arm64/boot/dts/Makefile                       |   1 +
>  arch/arm64/boot/dts/huawei/Makefile                |   5 +
>  .../boot/dts/huawei/msm8994-angler-rev-101.dts     |  41 ++
>  arch/arm64/boot/dts/qcom/msm8994-pins.dtsi         |  38 ++
>  arch/arm64/boot/dts/qcom/msm8994-v2.0.dtsi         |  31 +
>  arch/arm64/boot/dts/qcom/msm8994.dtsi              | 237 ++++++++
>  arch/arm64/configs/angler_defconfig                | 666 +++++++++++++++++++++
>  8 files changed, 1032 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/huawei/Makefile
>  create mode 100644 arch/arm64/boot/dts/huawei/msm8994-angler-rev-101.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8994-pins.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8994-v2.0.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8994.dtsi
>  create mode 100644 arch/arm64/configs/angler_defconfig
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 515e669..f253f60d 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -98,6 +98,19 @@ config MACH_LGE
>  	help
>  	  This enables support for the LGE Nexus 5X - BullHead MSM8992.
>  
> +config ARCH_MSM8994
> +	bool "Qualcomm MSM8994"
> +	depends on ARCH_QCOM
> +	select ARCH_REQUIRE_GPIOLIB
> +	help
> +	  This enables support for the Qualcomm MSM8994
> +
> +config MACH_HUAWEI
> +	bool "Huawei Angler (MSM8994)"
> +	depends on ARCH_QCOM
> +	help
> +	  This enables support for the Huawei Nexus 6P - Angler MSM8994.

We don't add OEM/end user config options.  We generally only add SoC vendors.
So whenever huawei makes their own processor and uses it in a product, then they
can get their own directory and config option.

> +
>  config ARCH_ROCKCHIP
>  	bool "Rockchip Platforms"
>  	select ARCH_HAS_RESET_CONTROLLER
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index bde90fb..d199f8b 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -9,6 +9,7 @@ dts-dirs += cavium
>  dts-dirs += exynos
>  dts-dirs += freescale
>  dts-dirs += hisilicon
> +dts-dirs += huawei
>  dts-dirs += marvell
>  dts-dirs += mediatek
>  dts-dirs += nvidia
> diff --git a/arch/arm64/boot/dts/huawei/Makefile b/arch/arm64/boot/dts/huawei/Makefile
> new file mode 100644
> index 0000000..4b31ff4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/huawei/Makefile
> @@ -0,0 +1,5 @@
> +dtb-$(CONFIG_MACH_HUAWEI) += msm8994-angler-rev-101.dtb

Nope.  This should be built if ARCH_QCOM is specified.

> +
> +always          := $(dtb-y)
> +subdir-y        := $(dts-dirs)
> +clean-files     := *.dtb
> diff --git a/arch/arm64/boot/dts/huawei/msm8994-angler-rev-101.dts b/arch/arm64/boot/dts/huawei/msm8994-angler-rev-101.dts
> new file mode 100644
> index 0000000..07a71d6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/huawei/msm8994-angler-rev-101.dts

This needs to be in the qcom directory.  And follow the QCOM filename
conventions


> @@ -0,0 +1,41 @@
> +/* Copyright (c) 2015, Huawei Inc. All rights reserved.
> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/dts-v1/;
> +
> +#include "../qcom/msm8994-v2.0.dtsi"
> +
> +/ {
> +	model = "HUAWEI MSM8994 ANGLER rev-1.01";
> +	compatible = "qcom,msm8994";
> +	qcom,board-id= <8026 0>;

We never specify the qcom,board-id in the DT.  We have a tool that adds this to
the dtb file after the fact.  Please work with sboyd to get the 8994 board id
support in the current tool.

The dtbTool is part of the skales repo.
https://source.codeaurora.org/quic/kernel/skales/

> +};
> +
> +/ {
> +	aliases {
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	soc {
> +		serial at f991e000 {
> +			status = "okay";
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&blsp1_uart2_default>;
> +			pinctrl-1 = <&blsp1_uart2_sleep>;
> +		};
> +	};
> +};

<snip>

> diff --git a/arch/arm64/boot/dts/qcom/msm8994-v2.0.dtsi b/arch/arm64/boot/dts/qcom/msm8994-v2.0.dtsi
> new file mode 100644
> index 0000000..8fc4c41f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8994-v2.0.dtsi
> @@ -0,0 +1,31 @@
> +/* Copyright (c) 2014-2016, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/*
> + * As a general rule, only version-specific property overrides should be placed
> + * inside this file. Device definitions should be placed inside the msm8994.dtsi
> + * file.
> + */
> +
> +#include "msm8994.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. MSM 8994v2.0";
> +	compatible = "qcom,msm8994";
> +	qcom,msm-id = <207 0x20000>;

See above comment concerning IDs.

> +
> +};
> +
> +/* Clock driver overrides */
> +&clock_gcc {
> +	compatible = "qcom,gcc-8994v2";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> new file mode 100644
> index 0000000..c95cb73
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> @@ -0,0 +1,237 @@
> +/* Copyright (c) 2013-2016, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/memreserve/ 0x00000000 0x00001000;
> +/memreserve/ 0xac1c0000 0x00001000;

This needs to be done in a reserved-memory { }; section.

> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-msm8994.h>
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. MSM 8994";
> +	compatible = "qcom,msm8994";
> +	qcom,msm-id = <207 0x0>;
> +	qcom,pmic-id = <0x10009 0x1000A 0x0 0x0>;
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&CPU0>;

<snip>

> diff --git a/arch/arm64/configs/angler_defconfig b/arch/arm64/configs/angler_defconfig
> new file mode 100644
> index 0000000..00cf192
> --- /dev/null
> +++ b/arch/arm64/configs/angler_defconfigo

I believe the current modus operandi is that there will be one defconfig for
ARM64.  Therefore, please identify specific options that you need to enable
using the ARM64 defconfig.  And please split out the defconfig changes into a
separate patch.

> @@ -0,0 +1,666 @@
> +CONFIG_AUDIT=y
> +CONFIG_NO_HZ=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_IRQ_TIME_ACCOUNTING=y
> +CONFIG_RCU_FAST_NO_HZ=y
> +CONFIG_LOG_BUF_SHIFT=20
> +CONFIG_CGROUPS=y
> +CONFIG_CGROUP_DEBUG=y

<snip>
