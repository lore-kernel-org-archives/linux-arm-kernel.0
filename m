From: varada@codeaurora.org (Varadarajan Narayanan)
Date: Fri, 21 Aug 2015 16:01:22 +0530
Subject: [PATCH] qcom: ipq40xx: Add basic board/dts support for IPQ40XX SoC
In-Reply-To: <20150821092035.GA22319@codeaurora.org>
References: <20150821092035.GA22319@codeaurora.org>
Message-ID: <20150821103122.GA17542@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 02:50:35PM +0530, Varadarajan Narayanan wrote:
> Add initial dts files and SoC support for IPQ40XX

Please ignore this. Missed the Devicetree bindings documentation.
Will post a revised patch.

Thanks
Varada

> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 246473a..6b4caee 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -477,7 +477,8 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-ipq8064-ap148.dtb \
>  	qcom-msm8660-surf.dtb \
>  	qcom-msm8960-cdp.dtb \
> -	qcom-msm8974-sony-xperia-honami.dtb
> +	qcom-msm8974-sony-xperia-honami.dtb \
> +	qcom-ipq40xx-r3pc.dtb
>  dtb-$(CONFIG_ARCH_REALVIEW) += \
>  	arm-realview-pb1176.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += \
> diff --git a/arch/arm/boot/dts/qcom-ipq40xx-r3pc.dts b/arch/arm/boot/dts/qcom-ipq40xx-r3pc.dts
> new file mode 100644
> index 0000000..7e4e629
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq40xx-r3pc.dts
> @@ -0,0 +1,33 @@
> +/* Copyright (c) 2014, The Linux Foundation. All rights reserved.
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
> +#include "qcom-ipq40xx.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ40XX R3PC";
> +	compatible = "qcom,ipq40xx-r3pc", "qcom,ipq40xx";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x20000000>; /* 512MB */
> +	};
> +
> +	chosen {
> +		bootargs = "root=/dev/ram rw init=/init console=ttyMSM0,115200n8 initrd=0x82000000,0x000E2246";
> +	};
> +
> +	soc {
> +		serial at 78b0000 {
> +			status = "ok";
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/qcom-ipq40xx.dtsi b/arch/arm/boot/dts/qcom-ipq40xx.dtsi
> new file mode 100644
> index 0000000..f572f38
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq40xx.dtsi
> @@ -0,0 +1,81 @@
> +/*
> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
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
> +#include "skeleton.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ40XX";
> +	compatible = "qcom,ipq40xx";
> +	interrupt-parent = <&intc>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x0>;
> +		};
> +
> +		cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x1>;
> +		};
> +
> +		cpu at 2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x2>;
> +		};
> +
> +		cpu at 3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x3>;
> +		};
> +	};
> +
> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +		compatible = "simple-bus";
> +
> +		intc: interrupt-controller at b000000 {
> +			compatible = "qcom,msm-qgic2";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			reg = <0x0b000000 0x1000>,
> +			<0x0b002000 0x1000>;
> +		};
> +
> +		timer {
> +			compatible = "arm,armv7-timer";
> +			interrupts = <1 2 0xf08>,
> +				     <1 3 0xf08>,
> +				     <1 4 0xf08>,
> +				     <1 1 0xf08>;
> +			clock-frequency = <20833333>;
> +		};
> +
> +		serial at 78b0000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x78b0000 0x200>;
> +			interrupts = <0 108 0>;
> +			status = "disabled";
> +		};
> +	};
> +};
> diff --git a/arch/arm/configs/ipq_defconfig b/arch/arm/configs/ipq_defconfig
> index 1cabd8b..054a159 100644
> --- a/arch/arm/configs/ipq_defconfig
> +++ b/arch/arm/configs/ipq_defconfig
> @@ -22,6 +22,7 @@ CONFIG_ARCH_MSM8X60=y
>  CONFIG_ARCH_MSM8960=y
>  CONFIG_ARCH_MSM8974=y
>  CONFIG_ARCH_IPQ8064=y
> +CONFIG_ARCH_IPQ40XX=y
>  CONFIG_SMP=y
>  CONFIG_PREEMPT=y
>  CONFIG_AEABI=y
> diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
> index fab49a2..3add9f9 100644
> --- a/arch/arm/mach-qcom/Kconfig
> +++ b/arch/arm/mach-qcom/Kconfig
> @@ -26,4 +26,8 @@ config ARCH_IPQ8064
>  	bool "Enable support for IPQ806x"
>  	select CLKSRC_QCOM
>  
> +config ARCH_IPQ40XX
> +	bool "Enable support for IPQ40XX"
> +	select HAVE_ARM_ARCH_TIMER
> +
>  endif
> diff --git a/arch/arm/mach-qcom/board.c b/arch/arm/mach-qcom/board.c
> index 6d8bbf7..566487d 100644
> --- a/arch/arm/mach-qcom/board.c
> +++ b/arch/arm/mach-qcom/board.c
> @@ -22,6 +22,7 @@ static const char * const qcom_dt_match[] __initconst = {
>  	"qcom,ipq8064",
>  	"qcom,msm8660-surf",
>  	"qcom,msm8960-cdp",
> +	"qcom,ipq40xx-r3pc",
>  	NULL
>  };
>  
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
