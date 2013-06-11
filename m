From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 10 Jun 2013 21:51:19 -0700
Subject: [PATCH 7/7] KVM: arm-vgic: Support CPU interface reg access
In-Reply-To: <1370926279-32532-1-git-send-email-christoffer.dall@linaro.org>
References: <1370926279-32532-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1370926279-32532-8-git-send-email-christoffer.dall@linaro.org>
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
 virt/kvm/arm/vgic.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 62d0fec..64bea93 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1660,9 +1660,61 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
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
+		reg = (vgic_cpu->vgic_vmcr & mask) >> 0;
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
 }
 
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
+}
+
+/*
+ * CPU Interface Register accesses - these are not accessed by the VM, but by
+ * user space for saving and restoring VGIC state.
+ */
 static const struct mmio_range vgic_cpu_ranges[] = {
 	{
 		.base		= GIC_CPU_CTRL,
@@ -1687,12 +1739,12 @@ static const struct mmio_range vgic_cpu_ranges[] = {
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
1.7.9.5
