From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 9 Sep 2016 19:53:36 +0800
Subject: [PATCH v4 2/3] arm64: dts: Add ZTE ZX296718 SoC dts and Makefile
In-Reply-To: <1473141861-5033-3-git-send-email-jun.nie@linaro.org>
References: <1473141861-5033-1-git-send-email-jun.nie@linaro.org>
 <1473141861-5033-3-git-send-email-jun.nie@linaro.org>
Message-ID: <20160909115336.GB16924@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A bit more comments as below ...

On Tue, Sep 06, 2016 at 02:04:20PM +0800, Jun Nie wrote:
> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&gic>;
> +		ranges;
> +
> +		timer {
> +			compatible = "arm,armv8-timer";
> +			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;

Affinity bits are missing for PPI interrupt.  You can use a bit help
from defines in include/dt-bindings/interrupt-controller/arm-gic.h.

> +		};
> +
> +		pmu {
> +			compatible = "arm,cortex-a53-pmu";
> +			interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +		};

There are no unit-address for timer and pmu, so we should probably move
them out of soc simple-bus and put them directly under root.

> +
> +		aon_sysctrl: aon-sysctrl at 116000 {
> +			compatible = "zte,zx296718-aon-sysctrl", "syscon";
> +			reg = <0x116000 0x1000>;
> +		};
> +
> +		uart0: uart at 11f000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			arm,primecell-periphid = <0x001feffe>;
> +			reg = <0x11f000 0x1000>;
> +			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc24m>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		dma: dma-controller at 1460000 {
> +			compatible = "zte,zx296702-dma";
> +			reg = <0x01460000 0x1000>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc24m>;
> +			clock-names = "dmaclk";
> +			#dma-cells = <1>;
> +			dma-channels = <32>;
> +			dma-requests = <32>;
> +		};
> +
> +		sysctrl: sysctrl at 1463000 {
> +			compatible = "zte,zx296718-sysctrl", "syscon";
> +			reg = <0x1463000 0x1000>;
> +		};
> +
> +		gic: interrupt-controller at 2a00000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			#redistributor-regions = <6>;
> +			redistributor-stride = <0x0 0x40000>;
> +			interrupt-controller;
> +			reg = <0x02a00000 0x10000>,
> +			      <0x02b00000 0x20000>,
> +			      <0x02b20000 0x20000>,
> +			      <0x02b40000 0x20000>,
> +			      <0x02b60000 0x20000>,
> +			      <0x02b80000 0x20000>,
> +			      <0x02ba0000 0x20000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;

Affinity bits are missing.

Shawn

> +		};
> +	};
> +};
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
