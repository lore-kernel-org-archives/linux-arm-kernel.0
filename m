From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 10 Dec 2014 16:48:29 +0100
Subject: [RFC 11/15] drm/exynos/dsi: convert to restrack API
In-Reply-To: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1418226513-14105-12-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert exynos_dsi driver to use restrack API.
As a result driver have following advantages:
- correctly handles removal of resources,
- do not need to defer probing, so as a result the whole drm system
  initialization will not be postponed to late initcall, unless other
  components delays it,
- simplified initialization.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 52 +++++++++++++--------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 8201d79..53ac467 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -23,7 +23,7 @@
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
 #include <linux/component.h>
-
+#include <linux/restrack.h>
 #include <video/mipi_display.h>
 #include <video/videomode.h>
 
@@ -1690,9 +1690,18 @@ static const struct component_ops exynos_dsi_component_ops = {
 	.unbind	= exynos_dsi_unbind,
 };
 
+void exynos_dsi_restrack_cb(struct device *dev, int ret)
+{
+	if (ret)
+		component_del(dev, &exynos_dsi_component_ops);
+	else
+		component_add(dev, &exynos_dsi_component_ops);
+}
+
 static int exynos_dsi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct restrack_ctx *rtrack;
 	struct resource *res;
 	struct exynos_dsi *dsi;
 	int ret;
@@ -1728,26 +1737,6 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 
 	dsi->supplies[0].supply = "vddcore";
 	dsi->supplies[1].supply = "vddio";
-	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(dsi->supplies),
-				      dsi->supplies);
-	if (ret) {
-		dev_info(dev, "failed to get regulators: %d\n", ret);
-		return -EPROBE_DEFER;
-	}
-
-	dsi->pll_clk = devm_clk_get(dev, "pll_clk");
-	if (IS_ERR(dsi->pll_clk)) {
-		dev_info(dev, "failed to get dsi pll input clock\n");
-		ret = PTR_ERR(dsi->pll_clk);
-		goto err_del_component;
-	}
-
-	dsi->bus_clk = devm_clk_get(dev, "bus_clk");
-	if (IS_ERR(dsi->bus_clk)) {
-		dev_info(dev, "failed to get dsi bus clock\n");
-		ret = PTR_ERR(dsi->bus_clk);
-		goto err_del_component;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dsi->reg_base = devm_ioremap_resource(dev, res);
@@ -1757,13 +1746,6 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 		goto err_del_component;
 	}
 
-	dsi->phy = devm_phy_get(dev, "dsim");
-	if (IS_ERR(dsi->phy)) {
-		dev_info(dev, "failed to get dsim phy\n");
-		ret = PTR_ERR(dsi->phy);
-		goto err_del_component;
-	}
-
 	dsi->irq = platform_get_irq(pdev, 0);
 	if (dsi->irq < 0) {
 		dev_err(dev, "failed to request dsi irq resource\n");
@@ -1782,11 +1764,20 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, &dsi->display);
 
-	ret = component_add(dev, &exynos_dsi_component_ops);
+	rtrack = devm_restrack_register(dsi->dev, exynos_dsi_restrack_cb,
+		regulator_bulk_restrack_desc(&dsi->supplies[0]),
+		regulator_bulk_restrack_desc(&dsi->supplies[1]),
+		clk_restrack_desc(&dsi->pll_clk, "pll_clk"),
+		clk_restrack_desc(&dsi->bus_clk, "bus_clk"),
+		phy_restrack_desc(&dsi->phy, "dsim"),
+	);
+
+	ret = PTR_ERR_OR_ZERO(rtrack);
+
 	if (ret)
 		goto err_del_component;
 
-	return ret;
+	return 0;
 
 err_del_component:
 	exynos_drm_component_del(dev, EXYNOS_DEVICE_TYPE_CONNECTOR);
@@ -1795,7 +1786,6 @@ err_del_component:
 
 static int exynos_dsi_remove(struct platform_device *pdev)
 {
-	component_del(&pdev->dev, &exynos_dsi_component_ops);
 	exynos_drm_component_del(&pdev->dev, EXYNOS_DEVICE_TYPE_CONNECTOR);
 
 	return 0;
-- 
1.9.1
