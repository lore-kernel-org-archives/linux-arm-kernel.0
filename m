From: Tirumalesh.Chalamarla@caviumnetworks.com (Chalamarla, Tirumalesh)
Date: Thu, 19 Jun 2014 21:24:15 +0000
Subject: [PATCH 08/14] arm/arm64: KVM: refactor MMIO accessors
In-Reply-To: <1403171152-24067-9-git-send-email-andre.przywara@arm.com>
References: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
 <1403171152-24067-9-git-send-email-andre.przywara@arm.com>
Message-ID: <3ea3573ff1b64af3a7c4a4db51b6d581@BY2PR07MB203.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: kvmarm-bounces@lists.cs.columbia.edu [mailto:kvmarm-bounces at lists.cs.columbia.edu] On Behalf Of Andre Przywara
Sent: Thursday, June 19, 2014 2:46 AM
To: linux-arm-kernel at lists.infradead.org; kvmarm at lists.cs.columbia.edu; kvm at vger.kernel.org
Cc: christoffer.dall at linaro.org
Subject: [PATCH 08/14] arm/arm64: KVM: refactor MMIO accessors

The MMIO accessors for GICD_I[CS]ENABLER, GICD_I[CS]PENDR and GICD_ICFGR behave very similiar in GICv3, although the way the affected vCPU is determined differs.
Factor out a generic, backend-facing implementation and use small wrappers in the current GICv2 emulation to ease code sharing later.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic.c |   93 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 41 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c index 2de58b3..2a59dff 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -398,35 +398,54 @@ static bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu,
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
+				      vcpu->vcpu_id, ACCESS_WRITE_SETBIT); }
+
 static bool handle_mmio_clear_enable_reg(struct kvm_vcpu *vcpu,
 					 struct kvm_exit_mmio *mmio,
 					 phys_addr_t offset)
 {
-	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_enabled,
-				       vcpu->vcpu_id, offset);
-	vgic_reg_access(mmio, reg, offset,
-			ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
+	return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
+				      vcpu->vcpu_id, ACCESS_WRITE_CLEARBIT); }
+
+static bool vgic_handle_pending_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
+				    phys_addr_t offset, int vcpu_id, int access) {
+	u32 *reg;
+	int mode = ACCESS_READ_VALUE | access;
+
+	reg = vgic_bitmap_get_reg(&kvm->arch.vgic.irq_state, vcpu_id, offset);
+	vgic_reg_access(mmio, reg, offset, mode);
 	if (mmio->is_write) {
-		if (offset < 4) /* Force SGI enabled */
-			*reg |= 0xffff;
-		vgic_retire_disabled_irqs(vcpu);
-		vgic_update_state(vcpu->kvm);
+		vgic_update_state(kvm);
 		return true;
 	}
 
@@ -437,31 +456,16 @@ static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
 					struct kvm_exit_mmio *mmio,
 					phys_addr_t offset)
 {
-	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_state,
-				       vcpu->vcpu_id, offset);
-	vgic_reg_access(mmio, reg, offset,
-			ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
-	if (mmio->is_write) {
-		vgic_update_state(vcpu->kvm);
-		return true;
-	}
-
-	return false;
+	return vgic_handle_pending_reg(vcpu->kvm, mmio, offset,
+				       vcpu->vcpu_id, ACCESS_WRITE_SETBIT);
 }
 
 static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
 					  struct kvm_exit_mmio *mmio,
 					  phys_addr_t offset)
 {
-	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_state,
-				       vcpu->vcpu_id, offset);
-	vgic_reg_access(mmio, reg, offset,
-			ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
-	if (mmio->is_write) {
-		vgic_update_state(vcpu->kvm);
-		return true;
-	}
-
+	return vgic_handle_pending_reg(vcpu->kvm, mmio, offset,
+				       vcpu->vcpu_id, ACCESS_WRITE_CLEARBIT);
 	return false;
 }
 
@@ -587,14 +591,10 @@ static u16 vgic_cfg_compress(u32 val)
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
@@ -623,6 +623,17 @@ static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
 	return false;
 }
 
+static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
+				struct kvm_exit_mmio *mmio, phys_addr_t offset) {
+	u32 *reg;
+
+	reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
+				  vcpu->vcpu_id, offset >> 1);
+
+	return vgic_handle_cfg_reg(reg, mmio, offset); }
+

I think coding style needs to change for this function.

 static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
 				struct kvm_exit_mmio *mmio, phys_addr_t offset)  {
--
1.7.9.5

_______________________________________________
kvmarm mailing list
kvmarm at lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
