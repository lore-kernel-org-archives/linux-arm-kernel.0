From: aisheng.dong@nxp.com (A.S. Dong)
Date: Wed, 29 Mar 2017 16:08:02 +0000
Subject: [PATCH 2/2] soc/imx: add workaround for i.MX6QP to the GPC PD
 driver
In-Reply-To: <20170323144418.30977-3-l.stach@pengutronix.de>
References: <20170323144418.30977-1-l.stach@pengutronix.de>
 <20170323144418.30977-3-l.stach@pengutronix.de>
Message-ID: <DB5PR04MB1431A7CC91F55ECFE5BE31FB80350@DB5PR04MB1431.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

> -----Original Message-----
> From: Lucas Stach [mailto:l.stach at pengutronix.de]
> Sent: Thursday, March 23, 2017 10:44 PM
> To: Shawn Guo
> Cc: Fabio Estevam; A.S. Dong; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; kernel at pengutronix.de; patchwork-
> lst at pengutronix.de
> Subject: [PATCH 2/2] soc/imx: add workaround for i.MX6QP to the GPC PD
> driver
> 
> On i.MX6QP, due to hardware erratum ERR009619, the PRE clocks may be
> stalled during the power up sequencing of the PU power domain. As this may
> lead to a complete loss of display output, the recommended workaround is
> to keep the PU domain enabled during normal system operation.
> 
> Implement this by rejecting the domain power down request on the affected
> SoC.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/soc/imx/gpc.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c index
> 4294287e5f6c..599e1e46f694 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -45,6 +45,7 @@ struct imx_pm_domain {
>  	unsigned int reg_offs;
>  	signed char cntr_pdn_bit;
>  	unsigned int ipg_rate_mhz;
> +	bool allow_dynamic_pd;
>  };
> 
>  static inline struct imx_pm_domain *
> @@ -59,6 +60,9 @@ static int imx6_pm_domain_power_off(struct
> generic_pm_domain *genpd)
>  	int iso, iso2sw;
>  	u32 val;
> 
> +	if (!pd->allow_dynamic_pd)
> +		return -EBUSY;
> +
>  	/* Read ISO and ISO2SW power down delays */
>  	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
>  	iso = val & 0x3f;
> @@ -255,6 +259,7 @@ static struct imx_pm_domain imx_gpc_domains[] = {
>  		},
>  		.reg_offs = 0x260,
>  		.cntr_pdn_bit = 0,
> +		.allow_dynamic_pd = true,
>  	}, {
>  		.base = {
>  			.name = "DISPLAY",
> @@ -263,23 +268,33 @@ static struct imx_pm_domain imx_gpc_domains[] = {
>  		},
>  		.reg_offs = 0x240,
>  		.cntr_pdn_bit = 4,
> +		.allow_dynamic_pd = true,

Just a Nitpick, besides shawn's comment in another mail,
if we use a domain flag like IMX_PD_ALWAYS_ON set by SoC errata flag,
then probably we can save all the default allow_dynamic_pd lines.
This also release the life when adding new domains.

Otherwise, the two patch seems good to me.

Regards
Dong Aisheng

>  	}
>  };
> 
>  struct imx_gpc_dt_data {
>  	int num_domains;
> +	bool err009619_present;
>  };
> 
>  static const struct imx_gpc_dt_data imx6q_dt_data = {
>  	.num_domains = 2,
> +	.err009619_present = false,
> +};
> +
> +static const struct imx_gpc_dt_data imx6qp_dt_data = {
> +	.num_domains = 2,
> +	.err009619_present = true,
>  };
> 
>  static const struct imx_gpc_dt_data imx6sl_dt_data = {
>  	.num_domains = 3,
> +	.err009619_present = false,
>  };
> 
>  static const struct of_device_id imx_gpc_dt_ids[] = {
>  	{ .compatible = "fsl,imx6q-gpc", .data = &imx6q_dt_data },
> +	{ .compatible = "fsl,imx6qp-gpc", .data = &imx6qp_dt_data },
>  	{ .compatible = "fsl,imx6sl-gpc", .data = &imx6sl_dt_data },
>  	{ }
>  };
> @@ -377,6 +392,10 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
> 
> +	/* Disable PU power down in normal operation if ERR009619 is present
> */
> +	if (of_id_data->err009619_present)
> +		imx_gpc_domains[1].allow_dynamic_pd = false;
> +
>  	if (!pgc_node) {
>  		ret = imx_gpc_old_dt_init(&pdev->dev, regmap,
>  					  of_id_data->num_domains);
> --
> 2.11.0
