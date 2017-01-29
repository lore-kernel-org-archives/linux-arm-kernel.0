From: john@metanate.com (John Keeping)
Date: Sun, 29 Jan 2017 13:24:30 +0000
Subject: [PATCH v3 10/24] drm/rockchip: dw-mipi-dsi: don't assume buffer is
 aligned
In-Reply-To: <20170129132444.25251-1-john@metanate.com>
References: <20170129132444.25251-1-john@metanate.com>
Message-ID: <20170129132444.25251-11-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By dereferencing the MIPI command buffer as a u32* we rely on it being
correctly aligned on ARM, but this may not be the case.  Copy it into a
stack variable that will be correctly aligned.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Chris Zhong <zyw@rock-chips.com>
---
v3:
- Add Chris' Reviewed-by
Unchanged in v2

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 03fc096fe1bd..ddbc037e7ced 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -607,10 +607,10 @@ static int dw_mipi_dsi_dcs_short_write(struct dw_mipi_dsi *dsi,
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
@@ -621,12 +621,14 @@ static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
 
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
2.11.0.197.gb556de5.dirty
