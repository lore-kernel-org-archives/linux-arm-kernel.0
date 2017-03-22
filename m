From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 22 Mar 2017 14:31:36 +0100
Subject: [PATCH v2 4/8] soc: imx: gpc: fix imx6sl gpc power domain
 regression
In-Reply-To: <1490244805-3921-5-git-send-email-aisheng.dong@nxp.com>
References: <1490244805-3921-1-git-send-email-aisheng.dong@nxp.com>
 <1490244805-3921-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1490189496.29056.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 23.03.2017, 12:53 +0800 schrieb Dong Aisheng:
> Commit 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> broke the MX6SL GPC power domain support.
> It always got the following error:
> [    1.248364] imx-gpc 20dc000.gpc: could not find pgc DT node
> This patch adds back the legecy support.
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

I would have hoped to keep the sanity check, but it makes things more
complicated for no real gain, as probably nobody is going to try adding
SoC support with the old bindings:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> Change Log:
> v1->v2: add back the three domain support for MX6SL
> ---
>  drivers/soc/imx/gpc.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index ba6e7ab..9a2354e 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -309,12 +309,13 @@ static struct genpd_onecell_data imx_gpc_onecell_data = {
>  	.num_domains = 2,
>  };
>  
> -static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap)
> +static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
> +			       unsigned int num_domains)
>  {
>  	struct imx_pm_domain *domain;
>  	int i, ret;
>  
> -	for (i = 0; i < 2; i++) {
> +	for (i = 0; i < num_domains; i++) {
>  		domain = &imx_gpc_domains[i];
>  		domain->regmap = regmap;
>  		domain->ipg_rate_mhz = 66;
> @@ -332,7 +333,7 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap)
>  		}
>  	}
>  
> -	for (i = 0; i < 2; i++)
> +	for (i = 0; i < num_domains; i++)
>  		pm_genpd_init(&imx_gpc_domains[i].base, NULL, false);
>  
>  	if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
> @@ -345,7 +346,7 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap)
>  	return 0;
>  
>  genpd_err:
> -	for (i = 0; i < 2; i++)
> +	for (i = 0; i < num_domains; i++)
>  		pm_genpd_remove(&imx_gpc_domains[i].base);
>  	imx_pgc_put_clocks(&imx_gpc_domains[1]);
>  clk_err:
> @@ -385,13 +386,8 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  	}
>  
>  	if (!pgc_node) {
> -		/* old DT layout is only supported for mx6q aka 2 domains */
> -		if (of_id_data->num_domains != 2) {
> -			dev_err(&pdev->dev, "could not find pgc DT node\n");
> -			return -ENODEV;
> -		}
> -
> -		ret = imx_gpc_old_dt_init(&pdev->dev, regmap);
> +		ret = imx_gpc_old_dt_init(&pdev->dev, regmap,
> +					  of_id_data->num_domains);
>  		if (ret)
>  			return ret;
>  	} else {
