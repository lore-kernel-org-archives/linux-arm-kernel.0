From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 16 Jan 2017 18:08:28 +0800
Subject: [PATCH v2 08/11] drm/rockchip/dsi: fix the issue can not send commands
In-Reply-To: <1484561311-494-1-git-send-email-zyw@rock-chips.com>
References: <1484561311-494-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1484561311-494-9-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: xubilv <xbl@rock-chips.com>

There is a bug in hdr_write function, the value from the caller will be
overwritten, it cause the mipi can not send the correct command. And the
MIPI_DSI_GENERIC_SHORT_WRITE_n_PARAM message type should be supported.

Signed-off-by: xubilv <xbl@rock-chips.com>
Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 4ec82f6..4a2691c 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -572,10 +572,12 @@ static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
 static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 val)
 {
 	int ret;
+	u32 sts;
 
 	ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
-				 val, !(val & GEN_CMD_FULL), 1000,
+				 sts, !(sts & GEN_CMD_FULL), 1000,
 				 CMD_PKT_STATUS_TIMEOUT_US);
+
 	if (ret < 0) {
 		dev_err(dsi->dev, "failed to get available command FIFO\n");
 		return ret;
@@ -584,8 +586,9 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 val)
 	dsi_write(dsi, DSI_GEN_HDR, val);
 
 	ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
-				 val, val & (GEN_CMD_EMPTY | GEN_PLD_W_EMPTY),
+				 sts, sts & (GEN_CMD_EMPTY | GEN_PLD_W_EMPTY),
 				 1000, CMD_PKT_STATUS_TIMEOUT_US);
+
 	if (ret < 0) {
 		dev_err(dsi->dev, "failed to write command FIFO\n");
 		return ret;
@@ -594,8 +597,8 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 val)
 	return 0;
 }
 
-static int dw_mipi_dsi_dcs_short_write(struct dw_mipi_dsi *dsi,
-				       const struct mipi_dsi_msg *msg)
+static int dw_mipi_dsi_short_write(struct dw_mipi_dsi *dsi,
+				   const struct mipi_dsi_msg *msg)
 {
 	const u16 *tx_buf = msg->tx_buf;
 	u32 val = GEN_HDATA(*tx_buf) | GEN_HTYPE(msg->type);
@@ -609,13 +612,14 @@ static int dw_mipi_dsi_dcs_short_write(struct dw_mipi_dsi *dsi,
 	return dw_mipi_dsi_gen_pkt_hdr_write(dsi, val);
 }
 
-static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
-				      const struct mipi_dsi_msg *msg)
+static int dw_mipi_dsi_long_write(struct dw_mipi_dsi *dsi,
+				  const struct mipi_dsi_msg *msg)
 {
 	const u32 *tx_buf = msg->tx_buf;
 	int len = msg->tx_len, pld_data_bytes = sizeof(*tx_buf), ret;
 	u32 val = GEN_HDATA(msg->tx_len) | GEN_HTYPE(msg->type);
 	u32 remainder = 0;
+	u32 sts = 0;
 
 	if (msg->tx_len < 3) {
 		dev_err(dsi->dev, "wrong tx buf length %zu for long write\n",
@@ -635,7 +639,7 @@ static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
 		}
 
 		ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
-					 val, !(val & GEN_PLD_W_FULL), 1000,
+					 sts, !(sts & GEN_PLD_W_FULL), 1000,
 					 CMD_PKT_STATUS_TIMEOUT_US);
 		if (ret < 0) {
 			dev_err(dsi->dev,
@@ -656,11 +660,15 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
 	switch (msg->type) {
 	case MIPI_DSI_DCS_SHORT_WRITE:
 	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
+	case MIPI_DSI_GENERIC_SHORT_WRITE_0_PARAM:
+	case MIPI_DSI_GENERIC_SHORT_WRITE_1_PARAM:
+	case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
 	case MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE:
-		ret = dw_mipi_dsi_dcs_short_write(dsi, msg);
+		ret = dw_mipi_dsi_short_write(dsi, msg);
 		break;
 	case MIPI_DSI_DCS_LONG_WRITE:
-		ret = dw_mipi_dsi_dcs_long_write(dsi, msg);
+	case MIPI_DSI_GENERIC_LONG_WRITE:
+		ret = dw_mipi_dsi_long_write(dsi, msg);
 		break;
 	default:
 		dev_err(dsi->dev, "unsupported message type\n");
-- 
2.6.3
