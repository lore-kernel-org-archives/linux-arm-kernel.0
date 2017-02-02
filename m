From: andre.przywara@arm.com (Andre Przywara)
Date: Thu,  2 Feb 2017 16:32:20 +0000
Subject: [kvmtool PATCH v9 12/15] PCI: inject PCI device ID on MSI injection
In-Reply-To: <20170202163223.15372-1-andre.przywara@arm.com>
References: <20170202163223.15372-1-andre.przywara@arm.com>
Message-ID: <20170202163223.15372-13-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ITS emulation requires a unique device ID to be passed along the
MSI payload when kvmtool wants to trigger an MSI in the guest.
According to the proposed changes to the interface add the PCI
bus/device/function triple to the structure passed with the ioctl.
Check the respective capability before actually adding the device ID
to the kvm_msi struct.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virtio/pci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/virtio/pci.c b/virtio/pci.c
index 98bf6b7..cecfe8a 100644
--- a/virtio/pci.c
+++ b/virtio/pci.c
@@ -321,14 +321,28 @@ static void virtio_pci__msix_mmio_callback(struct kvm_cpu *vcpu,
 		update_msix_map(vpci, table, vecnum);
 }
 
-static void virtio_pci__signal_msi(struct kvm *kvm, struct virtio_pci *vpci, int vec)
+static void virtio_pci__signal_msi(struct kvm *kvm, struct virtio_pci *vpci,
+				   int vec)
 {
+	static int needs_devid = 0;
 	struct kvm_msi msi = {
 		.address_lo = vpci->msix_table[vec].msg.address_lo,
 		.address_hi = vpci->msix_table[vec].msg.address_hi,
 		.data = vpci->msix_table[vec].msg.data,
 	};
 
+	if (needs_devid == 0) {
+		if (kvm__supports_vm_extension(kvm, KVM_CAP_MSI_DEVID))
+			needs_devid = 1;
+		else
+			needs_devid = -1;
+	}
+
+	if (needs_devid > 0) {
+		msi.flags = KVM_MSI_VALID_DEVID;
+		msi.devid = vpci->dev_hdr.dev_num << 3;
+	}
+
 	ioctl(kvm->vm_fd, KVM_SIGNAL_MSI, &msi);
 }
 
-- 
2.9.0
