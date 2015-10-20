From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 20 Oct 2015 10:23:13 +0100
Subject: [PATCH v4 2/4] drm/imx: Convert the probe function to the generic
 drm_of_component_probe()
In-Reply-To: <1445332995-11212-1-git-send-email-Liviu.Dudau@arm.com>
References: <1445332995-11212-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1445332995-11212-3-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic function is functionally equivalent to the driver's
imx_drm_platform_probe(). Use the generic function and reduce the
overall code size.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/imx/imx-drm-core.c | 55 +++-----------------------------------
 1 file changed, 4 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index de00a6c..64f16ea 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -531,59 +531,12 @@ static const struct component_master_ops imx_drm_ops = {
 
 static int imx_drm_platform_probe(struct platform_device *pdev)
 {
-	struct device_node *ep, *port, *remote;
-	struct component_match *match = NULL;
-	int ret;
-	int i;
-
-	/*
-	 * Bind the IPU display interface ports first, so that
-	 * imx_drm_encoder_parse_of called from encoder .bind callbacks
-	 * works as expected.
-	 */
-	for (i = 0; ; i++) {
-		port = of_parse_phandle(pdev->dev.of_node, "ports", i);
-		if (!port)
-			break;
-
-		component_match_add(&pdev->dev, &match, compare_of, port);
-	}
+	int ret = drm_of_component_probe(&pdev->dev, compare_of, &imx_drm_ops);
 
-	if (i == 0) {
-		dev_err(&pdev->dev, "missing 'ports' property\n");
-		return -ENODEV;
-	}
+	if (!ret)
+		ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 
-	/* Then bind all encoders */
-	for (i = 0; ; i++) {
-		port = of_parse_phandle(pdev->dev.of_node, "ports", i);
-		if (!port)
-			break;
-
-		for_each_child_of_node(port, ep) {
-			remote = of_graph_get_remote_port_parent(ep);
-			if (!remote || !of_device_is_available(remote)) {
-				of_node_put(remote);
-				continue;
-			} else if (!of_device_is_available(remote->parent)) {
-				dev_warn(&pdev->dev, "parent device of %s is not available\n",
-					 remote->full_name);
-				of_node_put(remote);
-				continue;
-			}
-
-			component_match_add(&pdev->dev, &match, compare_of,
-					    remote);
-			of_node_put(remote);
-		}
-		of_node_put(port);
-	}
-
-	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
-	return component_master_add_with_match(&pdev->dev, &imx_drm_ops, match);
+	return ret;
 }
 
 static int imx_drm_platform_remove(struct platform_device *pdev)
-- 
2.6.0
