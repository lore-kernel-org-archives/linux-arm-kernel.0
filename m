From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 19 Jun 2014 10:45:49 +0100
Subject: [PATCH 11/14] arm/arm64: KVM: add virtual GICv3 distributor emulation
In-Reply-To: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
References: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1403171152-24067-12-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With everything separated and prepared, we implement a model of a
GICv3 distributor and redistributors by using the existing framework
to provide handler functions for each register group.
Currently we limit the emulation to a model enforcing a single
security state, with SRE==1 (forcing system register access) and
ARE==1 (allowing more than 8 VCPUs).
We share some of functions provided for GICv2 emulation, but take
the different ways of addressing (v)CPUs into account.
Save and restore is currently not implemented.

Similar to the split-off GICv2 specific code, the new emulation code
goes into a new file (vgic-v3-emul.c).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/kvm/Makefile            |    1 +
 include/kvm/arm_vgic.h             |   11 +-
 include/linux/irqchip/arm-gic-v3.h |   26 ++
 include/linux/kvm_host.h           |    1 +
 include/uapi/linux/kvm.h           |    1 +
 virt/kvm/arm/vgic-v3-emul.c        |  895 ++++++++++++++++++++++++++++++++++++
 virt/kvm/arm/vgic.c                |   11 +-
 virt/kvm/arm/vgic.h                |    3 +
 virt/kvm/kvm_main.c                |    3 +
 9 files changed, 949 insertions(+), 3 deletions(-)
 create mode 100644 virt/kvm/arm/vgic-v3-emul.c

diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index f241db6..2fba3a5 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -21,6 +21,7 @@ kvm-$(CONFIG_KVM_ARM_HOST) += guest.o reset.o sys_regs.o sys_regs_generic_v8.o
 
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2-emul.o
+kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v3-emul.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v2-switch.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v3.o
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 8aa8482..3b164ee 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -151,7 +151,11 @@ struct vgic_dist {
 
 	/* Distributor and vcpu interface mapping in the guest */
 	phys_addr_t		vgic_dist_base;
-	phys_addr_t		vgic_cpu_base;
+	/* GICv2 and GICv3 use different mapped register blocks */
+	union {
+		phys_addr_t		vgic_cpu_base;
+		phys_addr_t		vgic_redist_base;
+	};
 
 	/* Distributor enabled */
 	u32			enabled;
@@ -176,6 +180,10 @@ struct vgic_dist {
 
 	/* Target CPU for each IRQ */
 	u8			*irq_spi_cpu;
+
+	/* Target MPIDR for each IRQ (needed for GICv3 IROUTERn) only */
+	u32			*irq_spi_mpidr;
+
 	struct vgic_bitmap	*irq_spi_target;
 
 	/* Bitmap indicating which CPU has something pending */
@@ -253,6 +261,7 @@ void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
 void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu);
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
 			bool level);
+void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg);
 int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
 bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		      struct kvm_exit_mmio *mmio);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 9eac712..9f17e57 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -31,6 +31,7 @@
 #define GICD_SETSPI_SR			0x0050
 #define GICD_CLRSPI_SR			0x0058
 #define GICD_SEIR			0x0068
+#define GICD_IGROUPR			0x0080
 #define GICD_ISENABLER			0x0100
 #define GICD_ICENABLER			0x0180
 #define GICD_ISPENDR			0x0200
@@ -39,19 +40,38 @@
 #define GICD_ICACTIVER			0x0380
 #define GICD_IPRIORITYR			0x0400
 #define GICD_ICFGR			0x0C00
+#define GICD_IGRPMODR			0x0D00
+#define GICD_NSACR			0x0E00
 #define GICD_IROUTER			0x6000
+#define GICD_IDREGS			0xFFD0
 #define GICD_PIDR2			0xFFE8
 
+/*
+ * Non-ARE distributor registers, needed to provide the RES0
+ * semantics for KVM's emulated GICv3
+ */
+#define GICD_ITARGETSR			0x0800
+#define GICD_SGIR			0x0F00
+#define GICD_CPENDSGIR			0x0F10
+#define GICD_SPENDSGIR			0x0F20
+
+
 #define GICD_CTLR_RWP			(1U << 31)
+#define GICD_CTLR_DS			(1U << 6)
 #define GICD_CTLR_ARE_NS		(1U << 4)
 #define GICD_CTLR_ENABLE_G1A		(1U << 1)
 #define GICD_CTLR_ENABLE_G1		(1U << 0)
 
+#define GICD_TYPER_LPIS			(1U << 17)
+#define GICD_TYPER_MBIS			(1U << 16)
+
 #define GICD_IROUTER_SPI_MODE_ONE	(0U << 31)
 #define GICD_IROUTER_SPI_MODE_ANY	(1U << 31)
 
 #define GIC_PIDR2_ARCH_MASK		0xf0
 
+#define GIC_V3_DIST_SIZE		0x10000
+
 /*
  * Re-Distributor registers, offsets from RD_base
  */
