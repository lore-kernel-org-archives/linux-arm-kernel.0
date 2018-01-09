From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  9 Jan 2018 19:04:12 +0000
Subject: [kvmtool hack 1/3] virtio: Handle aborts using invalid PFN
In-Reply-To: <20180109190414.4017-1-suzuki.poulose@arm.com>
References: <20180109190414.4017-1-suzuki.poulose@arm.com>
Message-ID: <20180109190414.4017-18-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the host fails to complete the shake hand due to various
reasons. e.g, for PCI and MMIO, if 0 is written as the PFN,
it implies the host has given up and simply don't take any
action.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 virtio/mmio.c | 14 ++++++++------
 virtio/pci.c  | 10 ++++++----
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/virtio/mmio.c b/virtio/mmio.c
index f0af4bd..ba02358 100644
--- a/virtio/mmio.c
+++ b/virtio/mmio.c
@@ -188,12 +188,14 @@ static void virtio_mmio_config_out(struct kvm_cpu *vcpu,
 		break;
 	case VIRTIO_MMIO_QUEUE_PFN:
 		val = ioport__read32(data);
-		virtio_mmio_init_ioeventfd(vmmio->kvm, vdev, vmmio->hdr.queue_sel);
-		vdev->ops->init_vq(vmmio->kvm, vmmio->dev,
-				   vmmio->hdr.queue_sel,
-				   vmmio->hdr.guest_page_size,
-				   vmmio->hdr.queue_align,
-				   val);
+		if (val) {
+			virtio_mmio_init_ioeventfd(vmmio->kvm, vdev, vmmio->hdr.queue_sel);
+			vdev->ops->init_vq(vmmio->kvm, vmmio->dev,
+					   vmmio->hdr.queue_sel,
+					   vmmio->hdr.guest_page_size,
+					   vmmio->hdr.queue_align,
+					   val);
+		}
 		break;
 	case VIRTIO_MMIO_QUEUE_NOTIFY:
 		val = ioport__read32(data);
diff --git a/virtio/pci.c b/virtio/pci.c
index 4ce1111..3c694c2 100644
--- a/virtio/pci.c
+++ b/virtio/pci.c
@@ -271,10 +271,12 @@ static bool virtio_pci__io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16
 		break;
 	case VIRTIO_PCI_QUEUE_PFN:
 		val = ioport__read32(data);
-		virtio_pci__init_ioeventfd(kvm, vdev, vpci->queue_selector);
-		vdev->ops->init_vq(kvm, vpci->dev, vpci->queue_selector,
-				   1 << VIRTIO_PCI_QUEUE_ADDR_SHIFT,
-				   VIRTIO_PCI_VRING_ALIGN, val);
+		if (val) {
+			virtio_pci__init_ioeventfd(kvm, vdev, vpci->queue_selector);
+			vdev->ops->init_vq(kvm, vpci->dev, vpci->queue_selector,
+					   1 << VIRTIO_PCI_QUEUE_ADDR_SHIFT,
+					   VIRTIO_PCI_VRING_ALIGN, val);
+		}
 		break;
 	case VIRTIO_PCI_QUEUE_SEL:
 		vpci->queue_selector = ioport__read16(data);
-- 
2.13.6
