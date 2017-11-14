From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 14 Nov 2017 16:32:03 +0200
Subject: [PATCH 01/10] dmaengine: virt-dma: Add helper to free/reuse a
 descriptor
In-Reply-To: <20171114143212.8311-1-peter.ujfalusi@ti.com>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
Message-ID: <20171114143212.8311-2-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vchan_vdesc_fini() can be used to free or reuse a given descriptor
after it has been marked as completed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/virt-dma.c |  5 +----
 drivers/dma/virt-dma.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index 545e97279083..88ad8ed2a8d6 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -107,10 +107,7 @@ static void vchan_complete(unsigned long arg)
 		dmaengine_desc_get_callback(&vd->tx, &cb);
 
 		list_del(&vd->node);
-		if (dmaengine_desc_test_reuse(&vd->tx))
-			list_add(&vd->node, &vc->desc_allocated);
-		else
-			vc->desc_free(vd);
+		vchan_vdesc_fini(vd);
 
 		dmaengine_desc_callback_invoke(&cb, NULL);
 	}
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 3f776a46a29c..2edb05505102 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -103,6 +103,20 @@ static inline void vchan_cookie_complete(struct virt_dma_desc *vd)
 	tasklet_schedule(&vc->task);
 }
 
+/**
+ * vchan_vdesc_fini - Free or reuse a descriptor
+ * @vd: virtual descriptor to free/reuse
+ */
+static inline void vchan_vdesc_fini(struct virt_dma_desc *vd)
+{
+	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
+
+	if (dmaengine_desc_test_reuse(&vd->tx))
+		list_add(&vd->node, &vc->desc_allocated);
+	else
+		vc->desc_free(vd);
+}
+
 /**
  * vchan_cyclic_callback - report the completion of a period
  * @vd: virtual descriptor
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
