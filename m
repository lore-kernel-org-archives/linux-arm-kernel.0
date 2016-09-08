From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 8 Sep 2016 14:23:25 +0100
Subject: [PATCH 3/7] [v2] arm64: dts: add QorIQ LS1046A SoC support
In-Reply-To: <1473069695-33092-4-git-send-email-shh.xie@gmail.com>
References: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
 <1473069695-33092-4-git-send-email-shh.xie@gmail.com>
Message-ID: <57D1664D.3060502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/16 11:01, shh.xie at gmail.com wrote:
> From: Mingkai Hu <Mingkai.Hu@nxp.com>
> 
> LS1046A is an SoC with 4 ARMv8 A72 cores and most other IP blocks
> are similar to LS1043A which also complies to Freescale Chassis 2.1
> spec.
> 
> Created LS1046A SoC DTSI file to be included by board level DTS
> files.
> 
> Signed-off-by: Horia Geant? <horia.geanta@nxp.com>
> Signed-off-by: Mihai Bantea <mihai.bantea@nxp.com>
> Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> Signed-off-by: Gong Qianyu <Qianyu.Gong@nxp.com>
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Signed-off-by: Mingkai Hu <Mingkai.Hu@nxp.com>
> Signed-off-by: Shaohui Xie <Shaohui.Xie@nxp.com>
> ---
> Changes in V2:
> 1. addressed Arnd's comments.
>    removed memory size property.
>    refined devices' names.
>    removed PCIe and MSI nodes.
> 2. updated interrupt properties with readable defines.
> 3. removed clock-names property from I2C and watchdog nodes.
> 4. added crypto nodes.
>    binding of crypto nodes available at:
>    http://patchwork.ozlabs.org/patch/663184/
> 5. added CPU idle-states node.
> 6. added ddr controller node.
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 511 +++++++++++++++++++++++++
>  1 file changed, 511 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> new file mode 100644
> index 0000000..9697332
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -0,0 +1,511 @@
> +/*
> + * Device Tree Include file for Freescale Layerscape-1046A family SoC.
> + *
> + * Copyright 2016, Freescale Semiconductor, Inc.
> + *
> + * Mingkai Hu <mingkai.hu@nxp.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPLv2 or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "fsl,ls1046a";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		crypto = &crypto;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x0>;
> +			clocks = <&clockgen 1 0>;
> +			next-level-cache = <&l2>;
> +			cpu-idle-states = <&CPU_PH20>;
> +		};
> +
> +		cpu1: cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x1>;
> +			clocks = <&clockgen 1 0>;
> +			next-level-cache = <&l2>;
> +			cpu-idle-states = <&CPU_PH20>;
> +		};
> +
> +		cpu2: cpu at 2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x2>;
> +			clocks = <&clockgen 1 0>;
> +			next-level-cache = <&l2>;
> +			cpu-idle-states = <&CPU_PH20>;
> +		};
> +
> +		cpu3: cpu at 3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x3>;
> +			clocks = <&clockgen 1 0>;
> +			next-level-cache = <&l2>;
> +			cpu-idle-states = <&CPU_PH20>;
> +		};
> +
> +		l2: l2-cache {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	idle-states {
> +		entry-method = "arm,psci";
> +
> +		CPU_PH20: cpu-ph20 {
> +			compatible = "arm,idle-state";
> +			idle-state-name = "PH20";
> +			arm,psci-suspend-param = <0x00010000>;
> +			entry-latency-us = <1000>;
> +			exit-latency-us = <1000>;
> +			min-residency-us = <3000>;
> +		};
> +	};
> +
> +	memory at 80000000 {
> +		device_type = "memory";
> +	};
> +
> +	sysclk: sysclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +		clock-output-names = "sysclk";
> +	};
> +
> +	reboot {
> +		compatible ="syscon-reboot";
> +		regmap = <&dcfg>;
> +		offset = <0xb0>;
> +		mask = <0x02>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_EDGE_RISING>,
> +			     <GIC_PPI 14 IRQ_TYPE_EDGE_RISING>,
> +			     <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>,
> +			     <GIC_PPI 10 IRQ_TYPE_EDGE_RISING>;

No, this is completely wrong. The timer is always level triggered, and
you're missing the affinity bits that are described the GIC binding.

> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";

Please add "arm,cortex-a72-pmu".

> +		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>,
> +				     <&cpu1>,
> +				     <&cpu2>,
> +				     <&cpu3>;
> +	};
> +
> +	gic: interrupt-controller at 1400000 {
> +		compatible = "arm,gic-400";
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg = <0x0 0x1410000 0 0x10000>, /* GICD */
> +		      <0x0 0x1420000 0 0x20000>, /* GICC */
> +		      <0x0 0x1440000 0 0x20000>, /* GICH */
> +		      <0x0 0x1460000 0 0x20000>; /* GICV */
> +		interrupts = <1 9 0xf08>;

Please choose between expressing the interrupts entirely with numerals
or entirely with symbols. At the moment this is a mix between the two.

> +	};

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
