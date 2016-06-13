From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Jun 2016 17:07:33 +0200
Subject: [PATCH] dma: xilinx-vdma: add some sanity checks
Message-ID: <1465830523-2484498-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added xilinx_dma_prep_dma_cyclic function sometimes causes
a gcc warning about the use of the segment function in case
we never run into the inner loop of the function:

dma/xilinx/xilinx_vdma.c: In function 'xilinx_dma_prep_dma_cyclic':
dma/xilinx/xilinx_vdma.c:1808:23: error: 'segment' may be used uninitialized in this function [-Werror=maybe-uninitialized]
   segment->hw.control |= XILINX_DMA_BD_SOP;

This can only happen if the period len is zero (which would cause other
problems earlier), or if the buffer is shorter than a period. Neither
of them should ever happen, but by adding an explicit check for these two
cases, we can abort in a more controlled way, and the compiler is
able to see that we never use uninitialized data.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/xilinx/xilinx_vdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index 0f5b38a0e46f..2ac3253bc823 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -1745,8 +1745,14 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 	int i;
 	u32 reg;
 
+	if (!period_len)
+		return NULL;
+
 	num_periods = buf_len / period_len;
 
+	if (!num_periods)
+		return NULL;
+
 	if (!is_slave_direction(direction))
 		return NULL;
 
-- 
2.7.0
