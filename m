From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed,  5 Apr 2017 15:19:07 +0200
Subject: [PATCH v2 1/3] soc: imx: gpc: add defines for domain index
Message-ID: <20170405131909.16880-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Makes referencing a specfic domain in the driver code
less error prone.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2: new patch
---
 drivers/soc/imx/gpc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 4294287e5f6c..d4ebb325b558 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -235,6 +235,10 @@ static struct platform_driver imx_pgc_power_domain_driver = {
 };
 builtin_platform_driver(imx_pgc_power_domain_driver)
 
+#define GPC_PGC_DOMAIN_ARM	0
+#define GPC_PGC_DOMAIN_PU	1
+#define GPC_PGC_DOMAIN_DISPLAY	2
+
 static struct genpd_power_state imx6_pm_domain_pu_state = {
 	.power_off_latency_ns = 25000,
 	.power_on_latency_ns = 2000000,
@@ -340,7 +344,7 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
 genpd_err:
 	for (i = 0; i < num_domains; i++)
 		pm_genpd_remove(&imx_gpc_domains[i].base);
-	imx_pgc_put_clocks(&imx_gpc_domains[1]);
+	imx_pgc_put_clocks(&imx_gpc_domains[GPC_PGC_DOMAIN_PU]);
 clk_err:
 	return ret;
 }
@@ -441,12 +445,12 @@ static int imx_gpc_remove(struct platform_device *pdev)
 	if (!of_get_child_by_name(pdev->dev.of_node, "pgc")) {
 		of_genpd_del_provider(pdev->dev.of_node);
 
-		ret = pm_genpd_remove(&imx_gpc_domains[1].base);
+		ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base);
 		if (ret)
 			return ret;
-		imx_pgc_put_clocks(&imx_gpc_domains[1]);
+		imx_pgc_put_clocks(&imx_gpc_domains[GPC_PGC_DOMAIN_PU]);
 
-		ret = pm_genpd_remove(&imx_gpc_domains[0].base);
+		ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_ARM].base);
 		if (ret)
 			return ret;
 	}
-- 
2.11.0
