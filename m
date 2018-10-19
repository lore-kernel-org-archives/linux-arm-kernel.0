From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 19 Oct 2018 08:02:33 +0000
Subject: [PATCH V3 6/8] arm64: dts: imx: add imx8qxp support
In-Reply-To: <20181018202457.GA25174@bogus>
References: <1539886483-15775-1-git-send-email-aisheng.dong@nxp.com>
 <1539886483-15775-7-git-send-email-aisheng.dong@nxp.com>
 <20181018202457.GA25174@bogus>
Message-ID: <DB7PR04MB42188ABE426A055E6097C03080F90@DB7PR04MB4218.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Friday, October 19, 2018 4:25 AM
> To: A.s. Dong <aisheng.dong@nxp.com>
[...]
> On Thu, Oct 18, 2018 at 06:19:39PM +0000, A.s. Dong wrote:
> > i.MX 8QuadXPlus is a quad (4x) Cortex-A35 proccessor with powerful
> > graphic and multimedia features. This patch adds the core SoC dtsi
> > file support.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree at vger.kernel.org
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > v2->v3:
> >  * add more SoC specific compatible string to IP nodes
> >  * move memory node into board dts
> >  * change pd reg value into hex
> >  * add more explanation about SoC in commit message
> >  * add external clocks
> >  * remove pmu compatible string which is not supported
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
> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 870
> ++++++++++++++++++++++++++
> >  3 files changed, 935 insertions(+)
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
> > index 0000000..acb4770
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > @@ -0,0 +1,870 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > + * Copyright 2017-2018 NXP
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
> > +	xtal32k: clock-xtal32k {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <32768>;
> > +		clock-output-names = "xtal_32KHz";
> > +	};
> > +
> > +	xtal24m: clock-xtal24m {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <24000000>;
> > +		clock-output-names = "xtal_24MHz";
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
> > +			clocks = <&xtal32k &xtal24m>;
> > +			clock-names = "xtal_32KHz", "xtal_24Mhz";
> > +		};
> > +
> > +		iomuxc: pinctrl {
> > +			compatible = "fsl,imx8qxp-iomuxc";
> > +		};
> > +
> > +		imx8qx-pm {
> > +			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			pd_lsio: lsio-power-domain {
> > +				#power-domain-cells = <0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				pd_lsio_pwm0: lsio-pwm0 at bf {
> > +					reg = <0xbf>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> 
> Power domains are supposed to be a block that can be power gated. No chip
> design is going to put tiny PWM, GPIO, etc. blocks each in their own domain.
> 
> If you really want to maintain these sub domains, just use 2
> #power-domain-cells. The first cell can be the power domain and the 2nd cell
> the device ID.
> 

Unfortunately the SCU firmware is designed like that each device has a power domain
ID which is specified in reg property in device tree.
Each driver should enable that power domain before being able to access the HW,
otherwise, xRDC (security and access control HW) may report bus errors.
And there could be different multi-level domains, how to do 2cells presentation for this case?
E.g.
Domain_A: {
	Domain_B {
		Domain_C {
			...
		}
	}
}
So make them separate power domain seems a suitable way to get things working well.
I'm not sure whether 2 cells could be suitable for our case.
Just wondering if you think this way could be accepted due to this special case?

> > +				};
> > +
> > +				pd_lsio_pwm1: lsio-pwm1 at c0 {
> > +					reg = <0xc0>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_pwm2: lsio-pwm2 at c1 {
> > +					reg = <0xc1>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_pwm3: lsio-pwm3 at c2 {
> > +					reg = <0xc2>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_pwm4: lsio-pwm4 at c3 {
> > +					reg = <0xc3>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_pwm5: lsio-pwm5 at c4 {
> > +					reg = <0xc4>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_pwm6: lsio-pwm6 at c5 {
> > +					reg = <0xc5>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_pwm7: lsio-pwm7 at c6 {
> > +					reg = <0xc6>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_gpio0: lsio-gpio0 at c7 {
> > +					reg = <0xc7>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_gpio1: lsio-gpio1 at c8 {
> > +					reg = <0xc8>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_gpio2: lsio-gpio2 at c9 {
> > +					reg = <0xc9>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_gpio3: lsio-gpio3 at ca {
> > +					reg = <0xca>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_gpio4: lsio-gpio4 at cb {
> > +					reg = <0xcb>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_gpio5: lsio-gpio5 at cc {
> > +					reg = <0xcc>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_gpio6: lsio-gpio6 at cd {
> > +					reg = <0xcd>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_gpio7: lsio-gpio7 at ce {
> > +					reg = <0xce>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_gpt0: lsio-gpt0 at cf {
> > +					reg = <0xcf>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_gpt1: lsio-gpt1 at d0 {
> > +					reg = <0xd0>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_gpt2: lsio-gpt2 at d1 {
> > +					reg = <0xd1>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_gpt3: lsio-gpt3 at d2 {
> > +					reg = <0xd2>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_gpt4: lsio-gpt4 at d3 {
> > +					reg = <0xd3>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_kpp: lsio-kpp at d4 {
> > +					reg = <0xd4>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_flexspi0: lsio-fspi0 at ed {
> > +					reg = <0xed>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +
> > +				pd_lsio_flexspi1: lsio-fspi1 at ee {
> > +					reg = <0xee>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_lsio>;
> > +				};
> > +			};
> > +
> > +			pd_conn: connectivity-power-domain {
> > +				#power-domain-cells = <0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				pd_conn_sdhc0: conn-sdhc0 at f8 {
> > +					reg = <0xf8>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_conn>;
> > +				};
> > +
> > +				pd_conn_sdhc1: conn-sdhc1 at f9 {
> > +					reg = <0xf9>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_conn>;
> > +				};
> > +
> > +				pd_conn_sdhc2: conn-sdhc2 at fa {
> > +					reg = <0xfa>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_conn>;
> > +				};
> > +
> > +				pd_conn_enet0: conn-enet0 at fb {
> > +					reg = <0xfb>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_conn>;
> > +				};
> > +
> > +				pd_conn_enet1: conn-enet1 at fc {
> > +					reg = <0xfc>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_conn>;
> > +				};
> > +
> > +				pd_conn_mlb0: conn-mlb0 at fd {
> > +					reg = <0xfd>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_conn>;
> > +				};
> > +
> > +				pd_conn_usbotg0: conn-usb0 at 103 {
> > +					reg = <0x103>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_conn>;
> > +				};
> > +
> > +				pd_conn_usbotg1: conn-usb1 at 104 {
> > +					reg = <0x104>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_conn>;
> > +				};
> > +
> > +				pd_conn_usbotg0_phy: conn-usb0-phy at 105 {
> > +					reg = <0x105>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_conn>;
> > +				};
> > +
> > +				pd_conn_usb2: conn-usb2 at 106 {
> > +					reg = <0x106>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_conn>;
> > +				};
> > +
> > +				pd_conn_usb2_phy: conn-usb2-phy at 107 {
> > +					reg = <0x107>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_conn>;
> > +				};
> > +
> > +				pd_conn_nand: conn-nand at 109 {
> > +					reg = <0x109>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_conn>;
> > +				};
> > +
> > +				pd_conn_edma_ch0: conn-dma4-ch0 at 174 {
> > +					reg = <0x174>;
> > +					#power-domain-cells = <0>;
> > +					power-domains =<&pd_conn>;
> > +				};
> > +
> > +				pd_conn_edma_ch1: conn-dma4-ch1 at 175 {
> > +					reg = <0x175>;
> > +					#power-domain-cells = <0>;
> > +					power-domains =<&pd_conn>;
> > +				};
> > +
> > +				pd_conn_edma_ch2: conn-dma4-ch2 at 176 {
> > +					reg = <0x176>;
> > +					#power-domain-cells = <0>;
> > +					power-domains =<&pd_conn>;
> > +				};
> > +
> > +				pd_conn_edma_ch3: conn-dma4-ch3 at 177 {
> > +					reg = <0x177>;
> > +					#power-domain-cells = <0>;
> > +					power-domains =<&pd_conn>;
> > +				};
> > +
> > +				pd_conn_edma_ch4: conn-dma4-ch4 at 178 {
> > +					reg = <0x178>;
> > +					#power-domain-cells = <0>;
> > +					power-domains =<&pd_conn>;
> > +				};
> > +			};
> > +
> > +			pd_dma: dma-power-domain {
> > +				#power-domain-cells = <0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				pd_dma_lpspi0: dma-spi0 at 35 {
> > +					reg = <0x35>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_lpspi1: dma-spi1 at 36 {
> > +					reg = <0x36>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_lpspi2: dma-spi2 at 37 {
> > +					reg = <0x37>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_lpspi3: dma-spi3 at 38 {
> > +					reg = <0x38>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_lpuart0: dma-lpuart0 at 39 {
> > +					reg = <0x39>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_lpuart1: dma-lpuart1 at 3a {
> > +					reg = <0x3a>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_lpuart2: dma-lpuart2 at 3b {
> > +					reg = <0x3b>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_lpuart3: dma-lpuart3 at 3c {
> > +					reg = <0x3c>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_lpi2c0: dma-lpi2c0 at 60 {
> > +					reg = <0x60>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_lpi2c1: dma-lpi2c1 at 61 {
> > +					reg = <0x61>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_lpi2c2: dma-lpi2c2 at 62 {
> > +					reg = <0x62>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_lpi2c3: dma-lpi2c3 at 63 {
> > +					reg = <0x63>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_adc0: dma-adc0 at 65 {
> > +					reg = <0x65>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_ftm0: dma-ftm0 at 67 {
> > +					reg = <0x67>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_ftm1: dma-ftm1 at 68 {
> > +					reg = <0x68>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_flexcan0: dma-flexcan0 at 69 {
> > +					reg = <0x69>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_flexcan1: dma-flexcan1 at 6a {
> > +					reg = <0x6a>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_flexcan2: dma-flexcan2 at 6b {
> > +					reg = <0x6b>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_lcd0: dma-lcd0 at bb {
> > +					reg = <0xbb>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +
> > +				pd_dma_pwm0: dma-pwm0 at bc {
> > +					reg = <0xbc>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +			};
> > +
> > +			pd_gpu: gpu-power-domain {
> > +				#power-domain-cells = <0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				pd_gpu0: gpu0 at 90 {
> > +					reg = <0x90>;
> > +					#power-domain-cells = <0>;
> > +					power-domains =<&pd_gpu>;
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +				};
> > +			};
> > +
> > +			pd_vpu: vpu-power-domain at 166 {
> > +				reg = <0x166>;
> > +				#power-domain-cells = <0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				pd_vpu_core: vpu-core at 16f {
> > +					reg = <0x16f>;
> > +					#power-domain-cells = <0>;
> > +					power-domains =<&pd_vpu>;
> > +				};
> > +			};
> > +
> > +			pd_hsio: hsio-power-domain {
> > +				#power-domain-cells = <0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				pd_pcie: hsio-pcie-pd at 98 {
> > +					reg = <0x98>;
> > +					#power-domain-cells = <0>;
> > +					power-domains =<&pd_hsio>;
> > +				};
> > +			};
> > +
> > +			pd_dc: dc-power-domain {
> > +				#power-domain-cells = <0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				pd_dc0: dc0-power-domain at 20 {
> > +					reg = <0x20>;
> > +					#power-domain-cells = <0>;
> > +					power-domains =<&pd_dc>;
> > +				};
> > +			};
> > +
> > +			pd_mipi_dsi: mipi0-dsi-power-domain at 189 {
> > +				reg = <0x189>;
> > +				#power-domain-cells = <0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				pd_mipi_pwm0: mipi0-dsi-pwm0 at 18a {
> > +					reg = <0x18a>;
> > +					power-domains =<&pd_mipi_dsi>;
> > +				};
> > +
> > +				pd_mipi_dsi_i2c0: mipi0-dsi-i2c0 at 18b {
> > +					reg = <0x18b>;
> > +					power-domains =<&pd_mipi_dsi>;
> > +				};
> > +
> > +				pd_mipi_dsi_i2c1: mipi0-dsi-i2c1 at 18c {
> > +					reg = <0x18c>;
> > +					power-domains =<&pd_mipi_dsi>;
> > +				};
> > +			};
> > +
> > +			pd_mipi_csi: mipi-csi0-power-domain at 191 {
> > +				reg = <0x191>;
> > +				#power-domain-cells = <0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				pd_mipi_csi0_pwm0: mipi-csi0-pwm at 192 {
> > +					reg = <0x192>;
> > +					power-domains =<&pd_mipi_csi>;
> > +				};
> > +
> > +				pd_mipi_csi0_i2c0: mipi-csi0-i2c at 193 {
> > +					reg = <0x193>;
> > +					power-domains =<&pd_mipi_csi>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	audio_subsys: bus at 59000000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x59000000 0x0 0x59000000 0x1000000>;
> > +	};
> > +
> > +	dma_subsys: bus at 5a000000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x5a000000 0x0 0x5a000000 0x1000000>;
> 
> Can't you do some actual translation here.

Can you help give an example as I'm not quite get the point?

Thanks

Regards
Dong Aisheng

> > +
> > +		dma_lpuart0: serial at 5a060000 {
> > +			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> > +			reg = <0x5a060000 0x1000>;
> > +			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-parent = <&gic>;
> > +			clocks = <&clk IMX8QXP_UART0_CLK>;
> > +			clock-names = "ipg";
> > +			status = "disabled";
> > +		};
> > +
> > +		dma_i2c0: i2c at 5a800000 {
> > +			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> > +			reg = <0x5a800000 0x4000>;
> > +			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-parent = <&gic>;
> > +			clocks = <&clk IMX8QXP_I2C0_CLK>;
> > +			clock-names = "per";
> > +			assigned-clocks = <&clk IMX8QXP_I2C0_CLK>;
> > +			assigned-clock-rates = <24000000>;
> > +			power-domains = <&pd_dma_lpi2c0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		dma_i2c1: i2c at 5a810000 {
> > +			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> > +			reg = <0x5a810000 0x4000>;
> > +			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-parent = <&gic>;
> > +			clocks = <&clk IMX8QXP_I2C1_CLK>;
> > +			clock-names = "per";
> > +			assigned-clocks = <&clk IMX8QXP_I2C1_CLK>;
> > +			assigned-clock-rates = <24000000>;
> > +			status = "disabled";
> > +		};
> > +
> > +		dma_i2c2: i2c at 5a820000 {
> > +			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> > +			reg = <0x5a820000 0x4000>;
> > +			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-parent = <&gic>;
> > +			clocks = <&clk IMX8QXP_I2C2_CLK>;
> > +			clock-names = "per";
> > +			assigned-clocks = <&clk IMX8QXP_I2C2_CLK>;
> > +			assigned-clock-rates = <24000000>;
> > +			power-domains = <&pd_dma_lpi2c2>;
> > +			status = "disabled";
> > +		};
> > +
> > +		dma_i2c3: i2c at 5a830000 {
> > +			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> > +			reg = <0x5a830000 0x4000>;
> > +			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-parent = <&gic>;
> > +			clocks = <&clk IMX8QXP_I2C3_CLK>;
> > +			clock-names = "per";
> > +			assigned-clocks = <&clk IMX8QXP_I2C3_CLK>;
> > +			assigned-clock-rates = <24000000>;
> > +			power-domains = <&pd_dma_lpi2c3>;
> > +			status = "disabled";
> > +		};
> > +	};
> > +
> > +	conn_subsys: bus at 5b000000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x5b000000 0x0 0x5b000000 0x1000000>;
> > +
> > +		usdhc1: mmc at 5b010000 {
> > +			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> > +			interrupt-parent = <&gic>;
> > +			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
> > +			reg = <0x5b010000 0x10000>;
> > +			clocks = <&clk IMX8QXP_SDHC0_IPG_CLK>,
> > +				 <&clk IMX8QXP_SDHC0_CLK>,
> > +				 <&clk IMX8QXP_CLK_DUMMY>;
> > +			clock-names = "ipg", "per", "ahb";
> > +			assigned-clocks = <&clk IMX8QXP_SDHC0_DIV>;
> > +			assigned-clock-rates = <200000000>;
> > +			power-domains = <&pd_conn_sdhc0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		usdhc2: mmc at 5b020000 {
> > +			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> > +			interrupt-parent = <&gic>;
> > +			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
> > +			reg = <0x5b020000 0x10000>;
> > +			clocks = <&clk IMX8QXP_SDHC1_IPG_CLK>,
> > +				 <&clk IMX8QXP_SDHC1_CLK>,
> > +				 <&clk IMX8QXP_CLK_DUMMY>;
> > +			clock-names = "ipg", "per", "ahb";
> > +			assigned-clocks = <&clk IMX8QXP_SDHC1_DIV>;
> > +			assigned-clock-rates = <200000000>;
> > +			power-domains = <&pd_conn_sdhc1>;
> > +			fsl,tuning-start-tap = <20>;
> > +			fsl,tuning-step= <2>;
> > +			status = "disabled";
> > +		};
> > +
> > +		usdhc3: mmc at 5b030000 {
> > +			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> > +			interrupt-parent = <&gic>;
> > +			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
> > +			reg = <0x5b030000 0x10000>;
> > +			clocks = <&clk IMX8QXP_SDHC2_IPG_CLK>,
> > +				 <&clk IMX8QXP_SDHC2_CLK>,
> > +				 <&clk IMX8QXP_CLK_DUMMY>;
> > +			clock-names = "ipg", "per", "ahb";
> > +			assigned-clocks = <&clk IMX8QXP_SDHC2_DIV>;
> > +			assigned-clock-rates = <200000000>;
> > +			power-domains = <&pd_conn_sdhc2>;
> > +			status = "disabled";
> > +		};
> > +
> > +		fec1: ethernet at 5b040000 {
> > +			compatible = "fsl,imx8qxp-fec", "fsl,imx6sx-fec";
> > +			reg = <0x5b040000 0x10000>;
> > +			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
> > +					<GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
> > +					<GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
> > +					<GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&clk IMX8QXP_ENET0_IPG_CLK>, <&clk
> IMX8QXP_ENET0_AHB_CLK>, <&clk IMX8QXP_ENET0_TX_CLK>,
> > +				<&clk IMX8QXP_ENET0_PTP_CLK>;
> > +			clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
> > +			assigned-clocks = <&clk IMX8QXP_ENET0_REF_DIV>, <&clk
> IMX8QXP_ENET0_PTP_CLK>;
> > +			assigned-clock-rates = <125000000>, <125000000>;
> > +			fsl,num-tx-queues=<3>;
> > +			fsl,num-rx-queues=<3>;
> > +			power-domains = <&pd_conn_enet0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		fec2: ethernet at 5b050000 {
> > +			compatible = "fsl,imx8qxp-fec", "fsl,imx6sx-fec";
> > +			reg = <0x5b050000 0x10000>;
> > +			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
> > +					<GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
> > +					<GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
> > +					<GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&clk IMX8QXP_ENET1_IPG_CLK>, <&clk
> IMX8QXP_ENET1_AHB_CLK>, <&clk IMX8QXP_ENET1_TX_CLK>,
> > +				<&clk IMX8QXP_ENET1_PTP_CLK>;
> > +			clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
> > +			assigned-clocks = <&clk IMX8QXP_ENET1_REF_DIV>, <&clk
> IMX8QXP_ENET1_PTP_CLK>;
> > +			assigned-clock-rates = <125000000>, <125000000>;
> > +			fsl,num-tx-queues=<3>;
> > +			fsl,num-rx-queues=<3>;
> > +			power-domains = <&pd_conn_enet1>;
> > +			status = "disabled";
> > +		};
> > +	};
> > +
> > +	db_subsys: bus at 5c000000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x5c000000 0x0 0x5c000000 0x1000000>;
> > +
> > +		ddr_pmu0: pmu at 5c020000 {
> > +			reg = <0x5c020000 0x10000>;
> > +		};
> > +	};
> > +
> > +	lsio_subsys: bus at 5d000000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x5d000000 0x0 0x5d000000 0x1000000>;
> > +
> > +		lsio_mu0: mailbox at 5d1b0000 {
> > +			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> > +			reg = <0x5d1b0000 0x10000>;
> > +			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells = <0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		lsio_mu1: mailbox at 5d1c0000 {
> > +			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> > +			reg = <0x5d1c0000 0x10000>;
> > +			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells = <2>;
> > +		};
> > +
> > +		lsio_mu3: mailbox at 5d1e0000 {
> > +			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> > +			reg = <0x5d1e0000 0x10000>;
> > +			interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells = <0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		lsio_mu4: mailbox at 5d1f0000 {
> > +			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> > +			reg = <0x5d1f0000 0x10000>;
> > +			interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells = <0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		lsio_gpio0: gpio at 5d080000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d080000 0x10000>;
> > +			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd_lsio_gpio0>;
> > +		};
> > +
> > +		lsio_gpio1: gpio at 5d090000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d090000 0x10000>;
> > +			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd_lsio_gpio1>;
> > +		};
> > +
> > +		lsio_gpio2: gpio at 5d0a0000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d0a0000 0x10000>;
> > +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd_lsio_gpio2>;
> > +		};
> > +
> > +		lsio_gpio3: gpio at 5d0b0000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d0b0000 0x10000>;
> > +			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd_lsio_gpio3>;
> > +		};
> > +
> > +		lsio_gpio4: gpio at 5d0c0000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d0c0000 0x10000>;
> > +			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd_lsio_gpio4>;
> > +		};
> > +
> > +		lsio_gpio5: gpio at 5d0d0000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d0d0000 0x10000>;
> > +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd_lsio_gpio5>;
> > +		};
> > +
> > +		lsio_gpio6: gpio at 5d0e0000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d0e0000 0x10000>;
> > +			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd_lsio_gpio6>;
> > +		};
> > +
> > +		lsio_gpio7: gpio at 5d0f0000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d0f0000 0x10000>;
> > +			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd_lsio_gpio7>;
> > +		};
> > +	};
> > +
> > +	hsio_subsys: bus at 5f000000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x5f000000 0x0 0x5f000000 0x1000000>;
> > +	};
> > +};
> > --
> > 2.7.4
> >
