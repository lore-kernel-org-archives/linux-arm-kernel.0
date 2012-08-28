From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 28 Aug 2012 09:49:57 +0200
Subject: [PATCH v2 1/2] ARM: clk-imx35: Fix SSI clock registration
In-Reply-To: <1345466362-2576-1-git-send-email-fabio.estevam@freescale.com>
References: <1345466362-2576-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120828074957.GY26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 09:39:22AM -0300, Fabio Estevam wrote:
> SSI block has two types of clock:
> 
> ipg: bus clock, the clock needed for accessing registers.
> per: peripheral clock, the clock needed for generating the bit rate.
> 
> Currently SSI driver only supports slave mode and only need to handle
> the ipg clock, because the peripheral clock comes from the master codec.
> 
> Only register the ipg clock and do not register the peripheral clock for ssi.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Ok, used this version instead.

Sascha

> ---
> Changes since v1:
> - Use ssi2_gate for imx-ssi.1
> 
>  arch/arm/mach-imx/clk-imx35.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
> index c6422fb..f7910df 100644
> --- a/arch/arm/mach-imx/clk-imx35.c
> +++ b/arch/arm/mach-imx/clk-imx35.c
> @@ -230,10 +230,8 @@ int __init mx35_clocks_init()
>  	clk_register_clkdev(clk[ipu_gate], NULL, "mx3_sdc_fb");
>  	clk_register_clkdev(clk[owire_gate], NULL, "mxc_w1");
>  	clk_register_clkdev(clk[sdma_gate], NULL, "imx35-sdma");
> -	clk_register_clkdev(clk[ipg], "ipg", "imx-ssi.0");
> -	clk_register_clkdev(clk[ssi1_div_post], "per", "imx-ssi.0");
> -	clk_register_clkdev(clk[ipg], "ipg", "imx-ssi.1");
> -	clk_register_clkdev(clk[ssi2_div_post], "per", "imx-ssi.1");
> +	clk_register_clkdev(clk[ssi1_gate], NULL, "imx-ssi.0");
> +	clk_register_clkdev(clk[ssi2_gate], NULL, "imx-ssi.1");
>  	/* i.mx35 has the i.mx21 type uart */
>  	clk_register_clkdev(clk[uart1_gate], "per", "imx21-uart.0");
>  	clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.0");
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
