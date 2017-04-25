From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 25 Apr 2017 15:39:29 +0100
Subject: [kvmtool PATCH v10 12/15] PCI: inject PCI device ID on MSI injection
In-Reply-To: <20170425143932.17235-1-andre.przywara@arm.com>
References: <20170425143932.17235-1-andre.przywara@arm.com>
Message-ID: <20170425143932.17235-13-andre.przywara@arm.com>
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
 arm/gic.c         | 3 +++
 include/kvm/kvm.h | 1 +
 virtio/pci.c      | 8 +++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arm/gic.c b/arm/gic.c
index 056fd09..651ede7 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -245,6 +245,9 @@ static int gic__init_gic(struct kvm *kvm)
 			return ret;
 	}
 
+	kvm->msix_needs_devid = kvm__supports_vm_extension(kvm,
+							   KVM_CAP_MSI_DEVID);
+
 	return 0;
 }
 late_init(gic__init_gic)
diff --git a/include/kvm/kvm.h b/include/kvm/kvm.h
index a76a25d..90463b8 100644
--- a/include/kvm/kvm.h
+++ b/include/kvm/kvm.h
@@ -63,6 +63,7 @@ struct kvm {
 	struct list_head	mem_banks;
 
 	bool			nmi_disabled;
+	bool			msix_needs_devid;
 
 	const char		*vmlinux;
 	struct disk_image       **disks;
diff --git a/virtio/pci.c b/virtio/pci.c
index 04176c1..f0e884c 100644
--- a/virtio/pci.c
+++ b/virtio/pci.c
@@ -334,7 +334,8 @@ static void virtio_pci__msix_mmio_callback(struct kvm_cpu *vcpu,
 		update_msix_map(vpci, table, vecnum);
 }
 
-static void virtio_pci__signal_msi(struct kvm *kvm, struct virtio_pci *vpci, int vec)
+static void virtio_pci__signal_msi(struct kvm *kvm, struct virtio_pci *vpci,
+				   int vec)
 {
 	struct kvm_msi msi = {
 		.address_lo = vpci->msix_table[vec].msg.address_lo,
@@ -342,6 +343,11 @@ static void virtio_pci__signal_msi(struct kvm *kvm, struct virtio_pci *vpci, int
 		.data = vpci->msix_table[vec].msg.data,
 	};
 
+	if (kvm->msix_needs_devid) {
+		msi.flags = KVM_MSI_VALID_DEVID;
+		msi.devid = vpci->dev_hdr.dev_num << 3;
+	}
+
 	ioctl(kvm->vm_fd, KVM_SIGNAL_MSI, &msi);
 }
 
-- 
2.9.0
