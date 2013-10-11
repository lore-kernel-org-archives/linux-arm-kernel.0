From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Oct 2013 15:36:30 +0100
Subject: [PATCH 2/7] kvmtool: virt_queue: handle guest endianness
In-Reply-To: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
References: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1381502195-8263-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wrap all accesses to virt_queue data structures shared between
host and guest with byte swapping helpers.

Should the architecture only support one endianness, these helpers
are reduced to the identity function.

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 tools/kvm/include/kvm/virtio.h | 189 ++++++++++++++++++++++++++++++++++++++++-
 tools/kvm/virtio/core.c        |  59 +++++++------
 2 files changed, 219 insertions(+), 29 deletions(-)

diff --git a/tools/kvm/include/kvm/virtio.h b/tools/kvm/include/kvm/virtio.h
index d6b0f47..04ec137 100644
--- a/tools/kvm/include/kvm/virtio.h
+++ b/tools/kvm/include/kvm/virtio.h
@@ -1,6 +1,8 @@
 #ifndef KVM__VIRTIO_H
 #define KVM__VIRTIO_H
 
+#include <endian.h>
+
 #include <linux/virtio_ring.h>
 #include <linux/virtio_pci.h>
 
@@ -29,15 +31,194 @@ struct virt_queue {
 	u16		endian;
 };
 
+/*
+ * The default policy is not to cope with the guest endianness.
+ * It also helps not breaking archs that do not care about supporting
+ * such a configuration.
+ */
+#ifndef VIRTIO_RING_ENDIAN
+#define VIRTIO_RING_ENDIAN 0
+#endif
+
+#if (VIRTIO_RING_ENDIAN & ((1UL << VIRTIO_RING_F_GUEST_LE) | (1UL << VIRTIO_RING_F_GUEST_BE)))
+
+#ifndef __BYTE_ORDER
+#error "No byteorder? Giving up..."
+#endif
+
+
+static inline __u16 __virtio_guest_to_host_u16(u16 endian, __u16 val)
+{
+#if __BYTE_ORDER == __BIG_ENDIAN
+	if (endian == VIRTIO_ENDIAN_LE)
+		return le16toh(val);
+#else
+	if (endian == VIRTIO_ENDIAN_BE)
+		return be16toh(val);
+#endif
+
+	return val;
+}
+
+static inline __u16 virtio_guest_to_host_u16(struct virt_queue *vq, __u16 val)
+{
+	return __virtio_guest_to_host_u16(vq->endian, val);
+}
+
+static inline __u16 __virtio_host_to_guest_u16(u16 endian, __u16 val)
+{
+#if __BYTE_ORDER == __BIG_ENDIAN
+	if (endian == VIRTIO_ENDIAN_LE)
+		return htole16(val);
+#else
+	if (endian == VIRTIO_ENDIAN_BE)
+		return htobe16(val);
+#endif
+
+	return val;
+}
+
+static inline __u16 virtio_host_to_guest_u16(struct virt_queue *vq, __u16 val)
+{
+	return __virtio_host_to_guest_u16(vq->endian, val);
+}
+
+static inline __u32 __virtio_guest_to_host_u32(u16 endian, __u32 val)
+{
+#if __BYTE_ORDER == __BIG_ENDIAN
+	if (endian == VIRTIO_ENDIAN_LE)
+		return le32toh(val);
+#else
+	if (endian == VIRTIO_ENDIAN_BE)
+		return be32toh(val);
+#endif
+
+	return val;
+}
+
+static inline __u32 virtio_guest_to_host_u32(struct virt_queue *vq, __u32 val)
+{
+	return __virtio_guest_to_host_u32(vq->endian, val);
+}
+
+static inline __u32 __virtio_host_to_guest_u32(u16 endian, __u32 val)
+{
+#if __BYTE_ORDER == __BIG_ENDIAN
+	if (endian == VIRTIO_ENDIAN_LE)
+		return htole32(val);
+#else
+	if (endian == VIRTIO_ENDIAN_BE)
+		return htobe32(val);
+#endif
+
+	return val;
+}
+
+static inline __u32 virtio_host_to_guest_u32(struct virt_queue *vq, __u32 val)
+{
+	return __virtio_host_to_guest_u32(vq->endian, val);
+}
+
+static inline __u64 __virtio_guest_to_host_u64(u16 endian, __u64 val)
+{
+#if __BYTE_ORDER == __BIG_ENDIAN
+	if (endian == VIRTIO_ENDIAN_LE)
+		return le64toh(val);
+#else
+	if (endian == VIRTIO_ENDIAN_BE)
+		return be64toh(val);
+#endif
+
+	return val;
+}
+
+static inline __u64 virtio_guest_to_host_u64(struct virt_queue *vq, __u64 val)
+{
+	return __virtio_guest_to_host_u64(vq->endian, val);
+}
+
+static inline __u64 __virtio_host_to_guest_u64(u16 endian, __u64 val)
+{
+#if __BYTE_ORDER == __BIG_ENDIAN
+	if (endian == VIRTIO_ENDIAN_LE)
+		return htole64(val);
+#else
+	if (endian == VIRTIO_ENDIAN_BE)
+		return htobe64(val);
+#endif
+
+	return val;
+}
+
+static inline __u64 virtio_host_to_guest_u64(struct virt_queue *vq, __u64 val)
+{
+	return __virtio_host_to_guest_u64(vq->endian, val);
+}
+
+static inline u16 virtio_features_to_endian(u32 features)
+{
+	u16 endian = VIRTIO_ENDIAN_HOST;
+
+#if __BYTE_ORDER == __BIG_ENDIAN
+	if (features & (1 << VIRTIO_RING_F_GUEST_LE))
+		endian = VIRTIO_ENDIAN_LE;
+#else
+	if (features & (1 << VIRTIO_RING_F_GUEST_BE))
+		endian = VIRTIO_ENDIAN_BE;
+#endif
+
+	return endian;
+}
+
+#else
+
+static inline __u16 virtio_guest_to_host_u16(struct virt_queue *vq, __u16 val)
+{
+	return val;
+}
+
+static inline __u16 virtio_host_to_guest_u16(struct virt_queue *vq, __u16 val)
+{
+	return val;
+}
+
+static inline __u32 virtio_guest_to_host_u32(struct virt_queue *vq, __u32 val)
+{
+	return val;
+}
+
+static inline __u32 virtio_host_to_guest_u32(struct virt_queue *vq, __u32 val)
+{
+	return val;
+}
+
+static inline __u64 virtio_guest_to_host_u64(struct virt_queue *vq, __u64 val)
+{
+	return val;
+}
+
+static inline __u64 virtio_host_to_guest_u64(struct virt_queue *vq, __u64 val)
+{
+	return val;
+}
+
+static inline u16 virtio_features_to_endian(u32 features)
+{
+	return VIRTIO_ENDIAN_HOST;
+}
+#endif
 
 static inline void virt_queue__init(struct virt_queue *vq, u32 features)
 {
-	vq->endian = VIRTIO_ENDIAN_HOST;
+	vq->endian = virtio_features_to_endian(features);
 }
 
 static inline u16 virt_queue__pop(struct virt_queue *queue)
 {
-	return queue->vring.avail->ring[queue->last_avail_idx++ % queue->vring.num];
+	__u16 guest_idx;
+
+	guest_idx = queue->vring.avail->ring[queue->last_avail_idx++ % queue->vring.num];
+	return virtio_guest_to_host_u16(queue, guest_idx);
 }
 
 static inline struct vring_desc *virt_queue__get_desc(struct virt_queue *queue, u16 desc_ndx)
