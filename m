From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 27 Apr 2014 00:02:08 +0100
Subject: [PATCH RFC 5/8] imx-drm: update to use component match support
In-Reply-To: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
References: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
Message-ID: <E1WeBbk-0002Gn-Gw@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the imx-drm driver to use the component match support rather than
add_components.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c | 57 +++-------------------------------
 1 file changed, 4 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 4144a75e5f71..84cd915bba44 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -577,22 +577,6 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == np;
 }
 
-static LIST_HEAD(imx_drm_components);
-
-static int imx_drm_add_components(struct device *master, struct master *m)
-{
-	struct imx_drm_component *component;
-	int ret;
-
-	list_for_each_entry(component, &imx_drm_components, list) {
-		ret = component_master_add_child(m, compare_of,
-						 component->of_node);
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-
 static int imx_drm_bind(struct device *dev)
 {
 	return drm_platform_init(&imx_drm_driver, to_platform_device(dev));
@@ -604,43 +588,14 @@ static void imx_drm_unbind(struct device *dev)
 }
 
 static const struct component_master_ops imx_drm_ops = {
-	.add_components = imx_drm_add_components,
 	.bind = imx_drm_bind,
 	.unbind = imx_drm_unbind,
 };
 
-static struct imx_drm_component *imx_drm_find_component(struct device *dev,
-		struct device_node *node)
-{
-	struct imx_drm_component *component;
-
-	list_for_each_entry(component, &imx_drm_components, list)
-		if (component->of_node == node)
-			return component;
-
-	return NULL;
-}
-
-static int imx_drm_add_component(struct device *dev, struct device_node *node)
-{
-	struct imx_drm_component *component;
-
-	if (imx_drm_find_component(dev, node))
-		return 0;
-
-	component = devm_kzalloc(dev, sizeof(*component), GFP_KERNEL);
-	if (!component)
-		return -ENOMEM;
-
-	component->of_node = node;
-	list_add_tail(&component->list, &imx_drm_components);
-
-	return 0;
-}
-
 static int imx_drm_platform_probe(struct platform_device *pdev)
 {
 	struct device_node *ep, *port, *remote;
+	struct component_match *match = NULL;
 	int ret;
 	int i;
 
@@ -654,9 +609,7 @@ static int imx_drm_platform_probe(struct platform_device *pdev)
 		if (!port)
 			break;
 
-		ret = imx_drm_add_component(&pdev->dev, port);
-		if (ret < 0)
-			return ret;
+		component_match_add(&pdev->dev, &match, compare_of, port);
 	}
 
 	if (i == 0) {
@@ -677,10 +630,8 @@ static int imx_drm_platform_probe(struct platform_device *pdev)
 				continue;
 			}
 
-			ret = imx_drm_add_component(&pdev->dev, remote);
+			component_match_add(&pdev->dev, &match, compare_of, remote);
 			of_node_put(remote);
-			if (ret < 0)
-				return ret;
 		}
 		of_node_put(port);
 	}
@@ -689,7 +640,7 @@ static int imx_drm_platform_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return component_master_add(&pdev->dev, &imx_drm_ops);
+	return component_master_add_with_match(&pdev->dev, &imx_drm_ops, match);
 }
 
 static int imx_drm_platform_remove(struct platform_device *pdev)
-- 
1.8.3.1
