From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 17 Feb 2016 08:00:33 +0100
Subject: [PATCH 6/6] ARM64: dts: rockchip: add core dtsi file for rk3399
In-Reply-To: <1455674476-16655-1-git-send-email-jay.xu@rock-chips.com>
References: <1455673992-16469-1-git-send-email-jay.xu@rock-chips.com>
 <1455674476-16655-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <2396201.CBcovI4jc4@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jianqun,

Am Mittwoch, 17. Februar 2016, 10:01:16 schrieb jianqun.xu:
> From: Xu Jianqun <jay.xu@rock-chips.com>
> 
> Add dtsi file for Rockchip rk3399 SoCs, which includes some
> general nodes such as cpu, pmu, cru, gic, amba and so on.
> 
> Change-Id: Ie3b824e8ead967d4cb119d73222b7a198478c29c

please remove any review-cruft like Change-Ids from mainline patches :-)

> Signed-off-by: Xu Jianqun <jay.xu@rock-chips.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 989
> +++++++++++++++++++++++++++++++ 1 file changed, 989 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi new file mode 100644
> index 0000000..eb671f6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -0,0 +1,989 @@
> +/*
> + * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
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
> +#include <dt-bindings/clock/rk3399-cru.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +
> +/ {
> +	compatible = "rockchip,rk3399";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci";
> +		method = "smc";
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu_l0>;
> +				};
> +				core1 {
> +					cpu = <&cpu_l1>;
> +				};
> +				core2 {
> +					cpu = <&cpu_l2>;
> +				};
> +				core3 {
> +					cpu = <&cpu_l3>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu_b0>;
> +				};
> +				core1 {
> +					cpu = <&cpu_b1>;
> +				};
> +			};
> +		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			cpu_sleep: cpu-sleep-0 {
> +				compatible = "arm,idle-state";
> +			};
> +		};

why the essentially empty idle-states, which is probably missing properties? 
In the absence of a real idle driver the kernel will fall back to 
arch_cpu_idle(), which already does WFI handling even on arm64.


> +
> +		cpu_l0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x0>;
> +			cpu-idle-states = <&cpu_sleep>;

that won't compile, as the referenced node is not present


> +			enable-method = "psci";
> +		};
> +
> +		cpu_l1: cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x1>;
> +			cpu-idle-states = <&cpu_sleep>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu_l2: cpu at 2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x2>;
> +			cpu-idle-states = <&cpu_sleep>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu_l3: cpu at 3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x3>;
> +			cpu-idle-states = <&cpu_sleep>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu_b0: cpu at 100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0x0 0x100>;
> +			cpu-idle-states = <&cpu_sleep>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu_b1: cpu at 101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0x0 0x101>;
> +			cpu-idle-states = <&cpu_sleep>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-affinity = <&cpu_l0>, <&cpu_l1>, <&cpu_l2>,
> +				     <&cpu_l3>, <&cpu_b0>, <&cpu_b1>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts =
> +			<GIC_PPI 13
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,

shouldn't that be GIC_CPU_MASK_SIMPLE(6) instead of 4?


> +			<GIC_PPI 14
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			<GIC_PPI 11
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			<GIC_PPI 10
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +		clock-frequency = <24000000>;
> +	};
> +
> +	xin24m: xin24m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24000000>;
> +		clock-output-names = "xin24m";
> +	};
> +
> +	gic: interrupt-controller at fee00000 {
> +		compatible = "arm,gic-v3";
> +		#interrupt-cells = <3>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		interrupt-controller;
> +
> +		reg = <0x0 0xfee00000 0 0x10000>, /* GICD */
> +		      <0x0 0xfef00000 0 0xc0000>, /* GICR */
> +		      <0x0 0xfff00000 0 0x10000>, /* GICC */
> +		      <0x0 0xfff10000 0 0x10000>, /* GICH */
> +		      <0x0 0xfff20000 0 0x10000>; /* GICV */
> +		interrupts =
> +			<GIC_PPI 9
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;

again GIC_CPU_MASK_SIMPLE(6)?

> +		its: interrupt-controller at fee20000 {
> +			compatible = "arm,gic-v3-its";
> +			msi-controller;
> +			reg = <0x0 0xfee20000 0x0 0x20000>;
> +		};
> +	};
> +
> +	amba {
> +		compatible = "arm,amba-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		dmac_bus: dma-controller at ff6d0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x0 0xff6d0000 0x0 0x4000>;
> +			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			clocks = <&cru ACLK_DMAC_BUS>;
> +			clock-names = "apb_pclk";

has the FLUSHP bug gotten fixed? That would be cool.


> +		};

rest looks nice on first glance :-)


Heiko
