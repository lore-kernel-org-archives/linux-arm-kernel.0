From: dongas86@gmail.com (Dong Aisheng)
Date: Mon, 8 Jan 2018 18:28:55 +0800
Subject: [PATCH] soc: imx: gpc: de-register power domains only if
 initialized
In-Reply-To: <20180107134905.15624-1-stefan@agner.ch>
References: <20180107134905.15624-1-stefan@agner.ch>
Message-ID: <20180108102855.GA32635@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 07, 2018 at 02:49:05PM +0100, Stefan Agner wrote:
> If power domain information are missing in the device tree, no
> power domains get initialized. However, imx_gpc_remove tries to
> remove power domains always in the old DT binding case. Only
> remove power domains when imx_gpc_probe initialized them in
> first place.
> 
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/soc/imx/gpc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index 53f7275d6cbd..62bb724726d9 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -470,13 +470,21 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  
>  static int imx_gpc_remove(struct platform_device *pdev)
>  {

What's the original purpose of imx_gpc_remove?
ARM power domain can't be removed.

And why current imx_gpc_remove only remove domains for old DT but not
for new ones?

How about make it un-removable?
e.g.

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 47e7aa9..7fc6737 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -454,36 +454,17 @@ static int imx_gpc_probe(struct platform_device *pdev)
        return 0;
 }
 
-static int imx_gpc_remove(struct platform_device *pdev)
-{
-       int ret;
-
-       /*
-        * If the old DT binding is used the toplevel driver needs to
-        * de-register the power domains
-        */
-       if (!of_get_child_by_name(pdev->dev.of_node, "pgc")) {
-               of_genpd_del_provider(pdev->dev.of_node);
-
-               ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base);
-               if (ret)
-                       return ret;
-               imx_pgc_put_clocks(&imx_gpc_domains[GPC_PGC_DOMAIN_PU]);
-
-               ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_ARM].base);
-               if (ret)
-                       return ret;
-       }
-
-       return 0;
-}
-
 static struct platform_driver imx_gpc_driver = {
        .driver = {
                .name = "imx-gpc",
                .of_match_table = imx_gpc_dt_ids,
+                /*
+                 * We can't forcibly eject devices form power domain,
+                 * so we can't really remove power domains once they
+                 * were added.
+                 */
+                .suppress_bind_attrs = true,
        },
        .probe = imx_gpc_probe,
-       .remove = imx_gpc_remove,
 };
 builtin_platform_driver(imx_gpc_driver)

Regards
Dong Aisheng

> +	struct device_node *pgc_node;
>  	int ret;
>  
> +	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
> +
> +	/* bail out if DT too old and doesn't provide the necessary info */
> +	if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells") &&
> +	    !pgc_node)
> +		return 0;
> +
>  	/*
>  	 * If the old DT binding is used the toplevel driver needs to
>  	 * de-register the power domains
>  	 */
> -	if (!of_get_child_by_name(pdev->dev.of_node, "pgc")) {
> +	if (!pgc_node) {
>  		of_genpd_del_provider(pdev->dev.of_node);
>  
>  		ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base);
> -- 
> 2.15.1
> 
