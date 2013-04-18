From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 18 Apr 2013 18:14:24 +0200
Subject: [PATCH V3] ARM: i.MX5: Allow DT clock providers
In-Reply-To: <20130418155510.26908.61334.stgit@localhost>
References: <20130418155510.26908.61334.stgit@localhost>
Message-ID: <20130418161424.GI1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 05:55:10PM +0200, Martin Fuzzey wrote:
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
> 
> ---
> Changelog:
> V2: Applied comments from Sascha Hauer:
> 	* Use kasprintf instead of scnprintf to avoid length limit
> 	* Avoid use of IS_ERR_OR_NULL
> 
> V3: Applied comments from Shawn Guo:
> 	* Find clocks by path rather than compatible string
> 	* Remove unnecessary #ifdef CONFIG_OF
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c |   76 ++++++++++++++++++-----------------
>  1 files changed, 40 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index 3228b4e..606c679 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -117,17 +117,51 @@ enum imx5_clks {
>  static struct clk *clk[clk_max];
>  static struct clk_onecell_data clk_data;
>  
> +
> +static struct clk * __init mx5_obtain_fixed_clock_from_dt(const char *name)
> +{
> +	struct of_phandle_args phandle = {0};
> +	struct clk *clk = ERR_PTR(-ENODEV);
> +	char *path;
> +
> +	path = kasprintf(GFP_KERNEL, "/clocks/%s", name);
> +	if (!path)
> +		return ERR_PTR(-ENOMEM);
> +
> +	phandle.np = of_find_node_by_path(path);
> +	kfree(path);
> +
> +	if (phandle.np) {
> +		clk = of_clk_get_from_provider(&phandle);
> +		of_node_put(phandle.np);
> +	}
> +	return clk;
> +}
> +
> +static struct clk * __init mx5_obtain_fixed_clock(
> +			const char *name, unsigned long rate)
> +{
> +	struct clk *clk;
> +
> +	clk = mx5_obtain_fixed_clock_from_dt(name);
> +	if (IS_ERR(clk))
> +		clk = imx_clk_fixed(name, rate);
> +	return clk;
> +}

I just realized that this is useful for other i.MX aswell. How about
renaming it to imx_obtain_fixed_clk() and move it to
arch/arm/mach-imx/clk.c?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
