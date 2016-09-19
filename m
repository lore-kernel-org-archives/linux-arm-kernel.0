From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:17:25 +0100
Subject: [PATCH 14/27] drm/rockchip: dw-mipi-dsi: use specific poll helper
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919171747.28512-16-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the documentation for readx_poll_timeout says, we want to use the
specialized macro for readl rather than using the generic version
directly.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 5e343b54f0d0..097b3b0af78f 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -440,14 +440,14 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 				     PHY_UNRSTZ | PHY_UNSHUTDOWNZ);
 
 
-	ret = readx_poll_timeout(readl, dsi->base + DSI_PHY_STATUS,
+	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
 				 val, val & LOCK, 1000, PHY_STATUS_TIMEOUT_US);
 	if (ret < 0) {
 		dev_err(dsi->dev, "failed to wait for phy lock state\n");
 		return ret;
 	}
 
-	ret = readx_poll_timeout(readl, dsi->base + DSI_PHY_STATUS,
+	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
 				 val, val & STOP_STATE_CLK_LANE, 1000,
 				 PHY_STATUS_TIMEOUT_US);
 	if (ret < 0) {
@@ -563,7 +563,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
 	int ret;
 	u32 val, mask;
 
-	ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
+	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
 				 val, !(val & GEN_CMD_FULL), 1000,
 				 CMD_PKT_STATUS_TIMEOUT_US);
 	if (ret < 0) {
@@ -574,7 +574,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
 	dsi_write(dsi, DSI_GEN_HDR, hdr_val);
 
 	mask = GEN_CMD_EMPTY | GEN_PLD_W_EMPTY;
-	ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
+	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
 				 val, (val & mask) == mask,
 				 1000, CMD_PKT_STATUS_TIMEOUT_US);
 	if (ret < 0) {
@@ -633,7 +633,7 @@ static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
 			len -= pld_data_bytes;
 		}
 
-		ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
+		ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
 					 val, !(val & GEN_PLD_W_FULL), 1000,
 					 CMD_PKT_STATUS_TIMEOUT_US);
 		if (ret < 0) {
-- 
2.10.0.278.g4f427b1.dirty
