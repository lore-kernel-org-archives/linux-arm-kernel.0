From: joelf@ti.com (Joel Fernandes)
Date: Thu, 18 Jul 2013 11:46:41 -0500
Subject: [PATCH 3/3] dma: edma: add device_slave_sg_limits() support
In-Reply-To: <1374166001-31340-1-git-send-email-joelf@ti.com>
References: <1374166001-31340-1-git-send-email-joelf@ti.com>
Message-ID: <1374166001-31340-4-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matt Porter <mporter@ti.com>

Implement device_slave_sg_limits().

EDMA has a finite set of PaRAM slots available for linking a
multi-segment SG transfer. In order to prevent any one channel
from consuming all PaRAM slots to fulfill a large SG transfer,
the driver reports a static per-channel max number of SG segments
it will handle.

The maximum size of an SG segment is limited by the addr_width
and maxburst of a given transfer request. These values are
provided by the client driver and used to calculate and return
the maximum segment length.

[Joel Fernandes <joelf@ti.com>: Changes for filling sg_limits
by DMAEngine implementation and allocating in client, channel
parameter is unused in this implementation as all channels
have the same capability]
Signed-off-by: Matt Porter <mporter@ti.com>
Signed-off-by: Joel Fernandes <joelf@ti.com>
Cc: Mark Jackson <mpfj-list@newflow.co.uk>
---
 drivers/dma/edma.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 5f3e532..964de26 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -462,6 +462,19 @@ static void edma_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&echan->vchan.lock, flags);
 }
 
+static inline int edma_get_slave_sg_limits(struct dma_chan *chan,
+		       enum dma_slave_buswidth addr_width,
+		       u32 maxburst,
+		       struct dma_slave_sg_limits *sg_limits)
+{
+	if (!sg_limits)
+		return -EINVAL;
+	sg_limits->max_seg_nr = MAX_NR_SG;
+	sg_limits->max_seg_len =
+		(SZ_64K - 1) * addr_width * maxburst;
+	return 0;
+}
+
 static size_t edma_desc_size(struct edma_desc *edesc)
 {
 	int i;
@@ -537,6 +550,7 @@ static void edma_dma_init(struct edma_cc *ecc, struct dma_device *dma,
 	dma->device_alloc_chan_resources = edma_alloc_chan_resources;
 	dma->device_free_chan_resources = edma_free_chan_resources;
 	dma->device_issue_pending = edma_issue_pending;
+	dma->device_slave_sg_limits = edma_get_slave_sg_limits;
 	dma->device_tx_status = edma_tx_status;
 	dma->device_control = edma_control;
 	dma->dev = dev;
-- 
1.7.9.5
