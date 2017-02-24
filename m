From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:55:05 +0000
Subject: [PATCH v4 22/23] drm/rockchip: dw-mipi-dsi: support non-burst modes
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-23-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Chris Zhong <zyw@rock-chips.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
v4:
- Add Sean's Reviewed-by
v3:
- Add Chris' Reviewed-by
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 9edb868f8dc1..0c4bae711e84 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -82,7 +82,9 @@
 #define FRAME_BTA_ACK			BIT(14)
 #define ENABLE_LOW_POWER		(0x3f << 8)
 #define ENABLE_LOW_POWER_MASK		(0x3f << 8)
-#define VID_MODE_TYPE_BURST_SYNC_PULSES		0x2
+#define VID_MODE_TYPE_NON_BURST_SYNC_PULSES	0x0
+#define VID_MODE_TYPE_NON_BURST_SYNC_EVENTS	0x1
+#define VID_MODE_TYPE_BURST			0x2
 #define VID_MODE_TYPE_MASK			0x3
 
 #define DSI_VID_PKT_SIZE		0x3c
@@ -286,6 +288,7 @@ struct dw_mipi_dsi {
 	u32 format;
 	u16 input_div;
 	u16 feedback_div;
+	unsigned long mode_flags;
 
 	const struct dw_mipi_dsi_plat_data *pdata;
 };
@@ -558,15 +561,10 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 		return -EINVAL;
 	}
 
-	if (!(device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) ||
-	    !(device->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)) {
-		dev_err(dsi->dev, "device mode is unsupported\n");
-		return -EINVAL;
-	}
-
 	dsi->lanes = device->lanes;
 	dsi->channel = device->channel;
 	dsi->format = device->format;
+	dsi->mode_flags = device->mode_flags;
 	dsi->panel = of_drm_find_panel(device->dev.of_node);
 	if (dsi->panel)
 		return drm_panel_attach(dsi->panel, &dsi->connector);
@@ -725,7 +723,14 @@ static void dw_mipi_dsi_video_mode_config(struct dw_mipi_dsi *dsi)
 {
 	u32 val;
 
-	val = VID_MODE_TYPE_BURST_SYNC_PULSES | ENABLE_LOW_POWER;
+	val = ENABLE_LOW_POWER;
+
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		val |= VID_MODE_TYPE_BURST;
+	else if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
+		val |= VID_MODE_TYPE_NON_BURST_SYNC_PULSES;
+	else
+		val |= VID_MODE_TYPE_NON_BURST_SYNC_EVENTS;
 
 	dsi_write(dsi, DSI_VID_MODE_CFG, val);
 }
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
