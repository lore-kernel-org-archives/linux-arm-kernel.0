From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Fri, 28 Feb 2014 14:16:35 -0300
Subject: [PATCH v2 2/5] clk: sun6i: Reparent AHB clock on PLL6
In-Reply-To: <1393605440-14643-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1393605440-14643-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393605440-14643-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <5310C473.7030304@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 28/02/14 13:37, Maxime Ripard escribi?:
> In order for the DMA controller to work for SDRAM to devices transfers, the AHB
> clock should be reparented on the PLL6.
>
> Force that parenting in the clock driver.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>   drivers/clk/sunxi/clk-sunxi.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index f6f61cc..a5c5882 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -1286,7 +1286,7 @@ static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_mat
>    */
>   static void __init sunxi_clock_protect(void)
>   {
> -	struct clk *clk;
> +	struct clk *clk, *parent;
>
>   	/* memory bus clock - sun5i+ */
>   	clk = clk_get(NULL, "mbus");
> @@ -1307,6 +1307,22 @@ static void __init sunxi_clock_protect(void)
>   	if (!IS_ERR(clk))
>   		clk_prepare_enable(clk);
>
> +	clk = clk_get(NULL, "ahb1_mux");
> +	if (IS_ERR(clk)) {
> +		pr_err("Couldn't get AHB1 Mux\n");
> +		return;
> +	}
> +
> +	parent = clk_get(NULL, "pll6");
> +	if (IS_ERR(clk)) {
> +		pr_err("Couldn't get PLL6\n");
> +		return;
> +	}

Remember this runs on every sunxi, but this bit of magic is sun6i only. 
We'll get bogus messages on the other platforms if this goes as is. You 
could do something like the following:

 > +	clk = clk_get(NULL, "ahb1_mux");
 > +	parent = clk_get(NULL, "pll6");
 > +	if (!IS_ERR(clk) && !IS_ERR(parent))
 > +		clk_set_parent(...)

If these things become more common, we may need to consider a 
per-platform fixup function or something.

Cheers,

Emilio
