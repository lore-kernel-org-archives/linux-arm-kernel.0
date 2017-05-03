From: varada@codeaurora.org (Varadarajan Narayanan)
Date: Wed, 3 May 2017 13:00:54 +0530
Subject: [PATCH 4/5] arm64: dts: Add ipq8074 SoC and MTP board support
In-Reply-To: <20170428185349.GD7065@codeaurora.org>
References: <1493373403-23462-1-git-send-email-varada@codeaurora.org>
 <1493373403-23462-5-git-send-email-varada@codeaurora.org>
 <20170428185349.GD7065@codeaurora.org>
Message-ID: <5d5c88ac-6261-9209-b7f9-b6d794f677e5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/29/2017 12:23 AM, Stephen Boyd wrote:
> On 04/28, Varadarajan Narayanan wrote:
>> diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
>> new file mode 100644
>> index 0000000..c150bea
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
>> @@ -0,0 +1,48 @@
>> +/dts-v1/;
>> +/* Copyright (c) 2017, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +#include "ipq8074.dtsi"
>> +
>> +/ {
>> +	#address-cells = <0x2>;
>> +	#size-cells = <0x2>;
>> +	model = "Qualcomm Technologies, Inc. IPQ8074-HK01";
>> +	compatible = "qcom,ipq8074-hk01", "qcom,ipq8074";
>> +	interrupt-parent = <&intc>;
>> +
>> +	chosen {
>> +		bootargs = "console=ttyMSM0,115200,n8 root=/dev/ram0 rw init=/init";
> 
> Add an aliases node for serial0 and use a chosen node with stdout-path = "serial0" instead please.

Ok

> 
>> +	};
>> +
>> +	memory {
>> +		device_type = "memory";
>> +		reg = <0x0 0x40000000 0x0 0x20000000>;
>> +	};
>> +
>> +	soc: soc {
> 
> Do you need the soc label here? Please remove.

Ok

> 
>> +		pinctrl at 1000000 {
>> +			serial_4_pins: serial4_pinmux {
>> +				mux {
>> +					pins = "gpio23", "gpio24";
>> +					function = "blsp4_uart1";
>> +					bias-disable;
>> +				};
>> +			};
>> +		};
>> +
>> +		serial at 78b3000 {
>> +			pinctrl-0 = <&serial_4_pins>;
>> +			pinctrl-names = "default";
>> +			status = "ok";
>> +		};
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> new file mode 100644
>> index 0000000..f910cc0
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> @@ -0,0 +1,153 @@
>> +/*
>> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/qcom,gcc-ipq8074.h>
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ8074";
>> +	compatible = "qcom,ipq8074";
>> +
>> +	soc: soc {
>> +		#address-cells = <0x1>;
>> +		#size-cells = <0x1>;
>> +		ranges = <0 0 0 0xffffffff>;
>> +		compatible = "simple-bus";
>> +
>> +		pinctrl at 1000000 {
>> +			compatible = "qcom,ipq8074-pinctrl";
>> +			reg = <0x1000000 0x300000>;
>> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +			gpio-controller;
>> +			#gpio-cells = <0x2>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <0x2>;
>> +		};
>> +
>> +		intc: interrupt-controller at b000000 {
>> +			compatible = "qcom,msm-qgic2";
>> +			interrupt-controller;
>> +			#interrupt-cells = <0x3>;
>> +			reg = <0xb000000 0x1000>,
>> +			<0xb002000 0x1000>;
> 
> Please align this up with previous reg property.

Ok

> 
>> +		};
>> +
>> +		timer {
>> +			compatible = "arm,armv8-timer";
>> +			interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +				     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +				     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +				     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +		};
> 
> Is there an mmio timer as well? We should add it too.

Ok

> 
>> +
>> +		gcc: gcc at 1800000 {
>> +			compatible = "qcom,gcc-ipq8074";
>> +			reg = <0x1800000 0x80000>;
> 
> Wow that is a huge area! Is it really that large?

Yes, per the memory map this region is 512K.

> 
>> +			#clock-cells = <0x1>;
>> +			#reset-cells = <0x1>;
>> +		};
>> +
>> +		serial at 78b3000 {
>> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>> +			reg = <0x78b3000 0x200>;
>> +			interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_UART5_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			status = "disabled";
>> +		};
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <0x1>;
>> +		#size-cells = <0x0>;
>> +
>> +		cpu-map {
>> +
>> +			cluster0 {
>> +
>> +				core0 {
>> +					cpu = <&CPU0>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&CPU1>;
>> +				};
>> +
>> +				core2 {
>> +					cpu = <&CPU2>;
>> +				};
>> +
>> +				core3 {
>> +					cpu = <&CPU3>;
>> +				};
>> +			};
>> +		};
> 
> Is this needed? Looks ok, but just curious if we need to do it
> for other arm64 platforms we support.

Don't see the need for topology at this time, will add it later if needed.

> 
>> +
>> +		CPU0: cpu at 0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			reg = <0x0>;
>> +			next-level-cache = <&L2_0>;
>> +			enable-method = "psci";
>> +		};
>> +
>> +		CPU1: cpu at 1 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			enable-method = "psci";
>> +			reg = <0x1>;
>> +			next-level-cache = <&L2_0>;
>> +		};
>> +
>> +		CPU2: cpu at 2 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			enable-method = "psci";
>> +			reg = <0x2>;
>> +			next-level-cache = <&L2_0>;
>> +		};
>> +
>> +		CPU3: cpu at 3 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			enable-method = "psci";
>> +			reg = <0x3>;
>> +			next-level-cache = <&L2_0>;
>> +		};
>> +
>> +		L2_0: l2-cache {
>> +			compatible = "cache";
>> +			cache-level = <0x2>;
>> +		};
> 
> This should be inside some CPU? CPU0?

There is only one L2. We followed the same convention as in msm8916.dtsi.

> 
>> +	};
> 
> We should be able to add the performance monitor node too?
> 
Ok

>> +
>> +	psci {
>> +		compatible = "arm,psci-1.0";
>> +		method = "smc";
>> +	};
>> +
>> +	clocks {
>> +		sleep_clk: sleep_clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <32000>;
> 
> Not 32765 or 32768?

It is 32000.

> 
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		xo: xo {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <19200000>;
>> +			#clock-cells = <0>;
>> +		};
>> +	};
> 

-Varada
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum, a Linux Foundation Collaborative Project
