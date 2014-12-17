From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Dec 2014 14:33:05 +0000
Subject: [PATCH v2 3/4] arm64: dts: Add mediatek MT8173 SoC and
 evaluation board dts and Makefile
In-Reply-To: <1418825853-10934-4-git-send-email-eddie.huang@mediatek.com>
References: <1418825853-10934-1-git-send-email-eddie.huang@mediatek.com>
 <1418825853-10934-4-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20141217143305.GC8942@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 02:17:32PM +0000, Eddie Huang wrote:
> Add device tree support for MT8173 SoC and evaluation board based on it.
> 
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  arch/arm64/boot/dts/Makefile       |   1 +
>  arch/arm64/boot/dts/mt8173-evb.dts |  34 +++++++++
>  arch/arm64/boot/dts/mt8173.dtsi    | 152 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 187 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mt8173-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mt8173.dtsi
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index f8001a6..db7661e 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -1,3 +1,4 @@
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
>  dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
>  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
>  dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
> diff --git a/arch/arm64/boot/dts/mt8173-evb.dts b/arch/arm64/boot/dts/mt8173-evb.dts
> new file mode 100644
> index 0000000..b8b2621
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mt8173-evb.dts
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: Eddie Huang <eddie.huang@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/dts-v1/;
> +#include "mt8173.dtsi"
> +
> +/ {
> +	model = "mediatek,mt8173-evb";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +	};
> +
> +	memory at 40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +
> +	chosen { };
> +};
> diff --git a/arch/arm64/boot/dts/mt8173.dtsi b/arch/arm64/boot/dts/mt8173.dtsi
> new file mode 100644
> index 0000000..41c1441
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mt8173.dtsi
> @@ -0,0 +1,152 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: Eddie Huang <eddie.huang@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/ {
> +	compatible = "mediatek,mt8173";
> +	interrupt-parent = <&sysirq>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu2>;
> +				};
> +				core1 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x000>;
> +		};
> +
> +		cpu1: cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x001>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu at 2 {

The unit-address should be 100 rather than 2, matching the reg property.
This should be 'cpu at 100'.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a57";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu at 3 {

Similarly this should be 'cpu at 101'.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a57";
> +			reg = <0x101>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci";
> +		method = "smc";
> +		cpu_suspend   = <0x84000001>;
> +		cpu_off	      = <0x84000002>;
> +		cpu_on	      = <0x84000003>;
> +		affinity_info = <0x84000004>;
> +	};

There is no AFFINITY_INFO function prior to PSCI 0.2, and
'affinity_info' does not exist in the "arm,psci" binding.

I take it hotplug has been tested for all but CPU0?

> +
> +	uart_clk: dummy26m {
> +		compatible = "fixed-clock";
> +		clock-frequency = <26000000>;
> +		#clock-cells = <0>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <1 13 0xf08>,
> +			     <1 14 0xf08>,
> +			     <1 11 0xf08>,
> +			     <1 10 0xf08>;
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		sysirq: intpol-controller at 10200620 {
> +			compatible = "mediatek,mt8173-sysirq", "mediatek,mt6577-sysirq";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupt-parent = <&gic>;
> +			reg = <0 0x10200620 0 0x20>;
> +		};
> +
> +		gic: interrupt-controller at 10220000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x10221000 0 0x1000>,
> +			      <0 0x10222000 0 0x1000>,
> +			      <0 0x10224000 0 0x2000>,
> +			      <0 0x10226000 0 0x2000>;
> +			interrupts = <1 9 0xf04>;
> +		};

I don't think these reg entries are quite right; GICC should be 8k long.

Marc?

Thanks,
Mark.
