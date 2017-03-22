From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 22 Mar 2017 09:46:10 +0100
Subject: [PATCH 4/8] soc: imx: gpc: fix imx6sl gpc power domain regression
In-Reply-To: <20170322192356.GC16264@b29396-OptiPlex-7040>
References: <1489990547-1510-1-git-send-email-aisheng.dong@nxp.com>
 <1489990547-1510-5-git-send-email-aisheng.dong@nxp.com>
 <1490001974.2895.11.camel@pengutronix.de>
 <20170322192356.GC16264@b29396-OptiPlex-7040>
Message-ID: <1490172370.2895.34.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 23.03.2017, 03:23 +0800 schrieb Dong Aisheng:
> On Mon, Mar 20, 2017 at 10:26:14AM +0100, Lucas Stach wrote:
> > Am Montag, den 20.03.2017, 14:15 +0800 schrieb Dong Aisheng:
> > > Commit 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> > > broke the MX6SL GPC power domain support.
> > > It always got the following error:
> > > [    1.248364] imx-gpc 20dc000.gpc: could not find pgc DT node
> > > This patch adds back the legecy support.
> > 
> > This patch removes a safeguard against abusing the old binding for new
> > SoCs. Please leave this check in place and instead loosen the check to
> > also allow the old i.MX6SL binding.
> > 
> 
> Thanks for the reminder.
> I found beside the checking, we probably also need some extra fix that
> the current imx_gpc_old_dt_init() only supports two domains while the
> driver formerly supports three for MX6SL.
> 
> And because the num_domains is defined by driver itself, no need check
> in imx_gpc_old_dt_init() anymore.
> 
> The patch would be as follows:
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index 4885ec2..6a806a1 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -303,10 +303,13 @@ static struct genpd_onecell_data imx_gpc_onecell_data = {
>  
>  static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap)
>  {
> +       const struct of_device_id *of_id =
> +                       of_match_device(imx_gpc_dt_ids, dev);
> +       const struct imx_gpc_dt_data *of_id_data = of_id->data;
>         struct imx_pm_domain *domain;
>         int i, ret;
>  
> -       for (i = 0; i < 2; i++) {
> +       for (i = 0; i < of_id_data->num_domains; i++) {
>                 domain = &imx_gpc_domains[i];
>                 domain->regmap = regmap;
>                 domain->ipg_rate_mhz = 66;
> @@ -324,7 +327,7 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap)
>                 }
>         }
>  
> -       for (i = 0; i < 2; i++)
> +       for (i = 0; i < of_id_data->num_domains; i++)
>                 pm_genpd_init(&imx_gpc_domains[i].base, NULL, false);
>  
>         if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
> @@ -337,7 +340,7 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap)
>         return 0;
>  
>  genpd_err:
> -       for (i = 0; i < 2; i++)
> +       for (i = 0; i < of_id_data->num_domains; i++)
>                 pm_genpd_remove(&imx_gpc_domains[i].base);
>         imx_pgc_put_clocks(&imx_gpc_domains[1]);
>  clk_err:
> 
> Do you think it's ok?
> 
I don't like the redundant of_match_id. Please just pass num_domains as
a parameter to imx_gpc_old_dt_init(). Otherwise this looks good.

Regards,
Lucas
