From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Oct 2013 15:36:29 +0100
Subject: [PATCH 1/7] kvmtool: virt_queue configuration based on endianness
In-Reply-To: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
References: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1381502195-8263-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define a simple infrastructure to configure a virt_queue
depending on the guest endianness, as reported by the feature
flags. At this stage, the endianness is always the host's.

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 tools/kvm/include/kvm/virtio.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/kvm/include/kvm/virtio.h b/tools/kvm/include/kvm/virtio.h
index 820b94a..d6b0f47 100644
--- a/tools/kvm/include/kvm/virtio.h
+++ b/tools/kvm/include/kvm/virtio.h
@@ -15,6 +15,10 @@
 #define VIRTIO_PCI_O_CONFIG	0
 #define VIRTIO_PCI_O_MSIX	1
 
+#define VIRTIO_ENDIAN_HOST	0
+#define VIRTIO_ENDIAN_LE	1
+#define VIRTIO_ENDIAN_BE	2
+
 struct virt_queue {
 	struct vring	vring;
 	u32		pfn;
@@ -22,8 +26,15 @@ struct virt_queue {
 	   It's where we assume the next request index is at.  */
 	u16		last_avail_idx;
 	u16		last_used_signalled;
+	u16		endian;
 };
 
+
+static inline void virt_queue__init(struct virt_queue *vq, u32 features)
+{
+	vq->endian = VIRTIO_ENDIAN_HOST;
+}
+
 static inline u16 virt_queue__pop(struct virt_queue *queue)
 {
 	return queue->vring.avail->ring[queue->last_avail_idx++ % queue->vring.num];
-- 
1.8.2.3
