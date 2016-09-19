From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:17:17 +0100
Subject: [PATCH 07/26] drm/rockchip: dw-mipi-dsi: avoid out-of-bounds read on
 tx_buf
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919171747.28512-8-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a side-effect of this, encode the endianness explicitly rather than
casting a u16.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index f2bed2a0f907..38186df8476e 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -573,8 +573,13 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
 static int dw_mipi_dsi_dcs_short_write(struct dw_mipi_dsi *dsi,
 				       const struct mipi_dsi_msg *msg)
 {
-	const u16 *tx_buf = msg->tx_buf;
-	u32 val = GEN_HDATA(*tx_buf) | GEN_HTYPE(msg->type);
+	const u8 *tx_buf = msg->tx_buf;
+	u32 val = GEN_HTYPE(msg->type);
+
+	if (msg->tx_len > 0)
+		val |= GEN_HDATA(tx_buf[0]);
+	if (msg->tx_len > 1)
+		val |= GEN_HDATA(tx_buf[1] << 8);
 
 	if (msg->tx_len > 2) {
 		dev_err(dsi->dev, "too long tx buf length %zu for short write\n",
-- 
2.10.0.278.g4f427b1.dirty
