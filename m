From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Oct 2018 08:58:59 +0200
Subject: [PATCH V2 2/4] arm64: dts: imx: add imx8qxp support
In-Reply-To: <1539527419-23613-3-git-send-email-aisheng.dong@nxp.com>
References: <1539527419-23613-1-git-send-email-aisheng.dong@nxp.com>
 <1539527419-23613-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181015065859.lxevjroly435hlaq@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 14, 2018 at 02:34:52PM +0000, A.s. Dong wrote:
> Add imx8qxp support
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> v1->v2:
>  * mu binding usage update
>  * no define for node address
>  * do not use '_' for node name
>  * drop 'fsl-' prefix for imx dtsi
>  * no defines for unit address
>  * generic node names
>  * range map for 32bit register
>  * separate board dts
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |   4 +
>  arch/arm64/boot/dts/freescale/imx8-ca35.dtsi  |  61 ++
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 861 ++++++++++++++++++++++++++
>  3 files changed, 926 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> index 968f238..baeb1fc 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -119,6 +119,10 @@ i.MX6q generic board
>  Required root node properties:
>      - compatible = "fsl,imx6q";
>  
> +i.MX8QXP generic board
> +Required root node properties:
> +    - compatible = "fsl,imx8qxp";
> +
>  Freescale Vybrid Platform Device Tree Bindings
>  ----------------------------------------------
>  
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ca35.dtsi b/arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
> new file mode 100644
> index 0000000..c79e97a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017~2018 NXP
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/{
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		/* We have 1 clusters with 4 Cortex-A35 cores */
> +		A35_0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&A35_L2>;
> +		};
> +
> +		A35_1: cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +			next-level-cache = <&A35_L2>;
> +		};
> +
> +		A35_2: cpu at 2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0 0x2>;
> +			enable-method = "psci";
> +			next-level-cache = <&A35_L2>;
> +		};
> +
> +		A35_3: cpu at 3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0 0x3>;
> +			enable-method = "psci";
> +			next-level-cache = <&A35_L2>;
> +		};
> +
> +		A35_L2: l2-cache0 {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> new file mode 100644
> index 0000000..e1d2578
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -0,0 +1,861 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017~2018 NXP
> + *	Dong Aisheng <aisheng.dong@nxp.com>
> + */
> +
> +#include <dt-bindings/clock/imx8qxp-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/pads-imx8qxp.h>
> +
> +#include "imx8-ca35.dtsi"
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &dma_lpuart0;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		mmc2 = &usdhc3;
> +	};
> +
> +	memory at 80000000 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x80000000 0 0x40000000>;
> +	};
> +
> +	gic: interrupt-controller at 51a00000 {
> +		compatible = "arm,gic-v3";
> +		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
> +		      <0x0 0x51b00000 0 0xc0000>; /* GICR (RD_base + SGI_base) */
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure */
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* Physical Non-Secure */
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* Virtual */
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor */
> +	};
> +
> +	scu {
> +		compatible = "fsl,imx-scu";
> +		mbox-names = "tx0", "tx1", "tx2", "tx3",
> +			     "rx0", "rx1", "rx2", "rx3";
> +		mboxes = <&lsio_mu1 0 0
> +			  &lsio_mu1 0 1
> +			  &lsio_mu1 0 2
> +			  &lsio_mu1 0 3
> +			  &lsio_mu1 1 0
> +			  &lsio_mu1 1 1
> +			  &lsio_mu1 1 2
> +			  &lsio_mu1 1 3>;
> +
> +		clk: clock-controller {
> +			compatible = "fsl,imx8qxp-clk";
> +			#clock-cells = <1>;
> +		};
> +
> +		iomuxc: pinctrl {
> +			compatible = "fsl,imx8qxp-iomuxc";
> +		};
> +
> +		imx8qx-pm {
> +			compatible = "fsl,scu-pd";

I missed this earlier, but there should be a i.MX8qp specific compatible
as the SCU API might change for future SoCs.

> +			compatible = "fsl,imx7ulp-lpuart";
> +			compatible = "fsl,imx7ulp-lpi2c";
> +			compatible = "fsl,imx7d-usdhc";

All these lack the most specific imx8qp compatible.

> +			compatible = "fsl,imx6sx-fec";
> +			compatible = "fsl,imx8qxp-fec";

BTW are there really two different FECs on the i.MX8qp?


Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
