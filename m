From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:54:52 +0000
Subject: [PATCH v4 09/23] drm/rockchip: dw-mipi-dsi: only request HS clock
 when required
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-10-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Requesting the HS clock from the PHY before we initialize it causes an
invalid signal to be sent out since the input clock is not yet
configured.  The PHY databook suggests only asserting this signal when
performing HS transfers, so let's do that.

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
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index a20d669b73ee..1b6fce2600f3 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -545,13 +545,15 @@ static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
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
 
@@ -695,6 +697,7 @@ static void dw_mipi_dsi_set_mode(struct dw_mipi_dsi *dsi,
 		dsi_write(dsi, DSI_PWR_UP, RESET);
 		dsi_write(dsi, DSI_MODE_CFG, ENABLE_VIDEO_MODE);
 		dw_mipi_dsi_video_mode_config(dsi);
+		dsi_write(dsi, DSI_LPCLK_CTRL, PHY_TXREQUESTCLKHS);
 		dsi_write(dsi, DSI_PWR_UP, POWERUP);
 	}
 }
@@ -712,7 +715,6 @@ static void dw_mipi_dsi_init(struct dw_mipi_dsi *dsi)
 		  | PHY_RSTZ | PHY_SHUTDOWNZ);
 	dsi_write(dsi, DSI_CLKMGR_CFG, TO_CLK_DIVIDSION(10) |
 		  TX_ESC_CLK_DIVIDSION(7));
-	dsi_write(dsi, DSI_LPCLK_CTRL, PHY_TXREQUESTCLKHS);
 }
 
 static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi,
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
