From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 25 Apr 2017 15:39:23 +0100
Subject: [kvmtool PATCH v10 06/15] PCI: Only allocate IRQ routing entry when
 available
In-Reply-To: <20170425143932.17235-1-andre.przywara@arm.com>
References: <20170425143932.17235-1-andre.przywara@arm.com>
Message-ID: <20170425143932.17235-7-andre.przywara@arm.com>
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
 virtio/pci.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/virtio/pci.c b/virtio/pci.c
index e9f36c7..04176c1 100644
--- a/virtio/pci.c
+++ b/virtio/pci.c
@@ -193,8 +193,20 @@ static bool virtio_pci__specific_io_out(struct kvm *kvm, struct virtio_device *v
 
 			gsi = irq__add_msix_route(kvm,
 						  &vpci->msix_table[vec].msg);
-			if (gsi >= 0)
-				vpci->config_gsi = gsi;
+			/*
+			 * We don't need IRQ routing if we can use
+			 * MSI injection via the KVM_SIGNAL_MSI ioctl.
+			 */
+			if (gsi == -ENXIO &&
+			    vpci->features & VIRTIO_PCI_F_SIGNAL_MSI)
+				break;
+
+			if (gsi < 0) {
+				die("failed to configure MSIs");
+				break;
+			}
+
+			vpci->config_gsi = gsi;
 			break;
 		case VIRTIO_MSI_QUEUE_VECTOR:
 			vec = ioport__read16(data);
@@ -205,8 +217,19 @@ static bool virtio_pci__specific_io_out(struct kvm *kvm, struct virtio_device *v
 
 			gsi = irq__add_msix_route(kvm,
 						  &vpci->msix_table[vec].msg);
-			if (gsi < 0)
+			/*
+			 * We don't need IRQ routing if we can use
+			 * MSI injection via the KVM_SIGNAL_MSI ioctl.
+			 */
+			if (gsi == -ENXIO &&
+			    vpci->features & VIRTIO_PCI_F_SIGNAL_MSI)
 				break;
+
+			if (gsi < 0) {
+				die("failed to configure MSIs");
+				break;
+			}
+
 			vpci->gsis[vpci->queue_selector] = gsi;
 			if (vdev->ops->notify_vq_gsi)
 				vdev->ops->notify_vq_gsi(kvm, vpci->dev,
-- 
2.9.0
