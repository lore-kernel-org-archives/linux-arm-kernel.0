From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 24 Aug 2015 15:49:28 -0700
Subject: [PATCH v3] qcom: ipq40xx: Add basic board/dts support for
 IPQ40XX SoC
In-Reply-To: <20150824092813.GA15581@codeaurora.org>
References: <20150824092813.GA15581@codeaurora.org>
Message-ID: <20150824224928.GE14330@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24, Varadarajan Narayanan wrote:
> Add initial dts files and SoC support for IPQ40XX
> 

So far we haven't added any Xs in the model names for our SoC
support. Even for IPQ806X, we have it as IPQ8064 as the config
name with IPQ806x in the help text because there's IPQ8062 out
there. So I guess it should be IPQ4019 or something?

> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
> diff --git a/Documentation/devicetree/bindings/qcom.txt b/Documentation/devicetree/bindings/qcom.txt
> new file mode 100644
> index 0000000..7d56bd0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/qcom.txt
> @@ -0,0 +1,16 @@
> +Qualcomm IPQ device tree bindings
> +---------------------------------
> +
> +System on Chip
> +
> +Device tree must specify which SoC it uses, with one of the
> +following compatible strings
> +
> +       "qcom,ipq40xx"
> +
> +Platform
> +
> +Device tree must specify which Platform it uses, with one of the
> +following compatible strings
> +
> +       "qcom,ipq40xx-r3pc"

This file is not complete and I don't see any other silicon
vendors doing this, so please drop the entire file.

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

Same here, we should know what model number is on the board.

> +	compatible = "qcom,ipq40xx-r3pc", "qcom,ipq40xx";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x20000000>; /* 512MB */
> +	};

Doesn't the bootloader fill the memory node for us? Why do we
need this?

> +
> +	chosen {
> +		bootargs = "root=/dev/ram rw init=/init console=ttyMSM0,115200n8 initrd=0x82000000,0x000E2246";
> +	};

Please don't add bootargs. Use stdout-path for the console part
and everything else should be done by the bootloader or is the
defaults.

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

These two should also be specific and drop the Xs. Same goes for
the file name.

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

This node is not a child of the SoC node. It should be at the
root level.

> +			compatible = "arm,armv7-timer";
> +			interrupts = <1 2 0xf08>,
> +				     <1 3 0xf08>,
> +				     <1 4 0xf08>,
> +				     <1 1 0xf08>;
> +			clock-frequency = <20833333>;

Drop this clock-frequency part if you can. The hardware should
properly report the frequency.

> +		};
> +
> +		serial at 78b0000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x78b0000 0x200>;
> +			interrupts = <0 108 0>;
> +			status = "disabled";

Don't you need some clocks here?

> +		};
> +	};
> +};
> diff --git a/arch/arm/configs/ipq_defconfig b/arch/arm/configs/ipq_defconfig
> index 1cabd8b..89bf8ad 100644
> --- a/arch/arm/configs/ipq_defconfig
> +++ b/arch/arm/configs/ipq_defconfig
> @@ -21,6 +21,7 @@ CONFIG_ARCH_QCOM=y
>  CONFIG_ARCH_MSM8X60=y
>  CONFIG_ARCH_MSM8960=y
>  CONFIG_ARCH_MSM8974=y
> +CONFIG_ARCH_IPQ40XX=y
>  CONFIG_ARCH_IPQ8064=y
>  CONFIG_SMP=y
>  CONFIG_PREEMPT=y

This hunk should be in a separate patch.

> diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
> index fab49a2..70812aa 100644
> --- a/arch/arm/mach-qcom/Kconfig
> +++ b/arch/arm/mach-qcom/Kconfig
> @@ -22,6 +22,10 @@ config ARCH_MSM8974
>  	bool "Enable support for MSM8974"
>  	select HAVE_ARM_ARCH_TIMER
>  
> +config ARCH_IPQ40XX
> +	bool "Enable support for IPQ40XX"
> +	select HAVE_ARM_ARCH_TIMER
> +
>  config ARCH_IPQ8064
>  	bool "Enable support for IPQ806x"
>  	select CLKSRC_QCOM
> diff --git a/arch/arm/mach-qcom/board.c b/arch/arm/mach-qcom/board.c
> index 6d8bbf7..af9e247 100644
> --- a/arch/arm/mach-qcom/board.c
> +++ b/arch/arm/mach-qcom/board.c
> @@ -18,6 +18,7 @@ static const char * const qcom_dt_match[] __initconst = {
>  	"qcom,apq8064",
>  	"qcom,apq8074-dragonboard",
>  	"qcom,apq8084",
> +	"qcom,ipq40xx",
>  	"qcom,ipq8062",
>  	"qcom,ipq8064",
>  	"qcom,msm8660-surf",
> 

And these two should also go as a separate patch.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
