From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 09 Jan 2018 16:25:17 +0100
Subject: [PATCH] soc: imx: gpc: de-register power domains only if
 initialized
In-Reply-To: <20180107134905.15624-1-stefan@agner.ch>
References: <20180107134905.15624-1-stefan@agner.ch>
Message-ID: <1515511517.12538.38.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, den 07.01.2018, 14:49 +0100 schrieb Stefan Agner:
> If power domain information are missing in the device tree, no
> power domains get initialized. However, imx_gpc_remove tries to
> remove power domains always in the old DT binding case. Only
> remove power domains when imx_gpc_probe initialized them in
> first place.
> 
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC
> driver")
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> ?drivers/soc/imx/gpc.c | 10 +++++++++-
> ?1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index 53f7275d6cbd..62bb724726d9 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -470,13 +470,21 @@ static int imx_gpc_probe(struct platform_device
> *pdev)
> ?
> ?static int imx_gpc_remove(struct platform_device *pdev)
> ?{
> +	struct device_node *pgc_node;
> ?	int ret;
> ?
> +	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
> +
> +	/* bail out if DT too old and doesn't provide the necessary
> info */
> +	if (!of_property_read_bool(pdev->dev.of_node, "#power-
> domain-cells") &&
> +	????!pgc_node)
> +		return 0;
> +
> ?	/*
> ?	?* If the old DT binding is used the toplevel driver needs
> to
> ?	?* de-register the power domains
> ?	?*/
> -	if (!of_get_child_by_name(pdev->dev.of_node, "pgc")) {
> +	if (!pgc_node) {
> ?		of_genpd_del_provider(pdev->dev.of_node);
> ?
> ?		ret =
> pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base);
