From: andrea.merello@gmail.com (Andrea Merello)
Date: Tue, 20 Nov 2018 16:31:46 +0100
Subject: [PATCH v6 2/7] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cyclic mode align split descriptors
In-Reply-To: <20181120153151.18024-1-andrea.merello@gmail.com>
References: <20181120153151.18024-1-andrea.merello@gmail.com>
Message-ID: <20181120153151.18024-2-andrea.merello@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whenever a single or cyclic transaction is prepared, the driver
could eventually split it over several SG descriptors in order
to deal with the HW maximum transfer length.

This could end up in DMA operations starting from a misaligned
address. This seems fatal for the HW if DRE (Data Realignment Engine)
is not enabled.

This patch eventually adjusts the transfer size in order to make sure
all operations start from an aligned address.

Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes in v2:
        - don't introduce copy_mask field, rather rely on already-esistent
          copy_align field. Suggested by Radhey Shyam Pandey
        - reword title
Changes in v3:
	- fix bug introduced in v2: wrong copy size when DRE is enabled
	- use implementation suggested by Radhey Shyam Pandey
Changes in v4:
	- rework on the top of 1/6
Changes in v5:
	- fix typo in commit title
	- add hint about "DRE" meaning in commit message
Changes in v6:
	None
---
 drivers/dma/xilinx/xilinx_dma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 2c1db500284f..cbf34dd5e966 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -975,6 +975,15 @@ static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
 	copy = min_t(size_t, size - done,
 		     chan->xdev->max_buffer_len);
 
+	if ((copy + done < size) &&
+	    chan->xdev->common.copy_align) {
+		/*
+		 * If this is not the last descriptor, make sure
+		 * the next one will be properly aligned
+		 */
+		copy = rounddown(copy,
+				 (1 << chan->xdev->common.copy_align));
+	}
 	return copy;
 }
 
-- 
2.17.1
