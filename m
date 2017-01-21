From: john@metanate.com (John Keeping)
Date: Sat, 21 Jan 2017 16:31:22 +0000
Subject: [PATCH v2 20/26] drm/rockchip: dw-mipi-dsi: use specific poll helper
In-Reply-To: <20170121163128.22240-1-john@metanate.com>
References: <20170121163128.22240-1-john@metanate.com>
Message-ID: <20170121163128.22240-21-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the documentation for readx_poll_timeout says, we want to use the
specialized macro for readl rather than using the generic version
directly.

Signed-off-by: John Keeping <john@metanate.com>
---
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index f2320cf1366c..3e19693ae59b 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -471,14 +471,14 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
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
@@ -594,7 +594,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
 	int ret;
 	u32 val, mask;
 
-	ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
+	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
 				 val, !(val & GEN_CMD_FULL), 1000,
 				 CMD_PKT_STATUS_TIMEOUT_US);
 	if (ret < 0) {
@@ -605,7 +605,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
 	dsi_write(dsi, DSI_GEN_HDR, hdr_val);
 
 	mask = GEN_CMD_EMPTY | GEN_PLD_W_EMPTY;
-	ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
+	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
 				 val, (val & mask) == mask,
 				 1000, CMD_PKT_STATUS_TIMEOUT_US);
 	if (ret < 0) {
@@ -664,7 +664,7 @@ static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
 			len -= pld_data_bytes;
 		}
 
-		ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
+		ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
 					 val, !(val & GEN_PLD_W_FULL), 1000,
 					 CMD_PKT_STATUS_TIMEOUT_US);
 		if (ret < 0) {
-- 
2.11.0.197.gb556de5.dirty
