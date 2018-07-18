From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 18 Jul 2018 10:18:44 +0100
Subject: [PATCH v4 01/20] virtio: mmio-v1: Validate queue PFN
In-Reply-To: <1531905547-25478-1-git-send-email-suzuki.poulose@arm.com>
References: <1531905547-25478-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1531905547-25478-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

virtio-mmio with virtio-v1 uses a 32bit PFN for the queue.
If the queue pfn is too large to fit in 32bits, which
we could hit on arm64 systems with 52bit physical addresses
(even with 64K page size), we simply miss out a proper link
to the other side of the queue.

Add a check to validate the PFN, rather than silently breaking
the devices.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Cc: Peter Maydel <peter.maydell@linaro.org>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v2:
 - Change errno to -E2BIG
---
 drivers/virtio/virtio_mmio.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 67763d3..4cd9ea5 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -397,9 +397,23 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 	/* Activate the queue */
 	writel(virtqueue_get_vring_size(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
 	if (vm_dev->version == 1) {
+		u64 q_pfn = virtqueue_get_desc_addr(vq) >> PAGE_SHIFT;
+
+		/*
+		 * virtio-mmio v1 uses a 32bit QUEUE PFN. If we have something
+		 * that doesn't fit in 32bit, fail the setup rather than
+		 * pretending to be successful.
+		 */
+		if (q_pfn >> 32) {
+			dev_err(&vdev->dev,
+				"platform bug: legacy virtio-mmio must not be used with RAM above 0x%llxGB\n",
+				0x1ULL << (32 + PAGE_SHIFT - 30));
+			err = -E2BIG;
+			goto error_bad_pfn;
+		}
+
 		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
-		writel(virtqueue_get_desc_addr(vq) >> PAGE_SHIFT,
-				vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
+		writel(q_pfn, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
 	} else {
 		u64 addr;
 
@@ -430,6 +444,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 
 	return vq;
 
+error_bad_pfn:
+	vring_del_virtqueue(vq);
 error_new_virtqueue:
 	if (vm_dev->version == 1) {
 		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
-- 
2.7.4
