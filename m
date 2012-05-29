From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 29 May 2012 11:15:36 +0200
Subject: [PATCH] ARM: i.MX35: Implement camera and keypad clocks
In-Reply-To: <1338206687-14551-1-git-send-email-alexg@meprolight.com>
References: <1338206687-14551-1-git-send-email-alexg@meprolight.com>
Message-ID: <20120529091536.GE30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2012 at 03:04:47PM +0300, Alex Gershgorin wrote:
> This patch also adds mux and divider for camera clock.
> 
> Signed-off-by: Alex Gershgorin <alexg@meprolight.com>

Applied, thanks

Sascha

> ---
>  arch/arm/mach-imx/clk-imx35.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
> index a9e60bf..42131d5 100644
> --- a/arch/arm/mach-imx/clk-imx35.c
> +++ b/arch/arm/mach-imx/clk-imx35.c
> @@ -62,8 +62,8 @@ enum mx35_clks {
>  	kpp_gate, mlb_gate, mshc_gate, owire_gate, pwm_gate, rngc_gate,
>  	rtc_gate, rtic_gate, scc_gate, sdma_gate, spba_gate, spdif_gate,
>  	ssi1_gate, ssi2_gate, uart1_gate, uart2_gate, uart3_gate, usbotg_gate,
> -	wdog_gate, max_gate, admux_gate, csi_gate, iim_gate, gpu2d_gate,
> -	clk_max
> +	wdog_gate, max_gate, admux_gate, csi_gate, csi_div, csi_sel, iim_gate,
> +	gpu2d_gate, clk_max
>  };
>  
>  static struct clk *clk[clk_max];
> @@ -142,6 +142,9 @@ int __init mx35_clocks_init()
>  
>  	clk[nfc_div] = imx_clk_divider("nfc_div", "ahb", base + MX35_CCM_PDR4, 28, 4);
>  
> +	clk[csi_sel] = imx_clk_mux("csi_sel", base + MX35_CCM_PDR2, 7, 1, std_sel, ARRAY_SIZE(std_sel));
> +	clk[csi_div] = imx_clk_divider("csi_div", "csi_sel", base + MX35_CCM_PDR2, 16, 6);
> +
>  	clk[asrc_gate] = imx_clk_gate2("asrc_gate", "ipg", base + MX35_CCM_CGR0,  0);
>  	clk[pata_gate] = imx_clk_gate2("pata_gate", "ipg", base + MX35_CCM_CGR0,  2);
>  	clk[audmux_gate] = imx_clk_gate2("audmux_gate", "ipg", base + MX35_CCM_CGR0,  4);
> @@ -192,7 +195,7 @@ int __init mx35_clocks_init()
>  	clk[max_gate] = imx_clk_gate2("max_gate", "dummy", base + MX35_CCM_CGR2, 26);
>  	clk[admux_gate] = imx_clk_gate2("admux_gate", "ipg", base + MX35_CCM_CGR2, 30);
>  
> -	clk[csi_gate] = imx_clk_gate2("csi_gate", "ipg", base + MX35_CCM_CGR3,  0);
> +	clk[csi_gate] = imx_clk_gate2("csi_gate", "csi_div", base + MX35_CCM_CGR3,  0);
>  	clk[iim_gate] = imx_clk_gate2("iim_gate", "ipg", base + MX35_CCM_CGR3,  2);
>  	clk[gpu2d_gate] = imx_clk_gate2("gpu2d_gate", "ahb", base + MX35_CCM_CGR3,  4);
>  
> @@ -229,6 +232,7 @@ int __init mx35_clocks_init()
>  	clk_register_clkdev(clk[i2c3_gate], NULL, "imx-i2c.2");
>  	clk_register_clkdev(clk[ipu_gate], NULL, "ipu-core");
>  	clk_register_clkdev(clk[ipu_gate], NULL, "mx3_sdc_fb");
> +	clk_register_clkdev(clk[kpp_gate], NULL, "imx-keypad");
>  	clk_register_clkdev(clk[owire_gate], NULL, "mxc_w1");
>  	clk_register_clkdev(clk[sdma_gate], NULL, "imx35-sdma");
>  	clk_register_clkdev(clk[ipg], "ipg", "imx-ssi.0");
> @@ -256,6 +260,7 @@ int __init mx35_clocks_init()
>  	clk_register_clkdev(clk[usbotg_gate], "ahb", "fsl-usb2-udc");
>  	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
>  	clk_register_clkdev(clk[nfc_div], NULL, "mxc_nand.0");
> +	clk_register_clkdev(clk[csi_gate], NULL, "mx3-camera.0");
>  
>  	clk_prepare_enable(clk[spba_gate]);
>  	clk_prepare_enable(clk[gpio1_gate]);
> -- 
> 1.7.0.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
