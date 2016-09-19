From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:17:20 +0100
Subject: [PATCH 10/26] drm/rockchip: dw-mipi-dsi: only request HS clock when
 required
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919171747.28512-11-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Requesting the HS clock from the PHY before we initialize it causes an
invalid signal to be sent out since the input clock is not yet
configured.  The PHY databook suggests only asserting this signal when
performing HS transfers, so let's do that.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 554336f8023e..ed2da1bbada9 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -546,13 +546,15 @@ static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
 static void dw_mipi_message_config(struct dw_mipi_dsi *dsi,
 				   const struct mipi_dsi_msg *msg)
 {
+	bool lpm = msg->flags & MIPI_DSI_MSG_USE_LPM;
 	u32 val = 0;
 
 	if (msg->flags & MIPI_DSI_MSG_REQ_ACK)
 		val |= EN_ACK_RQST;
-	if (msg->flags & MIPI_DSI_MSG_USE_LPM)
+	if (lpm)
 		val |= CMD_MODE_ALL_LP;
 
+	dsi_write(dsi, DSI_LPCLK_CTRL, lpm ? 0 : PHY_TXREQUESTCLKHS);
 	dsi_write(dsi, DSI_CMD_MODE_CFG, val);
 }
 
@@ -694,6 +696,7 @@ static void dw_mipi_dsi_set_mode(struct dw_mipi_dsi *dsi,
 		dsi_write(dsi, DSI_PWR_UP, RESET);
 		dsi_write(dsi, DSI_MODE_CFG, ENABLE_VIDEO_MODE);
 		dw_mipi_dsi_video_mode_config(dsi);
+		dsi_write(dsi, DSI_LPCLK_CTRL, PHY_TXREQUESTCLKHS);
 		dsi_write(dsi, DSI_PWR_UP, POWERUP);
 	}
 }
@@ -711,7 +714,6 @@ static void dw_mipi_dsi_init(struct dw_mipi_dsi *dsi)
 		  | PHY_RSTZ | PHY_SHUTDOWNZ);
 	dsi_write(dsi, DSI_CLKMGR_CFG, TO_CLK_DIVIDSION(10) |
 		  TX_ESC_CLK_DIVIDSION(7));
-	dsi_write(dsi, DSI_LPCLK_CTRL, PHY_TXREQUESTCLKHS);
 }
 
 static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi)
-- 
2.10.0.278.g4f427b1.dirty
