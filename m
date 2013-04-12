From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 12 Apr 2013 17:10:01 +0200
Subject: [PATCH] ARM: i.MX5 Allow DT clock providers
In-Reply-To: <20130412121329.3965.30768.stgit@localhost>
References: <20130412121329.3965.30768.stgit@localhost>
Message-ID: <20130412151001.GS1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 02:13:29PM +0200, Martin Fuzzey wrote:
> Currently clock providers defined in the DT are not registered
> on i.MX5 platforms since of_clk_init() is not called.
> 
> This is not a problem for the SOC's own clocks, which are registered
> in code,  but prevents the DT being used to define clocks for external
> hardware.
> 
> Fix this by calling of_clk_init() and actually using the DT to obtain
> the 4 SOC fixed clocks.
> These are already defined in the DT but were previously just used to
> manually obtain the rate.
> 
> Fall back to the old scheme for non DT platforms.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c |   75 +++++++++++++++++++----------------
>  1 files changed, 41 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index 3228b4e..342c8b3 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -117,17 +117,52 @@ enum imx5_clks {
>  static struct clk *clk[clk_max];
>  static struct clk_onecell_data clk_data;
>  
> +
> +static struct clk * __init mx5_obtain_fixed_clock_from_dt(const char *name)
> +{
> +#ifdef CONFIG_OF
> +	char compatible[20];
> +	struct of_phandle_args phandle = {0};
> +	struct clk *clk = NULL;
> +
> +	scnprintf(compatible, sizeof(compatible), "fsl,imx-%s", name);

Can we use kasprintf here? Not that it makes a big difference currently,
but it always looks a bit awkward to depend on a maximum string length.

> +	phandle.np = of_find_compatible_node(NULL, NULL, compatible);
> +	if (phandle.np) {
> +		clk = of_clk_get_from_provider(&phandle);
> +		of_node_put(phandle.np);
> +	}
> +	return clk;
> +#else
> +	return NULL;
> +#endif
> +}
> +
> +static struct clk * __init mx5_obtain_fixed_clock(
> +			const char *name, unsigned long rate)
> +{
> +	struct clk *clk;
> +
> +	clk = mx5_obtain_fixed_clock_from_dt(name);
> +	if (IS_ERR_OR_NULL(clk))

You shouldn't use IS_ERR_OR_NULL. Instead you could return
ERR_PTR(-ENODEV) for !CONFIG_OF. Another option would be to inline the
code from mx5_obtain_fixed_clock_from_dt here.

> +		clk = imx_clk_fixed(name, rate);
> +	return clk;
> +}
> +

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
