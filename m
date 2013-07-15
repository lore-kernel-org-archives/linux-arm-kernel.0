From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Jul 2013 23:50:09 +0200
Subject: [PATCH 21/22] DT: Add basic support for imx35-based devices.
In-Reply-To: <1373900227-341-22-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-22-git-send-email-denis@eukrea.com>
Message-ID: <20130715215009.GG10995@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 04:57:06PM +0200, Denis Carikli wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  arch/arm/boot/dts/imx35.dtsi         |  308 ++++++++++++++++++++++++++++++++++
>  arch/arm/configs/imx_v6_v7_defconfig |    1 +
>  arch/arm/mach-imx/Kconfig            |   11 ++
>  arch/arm/mach-imx/Makefile           |    1 +
>  arch/arm/mach-imx/clk-imx35.c        |   13 ++
>  arch/arm/mach-imx/imx35-dt.c         |   48 ++++++
>  6 files changed, 382 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx35.dtsi
>  create mode 100644 arch/arm/mach-imx/imx35-dt.c
> 
> diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
> new file mode 100644
> index 0000000..012c1a3
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx35.dtsi
> @@ -0,0 +1,308 @@
> +/*
> + * Copyright 2012 Steffen Trumtrar, Pengutronix
> + *
> + * based on imx27.dtsi
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +
> +#include "skeleton.dtsi"
> +#include "imx35-pinfunc.h"
> +
> +/ {
> +	aliases {
> +		serial0 = &uart1;
> +		serial1 = &uart2;
> +		serial2 = &uart3;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +	};
> +
> +	avic: avic-interrupt-controller at 68000000 {
> +		compatible = "fsl,imx35-avic", "fsl,avic";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0x68000000 0x10000000>;
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ckil {
> +			compatible = "fsl,imx-ckil", "fixed-clock";
> +			clock-frequency = <32768>;
> +		};
> +
> +		osc {
> +			compatible = "fsl,imx-osc", "fixed-clock";
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +
> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&avic>;
> +		ranges;
> +
> +		l2-cache at 30000000 {
> +			compatible = "arm,l210-cache";
> +			reg = <0x30000000 0x1000>;
> +			cache-unified;
> +			cache-level = <2>;
> +		};
> +
> +		aips at 43f00000 { /* AIPS1 */

You could add a 'aips1:' label to make the comment unnecessary.

> +			iomuxc at 43fac000 {

Add a 'iomuxc:' label here.

> diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
> index 2193c83..b46375c 100644
> --- a/arch/arm/mach-imx/clk-imx35.c
> +++ b/arch/arm/mach-imx/clk-imx35.c
> @@ -204,7 +204,9 @@ int __init mx35_clocks_init(void)
>  				i, PTR_ERR(clk[i]));
>  
>  	clk_register_clkdev(clk[pata_gate], NULL, "pata_imx");
> +	clk_register_clkdev(clk[can1_gate], NULL, "53fe4000.can");
>  	clk_register_clkdev(clk[can1_gate], NULL, "flexcan.0");
> +	clk_register_clkdev(clk[can2_gate], NULL, "53fe8000.can");
>  	clk_register_clkdev(clk[can2_gate], NULL, "flexcan.1");
>  	clk_register_clkdev(clk[cspi1_gate], "per", "imx35-cspi.0");
>  	clk_register_clkdev(clk[cspi1_gate], "ipg", "imx35-cspi.0");
> @@ -221,12 +223,16 @@ int __init mx35_clocks_init(void)
>  	clk_register_clkdev(clk[esdhc3_gate], "per", "sdhci-esdhc-imx35.2");
>  	clk_register_clkdev(clk[ipg], "ipg", "sdhci-esdhc-imx35.2");
>  	clk_register_clkdev(clk[ahb], "ahb", "sdhci-esdhc-imx35.2");
> +	clk_register_clkdev(clk[fec_gate], NULL, "50038000.fec");
>  	/* i.mx35 has the i.mx27 type fec */
>  	clk_register_clkdev(clk[fec_gate], NULL, "imx27-fec.0");
>  	clk_register_clkdev(clk[gpt_gate], "per", "imx-gpt.0");
>  	clk_register_clkdev(clk[ipg], "ipg", "imx-gpt.0");
> +	clk_register_clkdev(clk[i2c1_gate], NULL, "43f80000.i2c");
>  	clk_register_clkdev(clk[i2c1_gate], NULL, "imx21-i2c.0");
> +	clk_register_clkdev(clk[i2c2_gate], NULL, "43f98000.i2c");
>  	clk_register_clkdev(clk[i2c2_gate], NULL, "imx21-i2c.1");
> +	clk_register_clkdev(clk[i2c3_gate], NULL, "43f84000.i2c");
>  	clk_register_clkdev(clk[i2c3_gate], NULL, "imx21-i2c.2");
>  	clk_register_clkdev(clk[ipu_gate], NULL, "ipu-core");
>  	clk_register_clkdev(clk[ipu_gate], NULL, "mx3_sdc_fb");
> @@ -235,6 +241,12 @@ int __init mx35_clocks_init(void)
>  	clk_register_clkdev(clk[sdma_gate], NULL, "imx35-sdma");
>  	clk_register_clkdev(clk[ssi1_gate], NULL, "imx-ssi.0");
>  	clk_register_clkdev(clk[ssi2_gate], NULL, "imx-ssi.1");
> +	clk_register_clkdev(clk[uart1_gate], "per", "43f90000.serial");
> +	clk_register_clkdev(clk[ipg], "ipg", "43f90000.serial");
> +	clk_register_clkdev(clk[uart2_gate], "per", "43f94000.serial");
> +	clk_register_clkdev(clk[ipg], "ipg", "43f94000.serial");
> +	clk_register_clkdev(clk[uart3_gate], "per", "5000c000.serial");
> +	clk_register_clkdev(clk[ipg], "ipg", "5000c000.serial");
>  	/* i.mx35 has the i.mx21 type uart */
>  	clk_register_clkdev(clk[uart1_gate], "per", "imx21-uart.0");
>  	clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.0");
> @@ -255,6 +267,7 @@ int __init mx35_clocks_init(void)
>  	clk_register_clkdev(clk[ipg], "ipg", "imx-udc-mx27");
>  	clk_register_clkdev(clk[usbotg_gate], "ahb", "imx-udc-mx27");
>  	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
> +	clk_register_clkdev(clk[nfc_div], NULL, "bb000000.nand");

All the changes above shouldn't be necessary.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
