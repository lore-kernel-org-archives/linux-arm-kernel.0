From: woogyom.kim@gmail.com (Milo Kim)
Date: Wed, 24 Aug 2016 11:25:24 +0900
Subject: [PATCH v2 4/4] gpu: drm: exynos_hdmi: Use consolidated function on
 binding PHY DT property
In-Reply-To: <1472005524-3489-1-git-send-email-woogyom.kim@gmail.com>
References: <1472005524-3489-1-git-send-email-woogyom.kim@gmail.com>
Message-ID: <1472005524-3489-5-git-send-email-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handle legacy and raw 'phy' parsing in single function.
And it also removes goto condition.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: dri-devel at lists.freedesktop.org
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 6a636f2..bb2d6d4 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1778,11 +1778,22 @@ static struct device_node *hdmi_ddc_dt_binding(struct device *dev)
 	return np;
 }
 
-static struct device_node *hdmi_legacy_phy_dt_binding(struct device *dev)
+static struct device_node *hdmi_phy_dt_binding(struct device *dev)
 {
 	const char *compatible_str = "samsung,exynos4212-hdmiphy";
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, compatible_str);
+	if (np)
+		return np;
+
+	np = of_parse_phandle(dev->of_node, "phy", 0);
+	if (!np)
+		return NULL;
+
+	of_node_put(dev->of_node);
 
-	return of_find_compatible_node(NULL, NULL, compatible_str);
+	return np;
 }
 
 static int hdmi_probe(struct platform_device *pdev)
@@ -1829,19 +1840,13 @@ static int hdmi_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
-	phy_node = hdmi_legacy_phy_dt_binding(dev);
-	if (phy_node)
-		goto out_get_phy_port;
-
-	phy_node = of_parse_phandle(dev->of_node, "phy", 0);
+	phy_node = hdmi_phy_dt_binding(dev);
 	if (!phy_node) {
 		DRM_ERROR("Failed to find hdmiphy node in device tree\n");
 		ret = -ENODEV;
 		goto err_ddc;
 	}
-	of_node_put(dev->of_node);
 
-out_get_phy_port:
 	if (hdata->drv_data->is_apb_phy) {
 		hdata->regs_hdmiphy = of_iomap(phy_node, 0);
 		if (!hdata->regs_hdmiphy) {
-- 
1.9.1
