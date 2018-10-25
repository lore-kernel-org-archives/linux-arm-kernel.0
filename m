From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 25 Oct 2018 11:53:01 +0000
Subject: [PATCH V2 6/8] dts: imx: add common imx7ulp dtsi support
In-Reply-To: <20181024220213.GA26789@bogus>
References: <1540295058-26090-1-git-send-email-aisheng.dong@nxp.com>
 <1540295058-26090-7-git-send-email-aisheng.dong@nxp.com>
 <20181024220213.GA26789@bogus>
Message-ID: <AM0PR04MB4211A07053E99036B51ACB5880F70@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Thursday, October 25, 2018 6:02 AM
[...]
> On Tue, Oct 23, 2018 at 11:49:25AM +0000, A.s. Dong wrote:
> > The i.MX 7ULP family of processors represents NXP?s latest achievement
> > in ultra-low-power processing for use cases demanding long battery life.
> > Targeted towards the growing market of portable devices, the i.MX 7ULP
> > family of processors features NXP's advanced implementation of the
> > Arm?
> > Cortex?-A7 core, the Arm Cortex-M4 core, as well as a 3D and 2D
> > Graphics Processing Units (GPUs).
> >
> > This patch aims to add the initial support including:
> > 1) CLK
> > 2) GPIO PTC, PTD, PTE, PTF
> > 3) uSDHC 1/2
> > 4) LPUART 4/5/6/7
> > 5) LPI2C 6/7
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: devicetree at vger.kernel.org
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > ChangeLog:
> > v1->v2:
> >  * update clk part due to binding change
> >  * separate soc.dtsi from board.dts
> > ---
> >  arch/arm/boot/dts/imx7ulp.dtsi | 323
> > +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 323 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx7ulp.dtsi
> >
> > diff --git a/arch/arm/boot/dts/imx7ulp.dtsi
> > b/arch/arm/boot/dts/imx7ulp.dtsi new file mode 100644 index
> > 0000000..795edc2
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx7ulp.dtsi
> > @@ -0,0 +1,323 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > + * Copyright 2017-2018 NXP
> > + *   Dong Aisheng <aisheng.dong@nxp.com>
> > + */
> > +
> > +#include <dt-bindings/clock/imx7ulp-clock.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +#include "imx7ulp-pinfunc.h"
> > +
> > +/ {
> > +	interrupt-parent = <&intc>;
> > +
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +
> > +	aliases {
> > +		gpio0 = &gpio_ptc;
> > +		gpio1 = &gpio_ptd;
> > +		gpio2 = &gpio_pte;
> > +		gpio3 = &gpio_ptf;
> > +		i2c0 = &lpi2c6;
> > +		i2c1 = &lpi2c7;
> > +		mmc0 = &usdhc0;
> > +		mmc1 = &usdhc1;
> > +		serial0 = &lpuart4;
> > +		serial1 = &lpuart5;
> > +		serial2 = &lpuart6;
> > +		serial3 = &lpuart7;
> > +	};
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu0: cpu at 0 {
> > +			compatible = "arm,cortex-a7";
> > +			device_type = "cpu";
> > +			reg = <0>;
> > +		};
> > +	};
> > +
> > +	intc: interrupt-controller at 40021000 {
> > +		compatible = "arm,cortex-a7-gic";
> > +		#interrupt-cells = <3>;
> > +		interrupt-controller;
> > +		reg = <0x40021000 0x1000>,
> > +		      <0x40022000 0x1000>;
> > +	};
> > +
> > +	rosc: clock-rosc {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <32768>;
> > +		clock-output-names = "rosc";
> > +		#clock-cells = <0>;
> > +	};
> > +
> > +	sosc: clock-sosc {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <24000000>;
> > +		clock-output-names = "sosc";
> > +		#clock-cells = <0>;
> > +	};
> > +
> > +	sirc: clock-sirc {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <16000000>;
> > +		clock-output-names = "sirc";
> > +		#clock-cells = <0>;
> > +	};
> > +
> > +	firc: clock-firc {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <48000000>;
> > +		clock-output-names = "firc";
> > +		#clock-cells = <0>;
> > +	};
> > +
> > +	upll: clock-upll {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <480000000>;
> > +		clock-output-names = "upll";
> > +		#clock-cells = <0>;
> > +	};
> > +
> > +	mpll: clock-mpll {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <480000000>;
> > +		clock-output-names = "mpll";
> > +		#clock-cells = <0>;
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv7-timer";
> > +		arm,cpu-registers-not-fw-configured;
> 
> AIUI, this was a work-around for some existing platform. New platforms should
> not have this property.
> 
> > +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_LOW)>;
> > +		clock-frequency = <1000000>;
> 
> This too should be initialized by firmware and not in DT IIRC.
> 

Sorry for the careless. I should double checking these codes before sending
as the origin code base is quite old since first version.


> > +		status = "disabled";
> 
> I think enabled should be the norm.
> 

This is mostly because the arm timer may stop during low power idle
and we already have a TPM timer function the same in SoC.
Do you think we should still enable it?

> > +	};
> > +
> > +	ahbbridge0: bus at 40000000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		reg = <0x40000000 0x800000>;
> > +		ranges;
> > +
> > +		lpuart4: serial at 402d0000 {
> > +			compatible = "fsl,imx7ulp-lpuart";
> > +			reg = <0x402d0000 0x1000>;
> > +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&pcc2 IMX7ULP_CLK_LPUART4>;
> > +			clock-names = "ipg";
> > +			assigned-clocks = <&pcc2 IMX7ULP_CLK_LPUART4>;
> > +			assigned-clock-parents = <&scg1
> IMX7ULP_CLK_SOSC_BUS_CLK>;
> > +			assigned-clock-rates = <24000000>;
> > +			status = "disabled";
> > +		};
> > +
> > +		lpuart5: serial at 402e0000 {
> > +			compatible = "fsl,imx7ulp-lpuart";
> > +			reg = <0x402e0000 0x1000>;
> > +			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&pcc2 IMX7ULP_CLK_LPUART5>;
> > +			clock-names = "ipg";
> > +			assigned-clocks = <&pcc2 IMX7ULP_CLK_LPUART5>;
> > +			assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC>;
> > +			assigned-clock-rates = <48000000>;
> > +			status = "disabled";
> > +		};
> > +
> > +		tpm5: tpm at 40260000 {
> > +			compatible = "fsl,imx7ulp-tpm";
> > +			reg = <0x40260000 0x1000>;
> > +			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
> > +				 <&pcc2 IMX7ULP_CLK_LPTPM5>;
> > +			clock-names = "ipg", "per";
> > +		};
> > +
> > +		usdhc0: usdhc at 40370000 {
> 
> mmc at ... is the standard name.
> 

I should be more careful about these. Other places are the same.
Thanks for the reminder.

Regards
Dong Aisheng