@@ -70,6 +90,7 @@
 #define GICR_SYNCR			0x00C0
 #define GICR_MOVLPIR			0x0100
 #define GICR_MOVALLR			0x0110
+#define GICR_IDREGS			GICD_IDREGS
 #define GICR_PIDR2			GICD_PIDR2
 
 #define GICR_WAKER_ProcessorSleep	(1U << 1)
@@ -78,6 +99,7 @@
 /*
  * Re-Distributor registers, offsets from SGI_base
  */
+#define GICR_IGROUPR0			GICD_IGROUPR
 #define GICR_ISENABLER0			GICD_ISENABLER
 #define GICR_ICENABLER0			GICD_ICENABLER
 #define GICR_ISPENDR0			GICD_ISPENDR
@@ -86,10 +108,14 @@
 #define GICR_ICACTIVER0			GICD_ICACTIVER
 #define GICR_IPRIORITYR0		GICD_IPRIORITYR
 #define GICR_ICFGR0			GICD_ICFGR
+#define GICR_IGRPMODR0			GICD_IGRPMODR
+#define GICR_NSACR			GICD_NSACR
 
 #define GICR_TYPER_VLPIS		(1U << 1)
 #define GICR_TYPER_LAST			(1U << 4)
 
+#define GIC_V3_REDIST_SIZE		0x20000
+
 /*
  * CPU interface registers
  */
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ec4e3bd..7fe8203 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1089,6 +1089,7 @@ extern struct kvm_device_ops kvm_xics_ops;
 extern struct kvm_device_ops kvm_vfio_ops;
 extern struct kvm_device_ops kvm_arm_vgic_v2_ops;
 extern struct kvm_device_ops kvm_flic_ops;
+extern struct kvm_device_ops kvm_arm_vgic_v3_ops;
 
 #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index e11d8f1..7eca98c 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -949,6 +949,7 @@ struct kvm_device_attr {
 #define   KVM_DEV_VFIO_GROUP_DEL			2
 #define KVM_DEV_TYPE_ARM_VGIC_V2	5
 #define KVM_DEV_TYPE_FLIC		6
