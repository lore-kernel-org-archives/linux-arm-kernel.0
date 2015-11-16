From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 16 Nov 2015 14:44:52 +0000
Subject: [PATCH 1/2] drm: Improve drm_of_component_probe() to correctly handle
 ports and remote ports.
In-Reply-To: <1447685093-26129-1-git-send-email-Liviu.Dudau@arm.com>
References: <1447685093-26129-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1447685093-26129-2-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip DRM driver cannot use the same compare_of() function to match
ports and remote ports (aka encoders) as their OF sub-trees look different.
Add a second compare function to be used when encoders are added to the
component framework and patch the existing users of the function
accordingly.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/gpu/drm/armada/armada_drv.c |  3 ++-
 drivers/gpu/drm/drm_of.c            | 23 ++++++++++++++++++-----
 drivers/gpu/drm/imx/imx-drm-core.c  |  3 ++-
 include/drm/drm_of.h                |  6 ++++--
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 77ab93d..3a2a929 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -274,7 +274,8 @@ static int armada_drm_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	ret = drm_of_component_probe(dev, compare_dev_name, &armada_master_ops);
+	ret = drm_of_component_probe(dev, compare_dev_name, compare_dev_name,
+				     &armada_master_ops);
 	if (ret != -EINVAL)
 		return ret;
 
diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 493c05c..58fafd7 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -77,7 +77,8 @@ EXPORT_SYMBOL(drm_of_find_possible_crtcs);
  * Returns zero if successful, or one of the standard error codes if it fails.
  */
 int drm_of_component_probe(struct device *dev,
-			   int (*compare_of)(struct device *, void *),
+			   int (*compare_port)(struct device *, void *),
+			   int (*compare_encoder)(struct device *, void *),
 			   const struct component_master_ops *m_ops)
 {
 	struct device_node *ep, *port, *remote;
@@ -101,8 +102,14 @@ int drm_of_component_probe(struct device *dev,
 			continue;
 		}
 
-		component_match_add(dev, &match, compare_of, port);
-		of_node_put(port);
+		component_match_add(dev, &match, compare_port, port);
+		/*
+		 * component_match_add keeps a reference to the port
+		 * variable but does not do proper reference counting,
+		 * so we cannot release the reference here. If that
+		 * gets fixed, the following line should be uncommented
+		 */
+		/* of_node_put(port); */
 	}
 
 	if (i == 0) {
@@ -140,8 +147,14 @@ int drm_of_component_probe(struct device *dev,
 				continue;
 			}
 
-			component_match_add(dev, &match, compare_of, remote);
-			of_node_put(remote);
+			component_match_add(dev, &match, compare_encoder, remote);
+			/*
+			 * component_match_add keeps a reference to the port
+			 * variable but does not do proper reference counting,
+			 * so we cannot release the reference here. If that
+			 * gets fixed, the following line should be uncommented
+			 */
+			/* of_node_put(remote); */
 		}
 		of_node_put(port);
 	}
diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index 64f16ea..0d36410 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -531,7 +531,8 @@ static const struct component_master_ops imx_drm_ops = {
 
 static int imx_drm_platform_probe(struct platform_device *pdev)
 {
-	int ret = drm_of_component_probe(&pdev->dev, compare_of, &imx_drm_ops);
+	int ret = drm_of_component_probe(&pdev->dev, compare_of, compare_of,
+					 &imx_drm_ops);
 
 	if (!ret)
 		ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index 8544665..1c29e42 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -10,7 +10,8 @@ struct device_node;
 extern uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
 					   struct device_node *port);
 extern int drm_of_component_probe(struct device *dev,
-				  int (*compare_of)(struct device *, void *),
+				  int (*compare_port)(struct device *, void *),
+				  int (*compare_encoder)(struct device *, void *),
 				  const struct component_master_ops *m_ops);
 #else
 static inline uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
@@ -21,7 +22,8 @@ static inline uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
 
 static inline int
 drm_of_component_probe(struct device *dev,
-		       int (*compare_of)(struct device *, void *),
+		       int (*compare_port)(struct device *, void *),
+		       int (*compare_encoder)(struct device *, void *),
 		       const struct component_master_ops *m_ops)
 {
 	return -EINVAL;
-- 
2.6.0
