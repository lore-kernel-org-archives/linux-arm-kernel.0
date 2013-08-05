From: joelf@ti.com (Joel Fernandes)
Date: Mon, 5 Aug 2013 11:14:55 -0500
Subject: [PATCH v3 10/12] dma: edma: Check if MAX_NR_SG is even in prep
 function
In-Reply-To: <1375719297-12871-1-git-send-email-joelf@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
Message-ID: <1375719297-12871-11-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Splitting of MAX available slots into 2 sets of size MAX_NR_LS
requires to the MAX_NR_SG function to be even. We ensure the same
in prep function.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 70923a2..061f0cf 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -354,6 +354,9 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 	int src_bidx, dst_bidx, src_cidx, dst_cidx;
 	int i, num_slots_needed;
 
+	if (MAX_NR_SG & 1)
+		dev_err(dev, "%s: MAX_NR_SG must be even\n", __func__);
+
 	if (unlikely(!echan || !sgl || !sg_len))
 		return NULL;
 
-- 
1.7.9.5
