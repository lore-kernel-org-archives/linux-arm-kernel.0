From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Feb 2017 15:57:43 +0000
Subject: [PATCH 1/5] arm64: dts: Add basic DT to support Spreadtrum's
 SP9860G
In-Reply-To: <1487063952-7113-2-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1487063952-7113-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1487063952-7113-2-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20170214155743.GG23718@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 14, 2017 at 05:19:08PM +0800, Chunyan Zhang wrote:

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8)
> +					 | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8)
> +					 | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8)
> +					 | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8)
> +					 | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <26000000>;
> +	};

Your FW should program CNTFRQ on all CPUs, and this clock-frequency
property should not be necessary. Please remove it.

> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";

Please list "arm,cortex-a53-pmu" first.

> +		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
> +	};

As you are using SPIs, please add an interrupt-affinity property, per
Documentation/devicetree/bindings/arm/pmu.txt.

> diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> new file mode 100644
> index 0000000..59390fc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> @@ -0,0 +1,58 @@
> +/*
> + * Spreadtrum SP9860g board DTS file
> + *
> + * Copyright (C) 2017, Spreadtrum Communications Inc.
> + *
> + * This file is licensed under a dual GPLv2 or X11 license.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc9860.dtsi"
> +
> +/ {
> +	model = "Spreadtrum SP9860G 3GFHD Board";
> +
> +	compatible = "sprd,sc9860", "sprd,sp9860g-1h10";
> +
> +	sprd,sc-id = <9860 1 0x20000>;

What is this? I can't see any documentation or user of this property in
mainline.


Thanks,
Mark.
