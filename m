From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 15 Sep 2015 15:39:11 +0200
Subject: [PATCH 4/4] dmaengine: at_xdmac: clean used descriptor
In-Reply-To: <1442323770-20266-1-git-send-email-ludovic.desroches@atmel.com>
References: <1442323770-20266-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1442324353-20557-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When putting back a descriptor to the free descs list, some fields are
not set to 0, it can cause bugs if someone uses it without having this
in mind.
Descriptor are not put back one by one so it is easier to clean
descriptors when we request them.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: stable at vger.kernel.org #4.2
---
 drivers/dma/at_xdmac.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index fbd4093..b5e132d 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -455,6 +455,15 @@ static struct at_xdmac_desc *at_xdmac_alloc_desc(struct dma_chan *chan,
 	return desc;
 }
 
+void at_xdmac_init_used_desc(struct at_xdmac_desc *desc)
+{
+	memset(&desc->lld, 0, sizeof(desc->lld));
+	INIT_LIST_HEAD(&desc->descs_list);
+	desc->direction = DMA_TRANS_NONE;
+	desc->xfer_size = 0;
+	desc->active_xfer = false;
+}
+
 /* Call must be protected by lock. */
 static struct at_xdmac_desc *at_xdmac_get_desc(struct at_xdmac_chan *atchan)
 {
@@ -466,7 +475,7 @@ static struct at_xdmac_desc *at_xdmac_get_desc(struct at_xdmac_chan *atchan)
 		desc = list_first_entry(&atchan->free_descs_list,
 					struct at_xdmac_desc, desc_node);
 		list_del(&desc->desc_node);
-		desc->active_xfer = false;
+		at_xdmac_init_used_desc(desc);
 	}
 
 	return desc;
-- 
2.5.0
