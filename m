From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 16 Nov 2013 20:30:20 -0800
Subject: [PATCH v3 9/9] KVM: arm-vgic: Support CPU interface reg access
In-Reply-To: <1384662620-13795-1-git-send-email-christoffer.dall@linaro.org>
References: <1384662620-13795-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1384662620-13795-10-git-send-email-christoffer.dall@linaro.org>
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
 virt/kvm/arm/vgic.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 16053eb..a08b89a 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -71,6 +71,10 @@
 #define VGIC_ADDR_UNDEF		(-1)
 #define IS_VGIC_ADDR_UNDEF(_x)  ((_x) == VGIC_ADDR_UNDEF)
 
+#define PRODUCT_ID_KVM		0x4b	/* ASCII code K */
+#define IMPLEMENTER_ARM		0x43b
+#define GICC_ARCH_VERSION_V2	0x2
+
 /* Physical address of vgic virtual cpu interface */
 static phys_addr_t vgic_vcpu_base;
 
@@ -312,7 +316,7 @@ static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
 	u32 word_offset = offset & 3;
 
 	switch (offset & ~3) {
-	case 0:			/* CTLR */
+	case 0:			/* GICD_CTLR */
 		reg = vcpu->kvm->arch.vgic.enabled;
 		vgic_reg_access(mmio, &reg, word_offset,
 				ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
@@ -323,15 +327,15 @@ static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
 		}
 		break;
 
-	case 4:			/* TYPER */
+	case 4:			/* GICD_TYPER */
 		reg  = (atomic_read(&vcpu->kvm->online_vcpus) - 1) << 5;
 		reg |= (VGIC_NR_IRQS >> 5) - 1;
 		vgic_reg_access(mmio, &reg, word_offset,
 				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
 		break;
 
-	case 8:			/* IIDR */
-		reg = 0x4B00043B;
+	case 8:			/* GICD_IIDR */
+		reg = (PRODUCT_ID_KVM << 24) | (IMPLEMENTER_ARM << 0);
 		vgic_reg_access(mmio, &reg, word_offset,
 				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
 		break;
@@ -1703,9 +1707,70 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
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
+		mmio_data_write(mmio, ~0, reg);
+	} else {
+		reg = mmio_data_read(mmio, ~0);
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
+	/* GICC_IIDR */
+	reg = (PRODUCT_ID_KVM << 20) |
+	      (GICC_ARCH_VERSION_V2 << 16) |
+	      (IMPLEMENTER_ARM << 0);
+	mmio_data_write(mmio, ~0, reg);
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
@@ -1715,17 +1780,17 @@ static const struct mmio_range vgic_cpu_ranges[] = {
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
