From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 16 Nov 2018 16:49:26 +0100
Subject: [PATCH 2/3] soc: imx: gpcv2: move register access table to domain data
In-Reply-To: <20181116154927.16152-1-l.stach@pengutronix.de>
References: <20181116154927.16152-1-l.stach@pengutronix.de>
Message-ID: <20181116154927.16152-2-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The valid register ranges are defined by the implemented power domains,
which are different between the individual SoCs where the GPCv2 is used.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/soc/imx/gpcv2.c | 44 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 4183f7f830c8..fe2cf6b61b05 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -67,6 +67,7 @@ struct imx_pgc_domain {
 struct imx_pgc_domain_data {
 	const struct imx_pgc_domain *domains;
 	size_t domains_num;
+	const struct regmap_access_table *reg_access_table;
 };
 
 static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
@@ -198,9 +199,26 @@ static const struct imx_pgc_domain imx7_pgc_domains[] = {
 	},
 };
 
+static const struct regmap_range imx7_yes_ranges[] = {
+		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
+				 GPC_M4_PU_PDN_FLG),
+		regmap_reg_range(GPC_PGC_CTRL(IMX7_PGC_MIPI),
+				 GPC_PGC_SR(IMX7_PGC_MIPI)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX7_PGC_PCIE),
+				 GPC_PGC_SR(IMX7_PGC_PCIE)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX7_PGC_USB_HSIC),
+				 GPC_PGC_SR(IMX7_PGC_USB_HSIC)),
+};
+
+static const struct regmap_access_table imx7_access_table = {
+	.yes_ranges	= imx7_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(imx7_yes_ranges),
+};
+
 static const struct imx_pgc_domain_data imx7_pgc_domain_data = {
 	.domains = imx7_pgc_domains,
 	.domains_num = ARRAY_SIZE(imx7_pgc_domains),
+	.reg_access_table = &imx7_access_table,
 };
 
 static int imx_pgc_domain_probe(struct platform_device *pdev)
@@ -265,27 +283,15 @@ builtin_platform_driver(imx_pgc_domain_driver)
 
 static int imx_gpcv2_probe(struct platform_device *pdev)
 {
-	static const struct imx_pgc_domain_data *domain_data;
-	static const struct regmap_range yes_ranges[] = {
-		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
-				 GPC_M4_PU_PDN_FLG),
-		regmap_reg_range(GPC_PGC_CTRL(IMX7_PGC_MIPI),
-				 GPC_PGC_SR(IMX7_PGC_MIPI)),
-		regmap_reg_range(GPC_PGC_CTRL(IMX7_PGC_PCIE),
-				 GPC_PGC_SR(IMX7_PGC_PCIE)),
-		regmap_reg_range(GPC_PGC_CTRL(IMX7_PGC_USB_HSIC),
-				 GPC_PGC_SR(IMX7_PGC_USB_HSIC)),
-	};
-	static const struct regmap_access_table access_table = {
-		.yes_ranges	= yes_ranges,
-		.n_yes_ranges	= ARRAY_SIZE(yes_ranges),
-	};
-	static const struct regmap_config regmap_config = {
+	const struct imx_pgc_domain_data *domain_data =
+			of_device_get_match_data(&pdev->dev);
+
+	struct regmap_config regmap_config = {
 		.reg_bits	= 32,
 		.val_bits	= 32,
 		.reg_stride	= 4,
-		.rd_table	= &access_table,
-		.wr_table	= &access_table,
+		.rd_table	= domain_data->reg_access_table,
+		.wr_table	= domain_data->reg_access_table,
 		.max_register   = SZ_4K,
 	};
 	struct device *dev = &pdev->dev;
@@ -313,8 +319,6 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	domain_data = of_device_get_match_data(&pdev->dev);
-
 	for_each_child_of_node(pgc_np, np) {
 		struct platform_device *pd_pdev;
 		struct imx_pgc_domain *domain;
-- 
2.19.1
