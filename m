From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Aug 2013 12:20:06 -0700
Subject: [PATCH 8/8] KVM: arm-vgic: Support CPU interface reg access
In-Reply-To: <1377285606-15692-1-git-send-email-christoffer.dall@linaro.org>
References: <1377285606-15692-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1377285606-15692-9-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement support for the CPU interface register access driven by MMIO
address offsets from the CPU interface base address.  Useful for user
space to support save/restore of the VGIC state.

This commit adds support only for the same logic as the current VGIC
support, and no more.  For example, the active priority registers are
handled as RAZ/WI, just like setting priorities on the emulated
distributor.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index d44b5a1..257dbae 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1684,9 +1684,67 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
 static bool handle_cpu_mmio_misc(struct kvm_vcpu *vcpu,
 				 struct kvm_exit_mmio *mmio, phys_addr_t offset)
 {
-	return true;
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	u32 reg, mask = 0, shift = 0;
+	bool updated = false;
+
+	switch (offset & ~0x3) {
+	case GIC_CPU_CTRL:
+		mask = GICH_VMCR_CTRL_MASK;
+		shift = GICH_VMCR_CTRL_SHIFT;
+		break;
+	case GIC_CPU_PRIMASK:
+		mask = GICH_VMCR_PRIMASK_MASK;
+		shift = GICH_VMCR_PRIMASK_SHIFT;
+		break;
+	case GIC_CPU_BINPOINT:
+		mask = GICH_VMCR_BINPOINT_MASK;
+		shift = GICH_VMCR_BINPOINT_SHIFT;
+		break;
+	case GIC_CPU_ALIAS_BINPOINT:
+		mask = GICH_VMCR_ALIAS_BINPOINT_MASK;
+		shift = GICH_VMCR_ALIAS_BINPOINT_SHIFT;
+		break;
+	}
+
+	if (!mmio->is_write) {
+		reg = (vgic_cpu->vgic_vmcr & mask) >> shift;
+		memcpy(mmio->data, &reg, sizeof(reg));
+	} else {
+		memcpy(&reg, mmio->data, sizeof(reg));
+		reg = (reg << shift) & mask;
+		if (reg != (vgic_cpu->vgic_vmcr & mask))
+			updated = true;
+		vgic_cpu->vgic_vmcr &= ~mask;
+		vgic_cpu->vgic_vmcr |= reg;
+	}
+	return updated;
+}
+
+static bool handle_mmio_abpr(struct kvm_vcpu *vcpu,
+			     struct kvm_exit_mmio *mmio, phys_addr_t offset)
+{
+	return handle_cpu_mmio_misc(vcpu, mmio, GIC_CPU_ALIAS_BINPOINT);
+}
+
+static bool handle_cpu_mmio_ident(struct kvm_vcpu *vcpu,
+				  struct kvm_exit_mmio *mmio,
+				  phys_addr_t offset)
+{
+	u32 reg;
+
+	if (mmio->is_write)
+		return false;
+
+	reg = 0x0002043B;
+	memcpy(mmio->data, &reg, sizeof(reg));
+	return false;
 }
 
+/*
+ * CPU Interface Register accesses - these are not accessed by the VM, but by
+ * user space for saving and restoring VGIC state.
+ */
 static const struct mmio_range vgic_cpu_ranges[] = {
 	{
 		.base		= GIC_CPU_CTRL,
@@ -1696,17 +1754,17 @@ static const struct mmio_range vgic_cpu_ranges[] = {
 	{
 		.base		= GIC_CPU_ALIAS_BINPOINT,
 		.len		= 4,
-		.handle_mmio	= handle_cpu_mmio_misc,
+		.handle_mmio	= handle_mmio_abpr,
 	},
 	{
 		.base		= GIC_CPU_ACTIVEPRIO,
 		.len		= 16,
-		.handle_mmio	= handle_cpu_mmio_misc,
+		.handle_mmio	= handle_mmio_raz_wi,
 	},
 	{
 		.base		= GIC_CPU_IDENT,
 		.len		= 4,
-		.handle_mmio	= handle_cpu_mmio_misc,
+		.handle_mmio	= handle_cpu_mmio_ident,
 	},
 };
 
-- 
1.7.10.4
