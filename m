From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 28 Aug 2018 16:36:46 +0800
Subject: [PATCH V2 2/2] soc: imx: gpcv2: make pgc driver more generic for
 other i.MX platforms
In-Reply-To: <1535445406-19633-1-git-send-email-Anson.Huang@nxp.com>
References: <1535445406-19633-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1535445406-19633-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX8MQ and i.MX8MM share same gpc module with i.MX7D, they
can reuse gpcv2 pgc driver for power domain control, this
patch renames all functions and structure definitions started
with "imx7" to "imx", and use .data in imx_gpcv2_dt_ids[] to
pass platform specific power domain data for power domain
driver, thus make gpcv2 pgc driver more generic for i.MX
platforms.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
changes since V1:
	use .data in imx_gpcv2_dt_ids[] instead of calling
	of_machine_is_compatible() for different platforms support.
 drivers/soc/imx/gpcv2.c | 72 +++++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 0e31465..938103a 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -14,6 +14,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
@@ -53,7 +54,7 @@
 
 #define GPC_PGC_CTRL_PCR		BIT(0)
 
-struct imx7_pgc_domain {
+struct imx_pgc_domain {
 	struct generic_pm_domain genpd;
 	struct regmap *regmap;
 	struct regulator *regulator;
@@ -69,11 +70,16 @@ struct imx7_pgc_domain {
 	struct device *dev;
 };
 
-static int imx7_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
+struct imx_pgc_domain_data {
+	const struct imx_pgc_domain *domains;
+	size_t domains_num;
+};
+
+static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 				      bool on)
 {
-	struct imx7_pgc_domain *domain = container_of(genpd,
-						      struct imx7_pgc_domain,
+	struct imx_pgc_domain *domain = container_of(genpd,
+						      struct imx_pgc_domain,
 						      genpd);
 	unsigned int offset = on ?
 		GPC_PU_PGC_SW_PUP_REQ : GPC_PU_PGC_SW_PDN_REQ;
@@ -150,17 +156,17 @@ static int imx7_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 	return ret;
 }
 
-static int imx7_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
+static int imx_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
 {
-	return imx7_gpc_pu_pgc_sw_pxx_req(genpd, true);
+	return imx_gpc_pu_pgc_sw_pxx_req(genpd, true);
 }
 
-static int imx7_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
+static int imx_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
 {
-	return imx7_gpc_pu_pgc_sw_pxx_req(genpd, false);
+	return imx_gpc_pu_pgc_sw_pxx_req(genpd, false);
 }
 
-static const struct imx7_pgc_domain imx7_pgc_domains[] = {
+static const struct imx_pgc_domain imx7_pgc_domains[] = {
 	[IMX7_POWER_DOMAIN_MIPI_PHY] = {
 		.genpd = {
 			.name      = "mipi-phy",
@@ -198,9 +204,14 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
 	},
 };
 
-static int imx7_pgc_domain_probe(struct platform_device *pdev)
+static const struct imx_pgc_domain_data imx7_pgc_domain_data = {
+	.domains = imx7_pgc_domains,
+	.domains_num = ARRAY_SIZE(imx7_pgc_domains),
+};
+
+static int imx_pgc_domain_probe(struct platform_device *pdev)
 {
-	struct imx7_pgc_domain *domain = pdev->dev.platform_data;
+	struct imx_pgc_domain *domain = pdev->dev.platform_data;
 	int ret;
 
 	domain->dev = &pdev->dev;
@@ -233,9 +244,9 @@ static int imx7_pgc_domain_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx7_pgc_domain_remove(struct platform_device *pdev)
+static int imx_pgc_domain_remove(struct platform_device *pdev)
 {
-	struct imx7_pgc_domain *domain = pdev->dev.platform_data;
+	struct imx_pgc_domain *domain = pdev->dev.platform_data;
 
 	of_genpd_del_provider(domain->dev->of_node);
 	pm_genpd_remove(&domain->genpd);
@@ -243,23 +254,24 @@ static int imx7_pgc_domain_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct platform_device_id imx7_pgc_domain_id[] = {
-	{ "imx7-pgc-domain", },
+static const struct platform_device_id imx_pgc_domain_id[] = {
+	{ "imx-pgc-domain", },
 	{ },
 };
 
-static struct platform_driver imx7_pgc_domain_driver = {
+static struct platform_driver imx_pgc_domain_driver = {
 	.driver = {
-		.name = "imx7-pgc",
+		.name = "imx-pgc",
 	},
-	.probe    = imx7_pgc_domain_probe,
-	.remove   = imx7_pgc_domain_remove,
-	.id_table = imx7_pgc_domain_id,
+	.probe    = imx_pgc_domain_probe,
+	.remove   = imx_pgc_domain_remove,
+	.id_table = imx_pgc_domain_id,
 };
-builtin_platform_driver(imx7_pgc_domain_driver)
+builtin_platform_driver(imx_pgc_domain_driver)
 
 static int imx_gpcv2_probe(struct platform_device *pdev)
 {
+	static const struct imx_pgc_domain_data *domain_data;
 	static const struct regmap_range yes_ranges[] = {
 		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
 				 GPC_M4_PU_PDN_FLG),
@@ -307,9 +319,11 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	domain_data = of_device_get_match_data(&pdev->dev);
+
 	for_each_child_of_node(pgc_np, np) {
 		struct platform_device *pd_pdev;
-		struct imx7_pgc_domain *domain;
+		struct imx_pgc_domain *domain;
 		u32 domain_index;
 
 		ret = of_property_read_u32(np, "reg", &domain_index);
@@ -319,14 +333,14 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		if (domain_index >= ARRAY_SIZE(imx7_pgc_domains)) {
+		if (domain_index >= domain_data->domains_num) {
 			dev_warn(dev,
 				 "Domain index %d is out of bounds\n",
 				 domain_index);
 			continue;
 		}
 
-		pd_pdev = platform_device_alloc("imx7-pgc-domain",
+		pd_pdev = platform_device_alloc("imx-pgc-domain",
 						domain_index);
 		if (!pd_pdev) {
 			dev_err(dev, "Failed to allocate platform device\n");
@@ -335,8 +349,8 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		}
 
 		ret = platform_device_add_data(pd_pdev,
-					       &imx7_pgc_domains[domain_index],
-					       sizeof(imx7_pgc_domains[domain_index]));
+					       &domain_data->domains[domain_index],
+					       sizeof(domain_data->domains[domain_index]));
 		if (ret) {
 			platform_device_put(pd_pdev);
 			of_node_put(np);
@@ -345,8 +359,8 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 
 		domain = pd_pdev->dev.platform_data;
 		domain->regmap = regmap;
-		domain->genpd.power_on  = imx7_gpc_pu_pgc_sw_pup_req;
-		domain->genpd.power_off = imx7_gpc_pu_pgc_sw_pdn_req;
+		domain->genpd.power_on  = imx_gpc_pu_pgc_sw_pup_req;
+		domain->genpd.power_off = imx_gpc_pu_pgc_sw_pdn_req;
 
 		pd_pdev->dev.parent = dev;
 		pd_pdev->dev.of_node = np;
@@ -363,7 +377,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx_gpcv2_dt_ids[] = {
-	{ .compatible = "fsl,imx7d-gpc" },
+	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
 	{ }
 };
 
-- 
2.7.4
