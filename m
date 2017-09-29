From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Fri, 29 Sep 2017 15:09:10 +0200
Subject: [RFC 08/11] hack: drm/mediatek: roll back
 drm_of_find_panel_or_bridge() use
In-Reply-To: <1506690553-27357-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1506690553-27357-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <1506690553-27357-9-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haven't looked into how to do this properly.

Fixes display initialization on the Acer Chromebook R13.

Reverts mediatek part of ebc9446135671b89c2397f438af45d9cef0d1368
("drm: convert drivers to use drm_of_find_panel_or_bridge")

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 7e5e24c..fd10cc4 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1093,6 +1093,7 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 {
 	struct mtk_dsi *dsi;
 	struct device *dev = &pdev->dev;
+	struct device_node *remote_node, *endpoint;
 	struct resource *regs;
 	int irq_num;
 	int comp_id;
@@ -1105,10 +1106,22 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 	dsi->host.ops = &mtk_dsi_ops;
 	dsi->host.dev = dev;
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
-					  &dsi->panel, &dsi->bridge);
-	if (ret)
-		return ret;
+	endpoint = of_graph_get_next_endpoint(dev->of_node, NULL);
+	if (endpoint) {
+		remote_node = of_graph_get_remote_port_parent(endpoint);
+		if (!remote_node) {
+			dev_err(dev, "No panel connected\n");
+			return -ENODEV;
+		}
+
+		dsi->bridge = of_drm_find_bridge(remote_node);
+		dsi->panel = of_drm_find_panel(remote_node);
+		of_node_put(remote_node);
+		if (!dsi->bridge && !dsi->panel) {
+			dev_info(dev, "Waiting for bridge or panel driver\n");
+			return -EPROBE_DEFER;
+		}
+	}
 
 	dsi->engine_clk = devm_clk_get(dev, "engine");
 	if (IS_ERR(dsi->engine_clk)) {
-- 
2.7.4
