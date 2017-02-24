From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:54:49 +0000
Subject: [PATCH v4 06/23] drm/rockchip: dw-mipi-dsi: avoid out-of-bounds read
 on tx_buf
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-7-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a side-effect of this, encode the endianness explicitly rather than
casting a u16.

Signed-off-by: John Keeping <john@metanate.com>
---
v4:
- Introduce "data" variable to avoid confusion around the masking in
  GEN_HDATA()
v3:
- Add Chris' Reviewed-by
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 4be1ff3a42bb..f55010312f25 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -572,8 +572,14 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
 static int dw_mipi_dsi_dcs_short_write(struct dw_mipi_dsi *dsi,
 				       const struct mipi_dsi_msg *msg)
 {
-	const u16 *tx_buf = msg->tx_buf;
-	u32 val = GEN_HDATA(*tx_buf) | GEN_HTYPE(msg->type);
+	const u8 *tx_buf = msg->tx_buf;
+	u16 data = 0;
+	u32 val;
+
+	if (msg->tx_len > 0)
+		data |= tx_buf[0];
+	if (msg->tx_len > 1)
+		data |= tx_buf[1] << 8;
 
 	if (msg->tx_len > 2) {
 		dev_err(dsi->dev, "too long tx buf length %zu for short write\n",
@@ -581,6 +587,7 @@ static int dw_mipi_dsi_dcs_short_write(struct dw_mipi_dsi *dsi,
 		return -EINVAL;
 	}
 
+	val = GEN_HDATA(data) | GEN_HTYPE(msg->type);
 	return dw_mipi_dsi_gen_pkt_hdr_write(dsi, val);
 }
 
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
