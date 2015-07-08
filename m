From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 8 Jul 2015 15:59:34 +0300
Subject: [PATCH 03/10] drm: exynos_hdmi: use of_get_i2c_adapter_by_node
 interface
In-Reply-To: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1436360374-9275-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change is needed to properly lock I2C bus driver, which serves DDC.

On release of_get_i2c_adapter_by_node() requires i2c_put_adapter() call,
which replaces put_device(). By the way added of_node_put(ddc_node) to
eliminate memory leak, if OF_DYNAMIC is enabled.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 99e2864..399eff9 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -2407,7 +2407,8 @@ static int hdmi_probe(struct platform_device *pdev)
 	}
 
 out_get_ddc_adpt:
-	hdata->ddc_adpt = of_find_i2c_adapter_by_node(ddc_node);
+	hdata->ddc_adpt = of_get_i2c_adapter_by_node(ddc_node);
+	of_node_put(ddc_node);
 	if (!hdata->ddc_adpt) {
 		DRM_ERROR("Failed to get ddc i2c adapter by node\n");
 		return -EPROBE_DEFER;
@@ -2485,7 +2486,7 @@ err_hdmiphy:
 	if (hdata->hdmiphy_port)
 		put_device(&hdata->hdmiphy_port->dev);
 err_ddc:
-	put_device(&hdata->ddc_adpt->dev);
+	i2c_put_adapter(hdata->ddc_adpt);
 
 	return ret;
 }
@@ -2501,7 +2502,7 @@ static int hdmi_remove(struct platform_device *pdev)
 
 	if (hdata->hdmiphy_port)
 		put_device(&hdata->hdmiphy_port->dev);
-	put_device(&hdata->ddc_adpt->dev);
+	i2c_put_adapter(hdata->ddc_adpt);
 
 	pm_runtime_disable(&pdev->dev);
 	component_del(&pdev->dev, &hdmi_component_ops);
-- 
2.1.4
