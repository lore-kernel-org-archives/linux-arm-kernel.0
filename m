From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:17:43 +0100
Subject: [PATCH 23/27] drm/rockchip: dw-mipi-dsi: support non-burst modes
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919171747.28512-34-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 5ecb03c24c2f..d93e620adea6 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -82,6 +82,7 @@
 #define FRAME_BTA_ACK			BIT(14)
 #define ENABLE_LOW_POWER		(0x3f << 8)
 #define ENABLE_LOW_POWER_MASK		(0x3f << 8)
+#define VID_MODE_TYPE_NON_BURST_SYNC_EVENTS	0x1
 #define VID_MODE_TYPE_BURST_SYNC_PULSES		0x2
 #define VID_MODE_TYPE_MASK			0x3
 
@@ -286,6 +287,7 @@ struct dw_mipi_dsi {
 	u32 format;
 	u16 input_div;
 	u16 feedback_div;
+	unsigned long mode_flags;
 
 	const struct dw_mipi_dsi_plat_data *pdata;
 };
@@ -549,15 +551,10 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
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
@@ -714,7 +711,12 @@ static void dw_mipi_dsi_video_mode_config(struct dw_mipi_dsi *dsi)
 {
 	u32 val;
 
-	val = VID_MODE_TYPE_BURST_SYNC_PULSES | ENABLE_LOW_POWER;
+	val = ENABLE_LOW_POWER;
+
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		val |= VID_MODE_TYPE_BURST_SYNC_PULSES;
+	else if (!(dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE))
+		val |= VID_MODE_TYPE_NON_BURST_SYNC_EVENTS;
 
 	dsi_write(dsi, DSI_VID_MODE_CFG, val);
 }
-- 
2.10.0.278.g4f427b1.dirty
