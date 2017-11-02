From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 Nov 2017 15:30:20 +0100
Subject: [PATCH] usb: mtu3: fix dma_addr_t printk output again
Message-ID: <20171102143027.775184-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The support for 36-bit addresses originally came with an incorrect
printk format for dma addresses. Felipe changed the format string it
while applying, but the result was still incorrect, since we now have
to pass a pointer to the address instead of the integer value:

drivers/usb/mtu3/mtu3_qmu.c: In function 'mtu3_prepare_tx_gpd':
drivers/usb/mtu3/mtu3_qmu.c:261:25: error: format '%p' expects argument of type 'void *', but argument 7 has type 'dma_addr_t {aka unsigned int}' [-Werror=format=]
drivers/usb/mtu3/mtu3_qmu.c: In function 'mtu3_prepare_rx_gpd':
drivers/usb/mtu3/mtu3_qmu.c:300:25: error: format '%p' expects argument of type 'void *', but argument 7 has type 'dma_addr_t {aka unsigned int}' [-Werror=format=]

This fixes the printk argument accordingly.

Fixes: 1a46dfea0841 ("usb: mtu3: support 36-bit DMA address")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/mtu3/mtu3_qmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
index 42145a3f1422..0b4b412b1d0d 100644
--- a/drivers/usb/mtu3/mtu3_qmu.c
+++ b/drivers/usb/mtu3/mtu3_qmu.c
@@ -259,7 +259,7 @@ static int mtu3_prepare_tx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	enq = advance_enq_gpd(ring);
 	enq_dma = gpd_virt_to_dma(ring, enq);
 	dev_dbg(mep->mtu->dev, "TX-EP%d queue gpd=%p, enq=%p, qdma=%pad\n",
-		mep->epnum, gpd, enq, enq_dma);
+		mep->epnum, gpd, enq, &enq_dma);
 
 	enq->flag &= ~GPD_FLAGS_HWO;
 	gpd->next_gpd = cpu_to_le32(lower_32_bits(enq_dma));
@@ -298,7 +298,7 @@ static int mtu3_prepare_rx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	enq = advance_enq_gpd(ring);
 	enq_dma = gpd_virt_to_dma(ring, enq);
 	dev_dbg(mep->mtu->dev, "RX-EP%d queue gpd=%p, enq=%p, qdma=%pad\n",
-		mep->epnum, gpd, enq, enq_dma);
+		mep->epnum, gpd, enq, &enq_dma);
 
 	enq->flag &= ~GPD_FLAGS_HWO;
 	gpd->next_gpd = cpu_to_le32(lower_32_bits(enq_dma));
-- 
2.9.0
