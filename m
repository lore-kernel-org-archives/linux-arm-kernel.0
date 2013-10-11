From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Oct 2013 15:36:31 +0100
Subject: [PATCH 3/7] kvmtool: convert console backend to support bi-endianness
In-Reply-To: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
References: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1381502195-8263-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Advertise bi-endianness support in the feature flags, and provide
byte-swapping of the config structure depending on the guest selection.

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 tools/kvm/virtio/console.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/kvm/virtio/console.c b/tools/kvm/virtio/console.c
index f982dab7..ac041df 100644
--- a/tools/kvm/virtio/console.c
+++ b/tools/kvm/virtio/console.c
@@ -126,12 +126,19 @@ static u8 *get_config(struct kvm *kvm, void *dev)
 
 static u32 get_host_features(struct kvm *kvm, void *dev)
 {
-	return 0;
+	return VIRTIO_RING_ENDIAN;
 }
 
 static void set_guest_features(struct kvm *kvm, void *dev, u32 features)
 {
-	/* Unused */
+	struct con_dev *cdev = dev;
+	struct virtio_console_config *conf = &cdev->config;
+
+	cdev->features = features;
+
+	conf->cols = htole16(conf->cols);
+	conf->rows = htole16(conf->rows);
+	conf->max_nr_ports = htole32(conf->max_nr_ports);
 }
 
 static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
@@ -149,6 +156,7 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 	p		= virtio_get_vq(kvm, queue->pfn, page_size);
 
 	vring_init(&queue->vring, VIRTIO_CONSOLE_QUEUE_SIZE, p, align);
+	virt_queue__init(queue, cdev.features);
 
 	if (vq == VIRTIO_CONSOLE_TX_QUEUE) {
 		thread_pool__init_job(&cdev.jobs[vq], kvm, virtio_console_handle_callback, queue);
-- 
1.8.2.3
