From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Sat, 29 Sep 2018 11:18:00 -0600
Subject: [PATCH v2 4/4] dmaengine: xilinx_dma: Fix 64-bit simple CDMA transfer
In-Reply-To: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1538241480-13844-5-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In AXI CDMA simple mode also pass MSB bits of source and destination
address to xilinx_write function. This fixes simple CDMA operation
mode using 64-bit addressing.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Changes for v2:
Use helper macro for preparing dma_addr_t.
---
 drivers/dma/xilinx/xilinx_dma.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index c27ab64..d04ef85 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1247,8 +1247,10 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
 
 		hw = &segment->hw;
 
-		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, hw->src_addr);
-		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, hw->dest_addr);
+		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR,
+			     xilinx_prep_dma_addr_t(hw->src_addr));
+		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR,
+			     xilinx_prep_dma_addr_t(hw->dest_addr));
 
 		/* Start the transfer */
 		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
-- 
1.7.1
