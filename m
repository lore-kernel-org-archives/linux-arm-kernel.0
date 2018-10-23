From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 23 Oct 2018 02:09:46 +0000
Subject: [PATCH RESEND V4 6/9] dt-bindings: clock: add imx7ulp clock
 binding doc
In-Reply-To: <20181022221639.GA31408@bogus>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
 <1540127173-21346-7-git-send-email-aisheng.dong@nxp.com>
 <20181022221639.GA31408@bogus>
Message-ID: <AM0PR04MB4211C2A2273C4B7C4673B62380F50@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Tuesday, October 23, 2018 6:17 AM
[...]
> 
> On Sun, Oct 21, 2018 at 01:11:09PM +0000, A.s. Dong wrote:
> > i.MX7ULP Clock functions are under joint control of the System Clock
> > Generation (SCG) modules, Peripheral Clock Control (PCC) modules, and
> > Core Mode Controller (CMC)1 blocks
> >
> > Note IMX7ULP has two clock domains: M4 and A7. This binding doc is
> > only for A7 clock domain.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: devicetree at vger.kernel.org
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Anson Huang <Anson.Huang@nxp.com>
> > Cc: Bai Ping <ping.bai@nxp.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >
> > ---
> > ChangeLog:
> > v3->v4:
> >  * make scg, pcc separate nodes according to Rob's suggestion
> > v2->v3:
> >  * no changes
> > v1->v2: no changes
> > ---
> >  .../devicetree/bindings/clock/imx7ulp-clock.txt    |  87
> ++++++++++++++++
> >  include/dt-bindings/clock/imx7ulp-clock.h          | 109
> +++++++++++++++++++++
> >  2 files changed, 196 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> >  create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h
> >
> > diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> > b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> > new file mode 100644
> > index 0000000..2239383
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> > @@ -0,0 +1,87 @@
> > +* Clock bindings for Freescale i.MX7ULP
> > +
> > +i.MX7ULP Clock functions are under joint control of the System Clock
> > +Generation (SCG) modules, Peripheral Clock Control (PCC) modules, and
> > +Core Mode Controller (CMC)1 blocks
> > +
> > +The clocking scheme provides clear separation between M4 domain and
> > +A7 domain. Except for a few clock sources shared between two domains,
> > +such as the System Oscillator clock, the Slow IRC (SIRC), and and the
> > +Fast IRC clock (FIRCLK), clock sources and clock management are
> > +separated and contained within each domain.
> > +
> > +M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> > +A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
> 
> Where's the CMC1 binding?
> 

CMC module is more related to low power control, so did not put in
clock series. But yes, it's missed in early series, will add it in next Arch
patch series.

> > +
> > +Note: this binding doc is only for A7 clock domain.
> > +
> > +System Clock Generation (SCG) modules:
> > +---------------------------------------------------------------------
> > +The System Clock Generation (SCG) is responsible for clock generation
> > +and distribution across this device. Functions performed by the SCG
> > +include: clock reference selection, generation of clock used to
> > +derive processor, system, peripheral bus and external memory
> > +interface clocks, source selection for peripheral clocks and control
> > +of power saving clock gating mode.
> > +
> > +Required properties:
> > +
> > +- compatible:	Should be "fsl,imx7ulp-scg1".
> > +- reg : 	Should contain registers location and length.
> > +- #clock-cells:	Should be <1>.
> > +- clocks:	Should contain the fixed input clocks.
> > +- clock-name:   Should contain the following clock names:"rosc", "sosc",
> 
> clock-names
>

Got it
 
> > +		"sirc", "firc", "upll", "mpll".
> > +
> > +Peripheral Clock Control (PCC) modules:
> > +---------------------------------------------------------------------
> > +The Peripheral Clock Control (PCC) is responsible for clock
> > +selection, optional division and clock gating mode for peripherals in
> > +their respected power domain
> > +
> > +Required properties:
> > +- compatible:	Should be "fsl,imx7ulp-pcc2" or "fsl,imx7ulp-pcc3".
> 
> Please format one per line.
> 

Got it

> There's some register layout difference between PCC2 and PCC3?
>

Yes, they're for different clocks and the layout may be slightly different.
For example, some clocks support rate setting (with dividers) while
some of them not.
 
> > +- reg : 	Should contain registers location and length.
> > +- #clock-cells:	Should be <1>.
> 
> No input clocks to list?
> 

