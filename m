From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:54:47 +0000
Subject: [PATCH v4 04/23] drm/rockchip: dw-mipi-dsi: fix command header writes
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-5-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a couple of places here we use "val" for the value that is about to
be written to a register but then reuse the same variable for the value
of a status register before we get around to writing it.  Rename the
value to be written to so that we write the value we intend to and not
what we have just read from the status register.

Signed-off-by: John Keeping <john@metanate.com>
Tested-by: Chris Zhong <zyw@rock-chips.com>
Reviewed-by: Chris Zhong <zyw@rock-chips.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
v4:
- Add Sean's Reviewed-by
Unchanged in v3
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index bd92e58b64f3..4cbbbcb619b7 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -542,9 +542,10 @@ static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
 	return 0;
 }
 
-static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 val)
+static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
 {
 	int ret;
+	u32 val;
 
 	ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
 				 val, !(val & GEN_CMD_FULL), 1000,
@@ -554,7 +555,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 val)
 		return ret;
 	}
 
-	dsi_write(dsi, DSI_GEN_HDR, val);
+	dsi_write(dsi, DSI_GEN_HDR, hdr_val);
 
 	ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
 				 val, val & (GEN_CMD_EMPTY | GEN_PLD_W_EMPTY),
@@ -587,8 +588,9 @@ static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
 {
 	const u32 *tx_buf = msg->tx_buf;
 	int len = msg->tx_len, pld_data_bytes = sizeof(*tx_buf), ret;
-	u32 val = GEN_HDATA(msg->tx_len) | GEN_HTYPE(msg->type);
+	u32 hdr_val = GEN_HDATA(msg->tx_len) | GEN_HTYPE(msg->type);
 	u32 remainder = 0;
+	u32 val;
 
 	if (msg->tx_len < 3) {
 		dev_err(dsi->dev, "wrong tx buf length %zu for long write\n",
@@ -617,7 +619,7 @@ static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
 		}
 	}
 
-	return dw_mipi_dsi_gen_pkt_hdr_write(dsi, val);
+	return dw_mipi_dsi_gen_pkt_hdr_write(dsi, hdr_val);
 }
 
 static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
