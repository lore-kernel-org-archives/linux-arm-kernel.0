From: harninder.rai@nxp.com (Harninder Rai)
Date: Tue, 15 Nov 2016 06:45:23 +0000
Subject: [PATCH] arm64: Add DTS support for FSL's LS1012A SoC
In-Reply-To: <20161114071308.GL3310@dragon>
References: <1478715118-12848-1-git-send-email-harninder.rai@nxp.com>
 <20161114071308.GL3310@dragon>
Message-ID: <DB5PR04MB16887A9480FD29B75735C707E6BF0@DB5PR04MB1688.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-qds.dtb
> 
> It seems that the patch is not generated against mainline kernel.  We do not
> have fsl-ls1046a-qds.dtb target in mainline kernel.
You already clarified in the following mail :)

> > +
> > +	reg_1p8v: regulator at 0 {
> 
> Drop the unit-address from node name, and name it like regulator-1p8v.
Ok. Will take care in V2

> > +
> > +&duart0 {
> 
> Please sort labeled nodes alphabetically.
Ok Sure
> 
> > +	status = "okay";
> > +};
> > +
> > +&sai2 {
> > +	status = "okay";
> > +};
> 
> <snip>
> 
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > new file mode 100644
> > index 0000000..0bf5b64
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > @@ -0,0 +1,248 @@
> > +/*
> > + * Device Tree Include file for Freescale Layerscape-1012A family SoC.
> > + *
> > + * Copyright 2016, Freescale Semiconductor
> > + *
> > + * This file is dual-licensed: you can use it either under the terms
> > + * of the GPLv2 or the X11 license, at your option. Note that this
> > +dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> > + *
> > + *  a) This library is free software; you can redistribute it and/or
> > + *     modify it under the terms of the GNU General Public License as
> > + *     published by the Free Software Foundation; either version 2 of the
> > + *     License, or (at your option) any later version.
> > + *
> > + *     This library is distributed in the hope that it will be useful,
> > + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *     GNU General Public License for more details.
> > + *
> > + * Or, alternatively,
> > + *
> > + *  b) Permission is hereby granted, free of charge, to any person
> > + *     obtaining a copy of this software and associated documentation
> > + *     files (the "Software"), to deal in the Software without
> > + *     restriction, including without limitation the rights to use,
> > + *     copy, modify, merge, publish, distribute, sublicense, and/or
> > + *     sell copies of the Software, and to permit persons to whom the
> > + *     Software is furnished to do so, subject to the following
> > + *     conditions:
> > + *
> > + *     The above copyright notice and this permission notice shall be
> > + *     included in all copies or substantial portions of the Software.
> > + *
> > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
> WARRANTIES
> > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
> COPYRIGHT
> > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING
> > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> OR
> > + *     OTHER DEALINGS IN THE SOFTWARE.
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +/ {
> > +	compatible = "fsl,ls1012a";
> > +	interrupt-parent = <&gic>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu0: cpu at 0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x0>;
> > +			clocks = <&clockgen 1 0>;
> > +			#cooling-cells = <2>;
> > +		};
> > +	};
> > +
> > +	sysclk: sysclk {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <100000000>;
> > +		clock-output-names = "sysclk";
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +			     /* Physical Secure PPI */
> > +		interrupts = <1 13 IRQ_TYPE_LEVEL_LOW>,
> > +			     /* Physical Non-Secure PPI */
> > +			     <1 14 IRQ_TYPE_LEVEL_LOW>,
> > +			     /* Virtual PPI */
> > +			     <1 11 IRQ_TYPE_LEVEL_LOW>,
> > +			     /* Hypervisor PPI */
> > +			     <1 10 IRQ_TYPE_LEVEL_LOW>;
> 
> The following form should be easier for read.
> 
> 		interrupts = <1 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure
> PPI */
> 			     <1 14 IRQ_TYPE_LEVEL_LOW>, /* Physical Non-
> Secure PPI */
> 			     <1 11 IRQ_TYPE_LEVEL_LOW>, /* Virtual PPI */
> 			     <1 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor PPI
> */
> 
> 
Agreed. My bad. Will correct in v2

> > +	};
> > +
> > +	pmu {
> > +		compatible = "arm,armv8-pmuv3";
> > +		interrupts = <0 106 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> > +
> > +	gic: interrupt-controller at 1400000 {
> > +		compatible = "arm,gic-400";
> > +		#interrupt-cells = <3>;
> > +		interrupt-controller;
> > +		reg = <0x0 0x1401000 0 0x1000>, /* GICD */
> > +		      <0x0 0x1402000 0 0x2000>, /* GICC */
> > +		      <0x0 0x1404000 0 0x2000>, /* GICH */
> > +		      <0x0 0x1406000 0 0x2000>; /* GICV */
> > +		interrupts = <1 9 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> > +
> > +	reboot {
> > +		compatible = "syscon-reboot";
> > +		regmap = <&dcfg>;
> > +		offset = <0xb0>;
> > +		mask = <0x02>;
> > +	};
> > +
> > +	soc {
> > +		compatible = "simple-bus";
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		clockgen: clocking at 1ee1000 {
> > +			compatible = "fsl,ls1012a-clockgen";
> > +			reg = <0x0 0x1ee1000 0x0 0x1000>;
> > +			#clock-cells = <2>;
> > +			clocks = <&sysclk>;
> > +		};
> > +
> > +		scfg: scfg at 1570000 {
> > +			compatible = "fsl,ls1012a-scfg", "syscon";
> > +			reg = <0x0 0x1570000 0x0 0x10000>;
> > +			big-endian;
> > +		};
> 
> Please sort these nodes with unit-address in order of the address.
> 
> Shawn
> 
> > +
> > +		dcfg: dcfg at 1ee0000 {
> > +			compatible = "fsl,ls1012a-dcfg",
> > +				     "syscon";
> > +			reg = <0x0 0x1ee0000 0x0 0x10000>;
> > +			big-endian;
> > +		};
> > +
> > +		i2c0: i2c at 2180000 {
> > +			compatible = "fsl,vf610-i2c";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			reg = <0x0 0x2180000 0x0 0x10000>;
> > +			interrupts = <0 56 IRQ_TYPE_LEVEL_LOW>;
> > +			clocks = <&clockgen 4 0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		i2c1: i2c at 2190000 {
> > +			compatible = "fsl,vf610-i2c";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			reg = <0x0 0x2190000 0x0 0x10000>;
> > +			interrupts = <0 57 IRQ_TYPE_LEVEL_LOW>;
> > +			clocks = <&clockgen 4 0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		duart0: serial at 21c0500 {
> > +			compatible = "fsl,ns16550", "ns16550a";
> > +			reg = <0x00 0x21c0500 0x0 0x100>;
> > +			interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&clockgen 4 0>;
> > +		};
> > +
> > +		duart1: serial at 21c0600 {
> > +			compatible = "fsl,ns16550", "ns16550a";
> > +			reg = <0x00 0x21c0600 0x0 0x100>;
> > +			interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&clockgen 4 0>;
> > +		};
> > +
> > +		gpio0: gpio at 2300000 {
> > +			compatible = "fsl,qoriq-gpio";
> > +			reg = <0x0 0x2300000 0x0 0x10000>;
> > +			interrupts = <0 66 IRQ_TYPE_LEVEL_LOW>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +		};
> > +
> > +		gpio1: gpio at 2310000 {
> > +			compatible = "fsl,qoriq-gpio";
> > +			reg = <0x0 0x2310000 0x0 0x10000>;
> > +			interrupts = <0 67 IRQ_TYPE_LEVEL_LOW>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +		};
> > +
> > +		wdog0: wdog at 2ad0000 {
> > +			compatible = "fsl,ls1012a-wdt",
> > +				     "fsl,imx21-wdt";
> > +			reg = <0x0 0x2ad0000 0x0 0x10000>;
> > +			interrupts = <0 83 IRQ_TYPE_LEVEL_LOW>;
> > +			clocks = <&clockgen 4 0>;
> > +			big-endian;
> > +		};
> > +
> > +		sai1: sai at 2b50000 {
> > +			#sound-dai-cells = <0>;
> > +			compatible = "fsl,vf610-sai";
> > +			reg = <0x0 0x2b50000 0x0 0x10000>;
> > +			interrupts = <0 148 IRQ_TYPE_LEVEL_LOW>;
> > +			clocks = <&clockgen 4 3>, <&clockgen 4 3>,
> > +				 <&clockgen 4 3>, <&clockgen 4 3>;
> > +			clock-names = "bus", "mclk1", "mclk2", "mclk3";
> > +			dma-names = "tx", "rx";
> > +			dmas = <&edma0 1 47>,
> > +			       <&edma0 1 46>;
> > +			status = "disabled";
> > +		};
> > +
> > +		sai2: sai at 2b60000 {
> > +			#sound-dai-cells = <0>;
> > +			compatible = "fsl,vf610-sai";
> > +			reg = <0x0 0x2b60000 0x0 0x10000>;
> > +			interrupts = <0 149 IRQ_TYPE_LEVEL_LOW>;
> > +			clocks = <&clockgen 4 3>, <&clockgen 4 3>,
> > +				 <&clockgen 4 3>, <&clockgen 4 3>;
> > +			clock-names = "bus", "mclk1", "mclk2", "mclk3";
> > +			dma-names = "tx", "rx";
> > +			dmas = <&edma0 1 45>,
> > +			       <&edma0 1 44>;
> > +			status = "disabled";
> > +		};
> > +
> > +		edma0: edma at 2c00000 {
> > +			#dma-cells = <2>;
> > +			compatible = "fsl,vf610-edma";
> > +			reg = <0x0 0x2c00000 0x0 0x10000>,
> > +			      <0x0 0x2c10000 0x0 0x10000>,
> > +			      <0x0 0x2c20000 0x0 0x10000>;
> > +			interrupts = <0 103 IRQ_TYPE_LEVEL_LOW>,
> > +				     <0 103 IRQ_TYPE_LEVEL_LOW>;
> > +			interrupt-names = "edma-tx", "edma-err";
> > +			dma-channels = <32>;
> > +			big-endian;
> > +			clock-names = "dmamux0", "dmamux1";
> > +			clocks = <&clockgen 4 3>,
> > +				 <&clockgen 4 3>;
> > +		};
> > +
> > +		sata: sata at 3200000 {
> > +			compatible = "fsl,ls1012a-ahci";
> > +			reg = <0x0 0x3200000 0x0 0x10000>;
> > +			interrupts = <0 69 IRQ_TYPE_LEVEL_LOW>;
> > +			clocks = <&clockgen 4 0>;
> > +		};
> > +	};
> > +};
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
