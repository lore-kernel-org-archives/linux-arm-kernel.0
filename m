From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 16 Oct 2015 17:40:38 +0200
Subject: [PATCH] clk: imx25: Remove osc clock from driver
In-Reply-To: <1445009120-2582-1-git-send-email-mpa@pengutronix.de>
References: <1445009120-2582-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1445010038.3180.18.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 16.10.2015, 17:25 +0200 schrieb Markus Pargmann:
> The 'osc' clock is already initialized by the fixed clock defined in
> imx25.dtsi. The imx25 clock driver tries to add this clock for a second
> time and fails with -EEXIST:
> 	i.MX clk 1: register failed with -17
> 
> As the clock is already properly setup in DT with a different driver, we
> can completely remove the handling in the imx25 clock driver.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

I was just about to shout something about DT stability, but then noticed
that the "fixed-clock" compatible is present since the first commit of
the i.MX25 DTSI.

No objections from me,
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/clk/imx/clk-imx25.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
> index ec1a4c1dacf1..33b5b7b29aa0 100644
> --- a/drivers/clk/imx/clk-imx25.c
> +++ b/drivers/clk/imx/clk-imx25.c
> @@ -86,13 +86,12 @@ enum mx25_clks {
>  
>  static struct clk *clk[clk_max];
>  
> -static int __init __mx25_clocks_init(unsigned long osc_rate,
> -				     void __iomem *ccm_base)
> +static int __init __mx25_clocks_init(void __iomem *ccm_base)
>  {
>  	BUG_ON(!ccm_base);
>  
>  	clk[dummy] = imx_clk_fixed("dummy", 0);
> -	clk[osc] = imx_clk_fixed("osc", osc_rate);
> +	clk[osc] = NULL;

Nit: clk is a static array, so no need to explicitly set this entry to
NULL as it's already initialized that way.

>  	clk[mpll] = imx_clk_pllv1(IMX_PLLV1_IMX25, "mpll", "osc", ccm(CCM_MPCTL));
>  	clk[upll] = imx_clk_pllv1(IMX_PLLV1_IMX25, "upll", "osc", ccm(CCM_UPCTL));
>  	clk[mpll_cpu_3_4] = imx_clk_fixed_factor("mpll_cpu_3_4", "mpll", 3, 4);
> @@ -238,22 +237,10 @@ static int __init __mx25_clocks_init(unsigned long osc_rate,
>  
>  static void __init mx25_clocks_init_dt(struct device_node *np)
>  {
> -	struct device_node *refnp;
> -	unsigned long osc_rate = 24000000;
>  	void __iomem *ccm;
>  
> -	/* retrieve the freqency of fixed clocks from device tree */
> -	for_each_compatible_node(refnp, NULL, "fixed-clock") {
> -		u32 rate;
> -		if (of_property_read_u32(refnp, "clock-frequency", &rate))
> -			continue;
> -
> -		if (of_device_is_compatible(refnp, "fsl,imx-osc"))
> -			osc_rate = rate;
> -	}
> -
>  	ccm = of_iomap(np, 0);
> -	__mx25_clocks_init(osc_rate, ccm);
> +	__mx25_clocks_init(ccm);
>  
>  	clk_data.clks = clk;
>  	clk_data.clk_num = ARRAY_SIZE(clk);

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
