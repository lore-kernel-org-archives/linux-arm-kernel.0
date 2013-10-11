From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Oct 2013 15:36:34 +0100
Subject: [PATCH 6/7] kvmtool: convert net backend to support bi-endianness
In-Reply-To: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
References: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1381502195-8263-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Advertise bi-endianness support in the feature flags, and provide
byte-swapping of the config structure depending on the guest selection.

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 tools/kvm/virtio/net.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/kvm/virtio/net.c b/tools/kvm/virtio/net.c
index 2c34996..1c07a98 100644
--- a/tools/kvm/virtio/net.c
+++ b/tools/kvm/virtio/net.c
@@ -116,8 +116,10 @@ static void *virtio_net_rx_thread(void *p)
 
 				memcpy_toiovecend(iov, buffer, copied, iovsize);
 				copied += iovsize;
-				if (has_virtio_feature(ndev, VIRTIO_NET_F_MRG_RXBUF))
-					hdr->num_buffers++;
+				if (has_virtio_feature(ndev, VIRTIO_NET_F_MRG_RXBUF)) {
+					u16 num_buffers = virtio_guest_to_host_u16(vq, hdr->num_buffers);
+					hdr->num_buffers = virtio_host_to_guest_u16(vq, num_buffers + 1);
+				}
 				virt_queue__set_used_elem(vq, head, iovsize);
 				if (copied == len)
 					break;
@@ -381,14 +383,19 @@ static u32 get_host_features(struct kvm *kvm, void *dev)
 		| 1UL << VIRTIO_RING_F_INDIRECT_DESC
 		| 1UL << VIRTIO_NET_F_CTRL_VQ
 		| 1UL << VIRTIO_NET_F_MRG_RXBUF
-		| 1UL << (ndev->queue_pairs > 1 ? VIRTIO_NET_F_MQ : 0);
+		| 1UL << (ndev->queue_pairs > 1 ? VIRTIO_NET_F_MQ : 0)
+		| VIRTIO_RING_ENDIAN;
 }
 
 static void set_guest_features(struct kvm *kvm, void *dev, u32 features)
 {
 	struct net_dev *ndev = dev;
+	struct virtio_net_config *conf = &ndev->config;
 
 	ndev->features = features;
+
+	conf->status = htole16(conf->status);
+	conf->max_virtqueue_pairs = htole16(conf->max_virtqueue_pairs);
 }
 
 static bool is_ctrl_vq(struct net_dev *ndev, u32 vq)
@@ -413,6 +420,7 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 	p		= virtio_get_vq(kvm, queue->pfn, page_size);
 
 	vring_init(&queue->vring, VIRTIO_NET_QUEUE_SIZE, p, align);
+	virt_queue__init(queue, ndev->features);
 
 	mutex_init(&ndev->io_lock[vq]);
 	pthread_cond_init(&ndev->io_cond[vq], NULL);
@@ -429,6 +437,9 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 		return 0;
 	}
 
+	if (queue->endian != VIRTIO_ENDIAN_HOST)
+		die_perror("VHOST requires VIRTIO_ENDIAN_HOST");
+
 	state.num = queue->vring.num;
 	r = ioctl(ndev->vhost_fd, VHOST_SET_VRING_NUM, &state);
 	if (r < 0)
-- 
1.8.2.3
