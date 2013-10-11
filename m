From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Oct 2013 15:36:09 +0100
Subject: [PATCH 1/3] virtio: let the guest report its endianess if advertized
 by the host
In-Reply-To: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1381502171-8187-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for a guest to report its endianess, we introduce a pair of
per-ring flags: VIRTIO_RING_F_GUEST_{LE,BE}.

A host is allowed to advertise support for either or both endianess
for this ring. If it advertises none, it is assumed to be able to
handle the guest (best effort).

A guest is allowed to select one of the endiannesses advertised by
the host (but obviously not both). If none is selected, it is assumed
to be of an endianness compatible with the host (best effort).

This mechanism allows the host to deal with guests of different
endiannesses.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/virtio/virtio_ring.c     | 8 ++++++++
 include/uapi/linux/virtio_ring.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6b4a4db..efff20a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -813,6 +813,14 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_RING_F_EVENT_IDX:
 			break;
+#ifdef __LITTLE_ENDIAN
+		case VIRTIO_RING_F_GUEST_LE:
+			break;
+#endif
+#ifdef __BIG_ENDIAN
+		case VIRTIO_RING_F_GUEST_BE:
+			break;
+#endif
 		default:
 			/* We don't understand this bit. */
 			clear_bit(i, vdev->features);
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index a99f9b7..496b46a 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -58,6 +58,14 @@
  * at the end of the used ring. Guest should ignore the used->flags field. */
 #define VIRTIO_RING_F_EVENT_IDX		29
 
+/* The Host can advertise to support either or both endianness for the vring.
+ * If it advertise none, it is assumed to be able to handle the Guest
+ * endianness.
+ * The Guest can select either (but not both) endianness. If it selects none,
+ * it is assumed to be of an endianness compatible with the Host. */
+#define VIRTIO_RING_F_GUEST_LE		30
+#define VIRTIO_RING_F_GUEST_BE		31
+
 /* Virtio ring descriptors: 16 bytes.  These can chain together via "next". */
 struct vring_desc {
 	/* Address (guest-physical). */
-- 
1.8.2.3
