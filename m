From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:58 +0100
Subject: [GIT PULL 29/36] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-30-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

With everything separated and prepared, we implement a model of a
GICv3 distributor and redistributors by using the existing framework
to provide handler functions for each register group.

Currently we limit the emulation to a model enforcing a single
security state, with SRE==1 (forcing system register access) and
ARE==1 (allowing more than 8 VCPUs).

We share some of the functions provided for GICv2 emulation, but take
the different ways of addressing (v)CPUs into account.
Save and restore is currently not implemented.

Similar to the split-off of the GICv2 specific code, the new emulation
code goes into a new file (vgic-v3-emul.c).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/Makefile            |   1 +
 include/kvm/arm_vgic.h             |   9 +-
 include/linux/irqchip/arm-gic-v3.h |  32 ++
 include/linux/kvm_host.h           |   1 +
 include/uapi/linux/kvm.h           |   2 +
 virt/kvm/arm/vgic-v3-emul.c        | 922 +++++++++++++++++++++++++++++++++++++
 virt/kvm/arm/vgic.c                |  11 +-
 virt/kvm/arm/vgic.h                |   3 +
 8 files changed, 978 insertions(+), 3 deletions(-)
 create mode 100644 virt/kvm/arm/vgic-v3-emul.c

diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index d957353..4e6e09e 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -24,5 +24,6 @@ kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2-emul.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v2-switch.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v3.o
+kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v3-emul.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v3-switch.o
 kvm-$(CONFIG_KVM_ARM_TIMER) += $(KVM)/arm/arch_timer.o
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index ff04afd..98c3016 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -162,7 +162,11 @@ struct vgic_dist {
 
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
@@ -224,6 +228,9 @@ struct vgic_dist {
 	 */
 	struct vgic_bitmap	*irq_spi_target;
 
+	/* Target MPIDR for each IRQ (needed for GICv3 IROUTERn) only */
+	u32			*irq_spi_mpidr;
+
 	/* Bitmap indicating which CPU has something pending */
 	unsigned long		*irq_pending_on_cpu;
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 1e8b0cf..3fb4d85 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -33,6 +33,7 @@
 #define GICD_SETSPI_SR			0x0050
 #define GICD_CLRSPI_SR			0x0058
 #define GICD_SEIR			0x0068
+#define GICD_IGROUPR			0x0080
 #define GICD_ISENABLER			0x0100
 #define GICD_ICENABLER			0x0180
 #define GICD_ISPENDR			0x0200
@@ -41,14 +42,37 @@
 #define GICD_ICACTIVER			0x0380
 #define GICD_IPRIORITYR			0x0400
 #define GICD_ICFGR			0x0C00
+#define GICD_IGRPMODR			0x0D00
+#define GICD_NSACR			0x0E00
 #define GICD_IROUTER			0x6000
+#define GICD_IDREGS			0xFFD0
 #define GICD_PIDR2			0xFFE8
 
+/*
+ * Those registers are actually from GICv2, but the spec demands that they
+ * are implemented as RES0 if ARE is 1 (which we do in KVM's emulated GICv3).
+ */
+#define GICD_ITARGETSR			0x0800
+#define GICD_SGIR			0x0F00
+#define GICD_CPENDSGIR			0x0F10
+#define GICD_SPENDSGIR			0x0F20
+
 #define GICD_CTLR_RWP			(1U << 31)
+#define GICD_CTLR_DS			(1U << 6)
 #define GICD_CTLR_ARE_NS		(1U << 4)
 #define GICD_CTLR_ENABLE_G1A		(1U << 1)
 #define GICD_CTLR_ENABLE_G1		(1U << 0)
 
+/*
+ * In systems with a single security state (what we emulate in KVM)
+ * the meaning of the interrupt group enable bits is slightly different
+ */
+#define GICD_CTLR_ENABLE_SS_G1		(1U << 1)
+#define GICD_CTLR_ENABLE_SS_G0		(1U << 0)
+
+#define GICD_TYPER_LPIS			(1U << 17)
+#define GICD_TYPER_MBIS			(1U << 16)
+
 #define GICD_TYPER_ID_BITS(typer)	((((typer) >> 19) & 0x1f) + 1)
 #define GICD_TYPER_IRQS(typer)		((((typer) & 0x1f) + 1) * 32)
 #define GICD_TYPER_LPIS			(1U << 17)
@@ -60,6 +84,8 @@
 #define GIC_PIDR2_ARCH_GICv3		0x30
 #define GIC_PIDR2_ARCH_GICv4		0x40
 
+#define GIC_V3_DIST_SIZE		0x10000
+
 /*
  * Re-Distributor registers, offsets from RD_base
  */
@@ -78,6 +104,7 @@
 #define GICR_SYNCR			0x00C0
 #define GICR_MOVLPIR			0x0100
 #define GICR_MOVALLR			0x0110
+#define GICR_IDREGS			GICD_IDREGS
 #define GICR_PIDR2			GICD_PIDR2
 
 #define GICR_CTLR_ENABLE_LPIS		(1UL << 0)
@@ -104,6 +131,7 @@
 /*
  * Re-Distributor registers, offsets from SGI_base
  */
+#define GICR_IGROUPR0			GICD_IGROUPR
 #define GICR_ISENABLER0			GICD_ISENABLER
 #define GICR_ICENABLER0			GICD_ICENABLER
 #define GICR_ISPENDR0			GICD_ISPENDR
@@ -112,11 +140,15 @@
 #define GICR_ICACTIVER0			GICD_ICACTIVER
 #define GICR_IPRIORITYR0		GICD_IPRIORITYR
 #define GICR_ICFGR0			GICD_ICFGR
+#define GICR_IGRPMODR0			GICD_IGRPMODR
+#define GICR_NSACR			GICD_NSACR
 
 #define GICR_TYPER_PLPIS		(1U << 0)
 #define GICR_TYPER_VLPIS		(1U << 1)
 #define GICR_TYPER_LAST			(1U << 4)
 
+#define GIC_V3_REDIST_SIZE		0x20000
+
 #define LPI_PROP_GROUP1			(1 << 1)
 #define LPI_PROP_ENABLED		(1 << 0)
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 25d7ce3..0ef2daa 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1052,6 +1052,7 @@ void kvm_unregister_device_ops(u32 type);
 extern struct kvm_device_ops kvm_mpic_ops;
 extern struct kvm_device_ops kvm_xics_ops;
 extern struct kvm_device_ops kvm_arm_vgic_v2_ops;
+extern struct kvm_device_ops kvm_arm_vgic_v3_ops;
 
 #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a37fd12..b4e6f1e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -952,6 +952,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_ARM_VGIC_V2	KVM_DEV_TYPE_ARM_VGIC_V2
 	KVM_DEV_TYPE_FLIC,
 #define KVM_DEV_TYPE_FLIC		KVM_DEV_TYPE_FLIC
+	KVM_DEV_TYPE_ARM_VGIC_V3,
+#define KVM_DEV_TYPE_ARM_VGIC_V3	KVM_DEV_TYPE_ARM_VGIC_V3
 	KVM_DEV_TYPE_MAX,
 };
 
diff --git a/virt/kvm/arm/vgic-v3-emul.c b/virt/kvm/arm/vgic-v3-emul.c
new file mode 100644
index 0000000..8db1db5
--- /dev/null
+++ b/virt/kvm/arm/vgic-v3-emul.c
@@ -0,0 +1,922 @@
+/*
+ * GICv3 distributor and redistributor emulation
+ *
+ * GICv3 emulation is currently only supported on a GICv3 host (because
+ * we rely on the hardware's CPU interface virtualization support), but
+ * supports both hardware with or without the optional GICv2 backwards
+ * compatibility features.
+ *
+ * Limitations of the emulation:
+ * (RAZ/WI: read as zero, write ignore, RAO/WI: read as one, write ignore)
+ * - We do not support LPIs (yet). TYPER.LPIS is reported as 0 and is RAZ/WI.
+ * - We do not support the message based interrupts (MBIs) triggered by
+ *   writes to the GICD_{SET,CLR}SPI_* registers. TYPER.MBIS is reported as 0.
+ * - We do not support the (optional) backwards compatibility feature.
+ *   GICD_CTLR.ARE resets to 1 and is RAO/WI. If the _host_ GIC supports
+ *   the compatiblity feature, you can use a GICv2 in the guest, though.
+ * - We only support a single security state. GICD_CTLR.DS is 1 and is RAO/WI.
+ * - Priorities are not emulated (same as the GICv2 emulation). Linux
+ *   as a guest is fine with this, because it does not use priorities.
+ * - We only support Group1 interrupts. Again Linux uses only those.
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
+static bool handle_mmio_rao_wi(struct kvm_vcpu *vcpu,
+			       struct kvm_exit_mmio *mmio, phys_addr_t offset)
+{
+	u32 reg = 0xffffffff;
+
+	vgic_reg_access(mmio, &reg, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+
+	return false;
+}
+
+static bool handle_mmio_ctlr(struct kvm_vcpu *vcpu,
+			     struct kvm_exit_mmio *mmio, phys_addr_t offset)
+{
+	u32 reg = 0;
+
+	/*
+	 * Force ARE and DS to 1, the guest cannot change this.
+	 * For the time being we only support Group1 interrupts.
+	 */
+	if (vcpu->kvm->arch.vgic.enabled)
+		reg = GICD_CTLR_ENABLE_SS_G1;
+	reg |= GICD_CTLR_ARE_NS | GICD_CTLR_DS;
+
+	vgic_reg_access(mmio, &reg, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
+	if (mmio->is_write) {
+		if (reg & GICD_CTLR_ENABLE_SS_G0)
+			kvm_info("guest tried to enable unsupported Group0 interrupts\n");
+		vcpu->kvm->arch.vgic.enabled = !!(reg & GICD_CTLR_ENABLE_SS_G1);
+		vgic_update_state(vcpu->kvm);
+		return true;
+	}
+	return false;
+}
+
+/*
+ * As this implementation does not provide compatibility
+ * with GICv2 (ARE==1), we report zero CPUs in bits [5..7].
+ * Also LPIs and MBIs are not supported, so we set the respective bits to 0.
+ * Also we report at most 2**10=1024 interrupt IDs (to match 1024 SPIs).
+ */
+#define INTERRUPT_ID_BITS 10
+static bool handle_mmio_typer(struct kvm_vcpu *vcpu,
+			      struct kvm_exit_mmio *mmio, phys_addr_t offset)
+{
+	u32 reg;
+
+	reg = (min(vcpu->kvm->arch.vgic.nr_irqs, 1024) >> 5) - 1;
+
+	reg |= (INTERRUPT_ID_BITS - 1) << 19;
+
+	vgic_reg_access(mmio, &reg, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+
+	return false;
+}
+
+static bool handle_mmio_iidr(struct kvm_vcpu *vcpu,
+			     struct kvm_exit_mmio *mmio, phys_addr_t offset)
+{
+	u32 reg;
+
+	reg = (PRODUCT_ID_KVM << 24) | (IMPLEMENTER_ARM << 0);
+	vgic_reg_access(mmio, &reg, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+
+	return false;
+}
+
+static bool handle_mmio_set_enable_reg_dist(struct kvm_vcpu *vcpu,
+					    struct kvm_exit_mmio *mmio,
+					    phys_addr_t offset)
+{
+	if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
+		return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
+					      vcpu->vcpu_id,
+					      ACCESS_WRITE_SETBIT);
+
+	vgic_reg_access(mmio, NULL, offset,
+			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+	return false;
+}
+
+static bool handle_mmio_clear_enable_reg_dist(struct kvm_vcpu *vcpu,
+					      struct kvm_exit_mmio *mmio,
+					      phys_addr_t offset)
+{
+	if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
+		return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
+					      vcpu->vcpu_id,
+					      ACCESS_WRITE_CLEARBIT);
+
+	vgic_reg_access(mmio, NULL, offset,
+			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+	return false;
+}
+
+static bool handle_mmio_set_pending_reg_dist(struct kvm_vcpu *vcpu,
+					     struct kvm_exit_mmio *mmio,
+					     phys_addr_t offset)
+{
+	if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
+		return vgic_handle_set_pending_reg(vcpu->kvm, mmio, offset,
+						   vcpu->vcpu_id);
+
+	vgic_reg_access(mmio, NULL, offset,
+			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+	return false;
+}
+
+static bool handle_mmio_clear_pending_reg_dist(struct kvm_vcpu *vcpu,
+					       struct kvm_exit_mmio *mmio,
+					       phys_addr_t offset)
+{
+	if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
+		return vgic_handle_clear_pending_reg(vcpu->kvm, mmio, offset,
+						     vcpu->vcpu_id);
+
+	vgic_reg_access(mmio, NULL, offset,
+			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+	return false;
+}
+
+static bool handle_mmio_priority_reg_dist(struct kvm_vcpu *vcpu,
+					  struct kvm_exit_mmio *mmio,
+					  phys_addr_t offset)
+{
+	u32 *reg;
+
+	if (unlikely(offset < VGIC_NR_PRIVATE_IRQS)) {
+		vgic_reg_access(mmio, NULL, offset,
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
+				     phys_addr_t offset)
+{
+	u32 *reg;
+
+	if (unlikely(offset < VGIC_NR_PRIVATE_IRQS / 4)) {
+		vgic_reg_access(mmio, NULL, offset,
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
+/*
+ * We use a compressed version of the MPIDR (all 32 bits in one 32-bit word)
+ * when we store the target MPIDR written by the guest.
+ */
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
+	mpidr  = ((value >>  0) & 0xFF) << MPIDR_LEVEL_SHIFT(0);
+	mpidr |= ((value >>  8) & 0xFF) << MPIDR_LEVEL_SHIFT(1);
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
+ * type (or storing kvm_vcpu pointers) should lift the limit.
+ * Store the original MPIDR value in an extra array to support read-as-written.
+ * Unallocated MPIDRs are translated to a special value and caught
+ * before any array accesses.
+ */
+static bool handle_mmio_route_reg(struct kvm_vcpu *vcpu,
+				  struct kvm_exit_mmio *mmio,
+				  phys_addr_t offset)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	int spi;
+	u32 reg;
+	int vcpu_id;
+	unsigned long *bmap, mpidr;
+
+	/*
+	 * The upper 32 bits of each 64 bit register are zero,
+	 * as we don't support Aff3.
+	 */
+	if ((offset & 4)) {
+		vgic_reg_access(mmio, NULL, offset,
+				ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+		return false;
+	}
+
+	/* This region only covers SPIs, so no handling of private IRQs here. */
+	spi = offset / 8;
+
+	/* get the stored MPIDR for this IRQ */
+	mpidr = uncompress_mpidr(dist->irq_spi_mpidr[spi]);
+	reg = mpidr;
+
+	vgic_reg_access(mmio, &reg, offset,
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
+		__clear_bit(spi, bmap);
+	}
+
+	dist->irq_spi_mpidr[spi] = compress_mpidr(reg);
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
+		dist->irq_spi_cpu[spi] = vcpu_id;
+		bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[vcpu_id]);
+		__set_bit(spi, bmap);
+	} else {
+		dist->irq_spi_cpu[spi] = VCPU_NOT_ALLOCATED;
+	}
+
+	vgic_update_state(kvm);
+
+	return true;
+}
+
+/*
+ * We should be careful about promising too much when a guest reads
+ * this register. Don't claim to be like any hardware implementation,
+ * but just report the GIC as version 3 - which is what a Linux guest
+ * would check.
+ */
+static bool handle_mmio_idregs(struct kvm_vcpu *vcpu,
+			       struct kvm_exit_mmio *mmio,
+			       phys_addr_t offset)
+{
+	u32 reg = 0;
+
+	switch (offset + GICD_IDREGS) {
+	case GICD_PIDR2:
+		reg = 0x3b;
+		break;
+	}
+
+	vgic_reg_access(mmio, &reg, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+
+	return false;
+}
+
+static const struct kvm_mmio_range vgic_v3_dist_ranges[] = {
+	{
+		.base           = GICD_CTLR,
+		.len            = 0x04,
+		.bits_per_irq   = 0,
+		.handle_mmio    = handle_mmio_ctlr,
+	},
+	{
+		.base           = GICD_TYPER,
+		.len            = 0x04,
+		.bits_per_irq   = 0,
+		.handle_mmio    = handle_mmio_typer,
+	},
+	{
+		.base           = GICD_IIDR,
+		.len            = 0x04,
+		.bits_per_irq   = 0,
+		.handle_mmio    = handle_mmio_iidr,
+	},
+	{
+		/* this register is optional, it is RAZ/WI if not implemented */
+		.base           = GICD_STATUSR,
+		.len            = 0x04,
+		.bits_per_irq   = 0,
+		.handle_mmio    = handle_mmio_raz_wi,
+	},
+	{
+		/* this write only register is WI when TYPER.MBIS=0 */
+		.base		= GICD_SETSPI_NSR,
+		.len		= 0x04,
+		.bits_per_irq	= 0,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		/* this write only register is WI when TYPER.MBIS=0 */
+		.base		= GICD_CLRSPI_NSR,
+		.len		= 0x04,
+		.bits_per_irq	= 0,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		/* this is RAZ/WI when DS=1 */
+		.base		= GICD_SETSPI_SR,
+		.len		= 0x04,
+		.bits_per_irq	= 0,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		/* this is RAZ/WI when DS=1 */
+		.base		= GICD_CLRSPI_SR,
+		.len		= 0x04,
+		.bits_per_irq	= 0,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICD_IGROUPR,
+		.len		= 0x80,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_rao_wi,
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
+		/* this is RAZ/WI when DS=1 */
+		.base		= GICD_NSACR,
+		.len		= 0x100,
+		.bits_per_irq	= 2,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		/* this is RAZ/WI when ARE=1 */
+		.base		= GICD_SGIR,
+		.len		= 0x04,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		/* this is RAZ/WI when ARE=1 */
+		.base		= GICD_CPENDSGIR,
+		.len		= 0x10,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		/* this is RAZ/WI when ARE=1 */
+		.base           = GICD_SPENDSGIR,
+		.len            = 0x10,
+		.handle_mmio    = handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICD_IROUTER + 0x100,
+		.len		= 0x1ee0,
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
+					      phys_addr_t offset)
+{
+	struct kvm_vcpu *redist_vcpu = mmio->private;
+
+	return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
+				      redist_vcpu->vcpu_id,
+				      ACCESS_WRITE_SETBIT);
+}
+
+static bool handle_mmio_clear_enable_reg_redist(struct kvm_vcpu *vcpu,
+						struct kvm_exit_mmio *mmio,
+						phys_addr_t offset)
+{
+	struct kvm_vcpu *redist_vcpu = mmio->private;
+
+	return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
+				      redist_vcpu->vcpu_id,
+				      ACCESS_WRITE_CLEARBIT);
+}
+
+static bool handle_mmio_set_pending_reg_redist(struct kvm_vcpu *vcpu,
+					       struct kvm_exit_mmio *mmio,
+					       phys_addr_t offset)
+{
+	struct kvm_vcpu *redist_vcpu = mmio->private;
+
+	return vgic_handle_set_pending_reg(vcpu->kvm, mmio, offset,
+					   redist_vcpu->vcpu_id);
+}
+
+static bool handle_mmio_clear_pending_reg_redist(struct kvm_vcpu *vcpu,
+						 struct kvm_exit_mmio *mmio,
+						 phys_addr_t offset)
+{
+	struct kvm_vcpu *redist_vcpu = mmio->private;
+
+	return vgic_handle_clear_pending_reg(vcpu->kvm, mmio, offset,
+					     redist_vcpu->vcpu_id);
+}
+
+static bool handle_mmio_priority_reg_redist(struct kvm_vcpu *vcpu,
+					    struct kvm_exit_mmio *mmio,
+					    phys_addr_t offset)
+{
+	struct kvm_vcpu *redist_vcpu = mmio->private;
+	u32 *reg;
+
+	reg = vgic_bytemap_get_reg(&vcpu->kvm->arch.vgic.irq_priority,
+				   redist_vcpu->vcpu_id, offset);
+	vgic_reg_access(mmio, reg, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
+	return false;
+}
+
+static bool handle_mmio_cfg_reg_redist(struct kvm_vcpu *vcpu,
+				       struct kvm_exit_mmio *mmio,
+				       phys_addr_t offset)
+{
+	struct kvm_vcpu *redist_vcpu = mmio->private;
+
+	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
+				       redist_vcpu->vcpu_id, offset >> 1);
+
+	return vgic_handle_cfg_reg(reg, mmio, offset);
+}
+
+static const struct kvm_mmio_range vgic_redist_sgi_ranges[] = {
+	{
+		.base		= GICR_IGROUPR0,
+		.len		= 0x04,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_rao_wi,
+	},
+	{
+		.base		= GICR_ISENABLER0,
+		.len		= 0x04,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_set_enable_reg_redist,
+	},
+	{
+		.base		= GICR_ICENABLER0,
+		.len		= 0x04,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_clear_enable_reg_redist,
+	},
+	{
+		.base		= GICR_ISPENDR0,
+		.len		= 0x04,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_set_pending_reg_redist,
+	},
+	{
+		.base		= GICR_ICPENDR0,
+		.len		= 0x04,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_clear_pending_reg_redist,
+	},
+	{
+		.base		= GICR_ISACTIVER0,
+		.len		= 0x04,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICR_ICACTIVER0,
+		.len		= 0x04,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICR_IPRIORITYR0,
+		.len		= 0x20,
+		.bits_per_irq	= 8,
+		.handle_mmio	= handle_mmio_priority_reg_redist,
+	},
+	{
+		.base		= GICR_ICFGR0,
+		.len		= 0x08,
+		.bits_per_irq	= 2,
+		.handle_mmio	= handle_mmio_cfg_reg_redist,
+	},
+	{
+		.base		= GICR_IGRPMODR0,
+		.len		= 0x04,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GICR_NSACR,
+		.len		= 0x04,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{},
+};
+
+static bool handle_mmio_ctlr_redist(struct kvm_vcpu *vcpu,
+				    struct kvm_exit_mmio *mmio,
+				    phys_addr_t offset)
+{
+	/* since we don't support LPIs, this register is zero for now */
+	vgic_reg_access(mmio, NULL, offset,
+			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+	return false;
+}
+
+static bool handle_mmio_typer_redist(struct kvm_vcpu *vcpu,
+				     struct kvm_exit_mmio *mmio,
+				     phys_addr_t offset)
+{
+	u32 reg;
+	u64 mpidr;
+	struct kvm_vcpu *redist_vcpu = mmio->private;
+	int target_vcpu_id = redist_vcpu->vcpu_id;
+
+	/* the upper 32 bits contain the affinity value */
+	if ((offset & ~3) == 4) {
+		mpidr = kvm_vcpu_get_mpidr_aff(redist_vcpu);
+		reg = compress_mpidr(mpidr);
+
+		vgic_reg_access(mmio, &reg, offset,
+				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+		return false;
+	}
+
+	reg = redist_vcpu->vcpu_id << 8;
+	if (target_vcpu_id == atomic_read(&vcpu->kvm->online_vcpus) - 1)
+		reg |= GICR_TYPER_LAST;
+	vgic_reg_access(mmio, &reg, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+	return false;
+}
+
+static const struct kvm_mmio_range vgic_redist_ranges[] = {
+	{
+		.base           = GICR_CTLR,
+		.len            = 0x04,
+		.bits_per_irq   = 0,
+		.handle_mmio    = handle_mmio_ctlr_redist,
+	},
+	{
+		.base           = GICR_TYPER,
+		.len            = 0x08,
+		.bits_per_irq   = 0,
+		.handle_mmio    = handle_mmio_typer_redist,
+	},
+	{
+		.base           = GICR_IIDR,
+		.len            = 0x04,
+		.bits_per_irq   = 0,
+		.handle_mmio    = handle_mmio_iidr,
+	},
+	{
+		.base           = GICR_WAKER,
+		.len            = 0x04,
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
+ * This function splits accesses between the distributor and the two
+ * redistributor parts (private/SPI). As each redistributor is accessible
+ * from any CPU, we have to determine the affected VCPU by taking the faulting
+ * address into account. We then pass this VCPU to the handler function via
+ * the private parameter.
+ */
+#define SGI_BASE_OFFSET SZ_64K
+static bool vgic_v3_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
+				struct kvm_exit_mmio *mmio)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	unsigned long dbase = dist->vgic_dist_base;
+	unsigned long rdbase = dist->vgic_redist_base;
+	int nrcpus = atomic_read(&vcpu->kvm->online_vcpus);
+	int vcpu_id;
+	const struct kvm_mmio_range *mmio_range;
+
+	if (is_in_range(mmio->phys_addr, mmio->len, dbase, GIC_V3_DIST_SIZE)) {
+		return vgic_handle_mmio_range(vcpu, run, mmio,
+					      vgic_v3_dist_ranges, dbase);
+	}
+
+	if (!is_in_range(mmio->phys_addr, mmio->len, rdbase,
+	    GIC_V3_REDIST_SIZE * nrcpus))
+		return false;
+
+	vcpu_id = (mmio->phys_addr - rdbase) / GIC_V3_REDIST_SIZE;
+	rdbase += (vcpu_id * GIC_V3_REDIST_SIZE);
+	mmio->private = kvm_get_vcpu(vcpu->kvm, vcpu_id);
+
+	if (mmio->phys_addr >= rdbase + SGI_BASE_OFFSET) {
+		rdbase += SGI_BASE_OFFSET;
+		mmio_range = vgic_redist_sgi_ranges;
+	} else {
+		mmio_range = vgic_redist_ranges;
+	}
+	return vgic_handle_mmio_range(vcpu, run, mmio, mmio_range, rdbase);
+}
+
+static bool vgic_v3_queue_sgi(struct kvm_vcpu *vcpu, int irq)
+{
+	if (vgic_queue_irq(vcpu, 0, irq)) {
+		vgic_dist_irq_clear_pending(vcpu, irq);
+		vgic_cpu_irq_clear(vcpu, irq);
+		return true;
+	}
+
+	return false;
+}
+
+static int vgic_v3_map_resources(struct kvm *kvm,
+				 const struct vgic_params *params)
+{
+	int ret = 0;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+
+	if (!irqchip_in_kernel(kvm))
+		return 0;
+
+	mutex_lock(&kvm->lock);
+
+	if (vgic_ready(kvm))
+		goto out;
+
+	if (IS_VGIC_ADDR_UNDEF(dist->vgic_dist_base) ||
+	    IS_VGIC_ADDR_UNDEF(dist->vgic_redist_base)) {
+		kvm_err("Need to set vgic distributor addresses first\n");
+		ret = -ENXIO;
+		goto out;
+	}
+
+	/*
+	 * For a VGICv3 we require the userland to explicitly initialize
+	 * the VGIC before we need to use it.
+	 */
+	if (!vgic_initialized(kvm)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	kvm->arch.vgic.ready = true;
+out:
+	if (ret)
+		kvm_vgic_destroy(kvm);
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
+
+static int vgic_v3_init_model(struct kvm *kvm)
+{
+	int i;
+	u32 mpidr;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	int nr_spis = dist->nr_irqs - VGIC_NR_PRIVATE_IRQS;
+
+	dist->irq_spi_mpidr = kcalloc(nr_spis, sizeof(dist->irq_spi_mpidr[0]),
+				      GFP_KERNEL);
+
+	if (!dist->irq_spi_mpidr)
+		return -ENOMEM;
+
+	/* Initialize the target VCPUs for each IRQ to VCPU 0 */
+	mpidr = compress_mpidr(kvm_vcpu_get_mpidr_aff(kvm_get_vcpu(kvm, 0)));
+	for (i = VGIC_NR_PRIVATE_IRQS; i < dist->nr_irqs; i++) {
+		dist->irq_spi_cpu[i - VGIC_NR_PRIVATE_IRQS] = 0;
+		dist->irq_spi_mpidr[i - VGIC_NR_PRIVATE_IRQS] = mpidr;
+		vgic_bitmap_set_irq_val(dist->irq_spi_target, 0, i, 1);
+	}
+
+	return 0;
+}
+
+/* GICv3 does not keep track of SGI sources anymore. */
+static void vgic_v3_add_sgi_source(struct kvm_vcpu *vcpu, int irq, int source)
+{
+}
+
+void vgic_v3_init_emulation(struct kvm *kvm)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+
+	dist->vm_ops.handle_mmio = vgic_v3_handle_mmio;
+	dist->vm_ops.queue_sgi = vgic_v3_queue_sgi;
+	dist->vm_ops.add_sgi_source = vgic_v3_add_sgi_source;
+	dist->vm_ops.init_model = vgic_v3_init_model;
+	dist->vm_ops.map_resources = vgic_v3_map_resources;
+
+	kvm->arch.max_vcpus = KVM_MAX_VCPUS;
+}
+
+static int vgic_v3_create(struct kvm_device *dev, u32 type)
+{
+	return kvm_vgic_create(dev->kvm, type);
+}
+
+static void vgic_v3_destroy(struct kvm_device *dev)
+{
+	kfree(dev);
+}
+
+static int vgic_v3_set_attr(struct kvm_device *dev,
+			    struct kvm_device_attr *attr)
+{
+	int ret;
+
+	ret = vgic_set_common_attr(dev, attr);
+	if (ret != -ENXIO)
+		return ret;
+
+	switch (attr->group) {
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
+		return -ENXIO;
+	}
+
+	return -ENXIO;
+}
+
+static int vgic_v3_get_attr(struct kvm_device *dev,
+			    struct kvm_device_attr *attr)
+{
+	int ret;
+
+	ret = vgic_get_common_attr(dev, attr);
+	if (ret != -ENXIO)
+		return ret;
+
+	switch (attr->group) {
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
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
+		return 0;
+	case KVM_DEV_ARM_VGIC_GRP_CTRL:
+		switch (attr->attr) {
+		case KVM_DEV_ARM_VGIC_CTRL_INIT:
+			return 0;
+		}
+	}
+	return -ENXIO;
+}
+
+struct kvm_device_ops kvm_arm_vgic_v3_ops = {
+	.name = "kvm-arm-vgic-v3",
+	.create = vgic_v3_create,
+	.destroy = vgic_v3_destroy,
+	.set_attr = vgic_v3_set_attr,
+	.get_attr = vgic_v3_get_attr,
+	.has_attr = vgic_v3_has_attr,
+};
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index b6e17c8..6d23e57 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1249,7 +1249,7 @@ static int vgic_update_irq_pending(struct kvm *kvm, int cpuid,
 	struct kvm_vcpu *vcpu;
 	int edge_triggered, level_triggered;
 	int enabled;
-	bool ret = true;
+	bool ret = true, can_inject = true;
 
 	spin_lock(&dist->lock);
 
@@ -1264,6 +1264,11 @@ static int vgic_update_irq_pending(struct kvm *kvm, int cpuid,
 
 	if (irq_num >= VGIC_NR_PRIVATE_IRQS) {
 		cpuid = dist->irq_spi_cpu[irq_num - VGIC_NR_PRIVATE_IRQS];
+		if (cpuid == VCPU_NOT_ALLOCATED) {
+			/* Pretend we use CPU0, and prevent injection */
+			cpuid = 0;
+			can_inject = false;
+		}
 		vcpu = kvm_get_vcpu(kvm, cpuid);
 	}
 
@@ -1286,7 +1291,7 @@ static int vgic_update_irq_pending(struct kvm *kvm, int cpuid,
 
 	enabled = vgic_irq_is_enabled(vcpu, irq_num);
 
-	if (!enabled) {
+	if (!enabled || !can_inject) {
 		ret = false;
 		goto out;
 	}
@@ -1439,6 +1444,7 @@ void kvm_vgic_destroy(struct kvm *kvm)
 	}
 	kfree(dist->irq_sgi_sources);
 	kfree(dist->irq_spi_cpu);
+	kfree(dist->irq_spi_mpidr);
 	kfree(dist->irq_spi_target);
 	kfree(dist->irq_pending_on_cpu);
 	dist->irq_sgi_sources = NULL;
@@ -1594,6 +1600,7 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 	kvm->arch.vgic.vctrl_base = vgic->vctrl_base;
 	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
 	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
+	kvm->arch.vgic.vgic_redist_base = VGIC_ADDR_UNDEF;
 
 out_unlock:
 	for (; vcpu_lock_idx >= 0; vcpu_lock_idx--) {
diff --git a/virt/kvm/arm/vgic.h b/virt/kvm/arm/vgic.h
index e363b93..1e83bdf 100644
--- a/virt/kvm/arm/vgic.h
+++ b/virt/kvm/arm/vgic.h
@@ -35,6 +35,8 @@
 #define ACCESS_WRITE_VALUE	(3 << 1)
 #define ACCESS_WRITE_MASK(x)	((x) & (3 << 1))
 
+#define VCPU_NOT_ALLOCATED	((u8)-1)
+
 unsigned long *vgic_bitmap_get_shared_map(struct vgic_bitmap *x);
 
 void vgic_update_state(struct kvm *kvm);
@@ -116,5 +118,6 @@ int vgic_get_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr);
 
 int vgic_init(struct kvm *kvm);
 void vgic_v2_init_emulation(struct kvm *kvm);
+void vgic_v3_init_emulation(struct kvm *kvm);
 
 #endif
-- 
2.1.2.330.g565301e.dirty
