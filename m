From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:53 +0100
Subject: [GIT PULL 24/36] arm/arm64: KVM: refactor MMIO accessors
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-25-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

The MMIO accessors for GICD_I[CS]ENABLER, GICD_I[CS]PENDR and
GICD_ICFGR behave very similar for GICv2 and GICv3, although the way
the affected VCPU is determined differs.
Since we need them to access the registers from three different
places in the future, we factor out a generic, backend-facing
implementation and use small wrappers in the current GICv2 emulation.
This will ease adding GICv3 accessors later.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 126 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 74 insertions(+), 52 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 2126bf5..7589e2c 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -492,64 +492,66 @@ static bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu,
 	return false;
 }
 
-static bool handle_mmio_set_enable_reg(struct kvm_vcpu *vcpu,
-				       struct kvm_exit_mmio *mmio,
-				       phys_addr_t offset)
+static bool vgic_handle_enable_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
+				   phys_addr_t offset, int vcpu_id, int access)
 {
-	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_enabled,
-				       vcpu->vcpu_id, offset);
-	vgic_reg_access(mmio, reg, offset,
-			ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
+	u32 *reg;
+	int mode = ACCESS_READ_VALUE | access;
+	struct kvm_vcpu *target_vcpu = kvm_get_vcpu(kvm, vcpu_id);
+
+	reg = vgic_bitmap_get_reg(&kvm->arch.vgic.irq_enabled, vcpu_id, offset);
+	vgic_reg_access(mmio, reg, offset, mode);
 	if (mmio->is_write) {
-		vgic_update_state(vcpu->kvm);
+		if (access & ACCESS_WRITE_CLEARBIT) {
+			if (offset < 4) /* Force SGI enabled */
+				*reg |= 0xffff;
+			vgic_retire_disabled_irqs(target_vcpu);
+		}
+		vgic_update_state(kvm);
 		return true;
 	}
 
 	return false;
 }
 
+static bool handle_mmio_set_enable_reg(struct kvm_vcpu *vcpu,
+				       struct kvm_exit_mmio *mmio,
+				       phys_addr_t offset)
+{
+	return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
+				      vcpu->vcpu_id, ACCESS_WRITE_SETBIT);
+}
+
 static bool handle_mmio_clear_enable_reg(struct kvm_vcpu *vcpu,
 					 struct kvm_exit_mmio *mmio,
 					 phys_addr_t offset)
 {
-	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_enabled,
-				       vcpu->vcpu_id, offset);
-	vgic_reg_access(mmio, reg, offset,
-			ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
-	if (mmio->is_write) {
-		if (offset < 4) /* Force SGI enabled */
-			*reg |= 0xffff;
-		vgic_retire_disabled_irqs(vcpu);
-		vgic_update_state(vcpu->kvm);
-		return true;
-	}
-
-	return false;
+	return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
+				      vcpu->vcpu_id, ACCESS_WRITE_CLEARBIT);
 }
 
-static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
+static bool vgic_handle_set_pending_reg(struct kvm *kvm,
 					struct kvm_exit_mmio *mmio,
-					phys_addr_t offset)
+					phys_addr_t offset, int vcpu_id)
 {
 	u32 *reg, orig;
 	u32 level_mask;
-	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	int mode = ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT;
+	struct vgic_dist *dist = &kvm->arch.vgic;
 
-	reg = vgic_bitmap_get_reg(&dist->irq_cfg, vcpu->vcpu_id, offset);
+	reg = vgic_bitmap_get_reg(&dist->irq_cfg, vcpu_id, offset);
 	level_mask = (~(*reg));
 
 	/* Mark both level and edge triggered irqs as pending */
-	reg = vgic_bitmap_get_reg(&dist->irq_pending, vcpu->vcpu_id, offset);
+	reg = vgic_bitmap_get_reg(&dist->irq_pending, vcpu_id, offset);
 	orig = *reg;
-	vgic_reg_access(mmio, reg, offset,
-			ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
+	vgic_reg_access(mmio, reg, offset, mode);
 
 	if (mmio->is_write) {
 		/* Set the soft-pending flag only for level-triggered irqs */
 		reg = vgic_bitmap_get_reg(&dist->irq_soft_pend,
-					  vcpu->vcpu_id, offset);
-		vgic_reg_access(mmio, reg, offset,
-				ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
+					  vcpu_id, offset);
+		vgic_reg_access(mmio, reg, offset, mode);
 		*reg &= level_mask;
 
 		/* Ignore writes to SGIs */
@@ -558,31 +560,30 @@ static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
 			*reg |= orig & 0xffff;
 		}
 
-		vgic_update_state(vcpu->kvm);
+		vgic_update_state(kvm);
 		return true;
 	}
 
 	return false;
 }
 
