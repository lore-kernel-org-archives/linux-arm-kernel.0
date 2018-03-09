From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 9 Mar 2018 11:23:48 +0800
Subject: [PATCH v2 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <20180201183126.32384-2-l.stach@pengutronix.de>
References: <20180201183126.32384-1-l.stach@pengutronix.de>
 <20180201183126.32384-2-l.stach@pengutronix.de>
Message-ID: <20180309032347.GG3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 07:31:24PM +0100, Lucas Stach wrote:
> This adds the basic DTS for the i.MX8MQ.
> For now only the following peripherals are supported:
> - IOMUXC (pin controller)
> - CCM (clock controller)
> - GPIO
> - UART
> - uSDHC (SD/eMMC controller)
> - FEC (ethernet controller)
> - i2c

To follow the device naming recommendation from
devicetree-specification, I would suggest a few renames embedded as
below.

https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.2

<snip>

> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> new file mode 100644
> index 000000000000..50ed302d299a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -0,0 +1,411 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2017 NXP
> + * Copyright (C) 2017 Pengutronix, Lucas Stach <kernel@pengutronix.de>
> + */
> +
> +#include <dt-bindings/clock/imx8mq-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include "imx8mq-pinfunc.h"
> +
> +/* first 128 KiB of memory are owned by ATF */
> +/memreserve/ 0x40000000 0x00020000;
> +
> +/ {
> +	/* This should really be the GPC, but we need a driver for this first */
> +	interrupt-parent = <&gic>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		i2c0 = &i2c1;
> +		i2c1 = &i2c2;
> +		i2c2 = &i2c3;
> +		i2c3 = &i2c4;
> +		serial0 = &uart1;
> +		serial1 = &uart2;
> +		serial2 = &uart3;
> +		serial3 = &uart4;
> +	};
> +
> +	ckil: clk-ckil {

clock-xxx for node name.

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "ckil";
> +	};
> +
> +	osc_25m: clk-osc-25m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +		clock-output-names = "osc_25m";
> +	};
> +
> +	osc_27m: clk-osc-27m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <27000000>;
> +		clock-output-names = "osc_27m";
> +	};
> +
> +	clk_ext1: clk-ext1 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <133000000>;
> +		clock-output-names = "clk_ext1";
> +	};
> +
> +	clk_ext2: clk-ext2 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <133000000>;
> +		clock-output-names = "clk_ext2";
> +	};
> +
> +	clk_ext3: clk-ext3 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <133000000>;
> +		clock-output-names = "clk_ext3";
> +	};
> +
> +	clk_ext4: clk-ext4 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency= <133000000>;
> +		clock-output-names = "clk_ext4";
> +	};

<snip>

> +			usdhc1: usdhc at 30b40000 {

s/usdhc/mmc for node name.

> +				compatible = "fsl,imx8mq-usdhc",
> +				             "fsl,imx7d-usdhc";
> +				reg = <0x30b40000 0x10000>;
> +				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_DUMMY>,
> +				         <&clk IMX8MQ_CLK_NAND_USDHC_BUS_DIV>,
> +				         <&clk IMX8MQ_CLK_USDHC1_ROOT>;
> +				clock-names = "ipg", "ahb", "per";
> +				fsl,tuning-start-tap = <20>;
> +				fsl,tuning-step = <2>;
> +				bus-width = <4>;
> +				status = "disabled";
> +			};
> +
> +			usdhc2: usdhc at 30b50000 {
> +				compatible = "fsl,imx8mq-usdhc",
> +				             "fsl,imx7d-usdhc";
> +				reg = <0x30b50000 0x10000>;
> +				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_DUMMY>,
> +				         <&clk IMX8MQ_CLK_NAND_USDHC_BUS_DIV>,
> +				         <&clk IMX8MQ_CLK_USDHC2_ROOT>;
> +				clock-names = "ipg", "ahb", "per";
> +				fsl,tuning-start-tap = <20>;
> +				fsl,tuning-step = <2>;
> +				bus-width = <4>;
> +				status = "disabled";
> +			};

Shawn
