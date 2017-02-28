From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Tue, 28 Feb 2017 17:17:55 +0900
Subject: [RESEND PATCH v2 1/5] drm/exynos: dsi: Fix the parse_dt function
In-Reply-To: <1488269879-28876-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1488269879-28876-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170228081811epcas5p3931e12839e81f94b58bbd5eaa7a4b63b@epcas5p3.samsung.com>
Message-ID: <1488269879-28876-2-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dsi + panel is a parental relationship, so OF grpah is not needed.
Therefore, the current dsi_parse_dt function will throw an error,
because there is no linked OF graph for case such as fimd + dsi +
panel. So this patch parse the Pll, burst and esc clock frequency
properties in dsi_parse_dt and modified to create a bridge_node only
if there is an OF graph associated with dsi.
So I think the ABI breakage is needed.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index f5c04d0..2d4e118 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1652,39 +1652,23 @@ static int exynos_dsi_parse_dt(struct exynos_dsi *dsi)
 	if (ret < 0)
 		return ret;
 
-	ep = of_graph_get_endpoint_by_regs(node, DSI_PORT_OUT, 0);
-	if (!ep) {
-		dev_err(dev, "no output port with endpoint specified\n");
-		return -EINVAL;
-	}
-
-	ret = exynos_dsi_of_read_u32(ep, "samsung,burst-clock-frequency",
+	ret = exynos_dsi_of_read_u32(node, "samsung,burst-clock-frequency",
 				     &dsi->burst_clk_rate);
 	if (ret < 0)
-		goto end;
+		return ret;
 
-	ret = exynos_dsi_of_read_u32(ep, "samsung,esc-clock-frequency",
+	ret = exynos_dsi_of_read_u32(node, "samsung,esc-clock-frequency",
 				     &dsi->esc_clk_rate);
 	if (ret < 0)
-		goto end;
-
-	of_node_put(ep);
+		return ret;
 
 	ep = of_graph_get_next_endpoint(node, NULL);
-	if (!ep) {
-		ret = -EINVAL;
-		goto end;
-	}
-
-	dsi->bridge_node = of_graph_get_remote_port_parent(ep);
-	if (!dsi->bridge_node) {
-		ret = -EINVAL;
-		goto end;
+	if (ep) {
+		dsi->bridge_node = of_graph_get_remote_port_parent(ep);
+		of_node_put(ep);
 	}
-end:
-	of_node_put(ep);
 
-	return ret;
+	return 0;
 }
 
 static int exynos_dsi_bind(struct device *dev, struct device *master,
-- 
1.9.1
