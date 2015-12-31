From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 31 Dec 2015 21:09:32 +0200
Subject: [PATCH v2 29/32] Revert "virtio_ring: Update weak barriers to use
 dma_wmb/rmb"
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
Message-ID: <1451572003-2440-30-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 9e1a27ea42691429e31f158cce6fc61bc79bb2e9.

While that commit optimizes !CONFIG_SMP, it mixes
up DMA and SMP concepts, making the code hard
to figure out.

A better way to optimize this is with the new __smp_XXX
barriers.

As a first step, go back to full rmb/wmb barriers
for !SMP.
We switch to __smp_XXX barriers in the next patch.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 8e50888..67e06fe 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -21,20 +21,19 @@
  * actually quite cheap.
  */
 
+#ifdef CONFIG_SMP
 static inline void virtio_mb(bool weak_barriers)
 {
-#ifdef CONFIG_SMP
 	if (weak_barriers)
 		smp_mb();
 	else
-#endif
 		mb();
 }
 
 static inline void virtio_rmb(bool weak_barriers)
 {
 	if (weak_barriers)
-		dma_rmb();
+		smp_rmb();
 	else
 		rmb();
 }
@@ -42,10 +41,26 @@ static inline void virtio_rmb(bool weak_barriers)
 static inline void virtio_wmb(bool weak_barriers)
 {
 	if (weak_barriers)
-		dma_wmb();
+		smp_wmb();
 	else
 		wmb();
 }
+#else
+static inline void virtio_mb(bool weak_barriers)
+{
+	mb();
+}
+
+static inline void virtio_rmb(bool weak_barriers)
+{
+	rmb();
+}
+
+static inline void virtio_wmb(bool weak_barriers)
+{
+	wmb();
+}
+#endif
 
 struct virtio_device;
 struct virtqueue;
-- 
MST
