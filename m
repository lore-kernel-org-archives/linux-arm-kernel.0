From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sat, 17 Nov 2018 10:12:05 -0800
Subject: [PATCH 2/3] soc: imx: gpcv2: Make regmap access table variant
 specific.
In-Reply-To: <20181117181206.10267-1-andrew.smirnov@gmail.com>
References: <20181117181206.10267-1-andrew.smirnov@gmail.com>
Message-ID: <20181117181206.10267-3-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move regmap access table to be a part of struct imx_pgc_domain_data in
order to allow supporting multiple GPCv2 variants.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy at gmail.com
Cc: l.stach at pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx at nxp.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/soc/imx/gpcv2.c | 43 +++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 0835999f1ed0..184ffd4cc9aa 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -67,6 +67,7 @@ struct imx_pgc_domain {
 struct imx_pgc_domain_data {
 	const struct imx_pgc_domain *domains;
 	size_t domains_num;
+	struct regmap_access_table access_table;
 };
 
 static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
@@ -198,9 +199,24 @@ static const struct imx_pgc_domain imx7_pgc_domains[] = {
 	},
 };
 
+static const struct regmap_range imx7_yes_ranges[] = {
+	regmap_reg_range(GPC_LPCR_A_CORE_BSC,
+			 GPC_M4_PU_PDN_FLG),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_MIPI),
+			 GPC_PGC_SR(PGC_MIPI)),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_PCIE),
+			 GPC_PGC_SR(PGC_PCIE)),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_USB_HSIC),
+			 GPC_PGC_SR(PGC_USB_HSIC)),
+};
+
 static const struct imx_pgc_domain_data imx7_pgc_domain_data = {
 	.domains = imx7_pgc_domains,
 	.domains_num = ARRAY_SIZE(imx7_pgc_domains),
+	.access_table = {
+		.yes_ranges	= yes_ranges,
+		.n_yes_ranges	= ARRAY_SIZE(yes_ranges),
+	},
 };
 
 static int imx_pgc_domain_probe(struct platform_device *pdev)
@@ -265,30 +281,17 @@ builtin_platform_driver(imx_pgc_domain_driver)
 
 static int imx_gpcv2_probe(struct platform_device *pdev)
 {
-	const struct imx_pgc_domain_data *domain_data;
-	static const struct regmap_range yes_ranges[] = {
-		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
-				 GPC_M4_PU_PDN_FLG),
-		regmap_reg_range(GPC_PGC_CTRL(PGC_MIPI),
-				 GPC_PGC_SR(PGC_MIPI)),
-		regmap_reg_range(GPC_PGC_CTRL(PGC_PCIE),
-				 GPC_PGC_SR(PGC_PCIE)),
-		regmap_reg_range(GPC_PGC_CTRL(PGC_USB_HSIC),
-				 GPC_PGC_SR(PGC_USB_HSIC)),
-	};
-	static const struct regmap_access_table access_table = {
-		.yes_ranges	= yes_ranges,
-		.n_yes_ranges	= ARRAY_SIZE(yes_ranges),
-	};
-	static const struct regmap_config regmap_config = {
+	struct device *dev = &pdev->dev;
+	const struct imx_pgc_domain_data *
+		domain_data = of_device_get_match_data(dev);
+	const struct regmap_config regmap_config = {
 		.reg_bits	= 32,
 		.val_bits	= 32,
 		.reg_stride	= 4,
-		.rd_table	= &access_table,
-		.wr_table	= &access_table,
+		.rd_table	= &domain_data->access_table,
+		.wr_table	= &domain_data->access_table,
 		.max_register   = SZ_4K,
 	};
-	struct device *dev = &pdev->dev;
 	struct device_node *pgc_np, *np;
 	struct regmap *regmap;
 	struct resource *res;
@@ -313,8 +316,6 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	domain_data = of_device_get_match_data(&pdev->dev);
-
 	for_each_child_of_node(pgc_np, np) {
 		struct platform_device *pd_pdev;
 		struct imx_pgc_domain *domain;
-- 
2.19.1