@@ -50,8 +231,8 @@ static inline bool virt_queue__available(struct virt_queue *vq)
 	if (!vq->vring.avail)
 		return 0;
 
-	vring_avail_event(&vq->vring) = vq->last_avail_idx;
-	return vq->vring.avail->idx !=  vq->last_avail_idx;
+	vring_avail_event(&vq->vring) = virtio_host_to_guest_u16(vq, vq->last_avail_idx);
+	return virtio_guest_to_host_u16(vq, vq->vring.avail->idx) != vq->last_avail_idx;
 }
 
 struct vring_used_elem *virt_queue__set_used_elem(struct virt_queue *queue, u32 head, u32 len);
diff --git a/tools/kvm/virtio/core.c b/tools/kvm/virtio/core.c
index 2dfb828..9ae7887 100644
--- a/tools/kvm/virtio/core.c
+++ b/tools/kvm/virtio/core.c
@@ -15,10 +15,11 @@
 struct vring_used_elem *virt_queue__set_used_elem(struct virt_queue *queue, u32 head, u32 len)
 {
 	struct vring_used_elem *used_elem;
+	u16 idx = virtio_guest_to_host_u16(queue, queue->vring.used->idx);
 
-	used_elem	= &queue->vring.used->ring[queue->vring.used->idx % queue->vring.num];
-	used_elem->id	= head;
-	used_elem->len	= len;
+	used_elem	= &queue->vring.used->ring[idx % queue->vring.num];
+	used_elem->id	= virtio_host_to_guest_u32(queue, head);
+	used_elem->len	= virtio_host_to_guest_u32(queue, len);
 
 	/*
 	 * Use wmb to assure that used elem was updated with head and len.
@@ -26,7 +27,8 @@ struct vring_used_elem *virt_queue__set_used_elem(struct virt_queue *queue, u32
 	 * to pass the used element to the guest.
 	 */
 	wmb();
-	queue->vring.used->idx++;
+	idx++;
+	queue->vring.used->idx = virtio_host_to_guest_u16(queue, idx);
 
 	/*
 	 * Use wmb to assure used idx has been increased before we signal the guest.
@@ -38,22 +40,28 @@ struct vring_used_elem *virt_queue__set_used_elem(struct virt_queue *queue, u32
 	return used_elem;
 }
 
+static inline bool virt_desc__test_flag(struct virt_queue *vq,
+					struct vring_desc *desc, u16 flag)
+{
+	return !!(virtio_guest_to_host_u16(vq, desc->flags) & flag);
+}
+
 /*
  * Each buffer in the virtqueues is actually a chain of descriptors.  This
  * function returns the next descriptor in the chain, or vq->vring.num if we're
  * at the end.
  */
-static unsigned next_desc(struct vring_desc *desc,
+static unsigned next_desc(struct virt_queue *vq, struct vring_desc *desc,
 			  unsigned int i, unsigned int max)
 {
 	unsigned int next;
 
 	/* If this descriptor says it doesn't chain, we're done. */
-	if (!(desc[i].flags & VRING_DESC_F_NEXT))
+	if (!virt_desc__test_flag(vq, &desc[i], VRING_DESC_F_NEXT))
 		return max;
 
 	/* Check they're not leading us off end of descriptors. */
-	next = desc[i].next;
+	next = virtio_guest_to_host_u16(vq, desc[i].next);
 	/* Make sure compiler knows to grab that: we don't want it changing! */
 	wmb();
 
@@ -71,22 +79,23 @@ u16 virt_queue__get_head_iov(struct virt_queue *vq, struct iovec iov[], u16 *out
 	max = vq->vring.num;
 	desc = vq->vring.desc;
 
-	if (desc[idx].flags & VRING_DESC_F_INDIRECT) {
-		max = desc[idx].len / sizeof(struct vring_desc);
-		desc = guest_flat_to_host(kvm, desc[idx].addr);
+	if (virt_desc__test_flag(vq, &desc[idx], VRING_DESC_F_INDIRECT)) {
+		max = virtio_guest_to_host_u32(vq, desc[idx].len) / sizeof(struct vring_desc);
+		desc = guest_flat_to_host(kvm, virtio_guest_to_host_u64(vq, desc[idx].addr));
 		idx = 0;
 	}
 
 	do {
 		/* Grab the first descriptor, and check it's OK. */
-		iov[*out + *in].iov_len = desc[idx].len;
-		iov[*out + *in].iov_base = guest_flat_to_host(kvm, desc[idx].addr);
+		iov[*out + *in].iov_len = virtio_guest_to_host_u32(vq, desc[idx].len);
+		iov[*out + *in].iov_base = guest_flat_to_host(kvm,
+							      virtio_guest_to_host_u64(vq, desc[idx].addr));
 		/* If this is an input descriptor, increment that count. */
-		if (desc[idx].flags & VRING_DESC_F_WRITE)
+		if (virt_desc__test_flag(vq, &desc[idx], VRING_DESC_F_WRITE))
 			(*in)++;
 		else
 			(*out)++;
-	} while ((idx = next_desc(desc, idx, max)) != max);
+	} while ((idx = next_desc(vq, desc, idx, max)) != max);
 
 	return head;
 }
@@ -111,20 +120,20 @@ u16 virt_queue__get_inout_iov(struct kvm *kvm, struct virt_queue *queue,
 	idx = head = virt_queue__pop(queue);
 	*out = *in = 0;
 	do {
+		u64 addr;
 		desc = virt_queue__get_desc(queue, idx);
-		if (desc->flags & VRING_DESC_F_WRITE) {
-			in_iov[*in].iov_base = guest_flat_to_host(kvm,
-								  desc->addr);
-			in_iov[*in].iov_len = desc->len;
+		addr = virtio_guest_to_host_u64(queue, desc->addr);
+		if (virt_desc__test_flag(queue, desc, VRING_DESC_F_WRITE)) {
+			in_iov[*in].iov_base = guest_flat_to_host(kvm, addr);
+			in_iov[*in].iov_len = virtio_guest_to_host_u32(queue, desc->len);
 			(*in)++;
 		} else {
-			out_iov[*out].iov_base = guest_flat_to_host(kvm,
-								    desc->addr);
-			out_iov[*out].iov_len = desc->len;
+			out_iov[*out].iov_base = guest_flat_to_host(kvm, addr);
+			out_iov[*out].iov_len = virtio_guest_to_host_u32(queue, desc->len);
 			(*out)++;
 		}
-		if (desc->flags & VRING_DESC_F_NEXT)
-			idx = desc->next;
+		if (virt_desc__test_flag(queue, desc, VRING_DESC_F_NEXT))
+			idx = virtio_guest_to_host_u16(queue, desc->next);
 		else
 			break;
 	} while (1);
@@ -151,8 +160,8 @@ bool virtio_queue__should_signal(struct virt_queue *vq)
 	u16 old_idx, new_idx, event_idx;
 
 	old_idx		= vq->last_used_signalled;
-	new_idx		= vq->vring.used->idx;
-	event_idx	= vring_used_event(&vq->vring);
+	new_idx		= virtio_guest_to_host_u16(vq, vq->vring.used->idx);
+	event_idx	= virtio_guest_to_host_u16(vq, vring_used_event(&vq->vring));
 
 	if (vring_need_event(event_idx, new_idx, old_idx)) {
 		vq->last_used_signalled = new_idx;
-- 
1.8.2.3
