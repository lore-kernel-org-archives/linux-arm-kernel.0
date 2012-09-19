From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Sep 2012 13:33:50 +0800
Subject: [PATCH] ARM:IMX6Q:use pll2_pfd2_396m as the enfc_sel's parent
In-Reply-To: <1347261476-9799-1-git-send-email-b32955@freescale.com>
References: <1347261476-9799-1-git-send-email-b32955@freescale.com>
Message-ID: <20120919053348.GH6460@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 03:17:56PM +0800, Huang Shijie wrote:
> The gpmi-nand driver can support the ONFI nand chip's EDO (extra data out)
> mode in the asynchrounous mode. In the asynchrounous mode 5, the gpmi
> needs 100MHz clock for the IO. But with the pll2_pfd0_352m, we can not
> get the 100MHz clock.
> 
> So choose pll2_pfd2_396m as enfc_sel's parent.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Applied, thanks.

But we really expect that clock framework can get improved to have such
case handled in clk_set_rate() call.

Shawn

> ---
>  arch/arm/mach-imx/clk-imx6q.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index 4233d9e..58705b6 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -440,6 +440,13 @@ int __init mx6q_clocks_init(void)
>  	clk_register_clkdev(clk[ahb], "ahb", NULL);
>  	clk_register_clkdev(clk[cko1], "cko1", NULL);
>  
> +	/*
> +	 * The gpmi needs 100MHz frequency in the EDO/Sync mode,
> +	 * We can not get the 100MHz from the pll2_pfd0_352m.
> +	 * So choose pll2_pfd2_396m as enfc_sel's parent.
> +	 */
> +	clk_set_parent(clk[enfc_sel], clk[pll2_pfd2_396m]);
> +
>  	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
>  		clk_prepare_enable(clk[clks_init_on[i]]);
>  
> -- 
> 1.7.0.4
> 
> 
