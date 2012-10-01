From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 01 Oct 2012 05:13:38 -0400
Subject: [PATCH v2 04/10] ARM: KVM: VGIC distributor handling
In-Reply-To: <20121001091244.49503.96318.stgit@ubuntu>
References: <20121001091244.49503.96318.stgit@ubuntu>
Message-ID: <20121001091338.49503.17917.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Add the GIC distributor emulation code. A number of the GIC features
are simply ignored as they are not required to boot a Linux guest.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_vgic.h |  170 ++++++++++++++
 arch/arm/kvm/vgic.c             |  475 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 644 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
index a87ec6c..a82699f 100644
--- a/arch/arm/include/asm/kvm_vgic.h
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -19,7 +19,177 @@
 #ifndef __ASM_ARM_KVM_VGIC_H
 #define __ASM_ARM_KVM_VGIC_H
 
+#include <linux/kernel.h>
+#include <linux/kvm.h>
+#include <linux/kvm_host.h>
+#include <linux/irqreturn.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#define VGIC_NR_IRQS		128
+#define VGIC_NR_SHARED_IRQS	(VGIC_NR_IRQS - 32)
+#define VGIC_MAX_CPUS		NR_CPUS
+
+/* Sanity checks... */
+#if (VGIC_MAX_CPUS > 8)
+#error	Invalid number of CPU interfaces
+#endif
+
+#if (VGIC_NR_IRQS & 31)
+#error "VGIC_NR_IRQS must be a multiple of 32"
+#endif
+
+#if (VGIC_NR_IRQS > 1024)
+#error "VGIC_NR_IRQS must be <= 1024"
+#endif
+
+/*
+ * The GIC distributor registers describing interrupts have two parts:
+ * - 32 per-CPU interrupts (SGI + PPI)
+ * - a bunch of shared interrups (SPI)
+ */
+struct vgic_bitmap {
+	union {
+		u32 reg[1];
+		unsigned long reg_ul[0];
+	} percpu[VGIC_MAX_CPUS];
+	union {
+		u32 reg[VGIC_NR_SHARED_IRQS / 32];
+		unsigned long reg_ul[0];
+	} shared;
+};
+
+static inline u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
+				       int cpuid, u32 offset)
+{
+	offset >>= 2;
+	BUG_ON(offset > (VGIC_NR_IRQS / 32));
+	if (!offset)
+		return x->percpu[cpuid].reg;
+	else
+		return x->shared.reg + offset - 1;
+}
+
+static inline int vgic_bitmap_get_irq_val(struct vgic_bitmap *x,
+					 int cpuid, int irq)
+{
+	if (irq < 32)
+		return test_bit(irq, x->percpu[cpuid].reg_ul);
+
+	return test_bit(irq - 32, x->shared.reg_ul);
+}
+
+static inline void vgic_bitmap_set_irq_val(struct vgic_bitmap *x,
+					   int cpuid, int irq, int val)
+{
+	unsigned long *reg;
+
+	if (irq < 32)
+		reg = x->percpu[cpuid].reg_ul;
+	else {
+		reg =  x->shared.reg_ul;
+		irq -= 32;
+	}
+
+	if (val)
+		set_bit(irq, reg);
+	else
+		clear_bit(irq, reg);
+}
+
+static inline unsigned long *vgic_bitmap_get_cpu_map(struct vgic_bitmap *x,
+						     int cpuid)
+{
+	if (unlikely(cpuid >= VGIC_MAX_CPUS))
+		return NULL;
+	return x->percpu[cpuid].reg_ul;
+}
+
+static inline unsigned long *vgic_bitmap_get_shared_map(struct vgic_bitmap *x)
+{
+	return x->shared.reg_ul;
+}
+
+struct vgic_bytemap {
+	union {
+		u32 reg[8];
+		unsigned long reg_ul[0];
+	} percpu[VGIC_MAX_CPUS];
+	union {
+		u32 reg[VGIC_NR_SHARED_IRQS  / 4];
+		unsigned long reg_ul[0];
+	} shared;
+};
+
+static inline u32 *vgic_bytemap_get_reg(struct vgic_bytemap *x,
+					int cpuid, u32 offset)
+{
+	offset >>= 2;
+	BUG_ON(offset > (VGIC_NR_IRQS / 4));
+	if (offset < 4)
+		return x->percpu[cpuid].reg + offset;
+	else
+		return x->shared.reg + offset - 8;
+}
+
+static inline int vgic_bytemap_get_irq_val(struct vgic_bytemap *x,
+					   int cpuid, int irq)
+{
+	u32 *reg, shift;
+	shift = (irq & 3) * 8;
+	reg = vgic_bytemap_get_reg(x, cpuid, irq);
+	return (*reg >> shift) & 0xff;
+}
+
+static inline void vgic_bytemap_set_irq_val(struct vgic_bytemap *x,
+					    int cpuid, int irq, int val)
+{
+	u32 *reg, shift;
+	shift = (irq & 3) * 8;
+	reg = vgic_bytemap_get_reg(x, cpuid, irq);
+	*reg &= ~(0xff << shift);
+	*reg |= (val & 0xff) << shift;
+}
+
 struct vgic_dist {
+#ifdef CONFIG_KVM_ARM_VGIC
+	spinlock_t		lock;
+
+	/* Virtual control interface mapping */
+	void __iomem		*vctrl_base;
+
+	/* Distributor mapping in the guest */
+	unsigned long		vgic_dist_base;
+	unsigned long		vgic_dist_size;
+
+	/* Distributor enabled */
+	u32			enabled;
+
+	/* Interrupt enabled (one bit per IRQ) */
+	struct vgic_bitmap	irq_enabled;
+
+	/* Interrupt 'pin' level */
+	struct vgic_bitmap	irq_state;
+
+	/* Level-triggered interrupt in progress */
+	struct vgic_bitmap	irq_active;
+
+	/* Interrupt priority. Not used yet. */
+	struct vgic_bytemap	irq_priority;
+
+	/* Level/edge triggered */
+	struct vgic_bitmap	irq_cfg;
+
+	/* Source CPU per SGI and target CPU */
+	u8			irq_sgi_sources[VGIC_MAX_CPUS][16];
+
+	/* Target CPU for each IRQ */
+	u8			irq_spi_cpu[VGIC_NR_SHARED_IRQS];
+	struct vgic_bitmap	irq_spi_target[VGIC_MAX_CPUS];
+
+	/* Bitmap indicating which CPU has something pending */
+	unsigned long		irq_pending_on_cpu;
+#endif
 };
 
 struct vgic_cpu {
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index 26ada3b..a870596 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -22,6 +22,46 @@
 #include <linux/io.h>
 #include <asm/kvm_emulate.h>
 
+/*
+ * How the whole thing works (courtesy of Christoffer Dall):
+ *
+ * - At any time, the dist->irq_pending_on_cpu is the oracle that knows if
+ *   something is pending
+ * - VGIC pending interrupts are stored on the vgic.irq_state vgic
+ *   bitmap (this bitmap is updated by both user land ioctls and guest
+ *   mmio ops) and indicate the 'wire' state.
+ * - Every time the bitmap changes, the irq_pending_on_cpu oracle is
+ *   recalculated
+ * - To calculate the oracle, we need info for each cpu from
+ *   compute_pending_for_cpu, which considers:
+ *   - PPI: dist->irq_state & dist->irq_enable
+ *   - SPI: dist->irq_state & dist->irq_enable & dist->irq_spi_target
+ *   - irq_spi_target is a 'formatted' version of the GICD_ICFGR
+ *     registers, stored on each vcpu. We only keep one bit of
+ *     information per interrupt, making sure that only one vcpu can
+ *     accept the interrupt.
+ * - The same is true when injecting an interrupt, except that we only
+ *   consider a single interrupt at a time. The irq_spi_cpu array
+ *   contains the target CPU for each SPI.
+ *
+ * The handling of level interrupts adds some extra complexity. We
+ * need to track when the interrupt has been EOIed, so we can sample
+ * the 'line' again. This is achieved as such:
+ *
+ * - When a level interrupt is moved onto a vcpu, the corresponding
+ *   bit in irq_active is set. As long as this bit is set, the line
+ *   will be ignored for further interrupts. The interrupt is injected
+ *   into the vcpu with the VGIC_LR_EOI bit set (generate a
+ *   maintenance interrupt on EOI).
+ * - When the interrupt is EOIed, the maintenance interrupt fires,
+ *   and clears the corresponding bit in irq_active. This allow the
+ *   interrupt line to be sampled again.
+ */
+
+/* Temporary hacks, need to be provided by userspace emulation */
+#define VGIC_DIST_BASE		0x2c001000
+#define VGIC_DIST_SIZE		0x1000
+
 #define ACCESS_READ_VALUE	(1 << 0)
 #define ACCESS_READ_RAZ		(0 << 0)
 #define ACCESS_READ_MASK(x)	((x) & (1 << 0))
@@ -31,6 +71,14 @@
 #define ACCESS_WRITE_VALUE	(3 << 1)
 #define ACCESS_WRITE_MASK(x)	((x) & (3 << 1))
 
+static void vgic_update_state(struct kvm *kvm);
+static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
+
+static inline int vgic_irq_is_edge(struct vgic_dist *dist, int irq)
+{
+	return vgic_bitmap_get_irq_val(&dist->irq_cfg, 0, irq);
+}
+
 /**
  * vgic_reg_access - access vgic register
  * @mmio:   pointer to the data describing the mmio access
@@ -94,6 +142,280 @@ static void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
 	}
 }
 
+static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
+			     struct kvm_exit_mmio *mmio, u32 offset)
+{
+	u32 reg;
+	u32 u32off = offset & 3;
+
+	switch (offset & ~3) {
+	case 0:			/* CTLR */
+		reg = vcpu->kvm->arch.vgic.enabled;
+		vgic_reg_access(mmio, &reg, u32off,
+				ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
+		if (mmio->is_write) {
+			vcpu->kvm->arch.vgic.enabled = reg & 1;
+			vgic_update_state(vcpu->kvm);
+			return true;
+		}
+		break;
+
+	case 4:			/* TYPER */
+		reg  = (atomic_read(&vcpu->kvm->online_vcpus) - 1) << 5;
+		reg |= (VGIC_NR_IRQS >> 5) - 1;
+		vgic_reg_access(mmio, &reg, u32off,
+				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+		break;
+
+	case 8:			/* IIDR */
+		reg = 0x4B00043B;
+		vgic_reg_access(mmio, &reg, u32off,
+				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+		break;
+	}
+
+	return false;
+}
+
+static bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu,
+			       struct kvm_exit_mmio *mmio, u32 offset)
+{
+	vgic_reg_access(mmio, NULL, offset,
+			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+	return false;
+}
+
+static bool handle_mmio_set_enable_reg(struct kvm_vcpu *vcpu,
+				       struct kvm_exit_mmio *mmio, u32 offset)
+{
+	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_enabled,
+				       vcpu->vcpu_id, offset);
+	vgic_reg_access(mmio, reg, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
+	if (mmio->is_write) {
+		vgic_update_state(vcpu->kvm);
+		return true;
+	}
+
+	return false;
+}
+
+static bool handle_mmio_clear_enable_reg(struct kvm_vcpu *vcpu,
+					 struct kvm_exit_mmio *mmio, u32 offset)
+{
+	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_enabled,
+				       vcpu->vcpu_id, offset);
+	vgic_reg_access(mmio, reg, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
+	if (mmio->is_write) {
+		if (offset < 4) /* Force SGI enabled */
+			*reg |= 0xffff;
+		vgic_update_state(vcpu->kvm);
+		return true;
+	}
+
+	return false;
+}
+
+static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
+					struct kvm_exit_mmio *mmio, u32 offset)
+{
+	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_state,
+				       vcpu->vcpu_id, offset);
+	vgic_reg_access(mmio, reg, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
+	if (mmio->is_write) {
+		vgic_update_state(vcpu->kvm);
+		return true;
+	}
+
+	return false;
+}
+
+static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
+					  struct kvm_exit_mmio *mmio, u32 offset)
+{
+	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_state,
+				       vcpu->vcpu_id, offset);
+	vgic_reg_access(mmio, reg, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
+	if (mmio->is_write) {
+		vgic_update_state(vcpu->kvm);
+		return true;
+	}
+
+	return false;
+}
+
+static bool handle_mmio_priority_reg(struct kvm_vcpu *vcpu,
+				     struct kvm_exit_mmio *mmio, u32 offset)
+{
+	u32 *reg = vgic_bytemap_get_reg(&vcpu->kvm->arch.vgic.irq_priority,
+					vcpu->vcpu_id, offset);
+	vgic_reg_access(mmio, reg, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
+	return false;
+}
+
+static u32 vgic_get_target_reg(struct kvm *kvm, int irq)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct kvm_vcpu *vcpu;
+	int i, c;
+	unsigned long *bmap;
+	u32 val = 0;
+
+	BUG_ON(irq & 3);
+	BUG_ON(irq < 32);
+
+	irq -= 32;
+
+	kvm_for_each_vcpu(c, vcpu, kvm) {
+		bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[c]);
+		for (i = 0; i < 4; i++)
+			if (test_bit(irq + i, bmap))
+				val |= 1 << (c + i * 8);
+	}
+
+	return val;
+}
+
+static void vgic_set_target_reg(struct kvm *kvm, u32 val, int irq)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct kvm_vcpu *vcpu;
+	int i, c;
+	unsigned long *bmap;
+	u32 target;
+
+	BUG_ON(irq & 3);
+	BUG_ON(irq < 32);
+
+	irq -= 32;
+
+	/*
+	 * Pick the LSB in each byte. This ensures we target exactly
+	 * one vcpu per IRQ. If the byte is null, assume we target
+	 * CPU0.
+	 */
+	for (i = 0; i < 4; i++) {
+		int shift = i * 8;
+		target = ffs((val >> shift) & 0xffU);
+		target = target ? (target - 1) : 0;
+		dist->irq_spi_cpu[irq + i] = target;
+		kvm_for_each_vcpu(c, vcpu, kvm) {
+			bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[c]);
+			if (c == target)
+				set_bit(irq + i, bmap);
+			else
+				clear_bit(irq + i, bmap);
+		}
+	}
+}
+
+static bool handle_mmio_target_reg(struct kvm_vcpu *vcpu,
+				   struct kvm_exit_mmio *mmio, u32 offset)
+{
+	u32 reg;
+
+	/* We treat the banked interrupts targets as read-only */
+	if (offset < 32) {
+		u32 roreg = 1 << vcpu->vcpu_id;
+		roreg |= roreg << 8;
+		roreg |= roreg << 16;
+
+		vgic_reg_access(mmio, &roreg, offset,
+				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+		return false;
+	}
+
+	reg = vgic_get_target_reg(vcpu->kvm, offset & ~3U);
+	vgic_reg_access(mmio, &reg, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
+	if (mmio->is_write) {
+		vgic_set_target_reg(vcpu->kvm, reg, offset & ~3U);
+		vgic_update_state(vcpu->kvm);
+		return true;
+	}
+
+	return false;
+}
+
+static u32 vgic_cfg_expand(u16 val)
+{
+	u32 res = 0;
+	int i;
+
+	for (i = 0; i < 16; i++)
+		res |= (val >> i) << (2 * i + 1);
+
+	return res;
+}
+
+static u16 vgic_cfg_compress(u32 val)
+{
+	u16 res = 0;
+	int i;
+
+	for (i = 0; i < 16; i++)
+		res |= (val >> (i * 2 + 1)) << i;
+
+	return res;
+}
+
+/*
+ * The distributor uses 2 bits per IRQ for the CFG register, but the
+ * LSB is always 0. As such, we only keep the upper bit, and use the
+ * two above functions to compress/expand the bits
+ */
+static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
+				struct kvm_exit_mmio *mmio, u32 offset)
+{
+	u32 val;
+	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
+				       vcpu->vcpu_id, offset >> 1);
+	if (offset & 2)
+		val = *reg >> 16;
+	else
+		val = *reg & 0xffff;
+
+	val = vgic_cfg_expand(val);
+	vgic_reg_access(mmio, &val, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
+	if (mmio->is_write) {
+		if (offset < 4) {
+			*reg = ~0U; /* Force PPIs/SGIs to 1 */
+			return false;
+		}
+
+		val = vgic_cfg_compress(val);
+		if (offset & 2) {
+			*reg &= 0xffff;
+			*reg |= val << 16;
+		} else {
+			*reg &= 0xffff << 16;
+			*reg |= val;
+		}
+	}
+
+	return false;
+}
+
+static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
+				struct kvm_exit_mmio *mmio, u32 offset)
+{
+	u32 reg;
+	vgic_reg_access(mmio, &reg, offset,
+			ACCESS_READ_RAZ | ACCESS_WRITE_VALUE);
+	if (mmio->is_write) {
+		vgic_dispatch_sgi(vcpu, reg);
+		vgic_update_state(vcpu->kvm);
+		return true;
+	}
+
+	return false;
+}
+
 /* All this should be handled by kvm_bus_io_*()... FIXME!!! */
 struct mmio_range {
 	unsigned long base;
@@ -103,6 +425,66 @@ struct mmio_range {
 };
 
 static const struct mmio_range vgic_ranges[] = {
+	{			/* CTRL, TYPER, IIDR */
+		.base		= 0,
+		.len		= 12,
+		.handle_mmio	= handle_mmio_misc,
+	},
+	{			/* IGROUPRn */
+		.base		= 0x80,
+		.len		= VGIC_NR_IRQS / 8,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{			/* ISENABLERn */
+		.base		= 0x100,
+		.len		= VGIC_NR_IRQS / 8,
+		.handle_mmio	= handle_mmio_set_enable_reg,
+	},
+	{			/* ICENABLERn */
+		.base		= 0x180,
+		.len		= VGIC_NR_IRQS / 8,
+		.handle_mmio	= handle_mmio_clear_enable_reg,
+	},
+	{			/* ISPENDRn */
+		.base		= 0x200,
+		.len		= VGIC_NR_IRQS / 8,
+		.handle_mmio	= handle_mmio_set_pending_reg,
+	},
+	{			/* ICPENDRn */
+		.base		= 0x280,
+		.len		= VGIC_NR_IRQS / 8,
+		.handle_mmio	= handle_mmio_clear_pending_reg,
+	},
+	{			/* ISACTIVERn */
+		.base		= 0x300,
+		.len		= VGIC_NR_IRQS / 8,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{			/* ICACTIVERn */
+		.base		= 0x380,
+		.len		= VGIC_NR_IRQS / 8,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{			/* IPRIORITYRn */
+		.base		= 0x400,
+		.len		= VGIC_NR_IRQS,
+		.handle_mmio	= handle_mmio_priority_reg,
+	},
+	{			/* ITARGETSRn */
+		.base		= 0x800,
+		.len		= VGIC_NR_IRQS,
+		.handle_mmio	= handle_mmio_target_reg,
+	},
+	{			/* ICFGRn */
+		.base		= 0xC00,
+		.len		= VGIC_NR_IRQS / 4,
+		.handle_mmio	= handle_mmio_cfg_reg,
+	},
+	{			/* SGIRn */
+		.base		= 0xF00,
+		.len		= 4,
+		.handle_mmio	= handle_mmio_sgi_reg,
+	},
 	{}
 };
 
@@ -134,5 +516,96 @@ struct mmio_range *find_matching_range(const struct mmio_range *ranges,
  */
 bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run, struct kvm_exit_mmio *mmio)
 {
-	return KVM_EXIT_MMIO;
+	const struct mmio_range *range;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	unsigned long base = dist->vgic_dist_base;
+	bool updated_state;
+
+	if (!irqchip_in_kernel(vcpu->kvm) ||
+	    mmio->phys_addr < base ||
+	    (mmio->phys_addr + mmio->len) > (base + dist->vgic_dist_size))
+		return false;
+
+	range = find_matching_range(vgic_ranges, mmio, base);
+	if (unlikely(!range || !range->handle_mmio)) {
+		pr_warn("Unhandled access %d %08llx %d\n",
+			mmio->is_write, mmio->phys_addr, mmio->len);
+		return false;
+	}
+
+	spin_lock(&vcpu->kvm->arch.vgic.lock);
+	updated_state = range->handle_mmio(vcpu, mmio,mmio->phys_addr - range->base - base);
+	spin_unlock(&vcpu->kvm->arch.vgic.lock);
+	kvm_prepare_mmio(run, mmio);
+	kvm_handle_mmio_return(vcpu, run);
+
+	return true;
+}
+
+static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	int nrcpus = atomic_read(&kvm->online_vcpus);
+	u8 target_cpus;
+	int sgi, mode, c, vcpu_id;
+
+	vcpu_id = vcpu->vcpu_id;
+
+	sgi = reg & 0xf;
+	target_cpus = (reg >> 16) & 0xff;
+	mode = (reg >> 24) & 3;
+
+	switch (mode) {
+	case 0:
+		if (!target_cpus)
+			return;
+
+	case 1:
+		target_cpus = ((1 << nrcpus) - 1) & ~(1 << vcpu_id) & 0xff;
+		break;
+
+	case 2:
+		target_cpus = 1 << vcpu_id;
+		break;
+	}
+
+	kvm_for_each_vcpu(c, vcpu, kvm) {
+		if (target_cpus & 1) {
+			/* Flag the SGI as pending */
+			vgic_bitmap_set_irq_val(&dist->irq_state, c, sgi, 1);
+			dist->irq_sgi_sources[c][sgi] |= 1 << vcpu_id;
+			kvm_debug("SGI%d from CPU%d to CPU%d\n", sgi, vcpu_id, c);
+		}
+
+		target_cpus >>= 1;
+	}
+}
+
+static int compute_pending_for_cpu(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+/*
+ * Update the interrupt state and determine which CPUs have pending
+ * interrupts. Must be called with distributor lock held.
+ */
+static void vgic_update_state(struct kvm *kvm)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct kvm_vcpu *vcpu;
+	int c;
+
+	if (!dist->enabled) {
+		set_bit(0, &dist->irq_pending_on_cpu);
+		return;
+	}
+
+	kvm_for_each_vcpu(c, vcpu, kvm) {
+		if (compute_pending_for_cpu(vcpu)) {
+			pr_debug("CPU%d has pending interrupts\n", c);
+			set_bit(c, &dist->irq_pending_on_cpu);
+		}
+	}
 }