-static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
+static bool vgic_handle_clear_pending_reg(struct kvm *kvm,
 					  struct kvm_exit_mmio *mmio,
-					  phys_addr_t offset)
+					  phys_addr_t offset, int vcpu_id)
 {
 	u32 *level_active;
 	u32 *reg, orig;
-	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	int mode = ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT;
+	struct vgic_dist *dist = &kvm->arch.vgic;
 
-	reg = vgic_bitmap_get_reg(&dist->irq_pending, vcpu->vcpu_id, offset);
+	reg = vgic_bitmap_get_reg(&dist->irq_pending, vcpu_id, offset);
 	orig = *reg;
-	vgic_reg_access(mmio, reg, offset,
-			ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
+	vgic_reg_access(mmio, reg, offset, mode);
 	if (mmio->is_write) {
 		/* Re-set level triggered level-active interrupts */
 		level_active = vgic_bitmap_get_reg(&dist->irq_level,
-					  vcpu->vcpu_id, offset);
-		reg = vgic_bitmap_get_reg(&dist->irq_pending,
-					  vcpu->vcpu_id, offset);
+					  vcpu_id, offset);
+		reg = vgic_bitmap_get_reg(&dist->irq_pending, vcpu_id, offset);
 		*reg |= *level_active;
 
 		/* Ignore writes to SGIs */
@@ -593,17 +594,31 @@ static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
 
 		/* Clear soft-pending flags */
 		reg = vgic_bitmap_get_reg(&dist->irq_soft_pend,
-					  vcpu->vcpu_id, offset);
-		vgic_reg_access(mmio, reg, offset,
-				ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
+					  vcpu_id, offset);
+		vgic_reg_access(mmio, reg, offset, mode);
 
-		vgic_update_state(vcpu->kvm);
+		vgic_update_state(kvm);
 		return true;
 	}
-
 	return false;
 }
 
+static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
+					struct kvm_exit_mmio *mmio,
+					phys_addr_t offset)
+{
+	return vgic_handle_set_pending_reg(vcpu->kvm, mmio, offset,
+					   vcpu->vcpu_id);
+}
+
+static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
+					  struct kvm_exit_mmio *mmio,
+					  phys_addr_t offset)
+{
+	return vgic_handle_clear_pending_reg(vcpu->kvm, mmio, offset,
+					     vcpu->vcpu_id);
+}
+
 static bool handle_mmio_priority_reg(struct kvm_vcpu *vcpu,
 				     struct kvm_exit_mmio *mmio,
 				     phys_addr_t offset)
@@ -726,14 +741,10 @@ static u16 vgic_cfg_compress(u32 val)
  * LSB is always 0. As such, we only keep the upper bit, and use the
  * two above functions to compress/expand the bits
  */
-static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
-				struct kvm_exit_mmio *mmio, phys_addr_t offset)
+static bool vgic_handle_cfg_reg(u32 *reg, struct kvm_exit_mmio *mmio,
+				phys_addr_t offset)
 {
 	u32 val;
-	u32 *reg;
-
-	reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
-				  vcpu->vcpu_id, offset >> 1);
 
 	if (offset & 4)
 		val = *reg >> 16;
@@ -762,6 +773,17 @@ static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
 	return false;
 }
 
+static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
+				struct kvm_exit_mmio *mmio, phys_addr_t offset)
+{
+	u32 *reg;
+
+	reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
+				  vcpu->vcpu_id, offset >> 1);
+
+	return vgic_handle_cfg_reg(reg, mmio, offset);
+}
+
 static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
 				struct kvm_exit_mmio *mmio, phys_addr_t offset)
 {
-- 
2.1.2.330.g565301e.dirty
