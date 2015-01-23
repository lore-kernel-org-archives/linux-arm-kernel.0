From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:03:03 +0100
Subject: [GIT PULL 34/36] arm/arm64: KVM: force alignment of VGIC
 dist/CPU/redist addresses
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-35-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

Although the GIC architecture requires us to map the MMIO regions
only at page aligned addresses, we currently do not enforce this from
the kernel side.
Restrict any vGICv2 regions to be 4K aligned and any GICv3 regions
to be 64K aligned. Document this requirement.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 Documentation/virtual/kvm/devices/arm-vgic.txt |  4 ++++
 virt/kvm/arm/vgic.c                            | 16 +++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
index 5d4fd4b..3fb9054 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
@@ -20,20 +20,24 @@ Groups:
     KVM_VGIC_V2_ADDR_TYPE_DIST (rw, 64-bit)
       Base address in the guest physical address space of the GIC distributor
       register mappings. Only valid for KVM_DEV_TYPE_ARM_VGIC_V2.
+      This address needs to be 4K aligned and the region covers 4 KByte.
 
     KVM_VGIC_V2_ADDR_TYPE_CPU (rw, 64-bit)
       Base address in the guest physical address space of the GIC virtual cpu
       interface register mappings. Only valid for KVM_DEV_TYPE_ARM_VGIC_V2.
+      This address needs to be 4K aligned and the region covers 4 KByte.
 
     KVM_VGIC_V3_ADDR_TYPE_DIST (rw, 64-bit)
       Base address in the guest physical address space of the GICv3 distributor
       register mappings. Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
+      This address needs to be 64K aligned and the region covers 64 KByte.
 
     KVM_VGIC_V3_ADDR_TYPE_REDIST (rw, 64-bit)
       Base address in the guest physical address space of the GICv3
       redistributor register mappings. There are two 64K pages for each
       VCPU and all of the redistributor pages are contiguous.
       Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
+      This address needs to be 64K aligned.
 
 
   KVM_DEV_ARM_VGIC_GRP_DIST_REGS
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 184c6db..0cc6ab6 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1683,6 +1683,7 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
 	struct vgic_dist *vgic = &kvm->arch.vgic;
 	int type_needed;
 	phys_addr_t *addr_ptr, block_size;
+	phys_addr_t alignment;
 
 	mutex_lock(&kvm->lock);
 	switch (type) {
@@ -1690,22 +1691,26 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
 		type_needed = KVM_DEV_TYPE_ARM_VGIC_V2;
 		addr_ptr = &vgic->vgic_dist_base;
 		block_size = KVM_VGIC_V2_DIST_SIZE;
+		alignment = SZ_4K;
 		break;
 	case KVM_VGIC_V2_ADDR_TYPE_CPU:
 		type_needed = KVM_DEV_TYPE_ARM_VGIC_V2;
 		addr_ptr = &vgic->vgic_cpu_base;
 		block_size = KVM_VGIC_V2_CPU_SIZE;
+		alignment = SZ_4K;
 		break;
 #ifdef CONFIG_ARM_GIC_V3
 	case KVM_VGIC_V3_ADDR_TYPE_DIST:
 		type_needed = KVM_DEV_TYPE_ARM_VGIC_V3;
 		addr_ptr = &vgic->vgic_dist_base;
 		block_size = KVM_VGIC_V3_DIST_SIZE;
+		alignment = SZ_64K;
 		break;
 	case KVM_VGIC_V3_ADDR_TYPE_REDIST:
 		type_needed = KVM_DEV_TYPE_ARM_VGIC_V3;
 		addr_ptr = &vgic->vgic_redist_base;
 		block_size = KVM_VGIC_V3_REDIST_SIZE;
+		alignment = SZ_64K;
 		break;
 #endif
 	default:
@@ -1718,10 +1723,15 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
 		goto out;
 	}
 
-	if (write)
-		r = vgic_ioaddr_assign(kvm, addr_ptr, *addr, block_size);
-	else
+	if (write) {
+		if (!IS_ALIGNED(*addr, alignment))
+			r = -EINVAL;
+		else
+			r = vgic_ioaddr_assign(kvm, addr_ptr, *addr,
+					       block_size);
+	} else {
 		*addr = *addr_ptr;
+	}
 
 out:
 	mutex_unlock(&kvm->lock);
-- 
2.1.2.330.g565301e.dirty
