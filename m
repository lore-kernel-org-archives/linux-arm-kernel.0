From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Nov 2013 18:12:03 +0000
Subject: Fwd: [PATCH] Fix pl08x warnings
Message-ID: <20131126181202.GA19425@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay, I suck at email today.

----- Forwarded message from Russell King - ARM Linux <linux@arm.linux.org.uk> -----
Date: Tue, 26 Nov 2013 18:11:17 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] Fix pl08x warnings

drivers/dma/amba-pl08x.c: In function 'pl08x_desc_free':
drivers/dma/amba-pl08x.c:1173:2: warning: passing argument 1 of 'dma_descriptor_unmap' from incompatible pointer type
include/linux/dmaengine.h:476:91: note: expected 'struct dma_async_tx_descriptor *' but argument is of type 'struct pl08x_txd *'

Fixes: d38a8c622a1b ("dmaengine: prepare for generic 'unmap' data")
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---

This was introduced during the last merge window, and this warning is
one which should never have been ignored.

 drivers/dma/amba-pl08x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 68fe0e9661f8..1c4af965344b 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1170,7 +1170,7 @@ static void pl08x_desc_free(struct virt_dma_desc *vd)
 	struct pl08x_txd *txd = to_pl08x_txd(&vd->tx);
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(vd->tx.chan);
 
-	dma_descriptor_unmap(txd);
+	dma_descriptor_unmap(&vd->tx);
 	if (!txd->done)
 		pl08x_release_mux(plchan);
 

----- End forwarded message -----
