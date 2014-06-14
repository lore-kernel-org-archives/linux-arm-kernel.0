From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 14 Jun 2014 22:51:06 +0200
Subject: [RFC PATCH 5/6] arm/arm64: KVM: vgic: Fix SGI writes to
 GICD_I{CS}PENDR0
In-Reply-To: <1402779067-34478-1-git-send-email-christoffer.dall@linaro.org>
References: <1402779067-34478-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1402779067-34478-6-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Writes to GICD_ISPENDR0 and GICD_ICPENDR0 ignore all settings of the
pending state for SGIs.  Make sure the implementation handles this
correctly.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 0b41875..1f91b3b 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -432,7 +432,7 @@ static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
 					struct kvm_exit_mmio *mmio,
 					phys_addr_t offset)
 {
-	u32 *reg;
+	u32 *reg, orig;
 	u32 level_mask;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 
@@ -441,6 +441,7 @@ static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
 
 	/* Mark both level and edge triggered irqs as pending */
 	reg = vgic_bitmap_get_reg(&dist->irq_pending, vcpu->vcpu_id, offset);
+	orig = *reg;
 	vgic_reg_access(mmio, reg, offset,
 			ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
 
@@ -452,6 +453,12 @@ static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
 				ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
 		*reg &= level_mask;
 
+		/* Ignore writes to SGIs */
+		if (offset < 2) {
+			*reg &= ~0xffff;
+			*reg |= orig & 0xffff;
+		}
+
 		vgic_update_state(vcpu->kvm);
 		return true;
 	}
@@ -464,10 +471,11 @@ static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
 					  phys_addr_t offset)
 {
 	u32 *level_active;
-	u32 *reg;
+	u32 *reg, orig;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 
 	reg = vgic_bitmap_get_reg(&dist->irq_pending, vcpu->vcpu_id, offset);
+	orig = *reg;
 	vgic_reg_access(mmio, reg, offset,
 			ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
 	if (mmio->is_write) {
@@ -478,6 +486,12 @@ static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
 					  vcpu->vcpu_id, offset);
 		*reg |= *level_active;
 
+		/* Ignore writes to SGIs */
+		if (offset < 2) {
+			*reg &= ~0xffff;
+			*reg |= orig & 0xffff;
+		}
+
 		/* Clear soft-pending flags */
 		reg = vgic_bitmap_get_reg(&dist->irq_soft_pend,
 					  vcpu->vcpu_id, offset);
-- 
1.8.5.2