+#define KVM_DEV_TYPE_ARM_VGIC_V3	7
 
 /*
  * ioctls for VM fds
diff --git a/virt/kvm/arm/vgic-v3-emul.c b/virt/kvm/arm/vgic-v3-emul.c
new file mode 100644
index 0000000..68821fd
--- /dev/null
+++ b/virt/kvm/arm/vgic-v3-emul.c
@@ -0,0 +1,895 @@
+/*
+ * GICv3 distributor and redistributor emulation on GICv3 hardware
+ *
+ * able to run on a pure native host GICv3 (which forces ARE=1)
+ *
+ * forcing ARE=1 and DS=1, not covering LPIs yet (TYPER.LPIS=0)
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Andre Przywara <andre.przywara@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/cpu.h>
+#include <linux/kvm.h>
+#include <linux/kvm_host.h>
+#include <linux/interrupt.h>
+
+#include <linux/irqchip/arm-gic-v3.h>
+#include <kvm/arm_vgic.h>
+
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_arm.h>
+#include <asm/kvm_mmu.h>
+
+#include "vgic.h"
+
+#define INTERRUPT_ID_BITS 10
+
+static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
+			     struct kvm_exit_mmio *mmio, phys_addr_t offset,
+			     void *private)
+{
+	u32 reg = 0, val;
+	u32 word_offset = offset & 3;
+
+	switch (offset & ~3) {
+	case GICD_CTLR:
+		/*
+		 * Force ARE and DS to 1, the guest cannot change this.
+		 * For the time being we only support Group1 interrupts.
+		 */
+		if (vcpu->kvm->arch.vgic.enabled)
+			reg = GICD_CTLR_ENABLE_G1A;
+		reg |= GICD_CTLR_ARE_NS | GICD_CTLR_DS;
+
+		vgic_reg_access(mmio, &reg, word_offset,
+				ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
+		if (mmio->is_write) {
+			vcpu->kvm->arch.vgic.enabled = !!(reg & GICD_CTLR_ENABLE_G1A);
+			vgic_update_state(vcpu->kvm);
+			return true;
+		}
+		break;
+	case GICD_TYPER:
+		/*
+		 * as this implementation does not provide compatibility
+		 * with GICv2 (ARE==1), we report zero CPUs in the lower 5 bits.
+		 * Also TYPER.LPIS is 0 for now and TYPER.MBIS is not supported.
+		 */
+
+		/* claim we support at most 1024 (-4) SPIs via this interface */
+		val = min(vcpu->kvm->arch.vgic.nr_irqs, 1024);
+		reg |= (val >> 5) - 1;
+
+		reg |= (INTERRUPT_ID_BITS - 1) << 19;
+
+		vgic_reg_access(mmio, &reg, word_offset,
+				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+		break;
+	case GICD_IIDR:
+		reg = (PRODUCT_ID_KVM << 24) | (IMPLEMENTER_ARM << 0);
+		vgic_reg_access(mmio, &reg, word_offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+		break;
+	default:
+		vgic_reg_access(mmio, NULL, word_offset,
+				ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+		break;
+	}
+
+	return false;
+}
+
+static bool handle_mmio_set_enable_reg_dist(struct kvm_vcpu *vcpu,
+					    struct kvm_exit_mmio *mmio,
+					    phys_addr_t offset,
+					    void *private)
+{
+	if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
+		return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
+					      vcpu->vcpu_id,
+					      ACCESS_WRITE_SETBIT);
+
+	vgic_reg_access(mmio, NULL, offset & 3,
+			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+	return false;
+}
+
+static bool handle_mmio_clear_enable_reg_dist(struct kvm_vcpu *vcpu,
+					      struct kvm_exit_mmio *mmio,
+					      phys_addr_t offset,
+					      void *private)
+{
+	if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
+		return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
+					      vcpu->vcpu_id,
+					      ACCESS_WRITE_CLEARBIT);
+
+	vgic_reg_access(mmio, NULL, offset & 3,
+			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+	return false;
+}
+
+static bool handle_mmio_set_pending_reg_dist(struct kvm_vcpu *vcpu,
+					     struct kvm_exit_mmio *mmio,
+					     phys_addr_t offset,
+					     void *private)
+{
+	if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
+		return vgic_handle_pending_reg(vcpu->kvm, mmio, offset,
+					       vcpu->vcpu_id,
+					       ACCESS_WRITE_SETBIT);
+
+	vgic_reg_access(mmio, NULL, offset & 3,
+			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+	return false;
+}
+
+static bool handle_mmio_clear_pending_reg_dist(struct kvm_vcpu *vcpu,
+					       struct kvm_exit_mmio *mmio,
+					       phys_addr_t offset,
+					       void *private)
+{
+	if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
+		return vgic_handle_pending_reg(vcpu->kvm, mmio, offset,
+					       vcpu->vcpu_id,
+					       ACCESS_WRITE_CLEARBIT);
+
+	vgic_reg_access(mmio, NULL, offset & 3,
+			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+	return false;
+}
+
+static bool handle_mmio_priority_reg_dist(struct kvm_vcpu *vcpu,
+					  struct kvm_exit_mmio *mmio,
+					  phys_addr_t offset,
+					  void *private)
+{
+	u32 *reg;
+
+	if (unlikely(offset < VGIC_NR_PRIVATE_IRQS)) {
+		vgic_reg_access(mmio, NULL, offset & 3,
+				ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+		return false;
+	}
+
+	reg = vgic_bytemap_get_reg(&vcpu->kvm->arch.vgic.irq_priority,
+				   vcpu->vcpu_id, offset);
+	vgic_reg_access(mmio, reg, offset,
+		ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
+	return false;
+}
+
+static bool handle_mmio_cfg_reg_dist(struct kvm_vcpu *vcpu,
+				     struct kvm_exit_mmio *mmio,
+				     phys_addr_t offset,
+				     void *private)
+{
+	u32 *reg;
+
+	if (unlikely(offset < VGIC_NR_PRIVATE_IRQS / 4)) {
+		vgic_reg_access(mmio, NULL, offset & 3,
+				ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+		return false;
+	}
+
+	reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
+				  vcpu->vcpu_id, offset >> 1);
+
+	return vgic_handle_cfg_reg(reg, mmio, offset);
+}
+
+static u32 compress_mpidr(unsigned long mpidr)
+{
+	u32 ret;
+
+	ret = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	ret |= MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8;
+	ret |= MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16;
+	ret |= MPIDR_AFFINITY_LEVEL(mpidr, 3) << 24;
+
+	return ret;
+}
+
+static unsigned long uncompress_mpidr(u32 value)
+{
+	unsigned long mpidr;
+
+	mpidr = ((value >> 0) & 0xFF) << MPIDR_LEVEL_SHIFT(0);
+	mpidr |= ((value >> 8) & 0xFF) << MPIDR_LEVEL_SHIFT(1);
+	mpidr |= ((value >> 16) & 0xFF) << MPIDR_LEVEL_SHIFT(2);
+	mpidr |= (u64)((value >> 24) & 0xFF) << MPIDR_LEVEL_SHIFT(3);
+
+	return mpidr;
+}
+
+/*
+ * Lookup the given MPIDR value to get the vcpu_id (if there is one)
+ * and store that in the irq_spi_cpu[] array.
+ * This limits the number of VCPUs to 255 for now, extending the data
+ * type (or storing kvm_vcpu poiners) should lift the limit.
+ * Store the original MPIDR value in an extra array.
+ * Unallocated MPIDRs are translated to a special value and catched
+ * before any array accesses.
+ */
+static bool handle_mmio_route_reg(struct kvm_vcpu *vcpu,
+				  struct kvm_exit_mmio *mmio,
+				  phys_addr_t offset, void *private)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	int irq;
+	u32 reg;
+	int vcpu_id;
+	unsigned long *bmap, mpidr;
+	u32 word_offset = offset & 3;
+
+	/*
+	 * Private interrupts cannot be re-routed, so this register
+	 * is RES0 for any IRQ < 32.
+	 * Also the upper 32 bits of each 64 bit register are zero,
+	 * as we don't support Aff3 and that's the only value up there.
+	 */
+	if (unlikely(offset < VGIC_NR_PRIVATE_IRQS * 8) || (offset & 4) == 4) {
+		vgic_reg_access(mmio, NULL, word_offset,
+				ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+		return false;
+	}
+
+	irq = (offset / 8) - VGIC_NR_PRIVATE_IRQS;
+
+	/* get the stored MPIDR for this IRQ */
+	mpidr = uncompress_mpidr(dist->irq_spi_mpidr[irq]);
+	mpidr &= MPIDR_HWID_BITMASK;
+	reg = mpidr;
+
+	vgic_reg_access(mmio, &reg, word_offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
+
+	if (!mmio->is_write)
+		return false;
+
+	/*
+	 * Now clear the currently assigned vCPU from the map, making room
+	 * for the new one to be written below
+	 */
+	vcpu = kvm_mpidr_to_vcpu(kvm, mpidr);
+	if (likely(vcpu)) {
+		vcpu_id = vcpu->vcpu_id;
+		bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[vcpu_id]);
+		clear_bit(irq, bmap);
+	}
+
+	dist->irq_spi_mpidr[irq] = compress_mpidr(reg);
+	vcpu = kvm_mpidr_to_vcpu(kvm, reg & MPIDR_HWID_BITMASK);
+
+	/*
+	 * The spec says that non-existent MPIDR values should not be
+	 * forwarded to any existent (v)CPU, but should be able to become
+	 * pending anyway. We simply keep the irq_spi_target[] array empty, so
+	 * the interrupt will never be injected.
+	 * irq_spi_cpu[irq] gets a magic value in this case.
+	 */
+	if (likely(vcpu)) {
+		vcpu_id = vcpu->vcpu_id;
+		dist->irq_spi_cpu[irq] = vcpu_id;
+		bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[vcpu_id]);
+		set_bit(irq, bmap);
+	} else
+		dist->irq_spi_cpu[irq] = VCPU_NOT_ALLOCATED;
+
+	vgic_update_state(kvm);
+
+	return true;
+}
+
+static bool handle_mmio_idregs(struct kvm_vcpu *vcpu,
+			       struct kvm_exit_mmio *mmio,
+			       phys_addr_t offset, void *private)
+{
+	u32 reg = 0;
+
+	switch (offset + GICD_IDREGS) {
+	case GICD_PIDR2:
+		reg = 0x3b;
+		break;
+	}
+
+	vgic_reg_access(mmio, &reg, offset & 3,
+			ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+
+	return false;
+}
+
+static const struct mmio_range vgic_dist_ranges[] = {
+	{	/*
+		 * handling CTLR, TYPER, IIDR and STATUSR
+		 */
+		.base           = GICD_CTLR,
+		.len            = 20,
+		.bits_per_irq   = 0,
+		.handle_mmio    = handle_mmio_misc,
+	},
+	{
+		/* when DS=1, this is RAZ/WI */
+		.base		= GICD_SETSPI_SR,
+		.len		= 0x04,
+		.bits_per_irq	= 0,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		/* when DS=1, this is RAZ/WI */
+		.base		= GICD_CLRSPI_SR,
+		.len		= 0x04,
+		.bits_per_irq	= 0,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICD_IGROUPR,
+		.len		= 0x80,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICD_ISENABLER,
+		.len		= 0x80,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_set_enable_reg_dist,
+	},
+	{
+		.base		= GICD_ICENABLER,
+		.len		= 0x80,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_clear_enable_reg_dist,
+	},
+	{
+		.base		= GICD_ISPENDR,
+		.len		= 0x80,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_set_pending_reg_dist,
+	},
+	{
+		.base		= GICD_ICPENDR,
+		.len		= 0x80,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_clear_pending_reg_dist,
+	},
+	{
+		.base		= GICD_ISACTIVER,
+		.len		= 0x80,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICD_ICACTIVER,
+		.len		= 0x80,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICD_IPRIORITYR,
+		.len		= 0x400,
+		.bits_per_irq	= 8,
+		.handle_mmio	= handle_mmio_priority_reg_dist,
+	},
+	{
+		/* TARGETSRn is RES0 when ARE=1 */
+		.base		= GICD_ITARGETSR,
+		.len		= 0x400,
+		.bits_per_irq	= 8,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICD_ICFGR,
+		.len		= 0x100,
+		.bits_per_irq	= 2,
+		.handle_mmio	= handle_mmio_cfg_reg_dist,
+	},
+	{
+		/* this is RAZ/WI when DS=1 */
+		.base		= GICD_IGRPMODR,
+		.len		= 0x80,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		/* with DS==1 this is RAZ/WI */
+		.base		= GICD_NSACR,
+		.len		= 0x100,
+		.bits_per_irq	= 2,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	/* the next three blocks are RES0 if ARE=1 */
+	{
+		.base		= GICD_SGIR,
+		.len		= 4,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICD_CPENDSGIR,
+		.len		= 0x10,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base           = GICD_SPENDSGIR,
+		.len            = 0x10,
+		.handle_mmio    = handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICD_IROUTER,
+		.len		= 0x2000,
+		.bits_per_irq	= 64,
+		.handle_mmio	= handle_mmio_route_reg,
+	},
+	{
+		.base           = GICD_IDREGS,
+		.len            = 0x30,
+		.bits_per_irq   = 0,
+		.handle_mmio    = handle_mmio_idregs,
+	},
+	{},
+};
+
+static bool handle_mmio_set_enable_reg_redist(struct kvm_vcpu *vcpu,
+					      struct kvm_exit_mmio *mmio,
+					      phys_addr_t offset,
+					      void *private)
+{
+	struct kvm_vcpu *target_redist_vcpu = private;
+
+	return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
+				      target_redist_vcpu->vcpu_id,
+				      ACCESS_WRITE_SETBIT);
+}
+
+static bool handle_mmio_clear_enable_reg_redist(struct kvm_vcpu *vcpu,
+						struct kvm_exit_mmio *mmio,
+						phys_addr_t offset,
+						void *private)
+{
+	struct kvm_vcpu *target_redist_vcpu = private;
+
+	return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
+				      target_redist_vcpu->vcpu_id,
+				      ACCESS_WRITE_CLEARBIT);
+}
+
+static bool handle_mmio_set_pending_reg_redist(struct kvm_vcpu *vcpu,
+					       struct kvm_exit_mmio *mmio,
+					       phys_addr_t offset,
+					       void *private)
+{
+	struct kvm_vcpu *target_redist_vcpu = private;
+
+	return vgic_handle_pending_reg(vcpu->kvm, mmio, offset,
+				       target_redist_vcpu->vcpu_id,
+				       ACCESS_WRITE_SETBIT);
+}
+
+static bool handle_mmio_clear_pending_reg_redist(struct kvm_vcpu *vcpu,
+						 struct kvm_exit_mmio *mmio,
+						 phys_addr_t offset,
+						 void *private)
+{
+	struct kvm_vcpu *target_redist_vcpu = private;
+
+	return vgic_handle_pending_reg(vcpu->kvm, mmio, offset,
+				       target_redist_vcpu->vcpu_id,
+				       ACCESS_WRITE_CLEARBIT);
+}
+
+static bool handle_mmio_priority_reg_redist(struct kvm_vcpu *vcpu,
+					    struct kvm_exit_mmio *mmio,
+					    phys_addr_t offset,
+					    void *private)
+{
+	struct kvm_vcpu *target_redist_vcpu = private;
+	u32 *reg;
+
+	reg = vgic_bytemap_get_reg(&vcpu->kvm->arch.vgic.irq_priority,
+				   target_redist_vcpu->vcpu_id, offset);
+	vgic_reg_access(mmio, reg, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
+	return false;
+}
+
+static bool handle_mmio_cfg_reg_redist(struct kvm_vcpu *vcpu,
+				       struct kvm_exit_mmio *mmio,
+				       phys_addr_t offset,
+				       void *private)
+{
+	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
+				       *(int *)private, offset >> 1);
+
+	return vgic_handle_cfg_reg(reg, mmio, offset);
+}
+
+static const struct mmio_range vgic_redist_sgi_ranges[] = {
+	{
+		.base		= GICR_IGROUPR0,
+		.len		= 4,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICR_ISENABLER0,
+		.len		= 4,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_set_enable_reg_redist,
+	},
+	{
+		.base		= GICR_ICENABLER0,
+		.len		= 4,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_clear_enable_reg_redist,
+	},
+	{
+		.base		= GICR_ISPENDR0,
+		.len		= 4,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_set_pending_reg_redist,
+	},
+	{
+		.base		= GICR_ICPENDR0,
+		.len		= 4,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_clear_pending_reg_redist,
+	},
+	{
+		.base		= GICR_ISACTIVER0,
+		.len		= 4,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICR_ICACTIVER0,
+		.len		= 4,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICR_IPRIORITYR0,
+		.len		= 32,
+		.bits_per_irq	= 8,
+		.handle_mmio	= handle_mmio_priority_reg_redist,
+	},
+	{
+		.base		= GICR_ICFGR0,
+		.len		= 8,
+		.bits_per_irq	= 2,
+		.handle_mmio	= handle_mmio_cfg_reg_redist,
+	},
+	{
+		.base		= GICR_IGRPMODR0,
+		.len		= 4,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICR_NSACR,
+		.len		= 4,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{},
+};
+
+static bool handle_mmio_misc_redist(struct kvm_vcpu *vcpu,
+				    struct kvm_exit_mmio *mmio,
+				    phys_addr_t offset, void *private)
+{
+	u32 reg;
+	u32 word_offset = offset & 3;
+	u64 mpidr;
+	struct kvm_vcpu *target_redist_vcpu = private;
+	int target_vcpu_id = target_redist_vcpu->vcpu_id;
+
+	switch (offset & ~3) {
+	case GICR_CTLR:
+		/* since we don't support LPIs, this register is zero for now */
+		vgic_reg_access(mmio, &reg, word_offset,
+				ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+		break;
+	case GICR_TYPER + 4:
+		mpidr = kvm_vcpu_get_mpidr(target_redist_vcpu);
+		reg = compress_mpidr(mpidr);
+
+		vgic_reg_access(mmio, &reg, word_offset,
+				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+		break;
+	case GICR_TYPER:
+		reg = target_redist_vcpu->vcpu_id << 8;
+		if (target_vcpu_id == atomic_read(&vcpu->kvm->online_vcpus) - 1)
+			reg |= GICR_TYPER_LAST;
+		vgic_reg_access(mmio, &reg, word_offset,
+				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+		break;
+	case GICR_IIDR:
+		reg = (PRODUCT_ID_KVM << 24) | (IMPLEMENTER_ARM << 0);
+		vgic_reg_access(mmio, &reg, word_offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+		break;
+	default:
+		vgic_reg_access(mmio, NULL, word_offset,
+				ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+		break;
+	}
+
+	return false;
+}
+
+static const struct mmio_range vgic_redist_ranges[] = {
+	{	/*
+		 * handling CTLR, IIDR, TYPER and STATUSR
+		 */
+		.base           = GICR_CTLR,
+		.len            = 20,
+		.bits_per_irq   = 0,
+		.handle_mmio    = handle_mmio_misc_redist,
+	},
+	{
+		.base           = GICR_WAKER,
+		.len            = 4,
+		.bits_per_irq   = 0,
+		.handle_mmio    = handle_mmio_raz_wi,
+	},
+	{
+		.base           = GICR_IDREGS,
+		.len            = 0x30,
+		.bits_per_irq   = 0,
+		.handle_mmio    = handle_mmio_idregs,
+	},
+	{},
+};
+
+/*
+ * this is the stub handling both dist and redist MMIO exits for v3
+ * does some vcpu_id calculation on the redist MMIO to use a possibly
+ * different VCPU than the current one
+ */
+static bool vgic_v3_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
+				struct kvm_exit_mmio *mmio)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	unsigned long dbase = dist->vgic_dist_base;
+	unsigned long rdbase = dist->vgic_redist_base;
+	int nrcpus = atomic_read(&vcpu->kvm->online_vcpus);
+	int vcpu_id;
+	struct kvm_vcpu *target_redist_vcpu;
+
+	if (IS_IN_RANGE(mmio->phys_addr, mmio->len, dbase, GIC_V3_DIST_SIZE)) {
+		return vgic_handle_mmio_range(vcpu, run, mmio,
+					      vgic_dist_ranges, dbase, NULL);
+	}
+
+	if (!IS_IN_RANGE(mmio->phys_addr, mmio->len, rdbase,
+	    GIC_V3_REDIST_SIZE * nrcpus))
+		return false;
+
+	vcpu_id = (mmio->phys_addr - rdbase) / GIC_V3_REDIST_SIZE;
+	rdbase += (vcpu_id * GIC_V3_REDIST_SIZE);
+	target_redist_vcpu = kvm_get_vcpu(vcpu->kvm, vcpu_id);
+
+	if (mmio->phys_addr >= rdbase + 0x10000)
+		return vgic_handle_mmio_range(vcpu, run, mmio,
+					      vgic_redist_sgi_ranges,
+					      rdbase + 0x10000,
+					      target_redist_vcpu);
+
+	return vgic_handle_mmio_range(vcpu, run, mmio, vgic_redist_ranges,
+				      rdbase, target_redist_vcpu);
+}
+
+static bool vgic_v3_queue_sgi(struct kvm_vcpu *vcpu, int irq)
+{
+	if (vgic_queue_irq(vcpu, 0, irq)) {
+		vgic_dist_irq_clear(vcpu, irq);
+		vgic_cpu_irq_clear(vcpu, irq);
+		return true;
+	}
+
+	return false;
+}
+
+static int vgic_v3_init_maps(struct vgic_dist *dist, int nr_cpus, int nr_irqs)
+{
+	int nr_spis = nr_irqs - VGIC_NR_PRIVATE_IRQS;
+
+	dist->irq_spi_mpidr = kzalloc(nr_spis * sizeof(dist->irq_spi_mpidr[0]),
+				      GFP_KERNEL);
+
+	if (!dist->irq_spi_mpidr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int vgic_v3_init(struct kvm *kvm, const struct vgic_params *params)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	int ret, i;
+	u32 mpidr;
+
+	if (IS_VGIC_ADDR_UNDEF(dist->vgic_dist_base) ||
+	    IS_VGIC_ADDR_UNDEF(dist->vgic_redist_base)) {
+		kvm_err("Need to set vgic distributor addresses first\n");
+		return -ENXIO;
+	}
+
+	dist->nr_cpus = atomic_read(&kvm->online_vcpus);
+
+	ret = vgic_init_maps(dist, dist->nr_cpus, dist->nr_irqs);
+	if (!ret)
+		ret = vgic_v3_init_maps(dist, dist->nr_cpus, dist->nr_irqs);
+	if (ret) {
+		kvm_err("Unable to allocate maps\n");
+		return ret;
+	}
+
+	mpidr = compress_mpidr(kvm_vcpu_get_mpidr(kvm_get_vcpu(kvm, 0)));
+	for (i = VGIC_NR_PRIVATE_IRQS; i < dist->nr_irqs; i++) {
+		dist->irq_spi_cpu[i - VGIC_NR_PRIVATE_IRQS] = 0;
+		dist->irq_spi_mpidr[i - VGIC_NR_PRIVATE_IRQS] = mpidr;
+		vgic_bitmap_set_irq_val(dist->irq_spi_target, 0, i, 1);
+	}
+
+	return 0;
+}
+
+static void vgic_v3_unqueue_sgi(struct kvm_vcpu *vcpu, int irq, int source)
+{
+	return;
+}
+
+bool vgic_v3_init_emulation_ops(struct kvm *kvm, int type)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+
+	switch (type) {
+	case KVM_DEV_TYPE_ARM_VGIC_V3:
+		dist->vm_ops.handle_mmio = vgic_v3_handle_mmio;
+		dist->vm_ops.queue_sgi = vgic_v3_queue_sgi;
+		dist->vm_ops.unqueue_sgi = vgic_v3_unqueue_sgi;
+		dist->vm_ops.vgic_init = vgic_v3_init;
+		break;
+	default:
+		return false;
+	}
+	return true;
+}
+
+/*
+ * triggered by a system register access trap, called from the sysregs
+ * handling code there.
+ * The register contains the upper three affinity levels of the target
+ * processors as well as a bitmask of 16 Aff0 CPUs.
+ * Iterate over all VCPUs to check for matching ones or signal on
+ * all-but-self if the mode bit is set.
+ */
+void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_vcpu *c_vcpu;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	u16 target_cpus;
+	u64 mpidr, mpidr_h, mpidr_l;
+	int sgi, mode, c, vcpu_id;
+	int updated = 0;
+
+	vcpu_id = vcpu->vcpu_id;
+
+	sgi = (reg >> 24) & 0xf;
+	mode = (reg >> 40) & 0x1;
+	target_cpus = reg & 0xffff;
+	mpidr = ((reg >> 48) & 0xff) << MPIDR_LEVEL_SHIFT(3);
+	mpidr |= ((reg >> 32) & 0xff) << MPIDR_LEVEL_SHIFT(2);
+	mpidr |= ((reg >> 16) & 0xff) << MPIDR_LEVEL_SHIFT(1);
+	mpidr &= ~MPIDR_LEVEL_MASK;
+
+	/*
+	 * We take the dist lock here, because we come from the sysregs
+	 * code path and not from MMIO (where this is already done)
+	 */
+	spin_lock(&dist->lock);
+	kvm_for_each_vcpu(c, c_vcpu, kvm) {
+		if (target_cpus == 0)
+			break;
+		if (mode && c == vcpu_id)       /* not to myself */
+			continue;
+		if (!mode) {
+			mpidr_h = kvm_vcpu_get_mpidr(c_vcpu);
+			mpidr_l = MPIDR_AFFINITY_LEVEL(mpidr_h, 0);
+			mpidr_h &= ~MPIDR_LEVEL_MASK;
+			if (mpidr != mpidr_h)
+				continue;
+			if (!(target_cpus & BIT(mpidr_l)))
+				continue;
+			target_cpus &= ~BIT(mpidr_l);
+		}
+		/* Flag the SGI as pending */
+		vgic_dist_irq_set(c_vcpu, sgi);
+		updated = 1;
+		kvm_debug("SGI%d from CPU%d to CPU%d\n", sgi, vcpu_id, c);
+	}
+	if (updated)
+		vgic_update_state(vcpu->kvm);
+	spin_unlock(&dist->lock);
+	if (updated)
+		vgic_kick_vcpus(vcpu->kvm);
+}
+
+
+static int vgic_v3_get_attr(struct kvm_device *dev,
+			    struct kvm_device_attr *attr)
+{
+	int r;
+
+	r = vgic_get_common_attr(dev, attr);
+	if (!r)
+		return r;
+
+	switch (attr->group) {
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
+		return -ENXIO;
+	}
+
+	return r;
+}
+
+static int vgic_v3_set_attr(struct kvm_device *dev,
+			    struct kvm_device_attr *attr)
+{
+	int ret;
+
+	ret = vgic_set_common_attr(dev, attr);
+
+	if (!ret)
+		return ret;
+
+	switch (attr->group) {
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+		return -ENXIO;
+	}
+
+	return -ENXIO;
+}
+
+static int vgic_v3_has_attr(struct kvm_device *dev,
+			    struct kvm_device_attr *attr)
+{
+	switch (attr->group) {
+	case KVM_DEV_ARM_VGIC_GRP_ADDR:
+		switch (attr->attr) {
+		case KVM_VGIC_V2_ADDR_TYPE_DIST:
+		case KVM_VGIC_V2_ADDR_TYPE_CPU:
+			return -ENXIO;
+		}
+		break;
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
+		return -ENXIO;
+	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS:
+	case KVM_DEV_ARM_VGIC_GRP_ADDR_OFFSET:
+		return 0;
+	}
+	return -ENXIO;
+}
+
+struct kvm_device_ops kvm_arm_vgic_v3_ops = {
+	.name = "kvm-arm-vgic-v3",
+	.create = vgic_create,
+	.destroy = vgic_destroy,
+	.set_attr = vgic_v3_set_attr,
+	.get_attr = vgic_v3_get_attr,
+	.has_attr = vgic_v3_has_attr,
+};
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 4c1a129..fa150c7 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1071,7 +1071,7 @@ static bool vgic_update_irq_state(struct kvm *kvm, int cpuid,
 	struct kvm_vcpu *vcpu;
 	int is_edge, is_level;
 	int enabled;
-	bool ret = true;
+	bool ret = true, can_inject = true;
 
 	spin_lock(&dist->lock);
 
@@ -1086,6 +1086,11 @@ static bool vgic_update_irq_state(struct kvm *kvm, int cpuid,
 
 	if (irq_num >= VGIC_NR_PRIVATE_IRQS) {
 		cpuid = dist->irq_spi_cpu[irq_num - VGIC_NR_PRIVATE_IRQS];
+		if (cpuid == VCPU_NOT_ALLOCATED) {
+			/* Pretend we use CPU0, and prevent injection */
+			cpuid = 0;
+			can_inject = false;
+		}
 		vcpu = kvm_get_vcpu(kvm, cpuid);
 	}
 
@@ -1098,7 +1103,7 @@ static bool vgic_update_irq_state(struct kvm *kvm, int cpuid,
 
 	enabled = vgic_irq_is_enabled(vcpu, irq_num);
 
-	if (!enabled) {
+	if (!enabled || !can_inject) {
 		ret = false;
 		goto out;
 	}
@@ -1314,6 +1319,7 @@ static void vgic_free_maps(struct vgic_dist *dist)
 			vgic_free_bitmap(&dist->irq_spi_target[i]);
 	kfree(dist->irq_sgi_sources);
 	kfree(dist->irq_spi_cpu);
+	kfree(dist->irq_spi_mpidr);
 	kfree(dist->irq_spi_target);
 }
 
@@ -1463,6 +1469,7 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 	kvm->arch.vgic.vctrl_base = vgic->vctrl_base;
 	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
 	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
+	kvm->arch.vgic.vgic_redist_base = VGIC_ADDR_UNDEF;
 
 	init_emulation_ops(kvm, type);
 
diff --git a/virt/kvm/arm/vgic.h b/virt/kvm/arm/vgic.h
index 9078e2a..f24cdd0 100644
--- a/virt/kvm/arm/vgic.h
+++ b/virt/kvm/arm/vgic.h
@@ -34,6 +34,8 @@
 
 #define VCPU_NOT_ALLOCATED ((u8)-1)
 
+#define VCPU_NOT_ALLOCATED ((u8)-1)
+
 unsigned long *vgic_bitmap_get_shared_map(struct vgic_bitmap *x);
 
 void vgic_update_state(struct kvm *kvm);
@@ -112,3 +114,4 @@ int vgic_set_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr);
 int vgic_get_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr);
 
 bool vgic_v2_init_emulation_ops(struct kvm *kvm, int type);
+bool vgic_v3_init_emulation_ops(struct kvm *kvm, int type);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4b6c01b..c2fac5d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2286,6 +2286,9 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
 	case KVM_DEV_TYPE_ARM_VGIC_V2:
 		ops = &kvm_arm_vgic_v2_ops;
 		break;
+	case KVM_DEV_TYPE_ARM_VGIC_V3:
+		ops = &kvm_arm_vgic_v3_ops;
+		break;
 #endif
 #ifdef CONFIG_S390
 	case KVM_DEV_TYPE_FLIC:
-- 
1.7.9.5
