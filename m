From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 16 Jan 2017 18:08:26 +0800
Subject: [PATCH v2 06/11] drm/rockchip/dsi: return probe defer if attach panel
 failed
In-Reply-To: <1484561311-494-1-git-send-email-zyw@rock-chips.com>
References: <1484561311-494-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1484561311-494-7-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Yao <mark.yao@rock-chips.com>

Return -EINVAL would cause mipi dsi bad behavior, probe defer
to ensure mipi find the correct mode,

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index d2a3efb..5e3f031 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -549,10 +549,14 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 	dsi->channel = device->channel;
 	dsi->format = device->format;
 	dsi->panel = of_drm_find_panel(device->dev.of_node);
-	if (dsi->panel)
-		return drm_panel_attach(dsi->panel, &dsi->connector);
+	if (!dsi->panel) {
+		DRM_ERROR("failed to find panel\n");
+		return -EPROBE_DEFER;
+	}
 
-	return -EINVAL;
+	drm_panel_attach(dsi->panel, &dsi->connector);
+
+	return 0;
 }
 
 static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
@@ -560,7 +564,8 @@ static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
 {
 	struct dw_mipi_dsi *dsi = host_to_dsi(host);
 
-	drm_panel_detach(dsi->panel);
+	if (dsi->panel)
+		drm_panel_detach(dsi->panel);
 
 	return 0;
 }
-- 
2.6.3
