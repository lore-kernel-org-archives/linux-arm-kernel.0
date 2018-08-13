From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Aug 2018 15:57:38 +0100
Subject: [PATCH 20/37] KVM: arm/arm64: vgic: Let userspace opt-in to writable
 v2 IGROUPR
In-Reply-To: <20180813145755.16566-1-marc.zyngier@arm.com>
References: <20180813145755.16566-1-marc.zyngier@arm.com>
Message-ID: <20180813145755.16566-21-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@arm.com>

Simply letting IGROUPR be writable from userspace would break
migration from old kernels to newer kernels, because old kernels
incorrectly report interrupt groups as group 1.  This would not be a big
problem if userspace wrote GICD_IIDR as read from the kernel, because we
could detect the incompatibility and return an error to userspace.
Unfortunately, this is not the case with current userspace
implementations and simply letting IGROUPR be writable from userspace for
an emulated GICv2 silently breaks migration and causes the destination
VM to no longer run after migration.

We now encourage userspace to write the read and expected value of
GICD_IIDR as the first part of a GIC register restore, and if we observe
a write to GICD_IIDR we know that userspace has been updated and has had
a chance to cope with older kernels (VGICv2 IIDR.Revision == 0)
incorrectly reporting interrupts as group 1, and therefore we now allow
groups to be user writable.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h           |  3 +++
 virt/kvm/arm/vgic/vgic-mmio-v2.c | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index c661d0ee6628..c134790be32c 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -221,6 +221,9 @@ struct vgic_dist {
 	/* Implementation revision as reported in the GICD_IIDR */
 	u32			implementation_rev;
 
+	/* Userspace can write to GICv2 IGROUPR */
+	bool			v2_groups_user_writable;
+
 	/* Do injected MSIs require an additional device ID? */
 	bool			msis_require_devid;
 
diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio-v2.c
index ee164f831401..26654f4140ed 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
@@ -85,6 +85,18 @@ static int vgic_mmio_uaccess_write_v2_misc(struct kvm_vcpu *vcpu,
 	case GIC_DIST_IIDR:
 		if (val != vgic_mmio_read_v2_misc(vcpu, addr, len))
 			return -EINVAL;
+
+		/*
+		 * If we observe a write to GICD_IIDR we know that userspace
+		 * has been updated and has had a chance to cope with older
+		 * kernels (VGICv2 IIDR.Revision == 0) incorrectly reporting
+		 * interrupts as group 1, and therefore we now allow groups to
+		 * be user writable.  Doing this by default would break
+		 * migration from old kernels to new kernels with legacy
+		 * userspace.
+		 */
+		vcpu->kvm->arch.vgic.v2_groups_user_writable = true;
+		return 0;
 	}
 
 	vgic_mmio_write_v2_misc(vcpu, addr, len, val);
@@ -95,7 +107,9 @@ static int vgic_mmio_uaccess_write_v2_group(struct kvm_vcpu *vcpu,
 					    gpa_t addr, unsigned int len,
 					    unsigned long val)
 {
-	/* Ignore writes from userspace */
+	if (vcpu->kvm->arch.vgic.v2_groups_user_writable)
+		vgic_mmio_write_group(vcpu, addr, len, val);
+
 	return 0;
 }
 
-- 
2.18.0
