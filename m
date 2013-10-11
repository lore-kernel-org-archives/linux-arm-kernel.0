From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Oct 2013 15:36:33 +0100
Subject: [PATCH 5/7] kvmtool: convert blk backend to support bi-endianness
In-Reply-To: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
References: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1381502195-8263-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Advertise bi-endianness support in the feature flags, and provide
byte-swapping of the config structure depending on the guest selection.

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 tools/kvm/virtio/blk.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/kvm/virtio/blk.c b/tools/kvm/virtio/blk.c
index ab18716..237bf56 100644
--- a/tools/kvm/virtio/blk.c
+++ b/tools/kvm/virtio/blk.c
@@ -77,13 +77,15 @@ void virtio_blk_complete(void *param, long len)
 		bdev->vdev.ops->signal_vq(req->kvm, &bdev->vdev, queueid);
 }
 
-static void virtio_blk_do_io_request(struct kvm *kvm, struct blk_dev_req *req)
+static void virtio_blk_do_io_request(struct kvm *kvm, struct virt_queue *vq, struct blk_dev_req *req)
 {
 	struct virtio_blk_outhdr *req_hdr;
 	ssize_t block_cnt;
 	struct blk_dev *bdev;
 	struct iovec *iov;
 	u16 out, in;
+	u32 type;
+	u64 sector;
 
 	block_cnt	= -1;
 	bdev		= req->bdev;
@@ -92,13 +94,16 @@ static void virtio_blk_do_io_request(struct kvm *kvm, struct blk_dev_req *req)
 	in		= req->in;
 	req_hdr		= iov[0].iov_base;
 
-	switch (req_hdr->type) {
+	type = virtio_guest_to_host_u32(vq, req_hdr->type);
+	sector = virtio_guest_to_host_u64(vq, req_hdr->sector);
+
+	switch (type) {
 	case VIRTIO_BLK_T_IN:
-		block_cnt = disk_image__read(bdev->disk, req_hdr->sector,
+		block_cnt = disk_image__read(bdev->disk, sector,
 				iov + 1, in + out - 2, req);
 		break;
 	case VIRTIO_BLK_T_OUT:
-		block_cnt = disk_image__write(bdev->disk, req_hdr->sector,
+		block_cnt = disk_image__write(bdev->disk, sector,
 				iov + 1, in + out - 2, req);
 		break;
 	case VIRTIO_BLK_T_FLUSH:
@@ -112,7 +117,7 @@ static void virtio_blk_do_io_request(struct kvm *kvm, struct blk_dev_req *req)
 		virtio_blk_complete(req, block_cnt);
 		break;
 	default:
-		pr_warning("request type %d", req_hdr->type);
+		pr_warning("request type %d", type);
 		block_cnt	= -1;
 		break;
 	}
@@ -130,7 +135,7 @@ static void virtio_blk_do_io(struct kvm *kvm, struct virt_queue *vq, struct blk_
 					&req->in, head, kvm);
 		req->vq		= vq;
 
-		virtio_blk_do_io_request(kvm, req);
+		virtio_blk_do_io_request(kvm, vq, req);
 	}
 }
 
@@ -146,14 +151,28 @@ static u32 get_host_features(struct kvm *kvm, void *dev)
 	return	1UL << VIRTIO_BLK_F_SEG_MAX
 		| 1UL << VIRTIO_BLK_F_FLUSH
 		| 1UL << VIRTIO_RING_F_EVENT_IDX
-		| 1UL << VIRTIO_RING_F_INDIRECT_DESC;
+		| 1UL << VIRTIO_RING_F_INDIRECT_DESC
+		| VIRTIO_RING_ENDIAN;
 }
 
 static void set_guest_features(struct kvm *kvm, void *dev, u32 features)
 {
 	struct blk_dev *bdev = dev;
+	struct virtio_blk_config *conf = &bdev->blk_config;
+	struct virtio_blk_geometry *geo = &conf->geometry;
 
 	bdev->features = features;
+
+	conf->capacity = htole64(conf->capacity);
+	conf->size_max = htole32(conf->size_max);
+	conf->seg_max = htole32(conf->seg_max);
+
+	/* Geometry */
+	geo->cylinders = htole16(geo->cylinders);
+
+	conf->blk_size = htole32(conf->blk_size);
+	conf->min_io_size = htole16(conf->min_io_size);
+	conf->opt_io_size = htole32(conf->opt_io_size);
 }
 
 static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
@@ -170,6 +189,7 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 	p		= virtio_get_vq(kvm, queue->pfn, page_size);
 
 	vring_init(&queue->vring, VIRTIO_BLK_QUEUE_SIZE, p, align);
+	virt_queue__init(queue, bdev->features);
 
 	return 0;
 }
-- 
1.8.2.3
