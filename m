From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 20 Jul 2016 18:04:26 +0100
Subject: [PATCH v7 06/15] PCI: Only allocate IRQ routing entry when available
In-Reply-To: <20160720170435.28090-1-andre.przywara@arm.com>
References: <20160720170435.28090-1-andre.przywara@arm.com>
Message-ID: <20160720170435.28090-7-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we need to inject an MSI into the guest, we rely at the moment on a
working GSI MSI routing functionality. However we can get away without
IRQ routing, if the host supports MSI injection via the KVM_SIGNAL_MSI
ioctl.
So we try the GSI routing first, but if that fails due to a missing
IRQ routing functionality, we fall back to KVM_SIGNAL_MSI (if that is
supported).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virtio/pci.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/virtio/pci.c b/virtio/pci.c
index b3b4aac..604b9ec 100644
--- a/virtio/pci.c
+++ b/virtio/pci.c
@@ -193,8 +193,14 @@ static bool virtio_pci__specific_io_out(struct kvm *kvm, struct virtio_device *v
 
 			gsi = irq__add_msix_route(kvm,
 						  &vpci->msix_table[vec].msg);
-			if (gsi >= 0)
+			if (gsi >= 0) {
 				vpci->config_gsi = gsi;
+				break;
+			}
+			if (gsi == -ENXIO &&
+			    vpci->features & VIRTIO_PCI_F_SIGNAL_MSI)
+					break;
+			die("failed to configure MSIs");
 			break;
 		case VIRTIO_MSI_QUEUE_VECTOR:
 			vec = ioport__read16(data);
@@ -205,8 +211,14 @@ static bool virtio_pci__specific_io_out(struct kvm *kvm, struct virtio_device *v
 
 			gsi = irq__add_msix_route(kvm,
 						  &vpci->msix_table[vec].msg);
-			if (gsi < 0)
+			if (gsi < 0) {
+				if (gsi == -ENXIO &&
+				    vpci->features & VIRTIO_PCI_F_SIGNAL_MSI)
+					break;
+
+				die("failed to configure MSIs");
 				break;
+			}
 			vpci->gsis[vpci->queue_selector] = gsi;
 			if (vdev->ops->notify_vq_gsi)
 				vdev->ops->notify_vq_gsi(kvm, vpci->dev,
-- 
2.9.0
