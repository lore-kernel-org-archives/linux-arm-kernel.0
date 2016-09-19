From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:17:21 +0100
Subject: [PATCH 11/26] drm/rockchip: dw-mipi-dsi: don't assume buffer is
 aligned
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919171747.28512-12-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By dereferencing the MIPI command buffer as a u32* we rely on it being
correctly aligned on ARM, but this may not be the case.  Copy it into a
stack variable that will be correctly aligned.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index ed2da1bbada9..4c945cc4d31a 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -608,10 +608,10 @@ static int dw_mipi_dsi_dcs_short_write(struct dw_mipi_dsi *dsi,
 static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
 				      const struct mipi_dsi_msg *msg)
 {
-	const u32 *tx_buf = msg->tx_buf;
-	int len = msg->tx_len, pld_data_bytes = sizeof(*tx_buf), ret;
+	const u8 *tx_buf = msg->tx_buf;
+	int len = msg->tx_len, pld_data_bytes = sizeof(u32), ret;
 	u32 hdr_val = GEN_HDATA(msg->tx_len) | GEN_HTYPE(msg->type);
-	u32 remainder = 0;
+	u32 remainder;
 	u32 val;
 
 	if (msg->tx_len < 3) {
@@ -622,12 +622,14 @@ static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
 
 	while (DIV_ROUND_UP(len, pld_data_bytes)) {
 		if (len < pld_data_bytes) {
+			remainder = 0;
 			memcpy(&remainder, tx_buf, len);
 			dsi_write(dsi, DSI_GEN_PLD_DATA, remainder);
 			len = 0;
 		} else {
-			dsi_write(dsi, DSI_GEN_PLD_DATA, *tx_buf);
-			tx_buf++;
+			memcpy(&remainder, tx_buf, pld_data_bytes);
+			dsi_write(dsi, DSI_GEN_PLD_DATA, remainder);
+			tx_buf += pld_data_bytes;
 			len -= pld_data_bytes;
 		}
 
-- 
2.10.0.278.g4f427b1.dirty
