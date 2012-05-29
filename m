From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:35:58 +0100
Subject: [RFC 02/34] dmaengine: virt-dma: vchan_find_desc()
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIqM-0006yq-1w@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function to find a descriptor within the depths of the
virtualized DMA channel support.  Needed for tx_status functionality.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/virt-dma.c |   13 +++++++++++++
 drivers/dma/virt-dma.h |    2 +-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index bd85b05..a8054fc 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -39,6 +39,19 @@ dma_cookie_t vchan_tx_submit(struct dma_async_tx_descriptor *tx)
 }
 EXPORT_SYMBOL_GPL(vchan_tx_submit);
 
+struct virt_dma_desc *vchan_find_desc(struct virt_dma_chan *vc,
+	dma_cookie_t cookie)
+{
+	struct virt_dma_desc *vd;
+
+	list_for_each_entry(vd, &vc->desc_issued, node)
+		if (vd->tx.cookie == cookie)
+			return vd;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(vchan_find_desc);
+
 /*
  * This tasklet handles the completion of a DMA descriptor by
  * calling its callback and freeing it.
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 825bb96..44ec57e 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -40,8 +40,8 @@ static inline struct virt_dma_chan *to_virt_chan(struct dma_chan *chan)
 }
 
 void vchan_dma_desc_free_list(struct virt_dma_chan *vc, struct list_head *head);
-
 void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev);
+struct virt_dma_desc *vchan_find_desc(struct virt_dma_chan *, dma_cookie_t);
 
 /**
  * vchan_tx_prep - prepare a descriptor
-- 
1.7.4.4
