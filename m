From: john@metanate.com (John Keeping)
Date: Sat, 21 Jan 2017 16:31:08 +0000
Subject: [PATCH v2 06/26] drm/rockchip: dw-mipi-dsi: fix generic packet status
 check
In-Reply-To: <20170121163128.22240-1-john@metanate.com>
References: <20170121163128.22240-1-john@metanate.com>
Message-ID: <20170121163128.22240-7-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to check that both the GEN_CMD_EMPTY and GEN_PLD_W_EMPTY bits
are set so we can't just check "val & mask" because that will be true if
either bit is set.

Signed-off-by: John Keeping <john@metanate.com>
---
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 4cbbbcb619b7..4be1ff3a42bb 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -545,7 +545,7 @@ static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
 static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
 {
 	int ret;
-	u32 val;
+	u32 val, mask;
 
 	ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
 				 val, !(val & GEN_CMD_FULL), 1000,
@@ -557,8 +557,9 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
 
 	dsi_write(dsi, DSI_GEN_HDR, hdr_val);
 
+	mask = GEN_CMD_EMPTY | GEN_PLD_W_EMPTY;
 	ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
-				 val, val & (GEN_CMD_EMPTY | GEN_PLD_W_EMPTY),
+				 val, (val & mask) == mask,
 				 1000, CMD_PKT_STATUS_TIMEOUT_US);
 	if (ret < 0) {
 		dev_err(dsi->dev, "failed to write command FIFO\n");
-- 
2.11.0.197.gb556de5.dirty