Sorry for missing them, should add it.

Appreciate for the review.

Regards
Dong Aisheng

> > +
> > +The clock consumer should specify the desired clock by having the
> > +clock ID in its "clocks" phandle cell.
> > +See include/dt-bindings/clock/imx7ulp-clock.h
> > +for the full list of i.MX7ULP clock IDs of each module.
> > +
> > +Examples:
> > +
> > +#include <dt-bindings/clock/imx7ulp-clock.h>
> > +
> > +scg1: scg1 at 403e0000 {
> > +	compatible = "fsl,imx7ulp-scg1;
> > +	reg = <0x403e0000 0x10000>;
> > +	clocks = <&rosc>, <&sosc>, <&sirc>,
> > +		 <&firc>, <&upll>, <&mpll>;
> > +	clock-names = "rosc", "sosc", "sirc",
> > +		      "firc", "upll", "mpll";
> > +	#clock-cells = <1>;
> > +};
> > +
> > +pcc2: pcc2 at 403f0000 {
> > +	compatible = "fsl,imx7ulp-pcc2";
> > +	reg = <0x403f0000 0x10000>;
> > +	#clock-cells = <1>;
> > +};
> > +
> > +pcc3: pcc3 at 40b30000 {
> > +	compatible = "fsl,imx7ulp-pcc3";
> > +	reg = <0x40b30000 0x10000>;
> > +	#clock-cells = <1>;
> > +};
> > +
> > +usdhc1: usdhc at 40380000 {
> > +	compatible = "fsl,imx7ulp-usdhc";
> > +	reg = <0x40380000 0x10000>;
> > +	interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> > +	clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
> > +		 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
> > +		 <&pcc2 IMX7ULP_CLK_USDHC1>;
> > +	clock-names ="ipg", "ahb", "per";
> > +	bus-width = <4>;
> > +};
> > diff --git a/include/dt-bindings/clock/imx7ulp-clock.h
> > b/include/dt-bindings/clock/imx7ulp-clock.h
> > new file mode 100644
> > index 0000000..008c5ee
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/imx7ulp-clock.h
> > @@ -0,0 +1,109 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > + * Copyright 2017~2018 NXP
> > + *
> > + */
> > +
> > +#ifndef __DT_BINDINGS_CLOCK_IMX7ULP_H #define
> > +__DT_BINDINGS_CLOCK_IMX7ULP_H
> > +
> > +/* SCG1 */
> > +
> > +#define IMX7ULP_CLK_DUMMY		0
> > +#define IMX7ULP_CLK_ROSC		1
> > +#define IMX7ULP_CLK_SOSC		2
> > +#define IMX7ULP_CLK_FIRC		3
> > +#define IMX7ULP_CLK_SPLL_PRE_SEL	4
> > +#define IMX7ULP_CLK_SPLL_PRE_DIV	5
> > +#define IMX7ULP_CLK_SPLL		6
> > +#define IMX7ULP_CLK_SPLL_POST_DIV1	7
> > +#define IMX7ULP_CLK_SPLL_POST_DIV2	8
> > +#define IMX7ULP_CLK_SPLL_PFD0		9
> > +#define IMX7ULP_CLK_SPLL_PFD1		10
> > +#define IMX7ULP_CLK_SPLL_PFD2		11
> > +#define IMX7ULP_CLK_SPLL_PFD3		12
> > +#define IMX7ULP_CLK_SPLL_PFD_SEL	13
> > +#define IMX7ULP_CLK_SPLL_SEL		14
> > +#define IMX7ULP_CLK_APLL_PRE_SEL	15
> > +#define IMX7ULP_CLK_APLL_PRE_DIV	16
> > +#define IMX7ULP_CLK_APLL		17
> > +#define IMX7ULP_CLK_APLL_POST_DIV1	18
> > +#define IMX7ULP_CLK_APLL_POST_DIV2	19
> > +#define IMX7ULP_CLK_APLL_PFD0		20
> > +#define IMX7ULP_CLK_APLL_PFD1		21
> > +#define IMX7ULP_CLK_APLL_PFD2		22
> > +#define IMX7ULP_CLK_APLL_PFD3		23
> > +#define IMX7ULP_CLK_APLL_PFD_SEL	24
> > +#define IMX7ULP_CLK_APLL_SEL		25
> > +#define IMX7ULP_CLK_UPLL		26
> > +#define IMX7ULP_CLK_SYS_SEL		27
> > +#define IMX7ULP_CLK_CORE_DIV		28
> > +#define IMX7ULP_CLK_BUS_DIV		29
> > +#define IMX7ULP_CLK_PLAT_DIV		30
> > +#define IMX7ULP_CLK_DDR_SEL		31
> > +#define IMX7ULP_CLK_DDR_DIV		32
> > +#define IMX7ULP_CLK_NIC_SEL		33
> > +#define IMX7ULP_CLK_NIC0_DIV		34
> > +#define IMX7ULP_CLK_GPU_DIV		35
> > +#define IMX7ULP_CLK_NIC1_DIV		36
> > +#define IMX7ULP_CLK_NIC1_BUS_DIV	37
> > +#define IMX7ULP_CLK_NIC1_EXT_DIV	38
> > +#define IMX7ULP_CLK_MIPI_PLL		39
> > +#define IMX7ULP_CLK_SIRC		40
> > +#define IMX7ULP_CLK_SOSC_BUS_CLK	41
> > +#define IMX7ULP_CLK_FIRC_BUS_CLK	42
> > +#define IMX7ULP_CLK_SPLL_BUS_CLK	43
> > +
> > +#define IMX7ULP_CLK_SCG1_END		44
> > +
> > +/* PCC2 */
> > +#define IMX7ULP_CLK_DMA1		0
> > +#define IMX7ULP_CLK_RGPIO2P1		1
> > +#define IMX7ULP_CLK_FLEXBUS		2
> > +#define IMX7ULP_CLK_SEMA42_1		3
> > +#define IMX7ULP_CLK_DMA_MUX1		4
> > +#define IMX7ULP_CLK_SNVS		5
> > +#define IMX7ULP_CLK_CAAM		6
> > +#define IMX7ULP_CLK_LPTPM4		7
> > +#define IMX7ULP_CLK_LPTPM5		8
> > +#define IMX7ULP_CLK_LPIT1		9
> > +#define IMX7ULP_CLK_LPSPI2		10
> > +#define IMX7ULP_CLK_LPSPI3		11
> > +#define IMX7ULP_CLK_LPI2C4		12
> > +#define IMX7ULP_CLK_LPI2C5		13
> > +#define IMX7ULP_CLK_LPUART4		14
> > +#define IMX7ULP_CLK_LPUART5		15
> > +#define IMX7ULP_CLK_FLEXIO1		16
> > +#define IMX7ULP_CLK_USB0		17
> > +#define IMX7ULP_CLK_USB1		18
> > +#define IMX7ULP_CLK_USB_PHY		19
> > +#define IMX7ULP_CLK_USB_PL301		20
> > +#define IMX7ULP_CLK_USDHC0		21
> > +#define IMX7ULP_CLK_USDHC1		22
> > +#define IMX7ULP_CLK_WDG1		23
> > +#define IMX7ULP_CLK_WDG2		24
> > +
> > +#define IMX7ULP_CLK_PCC2_END		25
> > +
> > +/* PCC3 */
> > +#define IMX7ULP_CLK_LPTPM6		0
> > +#define IMX7ULP_CLK_LPTPM7		1
> > +#define IMX7ULP_CLK_LPI2C6		2
> > +#define IMX7ULP_CLK_LPI2C7		3
> > +#define IMX7ULP_CLK_LPUART6		4
> > +#define IMX7ULP_CLK_LPUART7		5
> > +#define IMX7ULP_CLK_VIU			6
> > +#define IMX7ULP_CLK_DSI			7
> > +#define IMX7ULP_CLK_LCDIF		8
> > +#define IMX7ULP_CLK_MMDC		9
> > +#define IMX7ULP_CLK_PCTLC		10
> > +#define IMX7ULP_CLK_PCTLD		11
> > +#define IMX7ULP_CLK_PCTLE		12
> > +#define IMX7ULP_CLK_PCTLF		13
> > +#define IMX7ULP_CLK_GPU3D		14
> > +#define IMX7ULP_CLK_GPU2D		15
> > +
> > +#define IMX7ULP_CLK_PCC3_END		16
> > +
> > +#endif /* __DT_BINDINGS_CLOCK_IMX7ULP_H */
> > --
> > 2.7.4
> >
