From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Oct 2013 15:36:32 +0100
Subject: [PATCH 4/7] kvmtool: convert 9p backend to support bi-endianness
In-Reply-To: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
References: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1381502195-8263-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Advertise bi-endianness support in the feature flags, and provide
byte-swapping of the config structure depending on the guest selection.

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 tools/kvm/virtio/9p.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/kvm/virtio/9p.c b/tools/kvm/virtio/9p.c
index 127b13a..b823306 100644
--- a/tools/kvm/virtio/9p.c
+++ b/tools/kvm/virtio/9p.c
@@ -1245,14 +1245,16 @@ static u8 *get_config(struct kvm *kvm, void *dev)
 
 static u32 get_host_features(struct kvm *kvm, void *dev)
 {
-	return 1 << VIRTIO_9P_MOUNT_TAG;
+	return (1 << VIRTIO_9P_MOUNT_TAG) | VIRTIO_RING_ENDIAN;
 }
 
 static void set_guest_features(struct kvm *kvm, void *dev, u32 features)
 {
 	struct p9_dev *p9dev = dev;
+	struct virtio_9p_config *conf = p9dev->config;
 
 	p9dev->features = features;
+	conf->tag_len = htole16(conf->tag_len);
 }
 
 static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
@@ -1271,6 +1273,7 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 	job		= &p9dev->jobs[vq];
 
 	vring_init(&queue->vring, VIRTQUEUE_NUM, p, align);
+	virt_queue__init(queue, p9dev->features);
 
 	*job		= (struct p9_dev_job) {
 		.vq		= queue,
-- 
1.8.2.3
