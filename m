From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 17 Oct 2017 18:16:24 +0800
Subject: [RFC PATCH v4 8/8] drm/rockchip: Add device links for master and
 components
In-Reply-To: <20171017101624.12506-1-jeffy.chen@rock-chips.com>
References: <20171017101624.12506-1-jeffy.chen@rock-chips.com>
Message-ID: <20171017101624.12506-9-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we are trying to access components' resources in the master's
suspend/resume PM callbacks(e.g. panel), add device links to correct
the suspend/resume and shutdown ordering.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
Use device link to correct the suspend/resume and shutdown ordering,
instead of converting rockchip spi's suspend/resume PM callbacks to
late suspend/resume PM callbacks.

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 76d63de5921d..af18967f699b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -337,6 +337,8 @@ static struct component_match *rockchip_drm_match_add(struct device *dev)
 
 			if (!d)
 				break;
+
+			device_link_add(dev, d, DL_FLAG_STATELESS);
 			component_match_add(dev, &match, compare_dev, d);
 		} while (true);
 	}
@@ -406,6 +408,7 @@ static int rockchip_drm_platform_of_probe(struct device *dev)
 static int rockchip_drm_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_link *link;
 	struct component_match *match = NULL;
 	int ret;
 
@@ -414,16 +417,31 @@ static int rockchip_drm_platform_probe(struct platform_device *pdev)
 		return ret;
 
 	match = rockchip_drm_match_add(dev);
-	if (IS_ERR(match))
-		return PTR_ERR(match);
+	if (IS_ERR(match)) {
+		ret = PTR_ERR(match);
+		goto err_cleanup_dev_links;
+	}
 
-	return component_master_add_with_match(dev, &rockchip_drm_ops, match);
+	ret = component_master_add_with_match(dev, &rockchip_drm_ops, match);
+	if (ret < 0)
+		goto err_cleanup_dev_links;
+
+	return 0;
+err_cleanup_dev_links:
+	list_for_each_entry(link, &dev->links.consumers, s_node)
+		device_link_del(link);
+	return ret;
 }
 
 static int rockchip_drm_platform_remove(struct platform_device *pdev)
 {
+	struct device_link *link;
+
 	component_master_del(&pdev->dev, &rockchip_drm_ops);
 
+	list_for_each_entry(link, &pdev->dev.links.consumers, s_node)
+		device_link_del(link);
+
 	return 0;
 }
 
-- 
2.11.0
