From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 22 Sep 2013 13:16:38 -0300
Subject: mxsfb on i.MX28 uses bypassed ref_xtal 24MHz clock for LCD
In-Reply-To: <523C529F.4000300@digi.com>
References: <5196375A.1070308@digi.com>
	<523C529F.4000300@digi.com>
Message-ID: <CAOMZO5Ds-HmFYua7A1j7BiMVjUipGzddmatnOpo1NORCVYLUWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hector,

On Fri, Sep 20, 2013 at 10:50 AM, Hector Palacios
<hector.palacios@digi.com> wrote:

> --- a/drivers/clk/mxs/clk-imx28.c
> +++ b/drivers/clk/mxs/clk-imx28.c
> @@ -246,6 +246,12 @@ int __init mx28_clocks_init(void)
>         clk_data.clk_num = ARRAY_SIZE(clks);
>         of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>
> +       /*
> +        * Select PLL as the parent source of lcdif_sel clk to have a finer
> +        * granularity when calculating the LCD pixelclock
> +        */
> +       clk_set_parent(clks[lcdif_sel], clks[ref_pix]);
> +
>         clk_register_clkdev(clks[enet_out], NULL, "enet_out");
>
>         for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
>
>
> Without this, the pixelclock can only be a power of two divisor of 24MHz,
> and I need a 20MHz signal, otherwise I see bad pixels in true color images
> on my LCD.

When you submit this patch, you can add:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
