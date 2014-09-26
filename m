From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 26 Sep 2014 15:16:48 +0200
Subject: [PATCH 15/27] arm/arm64: KVM: vgic: Fix SGI writes to GICD_I{CS}PENDR0
In-Reply-To: <1411737420-9063-1-git-send-email-christoffer.dall@linaro.org>
References: <1411737420-9063-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1411737420-9063-16-git-send-email-christoffer.dall@linaro.org>
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
index 435d8e7..0039ae2 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -454,7 +454,7 @@ static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
 					struct kvm_exit_mmio *mmio,
 					phys_addr_t offset)
 {
-	u32 *reg;
+	u32 *reg, orig;
 	u32 level_mask;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 
@@ -463,6 +463,7 @@ static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
 
 	/* Mark both level and edge triggered irqs as pending */
 	reg = vgic_bitmap_get_reg(&dist->irq_pending, vcpu->vcpu_id, offset);
+	orig = *reg;
 	vgic_reg_access(mmio, reg, offset,
 			ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
 
@@ -474,6 +475,12 @@ static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
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
@@ -486,10 +493,11 @@ static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
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
@@ -500,6 +508,12 @@ static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
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
2.0.0
