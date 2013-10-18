From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 18 Oct 2013 08:58:18 +0200
Subject: [Patch v2][ 17/37] DT: Add basic support for imx35-based devices.
In-Reply-To: <1382022155-21954-18-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
 <1382022155-21954-18-git-send-email-denis@eukrea.com>
Message-ID: <20131018065818.GT30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 05:02:15PM +0200, Denis Carikli wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> +
> +				can2 {
> +					pinctrl_can2_1: can2grp-1 {
> +						fsl,pins = <MX35_PAD_TX5_RX0__CAN2_TXCAN 0x1c0
> +							MX35_PAD_TX4_RX1__CAN2_RXCAN 0x1c0>;
> +					};
> +				};
> +
> +				uart1 {
> +					pinctrl_uart1_1: uart1grp-1 {
> +						fsl,pins = <
> +							MX35_PAD_CTS1__UART1_CTS 0x80000000
> +							MX35_PAD_RTS1__UART1_RTS 0x80000000
> +							MX35_PAD_TXD1__UART1_TXD_MUX 0x80000000
> +							MX35_PAD_RXD1__UART1_RXD_MUX 0x80000000
> +						>;
> +					};

The indentation is inconsistent with the fsl,pins nodes. I like the
above best, but I don't care much as long as its consistent.

> +					pinctrl_lcdc_1: lcdcgp-1 {
> +						fsl,pins = <
> +							MX35_PAD_LD0__IPU_DISPB_DAT_0         0x80000000
> +							MX35_PAD_LD1__IPU_DISPB_DAT_1         0x80000000
> +							MX35_PAD_LD2__IPU_DISPB_DAT_2         0x80000000
> +							MX35_PAD_LD3__IPU_DISPB_DAT_3         0x80000000
> +							MX35_PAD_LD4__IPU_DISPB_DAT_4         0x80000000
> +							MX35_PAD_LD5__IPU_DISPB_DAT_5         0x80000000
> +							MX35_PAD_LD6__IPU_DISPB_DAT_6         0x80000000
> +							MX35_PAD_LD7__IPU_DISPB_DAT_7         0x80000000
> +							MX35_PAD_LD8__IPU_DISPB_DAT_8         0x80000000
> +							MX35_PAD_LD9__IPU_DISPB_DAT_9         0x80000000
> +							MX35_PAD_LD10__IPU_DISPB_DAT_10       0x80000000
> +							MX35_PAD_LD11__IPU_DISPB_DAT_11       0x80000000
> +							MX35_PAD_LD12__IPU_DISPB_DAT_12	      0x80000000
> +							MX35_PAD_LD13__IPU_DISPB_DAT_13       0x80000000
> +							MX35_PAD_LD14__IPU_DISPB_DAT_14       0x80000000
> +							MX35_PAD_LD15__IPU_DISPB_DAT_15       0x80000000
> +							MX35_PAD_LD16__IPU_DISPB_DAT_16       0x80000000
> +							MX35_PAD_LD17__IPU_DISPB_DAT_17       0x80000000
> +							MX35_PAD_D3_HSYNC__IPU_DISPB_D3_HSYNC 0x80000000
> +							MX35_PAD_D3_FPSHIFT__IPU_DISPB_D3_CLK 0x80000000
> +							MX35_PAD_D3_DRDY__IPU_DISPB_D3_DRDY   0x80000000
> +							MX35_PAD_D3_VSYNC__IPU_DISPB_D3_VSYNC 0x80000000
> +							/* Backlight */
> +							MX35_PAD_CONTRAST__IPU_DISPB_CONTR    0x80000000

This pin should probably not be here. At least the comment seems board
specific, not SoC specific.

> @@ -235,6 +244,12 @@ int __init mx35_clocks_init(void)
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
> @@ -255,6 +270,7 @@ int __init mx35_clocks_init(void)
>  	clk_register_clkdev(clk[ipg], "ipg", "imx-udc-mx27");
>  	clk_register_clkdev(clk[usbotg_gate], "ahb", "imx-udc-mx27");
>  	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
> +	clk_register_clkdev(clk[nfc_div], NULL, "bb000000.nand");
>  	clk_register_clkdev(clk[nfc_div], NULL, "imx25-nand.0");
>  	clk_register_clkdev(clk[csi_gate], NULL, "mx3-camera.0");
>  	clk_register_clkdev(clk[admux_gate], "audmux", NULL);

Why does this patch add more clock lookups? They shouldn't be needed as
the lookups come from dt now.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
