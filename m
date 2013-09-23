From: marex@denx.de (Marek Vasut)
Date: Mon, 23 Sep 2013 17:23:56 +0200
Subject: [PATCH] clk: mxs: source LCD clock from PLL instead of from
 ref_xtal
In-Reply-To: <1379922623-4875-1-git-send-email-hector.palacios@digi.com>
References: <1379922623-4875-1-git-send-email-hector.palacios@digi.com>
Message-ID: <201309231723.56516.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Hector Palacios,

> The lcd clock hierarchy is as follows:
> 
>     ref_clk (24MHz)-----\
>                          +--+ lcdif_sel (MUX type)
>     frac1_clk (480Mhz)--/   |
>                             \--+ lcdif_div (DIV type)
> 
>                                \-- lcdif (GATE type)
> 
> The mxsfb driver retrieves the 'lcdif_div' clock from the DT, but the
> 'lcdif_sel' is by default sourced from 'ref_clk' which is a fixed 24MHz.
> This means the pixel clock can only be 24MHz or a power-of-two divisor
> of that frequency (12, 6, 3...) which is a very poor divisor granularity.
> 
> Since the driver doesn't know about the different clocks that can
> source its clk parent from, we must select the PLL (480MHz) to be the
> parent during the general clocks initialization. This allows for much
> better divisor granularity and for more accurate frequencies for LCD
> displays.
> 
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
> CC: Maxime Rippard <maxime.ripard@free-electrons.com>
> CC: Marek Vasut <marex@denx.de>
> CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> CC: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> ---
>  drivers/clk/mxs/clk-imx28.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
> index 4faf0af..882ec3f 100644
> --- a/drivers/clk/mxs/clk-imx28.c
> +++ b/drivers/clk/mxs/clk-imx28.c
> @@ -246,6 +246,12 @@ int __init mx28_clocks_init(void)
>  	clk_data.clk_num = ARRAY_SIZE(clks);
>  	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> 
> +	/*
> +	 * Select PLL as the parent source of lcdif_sel clk to have a finer
> +	 * granularity when calculating the LCD pixelclock
> +	 */
> +	clk_set_parent(clks[lcdif_sel], clks[ref_pix]);
> +
>  	clk_register_clkdev(clks[enet_out], NULL, "enet_out");
> 
>  	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)

On M28EVK:

Tested-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
