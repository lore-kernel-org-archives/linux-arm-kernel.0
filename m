From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Fri, 27 Jul 2018 16:20:39 +0530
Subject: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA transfer
In-Reply-To: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1532688639-32230-4-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In AXI CDMA simple mode also pass MSB bits of source and destination
address to xilinx_write function. This fixes simple CDMA operation
mode using 64-bit addressing.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a37871e..2e15d86 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1245,8 +1245,10 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
 
 		hw = &segment->hw;
 
-		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, hw->src_addr);
-		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, hw->dest_addr);
+		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, (dma_addr_t)
+			     ((u64)hw->src_addr_msb << 32 | hw->src_addr));
+		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, (dma_addr_t)
+			     ((u64)hw->dest_addr_msb << 32 | hw->dest_addr));
 
 		/* Start the transfer */
 		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
-- 
1.7.1
