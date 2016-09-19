From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:17:19 +0100
Subject: [PATCH 09/26] drm/rockchip: dw-mipi-dsi: respect message flags
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919171747.28512-10-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of always sending commands in LP mode, respect the
MIPI_DSI_MSG_USE_LPM flag to decide how to send each message.  Also
request acks if MIPI_DSI_MSG_REQ_ACK is set.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index a25db02e1c19..554336f8023e 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -543,6 +543,19 @@ static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
 	return 0;
 }
 
+static void dw_mipi_message_config(struct dw_mipi_dsi *dsi,
+				   const struct mipi_dsi_msg *msg)
+{
+	u32 val = 0;
+
+	if (msg->flags & MIPI_DSI_MSG_REQ_ACK)
+		val |= EN_ACK_RQST;
+	if (msg->flags & MIPI_DSI_MSG_USE_LPM)
+		val |= CMD_MODE_ALL_LP;
+
+	dsi_write(dsi, DSI_CMD_MODE_CFG, val);
+}
+
 static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
 {
 	int ret;
@@ -635,6 +648,8 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
 	struct dw_mipi_dsi *dsi = host_to_dsi(host);
 	int ret;
 
+	dw_mipi_message_config(dsi, msg);
+
 	switch (msg->type) {
 	case MIPI_DSI_DCS_SHORT_WRITE:
 	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
@@ -747,7 +762,6 @@ static void dw_mipi_dsi_command_mode_config(struct dw_mipi_dsi *dsi)
 {
 	dsi_write(dsi, DSI_TO_CNT_CFG, HSTX_TO_CNT(1000) | LPRX_TO_CNT(1000));
 	dsi_write(dsi, DSI_BTA_TO_CNT, 0xd00);
-	dsi_write(dsi, DSI_CMD_MODE_CFG, CMD_MODE_ALL_LP);
 	dsi_write(dsi, DSI_MODE_CFG, ENABLE_CMD_MODE);
 }
 
-- 
2.10.0.278.g4f427b1.dirty
