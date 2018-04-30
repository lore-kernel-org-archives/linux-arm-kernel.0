From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 30 Apr 2018 08:50:01 +0000
Subject: [PATCH 3/5] arm64: dts: imx: add imx8qxp support
In-Reply-To: <20180430055429.zkyhn7w7ppnqs2pp@salmiak>
References: <1524855977-15719-1-git-send-email-aisheng.dong@nxp.com>
 <1524855977-15719-4-git-send-email-aisheng.dong@nxp.com>
 <20180430055429.zkyhn7w7ppnqs2pp@salmiak>
Message-ID: <AM0PR04MB4211B138590F1729C638CB7F80820@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for the review.

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Monday, April 30, 2018 1:55 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com;
> kernel at pengutronix.de; shawnguo at kernel.org; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt at kernel.org; catalin.marinas at arm.com;
> will.deacon at arm.com; dl-linux-imx <linux-imx@nxp.com>;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH 3/5] arm64: dts: imx: add imx8qxp support
> 
> Hi,
> 
> On Sat, Apr 28, 2018 at 03:06:15AM +0800, Dong Aisheng wrote:
> > +/{
> > +	cpus {
> > +		#address-cells = <2>;
> > +		#size-cells = <0>;
> > +
> > +		/* We have 1 clusters having 4 Cortex-A35 cores */
> 
> > +	};
> > +
> > +	pmu {
> > +		compatible = "arm,armv8-pmuv3";
> > +		interrupts = <GIC_PPI 7
> > +			(GIC_CPU_MASK_SIMPLE(6) |
> IRQ_TYPE_LEVEL_HIGH)>;
> > +		interrupt-affinity = <&A35_0>, <&A35_1>, <&A35_2>,
> <&A35_3>;
> > +	};
> 
> If using a PPI and all cores are identical, interrupt-affinity isn't necessary.
> 
> I note you're using GICv3, whihch doesn't encode a cpumask in its PPI
> specifier. All instances of GIC_CPU_MASK_SIMPLE should go from dts{i,} files
> for this platform.
> 

You're right.
Thanks for the reminder.

> > +
> > +	psci {
> > +		compatible = "arm,psci-1.0";
> > +		method = "smc";
> > +		cpu_suspend   = <0xc4000001>;
> > +		cpu_off	      = <0xc4000002>;
> > +		cpu_on	      = <0xc4000003>;
> 
> You can drop the cpu_* function IDs if you only have "arm,psci-1.0" in the
> compatible list. These IDs (and more) are implied by PSCI 1.0+.
> 

That's true. Will remove them.

> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-imx8qxp-mek.dts
> > b/arch/arm64/boot/dts/freescale/fsl-imx8qxp-mek.dts
> > new file mode 100644
> > index 0000000..920018e
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-imx8qxp-mek.dts
> > @@ -0,0 +1,138 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2017~2018 NXP
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "fsl-imx8qxp.dtsi"
> > +
> > +/ {
> > +	model = "Freescale i.MX8QXP MEK";
> > +	compatible = "fsl,imx8qxp-mek", "fsl,imx8qxp";
> > +
> > +	chosen {
> > +		stdout-path = &dma_lpuart0;
> > +	};
> 
> No baud-rate configuration?
> 

We use the default one configured by bootloader.
Or should I be better to specify it?

> [...]
> 
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-imx8qxp.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-imx8qxp.dtsi
> > new file mode 100644
> > index 0000000..d7cc836
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-imx8qxp.dtsi
> > @@ -0,0 +1,794 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > + * Copyright 2017~2018 NXP
> > + *	Dong Aisheng <aisheng.dong@nxp.com>
> > + */
> > +
> > +#include <dt-bindings/clock/imx8qxp-clock.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/pinctrl/pads-imx8qxp.h>
> > +#include <dt-bindings/power/imx-rsrc.h>
> > +
> > +#include "fsl-imx8-ca35.dtsi"
> > +
> > +/ {
> > +	compatible = "fsl,imx8qxp";
> > +	interrupt-parent = <&gic>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	aliases {
> > +		serial0 = &dma_lpuart0;
> > +		mmc0 = &usdhc1;
> > +		mmc1 = &usdhc2;
> > +		mmc2 = &usdhc3;
> > +	};
> > +
> > +	memory at 80000000 {
> > +		device_type = "memory";
> > +		reg = <0x00000000 0x80000000 0 0x40000000>;
> > +	};
> > +
> > +	gic: interrupt-controller at 51a00000 {
> > +		compatible = "arm,gic-v3";
> > +		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
> > +		      <0x0 0x51b00000 0 0xC0000>; /* GICR (RD_base +
> SGI_base) */
> > +		#interrupt-cells = <3>;
> > +		interrupt-controller;
> > +		interrupts = <GIC_PPI 9
> > +			(GIC_CPU_MASK_SIMPLE(6) |
> IRQ_TYPE_LEVEL_HIGH)>;
> 
> As above, GIC_CPU_MASK_SIMPLE does not apply to GICv3, and should go.
> 
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) |
> IRQ_TYPE_LEVEL_LOW)>, /* Physical Secure */
> > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) |
> IRQ_TYPE_LEVEL_LOW)>, /* Physical Non-Secure */
> > +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) |
> IRQ_TYPE_LEVEL_LOW)>, /* Virtual */
> > +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) |
> IRQ_TYPE_LEVEL_LOW)>;
> > +/* Hypervisor */
> 
> ... likewise.
> 
> > +		clock-frequency = <8000000>;
> 
> Your firmware should be configuring CNTFRQ, so this clock-frequency
> property should go.
> 

Correct. Will delete it.

Regards
Dong Aisheng

> Thanks,
> Mark.
