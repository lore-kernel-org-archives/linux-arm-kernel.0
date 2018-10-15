From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 15 Oct 2018 08:08:31 +0000
Subject: [PATCH V2 2/4] arm64: dts: imx: add imx8qxp support
In-Reply-To: <20181015065859.lxevjroly435hlaq@pengutronix.de>
References: <1539527419-23613-1-git-send-email-aisheng.dong@nxp.com>
 <1539527419-23613-3-git-send-email-aisheng.dong@nxp.com>
 <20181015065859.lxevjroly435hlaq@pengutronix.de>
Message-ID: <AM0PR04MB42117867A50BB18D8127BE8080FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Monday, October 15, 2018 2:59 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; Mark Rutland
> <mark.rutland@arm.com>; dongas86 at gmail.com; devicetree at vger.kernel.org;
> catalin.marinas at arm.com; will.deacon at arm.com; robh+dt at kernel.org;
> dl-linux-imx <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; shawnguo at kernel.org
> Subject: Re: [PATCH V2 2/4] arm64: dts: imx: add imx8qxp support
> 
> On Sun, Oct 14, 2018 at 02:34:52PM +0000, A.s. Dong wrote:
> > Add imx8qxp support
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree at vger.kernel.org
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > v1->v2:
> >  * mu binding usage update
> >  * no define for node address
> >  * do not use '_' for node name
> >  * drop 'fsl-' prefix for imx dtsi
> >  * no defines for unit address
> >  * generic node names
> >  * range map for 32bit register
> >  * separate board dts
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.txt |   4 +
> >  arch/arm64/boot/dts/freescale/imx8-ca35.dtsi  |  61 ++
> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 861
> ++++++++++++++++++++++++++
> >  3 files changed, 926 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.txt
> > b/Documentation/devicetree/bindings/arm/fsl.txt
> > index 968f238..baeb1fc 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.txt
> > +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> > @@ -119,6 +119,10 @@ i.MX6q generic board  Required root node
> > properties:
> >      - compatible = "fsl,imx6q";
> >
> > +i.MX8QXP generic board
> > +Required root node properties:
> > +    - compatible = "fsl,imx8qxp";
> > +
> >  Freescale Vybrid Platform Device Tree Bindings
> >  ----------------------------------------------
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
> > new file mode 100644
> > index 0000000..c79e97a
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
> > @@ -0,0 +1,61 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > + * Copyright 2017~2018 NXP
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/{
> > +	cpus {
> > +		#address-cells = <2>;
> > +		#size-cells = <0>;
> > +
> > +		/* We have 1 clusters with 4 Cortex-A35 cores */
> > +		A35_0: cpu at 0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a35";
> > +			reg = <0x0 0x0>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&A35_L2>;
> > +		};
> > +
> > +		A35_1: cpu at 1 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a35";
> > +			reg = <0x0 0x1>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&A35_L2>;
> > +		};
> > +
> > +		A35_2: cpu at 2 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a35";
> > +			reg = <0x0 0x2>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&A35_L2>;
> > +		};
> > +
> > +		A35_3: cpu at 3 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a35";
> > +			reg = <0x0 0x3>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&A35_L2>;
> > +		};
> > +
> > +		A35_L2: l2-cache0 {
> > +			compatible = "cache";
> > +		};
> > +	};
> > +
> > +	pmu {
> > +		compatible = "arm,armv8-pmuv3";
> > +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> > +
> > +	psci {
> > +		compatible = "arm,psci-1.0";
> > +		method = "smc";
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > new file mode 100644
> > index 0000000..e1d2578
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > @@ -0,0 +1,861 @@
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
> > +
> > +#include "imx8-ca35.dtsi"
> > +
> > +/ {
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
> > +		      <0x0 0x51b00000 0 0xc0000>; /* GICR (RD_base + SGI_base)
> */
> > +		#interrupt-cells = <3>;
> > +		interrupt-controller;
> > +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure
> */
> > +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* Physical
> Non-Secure */
> > +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* Virtual */
> > +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor */
> > +	};
> > +
> > +	scu {
> > +		compatible = "fsl,imx-scu";
> > +		mbox-names = "tx0", "tx1", "tx2", "tx3",
> > +			     "rx0", "rx1", "rx2", "rx3";
> > +		mboxes = <&lsio_mu1 0 0
> > +			  &lsio_mu1 0 1
> > +			  &lsio_mu1 0 2
> > +			  &lsio_mu1 0 3
> > +			  &lsio_mu1 1 0
> > +			  &lsio_mu1 1 1
> > +			  &lsio_mu1 1 2
> > +			  &lsio_mu1 1 3>;
> > +
> > +		clk: clock-controller {
> > +			compatible = "fsl,imx8qxp-clk";
> > +			#clock-cells = <1>;
> > +		};
> > +
> > +		iomuxc: pinctrl {
> > +			compatible = "fsl,imx8qxp-iomuxc";
> > +		};
> > +
> > +		imx8qx-pm {
> > +			compatible = "fsl,scu-pd";
> 
> I missed this earlier, but there should be a i.MX8qp specific compatible as the
> SCU API might change for future SoCs.
> 

We still do not see that requirement up till now. Not sure if it would be
possible in the future. I see low possibilities.
SCU IPC is designed to be generic to all MX8 SCU firmwares.
Even it changes, SCU firmware version control may helps.

> > +			compatible = "fsl,imx7ulp-lpuart";
> > +			compatible = "fsl,imx7ulp-lpi2c";
> > +			compatible = "fsl,imx7d-usdhc";
> 
> All these lack the most specific imx8qp compatible.
> 

Adding them requires binding doc update as well.
S I suppose they could be added later when the QXP specific features are
really supported by the drivers.
Do you think it's okay?

> > +			compatible = "fsl,imx6sx-fec";
> > +			compatible = "fsl,imx8qxp-fec";
> 
> BTW are there really two different FECs on the i.MX8qp?

Good catch, will alignment them all to fsl,imx6sx-fec.

Regards
Dong Aisheng

> 
> 
> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7Cf1
> 897d4035174ffda74808d6326bb448%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636751835496320764&amp;sdata=J0MO38TWN91LWL3W
> 5SZk3y1v3PLyHzhNHl0L8jS1xcE%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
