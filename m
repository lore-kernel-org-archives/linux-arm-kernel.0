From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 19 Jun 2014 10:45:47 +0100
Subject: [PATCH 09/14] arm/arm64: KVM: split GICv2 specific emulation code
 from vgic.c
In-Reply-To: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
References: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1403171152-24067-10-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vgic.c is currently a mixture of generic vGIC emulation code and
functions specific to emulating a GICv2. To ease the addition of
GICv3, split off strictly v2 specific parts into a new file
vgic-v2-emul.c.
A new header file vgic.h is introduced to allow separation and later
sharing of functions.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/kvm/Makefile       |    1 +
 arch/arm64/kvm/Makefile     |    1 +
 virt/kvm/arm/vgic-v2-emul.c |  795 ++++++++++++++++++++++++++++++++++++++++
 virt/kvm/arm/vgic.c         |  856 +++----------------------------------------
 virt/kvm/arm/vgic.h         |  113 ++++++
 5 files changed, 956 insertions(+), 810 deletions(-)
 create mode 100644 virt/kvm/arm/vgic-v2-emul.c
 create mode 100644 virt/kvm/arm/vgic.h

diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index f7057ed..443b8be 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -22,4 +22,5 @@ obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
 obj-y += coproc.o coproc_a15.o coproc_a7.o mmio.o psci.o perf.o
 obj-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o
 obj-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2.o
+obj-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2-emul.o
 obj-$(CONFIG_KVM_ARM_TIMER) += $(KVM)/arm/arch_timer.o
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 32a0961..f241db6 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -20,6 +20,7 @@ kvm-$(CONFIG_KVM_ARM_HOST) += hyp.o hyp-init.o handle_exit.o
 kvm-$(CONFIG_KVM_ARM_HOST) += guest.o reset.o sys_regs.o sys_regs_generic_v8.o
 
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o
+kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2-emul.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v2-switch.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v3.o
diff --git a/virt/kvm/arm/vgic-v2-emul.c b/virt/kvm/arm/vgic-v2-emul.c
new file mode 100644
index 0000000..ba5f873
--- /dev/null
+++ b/virt/kvm/arm/vgic-v2-emul.c
@@ -0,0 +1,795 @@
+/*
+ * Contains GICv2 specific emulation code, was in vgic.c before.
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
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
+#include <linux/io.h>
+#include <linux/uaccess.h>
+
+#include <linux/irqchip/arm-gic.h>
+
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_arm.h>
+#include <asm/kvm_mmu.h>
+
+#include "vgic.h"
+
+#define GICC_ARCH_VERSION_V2        0x2
+
+static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
+static u8 *vgic_get_sgi_sources(struct vgic_dist *dist, int vcpu_id, int sgi)
+{
+	return dist->irq_sgi_sources + vcpu_id * VGIC_NR_SGIS + sgi;
+}
+
+static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
+			     struct kvm_exit_mmio *mmio, phys_addr_t offset)
+{
+	u32 reg;
+	u32 word_offset = offset & 3;
+
+	switch (offset & ~3) {
+	case 0:			/* GICD_CTLR */
+		reg = vcpu->kvm->arch.vgic.enabled;
+		vgic_reg_access(mmio, &reg, word_offset,
+				ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
+		if (mmio->is_write) {
+			vcpu->kvm->arch.vgic.enabled = reg & 1;
+			vgic_update_state(vcpu->kvm);
+			return true;
+		}
+		break;
+
+	case 4:			/* GICD_TYPER */
+		reg  = (atomic_read(&vcpu->kvm->online_vcpus) - 1) << 5;
+		reg |= (vcpu->kvm->arch.vgic.nr_irqs >> 5) - 1;
+		vgic_reg_access(mmio, &reg, word_offset,
+				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+		break;
+
+	case 8:			/* GICD_IIDR */
+		reg = (PRODUCT_ID_KVM << 24) | (IMPLEMENTER_ARM << 0);
+		vgic_reg_access(mmio, &reg, word_offset,
+				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
+		break;
+	}
+
+	return false;
+}
+
+static bool handle_mmio_set_enable_reg(struct kvm_vcpu *vcpu,
+				       struct kvm_exit_mmio *mmio,
+				       phys_addr_t offset)
+{
+	return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
+				      vcpu->vcpu_id, ACCESS_WRITE_SETBIT);
+}
+
+static bool handle_mmio_clear_enable_reg(struct kvm_vcpu *vcpu,
+					 struct kvm_exit_mmio *mmio,
+					 phys_addr_t offset)
+{
+	return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
+				      vcpu->vcpu_id, ACCESS_WRITE_CLEARBIT);
+}
+
+static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
+					struct kvm_exit_mmio *mmio,
+					phys_addr_t offset)
+{
+	return vgic_handle_pending_reg(vcpu->kvm, mmio, offset,
+				       vcpu->vcpu_id, ACCESS_WRITE_SETBIT);
+}
+
+static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
+					  struct kvm_exit_mmio *mmio,
+					  phys_addr_t offset)
+{
+	return vgic_handle_pending_reg(vcpu->kvm, mmio, offset,
+				       vcpu->vcpu_id, ACCESS_WRITE_CLEARBIT);
+}
+
+static bool handle_mmio_priority_reg(struct kvm_vcpu *vcpu,
+				     struct kvm_exit_mmio *mmio,
+				     phys_addr_t offset)
+{
+	u32 *reg;
+
+	reg = vgic_bytemap_get_reg(&vcpu->kvm->arch.vgic.irq_priority,
+				   vcpu->vcpu_id, offset);
+	vgic_reg_access(mmio, reg, offset,
+			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
+	return false;
+}
+
+#define GICD_ITARGETSR_SIZE	32
+#define GICD_CPUTARGETS_BITS	8
+#define GICD_IRQS_PER_ITARGETSR	(GICD_ITARGETSR_SIZE / GICD_CPUTARGETS_BITS)
+static u32 vgic_get_target_reg(struct kvm *kvm, int irq)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	int i;
+	u32 val = 0;
+
+	irq -= VGIC_NR_PRIVATE_IRQS;
+
+	for (i = 0; i < GICD_IRQS_PER_ITARGETSR; i++)
+		val |= 1 << (dist->irq_spi_cpu[irq + i] + i * 8);
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
+	irq -= VGIC_NR_PRIVATE_IRQS;
+
+	/*
+	 * Pick the LSB in each byte. This ensures we target exactly
+	 * one vcpu per IRQ. If the byte is null, assume we target
+	 * CPU0.
+	 */
+	for (i = 0; i < GICD_IRQS_PER_ITARGETSR; i++) {
+		int shift = i * GICD_CPUTARGETS_BITS;
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
+				   struct kvm_exit_mmio *mmio,
+				   phys_addr_t offset)
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
+static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
+				struct kvm_exit_mmio *mmio, phys_addr_t offset)
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
+/* Handle reads of GICD_CPENDSGIRn and GICD_SPENDSGIRn */
+static bool read_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
+					struct kvm_exit_mmio *mmio,
+					phys_addr_t offset)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	int sgi;
+	int min_sgi = (offset & ~0x3) * 4;
+	int max_sgi = min_sgi + 3;
+	int vcpu_id = vcpu->vcpu_id;
+	u32 reg = 0;
+
+	/* Copy source SGIs from distributor side */
+	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
+		u8 sources = *vgic_get_sgi_sources(dist, vcpu_id, sgi);
+		reg |= ((u32)sources) << (8 * (sgi - min_sgi));
+	}
+
+	mmio_data_write(mmio, ~0, reg);
+	return false;
+}
+
+static bool write_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
+					 struct kvm_exit_mmio *mmio,
+					 phys_addr_t offset, bool set)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	int sgi;
+	int min_sgi = (offset & ~0x3) * 4;
+	int max_sgi = min_sgi + 3;
+	int vcpu_id = vcpu->vcpu_id;
+	u32 reg;
+	bool updated = false;
+
+	reg = mmio_data_read(mmio, ~0);
+
+	/* Clear pending SGIs on the distributor */
+	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
+		u8 mask = reg >> (8 * (sgi - min_sgi));
+		u8 *src = vgic_get_sgi_sources(dist, vcpu_id, sgi);
+		if (set) {
+			if ((*src & mask) != mask)
+				updated = true;
+			*src |= mask;
+		} else {
+			if (*src & mask)
+				updated = true;
+			*src &= ~mask;
+		}
+	}
+
+	if (updated)
+		vgic_update_state(vcpu->kvm);
+
+	return updated;
+}
+
+static bool handle_mmio_sgi_set(struct kvm_vcpu *vcpu,
+				struct kvm_exit_mmio *mmio,
+				phys_addr_t offset)
+{
+	if (!mmio->is_write)
+		return read_set_clear_sgi_pend_reg(vcpu, mmio, offset);
+	else
+		return write_set_clear_sgi_pend_reg(vcpu, mmio, offset, true);
+}
+
+static bool handle_mmio_sgi_clear(struct kvm_vcpu *vcpu,
+				  struct kvm_exit_mmio *mmio,
+				  phys_addr_t offset)
+{
+	if (!mmio->is_write)
+		return read_set_clear_sgi_pend_reg(vcpu, mmio, offset);
+	else
+		return write_set_clear_sgi_pend_reg(vcpu, mmio, offset, false);
+}
+
+/*
+ * I would have liked to use the kvm_bus_io_*() API instead, but it
+ * cannot cope with banked registers (only the VM pointer is passed
+ * around, and we need the vcpu). One of these days, someone please
+ * fix it!
+ */
+static const struct mmio_range vgic_dist_ranges[] = {
+	{
+		.base		= GIC_DIST_CTRL,
+		.len		= 12,
+		.bits_per_irq	= 0,
+		.handle_mmio	= handle_mmio_misc,
+	},
+	{
+		.base		= GIC_DIST_IGROUP,
+		.len		= VGIC_MAX_IRQS / 8,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GIC_DIST_ENABLE_SET,
+		.len		= VGIC_MAX_IRQS / 8,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_set_enable_reg,
+	},
+	{
+		.base		= GIC_DIST_ENABLE_CLEAR,
+		.len		= VGIC_MAX_IRQS / 8,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_clear_enable_reg,
+	},
+	{
+		.base		= GIC_DIST_PENDING_SET,
+		.len		= VGIC_MAX_IRQS / 8,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_set_pending_reg,
+	},
+	{
+		.base		= GIC_DIST_PENDING_CLEAR,
+		.len		= VGIC_MAX_IRQS / 8,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_clear_pending_reg,
+	},
+	{
+		.base		= GIC_DIST_ACTIVE_SET,
+		.len		= VGIC_MAX_IRQS / 8,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GIC_DIST_ACTIVE_CLEAR,
+		.len		= VGIC_MAX_IRQS / 8,
+		.bits_per_irq	= 1,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GIC_DIST_PRI,
+		.len		= VGIC_MAX_IRQS,
+		.bits_per_irq	= 8,
+		.handle_mmio	= handle_mmio_priority_reg,
+	},
+	{
+		.base		= GIC_DIST_TARGET,
+		.len		= VGIC_MAX_IRQS,
+		.bits_per_irq	= 8,
+		.handle_mmio	= handle_mmio_target_reg,
+	},
+	{
+		.base		= GIC_DIST_CONFIG,
+		.len		= VGIC_MAX_IRQS / 4,
+		.bits_per_irq	= 2,
+		.handle_mmio	= handle_mmio_cfg_reg,
+	},
+	{
+		.base		= GIC_DIST_SOFTINT,
+		.len		= 4,
+		.handle_mmio	= handle_mmio_sgi_reg,
+	},
+	{
+		.base		= GIC_DIST_SGI_PENDING_CLEAR,
+		.len		= VGIC_NR_SGIS,
+		.handle_mmio	= handle_mmio_sgi_clear,
+	},
+	{
+		.base		= GIC_DIST_SGI_PENDING_SET,
+		.len		= VGIC_NR_SGIS,
+		.handle_mmio	= handle_mmio_sgi_set,
+	},
+	{}
+};
+
+static bool vgic_v2_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
+				struct kvm_exit_mmio *mmio)
+{
+	unsigned long base = vcpu->kvm->arch.vgic.vgic_dist_base;
+
+	if (!IS_IN_RANGE(mmio->phys_addr, mmio->len, base,
+			 KVM_VGIC_V2_DIST_SIZE))
+		return false;
+
+	/* GICv2 does not support accesses wider than 32 bits */
+	if (mmio->len > 4) {
+		kvm_inject_dabt(vcpu, mmio->phys_addr);
+		return true;
+	}
+
+	return vgic_handle_mmio_range(vcpu, run, mmio, vgic_dist_ranges, base);
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
+		break;
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
+			vgic_dist_irq_set(vcpu, sgi);
+			*vgic_get_sgi_sources(dist, c, sgi) |= 1 << vcpu_id;
+			kvm_debug("SGI%d from CPU%d to CPU%d\n",
+				  sgi, vcpu_id, c);
+		}
+
+		target_cpus >>= 1;
+	}
+}
+
+static bool vgic_v2_queue_sgi(struct kvm_vcpu *vcpu, int irq)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	unsigned long sources;
+	int vcpu_id = vcpu->vcpu_id;
+	int c;
+
+	sources = *vgic_get_sgi_sources(dist, vcpu_id, irq);
+
+	for_each_set_bit(c, &sources, dist->nr_cpus) {
+		if (vgic_queue_irq(vcpu, c, irq))
+			clear_bit(c, &sources);
+	}
+
+	*vgic_get_sgi_sources(dist, vcpu_id, irq) = sources;
+
+	/*
+	 * If the sources bitmap has been cleared it means that we
+	 * could queue all the SGIs onto link registers (see the
+	 * clear_bit above), and therefore we are done with them in
+	 * our emulated gic and can get rid of them.
+	 */
+	if (!sources) {
+		vgic_dist_irq_clear(vcpu, irq);
+		vgic_cpu_irq_clear(vcpu, irq);
+		return true;
+	}
+
+	return false;
+}
+
+static int vgic_v2_init(struct kvm *kvm, const struct vgic_params *params)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	int ret, i;
+
+	dist->nr_cpus = atomic_read(&kvm->online_vcpus);
+
+	if (IS_VGIC_ADDR_UNDEF(dist->vgic_dist_base) ||
+	    IS_VGIC_ADDR_UNDEF(dist->vgic_cpu_base)) {
+		kvm_err("Need to set vgic distributor addresses first\n");
+		return -ENXIO;
+	}
+
+	ret = vgic_init_maps(dist, dist->nr_cpus, dist->nr_irqs);
+	if (ret) {
+		kvm_err("Unable to allocate maps\n");
+		return ret;
+	}
+
+	ret = kvm_phys_addr_ioremap(kvm, dist->vgic_cpu_base,
+				    params->vcpu_base,
+				    KVM_VGIC_V2_CPU_SIZE);
+	if (ret) {
+		kvm_err("Unable to remap VGIC CPU to VCPU\n");
+		return ret;
+	}
+
+	for (i = VGIC_NR_PRIVATE_IRQS; i < dist->nr_irqs; i += 4)
+		vgic_set_target_reg(kvm, 0, i);
+
+	return 0;
+}
+
+static void vgic_v2_unqueue_sgi(struct kvm_vcpu *vcpu, int irq, int source)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
+	*vgic_get_sgi_sources(dist, vcpu->vcpu_id, irq) |= 1 << source;
+}
+
+bool vgic_v2_init_emulation_ops(struct kvm *kvm, int type)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+
+	switch (type) {
+	case KVM_DEV_TYPE_ARM_VGIC_V2:
+		dist->vm_ops.handle_mmio = vgic_v2_handle_mmio;
+		dist->vm_ops.queue_sgi = vgic_v2_queue_sgi;
+		dist->vm_ops.unqueue_sgi = vgic_v2_unqueue_sgi;
+		dist->vm_ops.vgic_init = vgic_v2_init;
+		return true;
+	}
+	return false;
+}
+
+static bool handle_cpu_mmio_misc(struct kvm_vcpu *vcpu,
+				 struct kvm_exit_mmio *mmio, phys_addr_t offset)
+{
+	bool updated = false;
+	struct vgic_vmcr vmcr;
+	u32 *vmcr_field;
+	u32 reg;
+
+	vgic_get_vmcr(vcpu, &vmcr);
+
+	switch (offset & ~0x3) {
+	case GIC_CPU_CTRL:
+		vmcr_field = &vmcr.ctlr;
+		break;
+	case GIC_CPU_PRIMASK:
+		vmcr_field = &vmcr.pmr;
+		break;
+	case GIC_CPU_BINPOINT:
+		vmcr_field = &vmcr.bpr;
+		break;
+	case GIC_CPU_ALIAS_BINPOINT:
+		vmcr_field = &vmcr.abpr;
+		break;
+	default:
+		BUG();
+	}
+
+	if (!mmio->is_write) {
+		reg = *vmcr_field;
+		mmio_data_write(mmio, ~0, reg);
+	} else {
+		reg = mmio_data_read(mmio, ~0);
+		if (reg != *vmcr_field) {
+			*vmcr_field = reg;
+			vgic_set_vmcr(vcpu, &vmcr);
+			updated = true;
+		}
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
+static const struct mmio_range vgic_cpu_ranges[] = {
+	{
+		.base		= GIC_CPU_CTRL,
+		.len		= 12,
+		.handle_mmio	= handle_cpu_mmio_misc,
+	},
+	{
+		.base		= GIC_CPU_ALIAS_BINPOINT,
+		.len		= 4,
+		.handle_mmio	= handle_mmio_abpr,
+	},
+	{
+		.base		= GIC_CPU_ACTIVEPRIO,
+		.len		= 16,
+		.handle_mmio	= handle_mmio_raz_wi,
+	},
+	{
+		.base		= GIC_CPU_IDENT,
+		.len		= 4,
+		.handle_mmio	= handle_cpu_mmio_ident,
+	},
+};
+
+static int vgic_attr_regs_access(struct kvm_device *dev,
+				 struct kvm_device_attr *attr,
+				 u32 *reg, bool is_write)
+{
+	const struct mmio_range *r = NULL, *ranges;
+	phys_addr_t offset;
+	int ret, cpuid, c;
+	struct kvm_vcpu *vcpu, *tmp_vcpu;
+	struct vgic_dist *vgic;
+	struct kvm_exit_mmio mmio;
+
+	offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
+	cpuid = (attr->attr & KVM_DEV_ARM_VGIC_CPUID_MASK) >>
+		KVM_DEV_ARM_VGIC_CPUID_SHIFT;
+
+	mutex_lock(&dev->kvm->lock);
+
+	if (cpuid >= atomic_read(&dev->kvm->online_vcpus)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	vcpu = kvm_get_vcpu(dev->kvm, cpuid);
+	vgic = &dev->kvm->arch.vgic;
+
+	mmio.len = 4;
+	mmio.is_write = is_write;
+	if (is_write)
+		mmio_data_write(&mmio, ~0, *reg);
+	switch (attr->group) {
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+		mmio.phys_addr = vgic->vgic_dist_base + offset;
+		ranges = vgic_dist_ranges;
+		break;
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
+		mmio.phys_addr = vgic->vgic_cpu_base + offset;
+		ranges = vgic_cpu_ranges;
+		break;
+	default:
+		BUG();
+	}
+	r = vgic_find_matching_range(ranges, &mmio, offset);
+
+	if (unlikely(!r || !r->handle_mmio)) {
+		ret = -ENXIO;
+		goto out;
+	}
+
+
+	spin_lock(&vgic->lock);
+
+	/*
+	 * Ensure that no other VCPU is running by checking the vcpu->cpu
+	 * field.  If no other VPCUs are running we can safely access the VGIC
+	 * state, because even if another VPU is run after this point, that
+	 * VCPU will not touch the vgic state, because it will block on
+	 * getting the vgic->lock in kvm_vgic_sync_hwstate().
+	 */
+	kvm_for_each_vcpu(c, tmp_vcpu, dev->kvm) {
+		if (unlikely(tmp_vcpu->cpu != -1)) {
+			ret = -EBUSY;
+			goto out_vgic_unlock;
+		}
+	}
+
+	/*
+	 * Move all pending IRQs from the LRs on all VCPUs so the pending
+	 * state can be properly represented in the register state accessible
+	 * through this API.
+	 */
+	kvm_for_each_vcpu(c, tmp_vcpu, dev->kvm)
+		vgic_unqueue_irqs(tmp_vcpu);
+
+	offset -= r->base;
+	r->handle_mmio(vcpu, &mmio, offset);
+
+	if (!is_write)
+		*reg = mmio_data_read(&mmio, ~0);
+
+	ret = 0;
+out_vgic_unlock:
+	spin_unlock(&vgic->lock);
+out:
+	mutex_unlock(&dev->kvm->lock);
+	return ret;
+}
+
+static int vgic_v2_has_attr(struct kvm_device *dev,
+			    struct kvm_device_attr *attr)
+{
+	phys_addr_t offset;
+
+	switch (attr->group) {
+	case KVM_DEV_ARM_VGIC_GRP_ADDR:
+		switch (attr->attr) {
+		case KVM_VGIC_V2_ADDR_TYPE_DIST:
+		case KVM_VGIC_V2_ADDR_TYPE_CPU:
+			return 0;
+		}
+		break;
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+		offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
+		return vgic_has_attr_regs(vgic_dist_ranges, offset);
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
+		offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
+		return vgic_has_attr_regs(vgic_cpu_ranges, offset);
+	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS:
+	case KVM_DEV_ARM_VGIC_GRP_ADDR_OFFSET:
+		return 0;
+	}
+	return -ENXIO;
+}
+
+static int vgic_v2_set_attr(struct kvm_device *dev,
+			    struct kvm_device_attr *attr)
+{
+	int ret;
+	u32 __user *uaddr = (u32 __user *)(long)attr->addr;
+	u32 reg;
+
+	ret = vgic_set_common_attr(dev, attr);
+	if (!ret)
+		return ret;
+
+	switch (attr->group) {
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
+		if (get_user(reg, uaddr))
+			return -EFAULT;
+		return vgic_attr_regs_access(dev, attr, &reg, true);
+	}
+	return -ENXIO;
+}
+
+static int vgic_v2_get_attr(struct kvm_device *dev,
+			    struct kvm_device_attr *attr)
+{
+	u32 __user *uaddr = (u32 __user *)(long)attr->addr;
+	u32 reg = 0;
+	int r;
+
+	r = vgic_get_common_attr(dev, attr);
+	if (!r)
+		return r;
+
+	switch (attr->group) {
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
+		r = vgic_attr_regs_access(dev, attr, &reg, false);
+		if (r)
+			return r;
+		r = put_user(reg, uaddr);
+		break;
+	}
+
+	return r;
+}
+
+struct kvm_device_ops kvm_arm_vgic_v2_ops = {
+	.name = "kvm-arm-vgic-v2",
+	.create = vgic_create,
+	.destroy = vgic_destroy,
+	.set_attr = vgic_v2_set_attr,
+	.get_attr = vgic_v2_get_attr,
+	.has_attr = vgic_v2_has_attr,
+};
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 2a59dff..0140505 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -69,32 +69,14 @@
  *   interrupt line to be sampled again.
  */
 
-#define VGIC_ADDR_UNDEF		(-1)
-#define IS_VGIC_ADDR_UNDEF(_x)  ((_x) == VGIC_ADDR_UNDEF)
+#include "vgic.h"
 
-#define PRODUCT_ID_KVM		0x4b	/* ASCII code K */
-#define IMPLEMENTER_ARM		0x43b
 #define GICC_ARCH_VERSION_V2	0x2
 
-#define ACCESS_READ_VALUE	(1 << 0)
-#define ACCESS_READ_RAZ		(0 << 0)
-#define ACCESS_READ_MASK(x)	((x) & (1 << 0))
-#define ACCESS_WRITE_IGNORED	(0 << 1)
-#define ACCESS_WRITE_SETBIT	(1 << 1)
-#define ACCESS_WRITE_CLEARBIT	(2 << 1)
-#define ACCESS_WRITE_VALUE	(3 << 1)
-#define ACCESS_WRITE_MASK(x)	((x) & (3 << 1))
-
 static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu);
 static void vgic_retire_lr(int lr_nr, int irq, struct kvm_vcpu *vcpu);
-static void vgic_update_state(struct kvm *kvm);
-static void vgic_kick_vcpus(struct kvm *kvm);
-static u8 *vgic_get_sgi_sources(struct vgic_dist *dist, int vcpu_id, int sgi);
-static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
 static struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr);
 static void vgic_set_lr(struct kvm_vcpu *vcpu, int lr, struct vgic_lr lr_desc);
-static void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
-static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
 
 static const struct vgic_ops *vgic_ops;
 static const struct vgic_params *vgic;
@@ -122,8 +104,7 @@ static void vgic_free_bitmap(struct vgic_bitmap *b)
 	kfree(b->private);
 }
 
-static u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
-				int cpuid, u32 offset)
+u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x, int cpuid, u32 offset)
 {
 	offset >>= 2;
 	if (!offset)
@@ -141,8 +122,8 @@ static int vgic_bitmap_get_irq_val(struct vgic_bitmap *x,
 	return test_bit(irq - VGIC_NR_PRIVATE_IRQS, x->shared);
 }
 
-static void vgic_bitmap_set_irq_val(struct vgic_bitmap *x, int cpuid,
-				    int irq, int val)
+void vgic_bitmap_set_irq_val(struct vgic_bitmap *x, int cpuid,
+			     int irq, int val)
 {
 	unsigned long *reg;
 
@@ -164,7 +145,7 @@ static unsigned long *vgic_bitmap_get_cpu_map(struct vgic_bitmap *x, int cpuid)
 	return x->private + cpuid;
 }
 
-static unsigned long *vgic_bitmap_get_shared_map(struct vgic_bitmap *x)
+unsigned long *vgic_bitmap_get_shared_map(struct vgic_bitmap *x)
 {
 	return x->shared;
 }
@@ -190,7 +171,7 @@ static void vgic_free_bytemap(struct vgic_bytemap *b)
 	kfree(b->private);
 }
 
-static u32 *vgic_bytemap_get_reg(struct vgic_bytemap *x, int cpuid, u32 offset)
+u32 *vgic_bytemap_get_reg(struct vgic_bytemap *x, int cpuid, u32 offset)
 {
 	u32 *reg;
 
@@ -252,14 +233,14 @@ static int vgic_dist_irq_is_pending(struct kvm_vcpu *vcpu, int irq)
 	return vgic_bitmap_get_irq_val(&dist->irq_state, vcpu->vcpu_id, irq);
 }
 
-static void vgic_dist_irq_set(struct kvm_vcpu *vcpu, int irq)
+void vgic_dist_irq_set(struct kvm_vcpu *vcpu, int irq)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 
 	vgic_bitmap_set_irq_val(&dist->irq_state, vcpu->vcpu_id, irq, 1);
 }
 
-static void vgic_dist_irq_clear(struct kvm_vcpu *vcpu, int irq)
+void vgic_dist_irq_clear(struct kvm_vcpu *vcpu, int irq)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 
@@ -275,7 +256,7 @@ static void vgic_cpu_irq_set(struct kvm_vcpu *vcpu, int irq)
 			vcpu->arch.vgic_cpu.pending_shared);
 }
 
-static void vgic_cpu_irq_clear(struct kvm_vcpu *vcpu, int irq)
+void vgic_cpu_irq_clear(struct kvm_vcpu *vcpu, int irq)
 {
 	if (irq < VGIC_NR_PRIVATE_IRQS)
 		clear_bit(irq, vcpu->arch.vgic_cpu.pending_percpu);
@@ -284,16 +265,6 @@ static void vgic_cpu_irq_clear(struct kvm_vcpu *vcpu, int irq)
 			  vcpu->arch.vgic_cpu.pending_shared);
 }
 
-static u32 mmio_data_read(struct kvm_exit_mmio *mmio, u32 mask)
-{
-	return *((u32 *)mmio->data) & mask;
-}
-
-static void mmio_data_write(struct kvm_exit_mmio *mmio, u32 mask, u32 value)
-{
-	*((u32 *)mmio->data) = value & mask;
-}
-
 /**
  * vgic_reg_access - access vgic register
  * @mmio:   pointer to the data describing the mmio access
@@ -305,7 +276,7 @@ static void mmio_data_write(struct kvm_exit_mmio *mmio, u32 mask, u32 value)
  * modes defined for vgic register access
  * (read,raz,write-ignored,setbit,clearbit,write)
  */
-static void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
+void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
 			    phys_addr_t offset, int mode)
 {
 	int word_offset = (offset & 3) * 8;
@@ -355,42 +326,7 @@ static void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
 	}
 }
 
-static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
-			     struct kvm_exit_mmio *mmio, phys_addr_t offset)
-{
-	u32 reg;
-	u32 word_offset = offset & 3;
-
-	switch (offset & ~3) {
-	case 0:			/* GICD_CTLR */
-		reg = vcpu->kvm->arch.vgic.enabled;
-		vgic_reg_access(mmio, &reg, word_offset,
-				ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
-		if (mmio->is_write) {
-			vcpu->kvm->arch.vgic.enabled = reg & 1;
-			vgic_update_state(vcpu->kvm);
-			return true;
-		}
-		break;
-
-	case 4:			/* GICD_TYPER */
-		reg  = (atomic_read(&vcpu->kvm->online_vcpus) - 1) << 5;
-		reg |= (vcpu->kvm->arch.vgic.nr_irqs >> 5) - 1;
-		vgic_reg_access(mmio, &reg, word_offset,
-				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
-		break;
-
-	case 8:			/* GICD_IIDR */
-		reg = (PRODUCT_ID_KVM << 24) | (IMPLEMENTER_ARM << 0);
-		vgic_reg_access(mmio, &reg, word_offset,
-				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
-		break;
-	}
-
-	return false;
-}
-
-static bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu,
+bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu,
 			       struct kvm_exit_mmio *mmio, phys_addr_t offset)
 {
 	vgic_reg_access(mmio, NULL, offset,
@@ -398,8 +334,8 @@ static bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu,
 	return false;
 }
 
-static bool vgic_handle_enable_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
-				   phys_addr_t offset, int vcpu_id, int access)
+bool vgic_handle_enable_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
+			    phys_addr_t offset, int vcpu_id, int access)
 {
 	u32 *reg;
 	int mode = ACCESS_READ_VALUE | access;
@@ -420,24 +356,8 @@ static bool vgic_handle_enable_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
 	return false;
 }
 
-static bool handle_mmio_set_enable_reg(struct kvm_vcpu *vcpu,
-				       struct kvm_exit_mmio *mmio,
-				       phys_addr_t offset)
-{
-	return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
-				      vcpu->vcpu_id, ACCESS_WRITE_SETBIT);
-}
-
-static bool handle_mmio_clear_enable_reg(struct kvm_vcpu *vcpu,
-					 struct kvm_exit_mmio *mmio,
-					 phys_addr_t offset)
-{
-	return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
-				      vcpu->vcpu_id, ACCESS_WRITE_CLEARBIT);
-}
-
-static bool vgic_handle_pending_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
-				    phys_addr_t offset, int vcpu_id, int access)
+bool vgic_handle_pending_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
+			     phys_addr_t offset, int vcpu_id, int access)
 {
 	u32 *reg;
 	int mode = ACCESS_READ_VALUE | access;
@@ -452,110 +372,6 @@ static bool vgic_handle_pending_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
 	return false;
 }
 
-static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
-					struct kvm_exit_mmio *mmio,
-					phys_addr_t offset)
-{
-	return vgic_handle_pending_reg(vcpu->kvm, mmio, offset,
-				       vcpu->vcpu_id, ACCESS_WRITE_SETBIT);
-}
-
-static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
-					  struct kvm_exit_mmio *mmio,
-					  phys_addr_t offset)
-{
-	return vgic_handle_pending_reg(vcpu->kvm, mmio, offset,
-				       vcpu->vcpu_id, ACCESS_WRITE_CLEARBIT);
-	return false;
-}
-
-static bool handle_mmio_priority_reg(struct kvm_vcpu *vcpu,
-				     struct kvm_exit_mmio *mmio,
-				     phys_addr_t offset)
-{
-	u32 *reg = vgic_bytemap_get_reg(&vcpu->kvm->arch.vgic.irq_priority,
-					vcpu->vcpu_id, offset);
-	vgic_reg_access(mmio, reg, offset,
-			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
-	return false;
-}
-
-#define GICD_ITARGETSR_SIZE	32
-#define GICD_CPUTARGETS_BITS	8
-#define GICD_IRQS_PER_ITARGETSR	(GICD_ITARGETSR_SIZE / GICD_CPUTARGETS_BITS)
-static u32 vgic_get_target_reg(struct kvm *kvm, int irq)
-{
-	struct vgic_dist *dist = &kvm->arch.vgic;
-	int i;
-	u32 val = 0;
-
-	irq -= VGIC_NR_PRIVATE_IRQS;
-
-	for (i = 0; i < GICD_IRQS_PER_ITARGETSR; i++)
-		val |= 1 << (dist->irq_spi_cpu[irq + i] + i * 8);
-
-	return val;
-}
-
-static void vgic_set_target_reg(struct kvm *kvm, u32 val, int irq)
-{
-	struct vgic_dist *dist = &kvm->arch.vgic;
-	struct kvm_vcpu *vcpu;
-	int i, c;
-	unsigned long *bmap;
-	u32 target;
-
-	irq -= VGIC_NR_PRIVATE_IRQS;
-
-	/*
-	 * Pick the LSB in each byte. This ensures we target exactly
-	 * one vcpu per IRQ. If the byte is null, assume we target
-	 * CPU0.
-	 */
-	for (i = 0; i < GICD_IRQS_PER_ITARGETSR; i++) {
-		int shift = i * GICD_CPUTARGETS_BITS;
-		target = ffs((val >> shift) & 0xffU);
-		target = target ? (target - 1) : 0;
-		dist->irq_spi_cpu[irq + i] = target;
-		kvm_for_each_vcpu(c, vcpu, kvm) {
-			bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[c]);
-			if (c == target)
-				set_bit(irq + i, bmap);
-			else
-				clear_bit(irq + i, bmap);
-		}
-	}
-}
-
-static bool handle_mmio_target_reg(struct kvm_vcpu *vcpu,
-				   struct kvm_exit_mmio *mmio,
-				   phys_addr_t offset)
-{
-	u32 reg;
-
-	/* We treat the banked interrupts targets as read-only */
-	if (offset < 32) {
-		u32 roreg = 1 << vcpu->vcpu_id;
-		roreg |= roreg << 8;
-		roreg |= roreg << 16;
-
-		vgic_reg_access(mmio, &roreg, offset,
-				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
-		return false;
-	}
-
-	reg = vgic_get_target_reg(vcpu->kvm, offset & ~3U);
-	vgic_reg_access(mmio, &reg, offset,
-			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
-	if (mmio->is_write) {
-		vgic_set_target_reg(vcpu->kvm, reg, offset & ~3U);
-		vgic_update_state(vcpu->kvm);
-		return true;
-	}
-
-	return false;
-}
-
 static u32 vgic_cfg_expand(u16 val)
 {
 	u32 res = 0;
@@ -591,8 +407,8 @@ static u16 vgic_cfg_compress(u32 val)
  * LSB is always 0. As such, we only keep the upper bit, and use the
  * two above functions to compress/expand the bits
  */
-static bool vgic_handle_cfg_reg(u32 *reg, struct kvm_exit_mmio *mmio,
-				phys_addr_t offset)
+bool vgic_handle_cfg_reg(u32 *reg, struct kvm_exit_mmio *mmio,
+			 phys_addr_t offset)
 {
 	u32 val;
 
@@ -623,32 +439,6 @@ static bool vgic_handle_cfg_reg(u32 *reg, struct kvm_exit_mmio *mmio,
 	return false;
 }
 
-static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
-				struct kvm_exit_mmio *mmio, phys_addr_t offset)
-{
-	u32 *reg;
-
-	reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
-				  vcpu->vcpu_id, offset >> 1);
-
-	return vgic_handle_cfg_reg(reg, mmio, offset);
-}
-
-static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
-				struct kvm_exit_mmio *mmio, phys_addr_t offset)
-{
-	u32 reg;
-	vgic_reg_access(mmio, &reg, offset,
-			ACCESS_READ_RAZ | ACCESS_WRITE_VALUE);
-	if (mmio->is_write) {
-		vgic_dispatch_sgi(vcpu, reg);
-		vgic_update_state(vcpu->kvm);
-		return true;
-	}
-
-	return false;
-}
-
 /**
  * vgic_unqueue_irqs - move pending IRQs from LRs to the distributor
  * @vgic_cpu: Pointer to the vgic_cpu struct holding the LRs
@@ -661,14 +451,7 @@ static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
  * to the distributor but the active state stays in the LRs, because we don't
  * track the active state on the distributor side.
  */
-
-static void vgic_v2_unqueue_sgi(struct kvm_vcpu *vcpu, int irq, int source)
-{
-	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
-
-	*vgic_get_sgi_sources(dist, vcpu->vcpu_id, irq) |= 1 << source;
-}
-static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
+void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	int i;
@@ -715,196 +498,18 @@ static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
 	}
 }
 
-/* Handle reads of GICD_CPENDSGIRn and GICD_SPENDSGIRn */
-static bool read_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
-					struct kvm_exit_mmio *mmio,
-					phys_addr_t offset)
-{
-	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
-	int sgi;
-	int min_sgi = (offset & ~0x3) * 4;
-	int max_sgi = min_sgi + 3;
-	int vcpu_id = vcpu->vcpu_id;
-	u32 reg = 0;
-
-	/* Copy source SGIs from distributor side */
-	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
-		int shift = 8 * (sgi - min_sgi);
-		reg |= ((u32)*vgic_get_sgi_sources(dist, vcpu_id, sgi)) << shift;
-	}
-
-	mmio_data_write(mmio, ~0, reg);
-	return false;
-}
-
-static bool write_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
-					 struct kvm_exit_mmio *mmio,
-					 phys_addr_t offset, bool set)
-{
-	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
-	int sgi;
-	int min_sgi = (offset & ~0x3) * 4;
-	int max_sgi = min_sgi + 3;
-	int vcpu_id = vcpu->vcpu_id;
-	u32 reg;
-	bool updated = false;
-
-	reg = mmio_data_read(mmio, ~0);
-
-	/* Clear pending SGIs on the distributor */
-	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
-		u8 mask = reg >> (8 * (sgi - min_sgi));
-		u8 *src = vgic_get_sgi_sources(dist, vcpu_id, sgi);
-		if (set) {
-			if ((*src & mask) != mask)
-				updated = true;
-			*src |= mask;
-		} else {
-			if (*src & mask)
-				updated = true;
-			*src &= ~mask;
-		}
-	}
-
-	if (updated)
-		vgic_update_state(vcpu->kvm);
-
-	return updated;
-}
-
-static bool handle_mmio_sgi_set(struct kvm_vcpu *vcpu,
-				struct kvm_exit_mmio *mmio,
-				phys_addr_t offset)
-{
-	if (!mmio->is_write)
-		return read_set_clear_sgi_pend_reg(vcpu, mmio, offset);
-	else
-		return write_set_clear_sgi_pend_reg(vcpu, mmio, offset, true);
-}
-
-static bool handle_mmio_sgi_clear(struct kvm_vcpu *vcpu,
-				  struct kvm_exit_mmio *mmio,
-				  phys_addr_t offset)
-{
-	if (!mmio->is_write)
-		return read_set_clear_sgi_pend_reg(vcpu, mmio, offset);
-	else
-		return write_set_clear_sgi_pend_reg(vcpu, mmio, offset, false);
-}
-
-/*
- * I would have liked to use the kvm_bus_io_*() API instead, but it
- * cannot cope with banked registers (only the VM pointer is passed
- * around, and we need the vcpu). One of these days, someone please
- * fix it!
- */
-struct mmio_range {
-	phys_addr_t base;
-	unsigned long len;
-	int bits_per_irq;
-	bool (*handle_mmio)(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
-			    phys_addr_t offset);
-};
-
-static const struct mmio_range vgic_dist_ranges[] = {
-	{
-		.base		= GIC_DIST_CTRL,
-		.len		= 12,
-		.bits_per_irq	= 0,
-		.handle_mmio	= handle_mmio_misc,
-	},
-	{
-		.base		= GIC_DIST_IGROUP,
-		.len		= VGIC_MAX_IRQS / 8,
-		.bits_per_irq	= 1,
-		.handle_mmio	= handle_mmio_raz_wi,
-	},
-	{
-		.base		= GIC_DIST_ENABLE_SET,
-		.len		= VGIC_MAX_IRQS / 8,
-		.bits_per_irq	= 1,
-		.handle_mmio	= handle_mmio_set_enable_reg,
-	},
-	{
-		.base		= GIC_DIST_ENABLE_CLEAR,
-		.len		= VGIC_MAX_IRQS / 8,
-		.bits_per_irq	= 1,
-		.handle_mmio	= handle_mmio_clear_enable_reg,
-	},
-	{
-		.base		= GIC_DIST_PENDING_SET,
-		.len		= VGIC_MAX_IRQS / 8,
-		.bits_per_irq	= 1,
-		.handle_mmio	= handle_mmio_set_pending_reg,
-	},
-	{
-		.base		= GIC_DIST_PENDING_CLEAR,
-		.len		= VGIC_MAX_IRQS / 8,
-		.bits_per_irq	= 1,
-		.handle_mmio	= handle_mmio_clear_pending_reg,
-	},
-	{
-		.base		= GIC_DIST_ACTIVE_SET,
-		.len		= VGIC_MAX_IRQS / 8,
-		.bits_per_irq	= 1,
-		.handle_mmio	= handle_mmio_raz_wi,
-	},
-	{
-		.base		= GIC_DIST_ACTIVE_CLEAR,
-		.len		= VGIC_MAX_IRQS / 8,
-		.bits_per_irq	= 1,
-		.handle_mmio	= handle_mmio_raz_wi,
-	},
-	{
-		.base		= GIC_DIST_PRI,
-		.len		= VGIC_MAX_IRQS,
-		.bits_per_irq	= 8,
-		.handle_mmio	= handle_mmio_priority_reg,
-	},
-	{
-		.base		= GIC_DIST_TARGET,
-		.len		= VGIC_MAX_IRQS,
-		.bits_per_irq	= 8,
-		.handle_mmio	= handle_mmio_target_reg,
-	},
-	{
-		.base		= GIC_DIST_CONFIG,
-		.len		= VGIC_MAX_IRQS / 4,
-		.bits_per_irq	= 2,
-		.handle_mmio	= handle_mmio_cfg_reg,
-	},
-	{
-		.base		= GIC_DIST_SOFTINT,
-		.len		= 4,
-		.handle_mmio	= handle_mmio_sgi_reg,
-	},
-	{
-		.base		= GIC_DIST_SGI_PENDING_CLEAR,
-		.len		= VGIC_NR_SGIS,
-		.handle_mmio	= handle_mmio_sgi_clear,
-	},
-	{
-		.base		= GIC_DIST_SGI_PENDING_SET,
-		.len		= VGIC_NR_SGIS,
-		.handle_mmio	= handle_mmio_sgi_set,
-	},
-	{}
-};
-
-static const
-struct mmio_range *find_matching_range(const struct mmio_range *ranges,
-				       struct kvm_exit_mmio *mmio,
-				       phys_addr_t offset)
+const
+struct mmio_range *vgic_find_matching_range(const struct mmio_range *ranges,
+					    struct kvm_exit_mmio *mmio,
+					    phys_addr_t offset)
 {
 	const struct mmio_range *r = ranges;
-
 	while (r->len) {
 		if (offset >= r->base &&
 		    (offset + mmio->len) <= (r->base + r->len))
 			return r;
 		r++;
 	}
-
 	return NULL;
 }
 
@@ -976,7 +581,7 @@ static bool call_range_handler(struct kvm_vcpu *vcpu,
  *
  * returns true if the MMIO access could be performed
  */
-static bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
+bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			    struct kvm_exit_mmio *mmio,
 			    const struct mmio_range *ranges,
 			    unsigned long mmio_base)
@@ -987,7 +592,7 @@ static bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	unsigned long offset;
 
 	offset = mmio->phys_addr - mmio_base;
-	range = find_matching_range(ranges, mmio, offset);
+	range = vgic_find_matching_range(ranges, mmio, offset);
 	if (unlikely(!range || !range->handle_mmio)) {
 		pr_warn("Unhandled access %d %08llx %d\n",
 			mmio->is_write, mmio->phys_addr, mmio->len);
@@ -1013,27 +618,6 @@ static bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	return true;
 }
 
-#define IS_IN_RANGE(addr, alen, base, len) \
-	(((addr) >= (base)) && (((addr) + (alen)) < ((base) + (len))))
-
-static bool vgic_v2_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
-				struct kvm_exit_mmio *mmio)
-{
-	unsigned long base = vcpu->kvm->arch.vgic.vgic_dist_base;
-
-	if (!IS_IN_RANGE(mmio->phys_addr, mmio->len, base,
-			 KVM_VGIC_V2_DIST_SIZE))
-		return false;
-
-	/* GICv2 does not support accesses wider than 32 bits */
-	if (mmio->len > 4) {
-		kvm_inject_dabt(vcpu, mmio->phys_addr);
-		return true;
-	}
-
-	return vgic_handle_mmio_range(vcpu, run, mmio, vgic_dist_ranges, base);
-}
-
 /**
  * vgic_handle_mmio - handle an in-kernel MMIO access for the GIC emulation
  * @vcpu:      pointer to the vcpu performing the access
@@ -1052,52 +636,6 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	return vgic_vm_op(vcpu->kvm, handle_mmio)(vcpu, run, mmio);
 }
 
-static u8 *vgic_get_sgi_sources(struct vgic_dist *dist, int vcpu_id, int sgi)
-{
-	return dist->irq_sgi_sources + vcpu_id * VGIC_NR_SGIS + sgi;
-}
-
-static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg)
-{
-	struct kvm *kvm = vcpu->kvm;
-	struct vgic_dist *dist = &kvm->arch.vgic;
-	int nrcpus = atomic_read(&kvm->online_vcpus);
-	u8 target_cpus;
-	int sgi, mode, c, vcpu_id;
-
-	vcpu_id = vcpu->vcpu_id;
-
-	sgi = reg & 0xf;
-	target_cpus = (reg >> 16) & 0xff;
-	mode = (reg >> 24) & 3;
-
-	switch (mode) {
-	case 0:
-		if (!target_cpus)
-			return;
-		break;
-
-	case 1:
-		target_cpus = ((1 << nrcpus) - 1) & ~(1 << vcpu_id) & 0xff;
-		break;
-
-	case 2:
-		target_cpus = 1 << vcpu_id;
-		break;
-	}
-
-	kvm_for_each_vcpu(c, vcpu, kvm) {
-		if (target_cpus & 1) {
-			/* Flag the SGI as pending */
-			vgic_dist_irq_set(vcpu, sgi);
-			*vgic_get_sgi_sources(dist, c, sgi) |= 1 << vcpu_id;
-			kvm_debug("SGI%d from CPU%d to CPU%d\n", sgi, vcpu_id, c);
-		}
-
-		target_cpus >>= 1;
-	}
-}
-
 static int vgic_nr_shared_irqs(struct vgic_dist *dist)
 {
 	return dist->nr_irqs - VGIC_NR_PRIVATE_IRQS;
@@ -1136,7 +674,7 @@ static int compute_pending_for_cpu(struct kvm_vcpu *vcpu)
  * Update the interrupt state and determine which CPUs have pending
  * interrupts. Must be called with distributor lock held.
  */
-static void vgic_update_state(struct kvm *kvm)
+void vgic_update_state(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
 	struct kvm_vcpu *vcpu;
@@ -1197,12 +735,12 @@ static inline void vgic_disable_underflow(struct kvm_vcpu *vcpu)
 	vgic_ops->disable_underflow(vcpu);
 }
 
-static inline void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
+void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
 {
 	vgic_ops->get_vmcr(vcpu, vmcr);
 }
 
-static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
+void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
 {
 	vgic_ops->set_vmcr(vcpu, vmcr);
 }
@@ -1251,8 +789,9 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
 /*
  * Queue an interrupt to a CPU virtual interface. Return true on success,
  * or false if it wasn't possible to queue it.
+ * sgi_source must be zero for any non-SGI interrupts.
  */
-static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
+bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
@@ -1301,37 +840,6 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 	return true;
 }
 
-static bool vgic_v2_queue_sgi(struct kvm_vcpu *vcpu, int irq)
-{
-	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
-	unsigned long sources;
-	int vcpu_id = vcpu->vcpu_id;
-	int c;
-
-	sources = *vgic_get_sgi_sources(dist, vcpu_id, irq);
-
-	for_each_set_bit(c, &sources, dist->nr_cpus) {
-		if (vgic_queue_irq(vcpu, c, irq))
-			clear_bit(c, &sources);
-	}
-
-	*vgic_get_sgi_sources(dist, vcpu_id, irq) = sources;
-
-	/*
-	 * If the sources bitmap has been cleared it means that we
-	 * could queue all the SGIs onto link registers (see the
-	 * clear_bit above), and therefore we are done with them in
-	 * our emulated gic and can get rid of them.
-	 */
-	if (!sources) {
-		vgic_dist_irq_clear(vcpu, irq);
-		vgic_cpu_irq_clear(vcpu, irq);
-		return true;
-	}
-
-	return false;
-}
-
 static bool vgic_queue_hwirq(struct kvm_vcpu *vcpu, int irq)
 {
 	if (vgic_irq_is_active(vcpu, irq))
@@ -1523,7 +1031,7 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
 	return test_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
 }
 
-static void vgic_kick_vcpus(struct kvm *kvm)
+void vgic_kick_vcpus(struct kvm *kvm)
 {
 	struct kvm_vcpu *vcpu;
 	int c;
@@ -1807,7 +1315,7 @@ static void vgic_free_maps(struct vgic_dist *dist)
 	kfree(dist->irq_spi_target);
 }
 
-static int vgic_init_maps(struct vgic_dist *dist, int nr_cpus, int nr_irqs)
+int vgic_init_maps(struct vgic_dist *dist, int nr_cpus, int nr_irqs)
 {
 	int ret, i;
 
@@ -1822,7 +1330,8 @@ static int vgic_init_maps(struct vgic_dist *dist, int nr_cpus, int nr_irqs)
 						GFP_KERNEL);
 		dist->irq_spi_cpu = kzalloc(nr_irqs - VGIC_NR_PRIVATE_IRQS,
 					    GFP_KERNEL);
-		dist->irq_spi_target = kzalloc(sizeof(*dist->irq_spi_target) * nr_cpus,
+		dist->irq_spi_target = kcalloc(nr_cpus,
+					       sizeof(*dist->irq_spi_target),
 					       GFP_KERNEL);
 		if (!dist->irq_sgi_sources ||
 		    !dist->irq_spi_cpu ||
@@ -1849,39 +1358,6 @@ void kvm_vgic_destroy(struct kvm *kvm)
 	vgic_free_maps(&kvm->arch.vgic);
 }
 
-static int vgic_v2_init(struct kvm *kvm, const struct vgic_params *params)
-{
-	struct vgic_dist *dist = &kvm->arch.vgic;
-	int ret, i;
-
-	dist->nr_cpus = atomic_read(&kvm->online_vcpus);
-
-	if (IS_VGIC_ADDR_UNDEF(dist->vgic_dist_base) ||
-	    IS_VGIC_ADDR_UNDEF(dist->vgic_cpu_base)) {
-		kvm_err("Need to set vgic distributor addresses first\n");
-		return -ENXIO;
-	}
-
-	ret = vgic_init_maps(dist, dist->nr_cpus, dist->nr_irqs);
-	if (ret) {
-		kvm_err("Unable to allocate maps\n");
-		return ret;
-	}
-
-	ret = kvm_phys_addr_ioremap(kvm, dist->vgic_cpu_base,
-				    params->vcpu_base,
-				    KVM_VGIC_V2_CPU_SIZE);
-	if (ret) {
-		kvm_err("Unable to remap VGIC CPU to VCPU\n");
-		return ret;
-	}
-
-	for (i = VGIC_NR_PRIVATE_IRQS; i < dist->nr_irqs; i += 4)
-		vgic_set_target_reg(kvm, 0, i);
-
-	return 0;
-}
-
 /**
  * kvm_vgic_init - Initialize global VGIC state before running any VCPUs
  * @kvm: pointer to the kvm struct
@@ -1937,15 +1413,9 @@ out:
 
 static bool init_emulation_ops(struct kvm *kvm, int type)
 {
-	struct vgic_dist *dist = &kvm->arch.vgic;
-
 	switch (type) {
 	case KVM_DEV_TYPE_ARM_VGIC_V2:
-		dist->vm_ops.handle_mmio = vgic_v2_handle_mmio;
-		dist->vm_ops.queue_sgi = vgic_v2_queue_sgi;
-		dist->vm_ops.unqueue_sgi = vgic_v2_unqueue_sgi;
-		dist->vm_ops.vgic_init = vgic_v2_init;
-		return true;
+		return vgic_v2_init_emulation_ops(kvm, type);
 	}
 	return false;
 }
@@ -2086,185 +1556,19 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
 	return r;
 }
 
-static bool handle_cpu_mmio_misc(struct kvm_vcpu *vcpu,
-				 struct kvm_exit_mmio *mmio, phys_addr_t offset)
+int vgic_has_attr_regs(const struct mmio_range *ranges,
+		       phys_addr_t offset)
 {
-	bool updated = false;
-	struct vgic_vmcr vmcr;
-	u32 *vmcr_field;
-	u32 reg;
-
-	vgic_get_vmcr(vcpu, &vmcr);
-
-	switch (offset & ~0x3) {
-	case GIC_CPU_CTRL:
-		vmcr_field = &vmcr.ctlr;
-		break;
-	case GIC_CPU_PRIMASK:
-		vmcr_field = &vmcr.pmr;
-		break;
-	case GIC_CPU_BINPOINT:
-		vmcr_field = &vmcr.bpr;
-		break;
-	case GIC_CPU_ALIAS_BINPOINT:
-		vmcr_field = &vmcr.abpr;
-		break;
-	default:
-		BUG();
-	}
-
-	if (!mmio->is_write) {
-		reg = *vmcr_field;
-		mmio_data_write(mmio, ~0, reg);
-	} else {
-		reg = mmio_data_read(mmio, ~0);
-		if (reg != *vmcr_field) {
-			*vmcr_field = reg;
-			vgic_set_vmcr(vcpu, &vmcr);
-			updated = true;
-		}
-	}
-	return updated;
-}
-
-static bool handle_mmio_abpr(struct kvm_vcpu *vcpu,
-			     struct kvm_exit_mmio *mmio, phys_addr_t offset)
-{
-	return handle_cpu_mmio_misc(vcpu, mmio, GIC_CPU_ALIAS_BINPOINT);
-}
-
-static bool handle_cpu_mmio_ident(struct kvm_vcpu *vcpu,
-				  struct kvm_exit_mmio *mmio,
-				  phys_addr_t offset)
-{
-	u32 reg;
-
-	if (mmio->is_write)
-		return false;
-
-	/* GICC_IIDR */
-	reg = (PRODUCT_ID_KVM << 20) |
-	      (GICC_ARCH_VERSION_V2 << 16) |
-	      (IMPLEMENTER_ARM << 0);
-	mmio_data_write(mmio, ~0, reg);
-	return false;
-}
-
-/*
- * CPU Interface Register accesses - these are not accessed by the VM, but by
- * user space for saving and restoring VGIC state.
- */
-static const struct mmio_range vgic_cpu_ranges[] = {
-	{
-		.base		= GIC_CPU_CTRL,
-		.len		= 12,
-		.handle_mmio	= handle_cpu_mmio_misc,
-	},
-	{
-		.base		= GIC_CPU_ALIAS_BINPOINT,
-		.len		= 4,
-		.handle_mmio	= handle_mmio_abpr,
-	},
-	{
-		.base		= GIC_CPU_ACTIVEPRIO,
-		.len		= 16,
-		.handle_mmio	= handle_mmio_raz_wi,
-	},
-	{
-		.base		= GIC_CPU_IDENT,
-		.len		= 4,
-		.handle_mmio	= handle_cpu_mmio_ident,
-	},
-};
-
-static int vgic_attr_regs_access(struct kvm_device *dev,
-				 struct kvm_device_attr *attr,
-				 u32 *reg, bool is_write)
-{
-	const struct mmio_range *r = NULL, *ranges;
-	phys_addr_t offset;
-	int ret, cpuid, c;
-	struct kvm_vcpu *vcpu, *tmp_vcpu;
-	struct vgic_dist *vgic;
-	struct kvm_exit_mmio mmio;
-
-	offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
-	cpuid = (attr->attr & KVM_DEV_ARM_VGIC_CPUID_MASK) >>
-		KVM_DEV_ARM_VGIC_CPUID_SHIFT;
-
-	mutex_lock(&dev->kvm->lock);
-
-	if (cpuid >= atomic_read(&dev->kvm->online_vcpus)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	vcpu = kvm_get_vcpu(dev->kvm, cpuid);
-	vgic = &dev->kvm->arch.vgic;
-
-	mmio.len = 4;
-	mmio.is_write = is_write;
-	if (is_write)
-		mmio_data_write(&mmio, ~0, *reg);
-	switch (attr->group) {
-	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
-		mmio.phys_addr = vgic->vgic_dist_base + offset;
-		ranges = vgic_dist_ranges;
-		break;
-	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
-		mmio.phys_addr = vgic->vgic_cpu_base + offset;
-		ranges = vgic_cpu_ranges;
-		break;
-	default:
-		BUG();
-	}
-	r = find_matching_range(ranges, &mmio, offset);
-
-	if (unlikely(!r || !r->handle_mmio)) {
-		ret = -ENXIO;
-		goto out;
-	}
-
-
-	spin_lock(&vgic->lock);
-
-	/*
-	 * Ensure that no other VCPU is running by checking the vcpu->cpu
-	 * field.  If no other VPCUs are running we can safely access the VGIC
-	 * state, because even if another VPU is run after this point, that
-	 * VCPU will not touch the vgic state, because it will block on
-	 * getting the vgic->lock in kvm_vgic_sync_hwstate().
-	 */
-	kvm_for_each_vcpu(c, tmp_vcpu, dev->kvm) {
-		if (unlikely(tmp_vcpu->cpu != -1)) {
-			ret = -EBUSY;
-			goto out_vgic_unlock;
-		}
-	}
-
-	/*
-	 * Move all pending IRQs from the LRs on all VCPUs so the pending
-	 * state can be properly represented in the register state accessible
-	 * through this API.
-	 */
-	kvm_for_each_vcpu(c, tmp_vcpu, dev->kvm)
-		vgic_unqueue_irqs(tmp_vcpu);
-
-	offset -= r->base;
-	r->handle_mmio(vcpu, &mmio, offset);
-
-	if (!is_write)
-		*reg = mmio_data_read(&mmio, ~0);
+	struct kvm_exit_mmio dev_attr_mmio;
 
-	ret = 0;
-out_vgic_unlock:
-	spin_unlock(&vgic->lock);
-out:
-	mutex_unlock(&dev->kvm->lock);
-	return ret;
+	dev_attr_mmio.len = 4;
+	if (vgic_find_matching_range(ranges, &dev_attr_mmio, offset))
+		return 0;
+	else
+		return -ENXIO;
 }
 
-static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+int vgic_set_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	int r;
 
@@ -2281,16 +1585,6 @@ static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		return (r == -ENODEV) ? -ENXIO : r;
 	}
 
-	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
-	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
-		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
-		u32 reg;
-
-		if (get_user(reg, uaddr))
-			return -EFAULT;
-
-		return vgic_attr_regs_access(dev, attr, &reg, true);
-	}
 	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS: {
 		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
 		u32 val;
@@ -2319,7 +1613,7 @@ static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 	return -ENXIO;
 }
 
-static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+int vgic_get_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	int r = -ENXIO;
 
@@ -2337,18 +1631,6 @@ static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 			return -EFAULT;
 		break;
 	}
-
-	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
-	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
-		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
-		u32 reg = 0;
-
-		r = vgic_attr_regs_access(dev, attr, &reg, false);
-		if (r)
-			return r;
-		r = put_user(reg, uaddr);
-		break;
-	}
 	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS: {
 		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
 		r = put_user(dev->kvm->arch.vgic.nr_irqs, uaddr);
@@ -2366,58 +1648,12 @@ static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 	return r;
 }
 
-static int vgic_has_attr_regs(const struct mmio_range *ranges,
-			      phys_addr_t offset)
-{
-	struct kvm_exit_mmio dev_attr_mmio;
-
-	dev_attr_mmio.len = 4;
-	if (find_matching_range(ranges, &dev_attr_mmio, offset))
-		return 0;
-	else
-		return -ENXIO;
-}
-
-static int vgic_has_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
-{
-	phys_addr_t offset;
-
-	switch (attr->group) {
-	case KVM_DEV_ARM_VGIC_GRP_ADDR:
-		switch (attr->attr) {
-		case KVM_VGIC_V2_ADDR_TYPE_DIST:
-		case KVM_VGIC_V2_ADDR_TYPE_CPU:
-			return 0;
-		}
-		break;
-	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
-		offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
-		return vgic_has_attr_regs(vgic_dist_ranges, offset);
-	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
-		offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
-		return vgic_has_attr_regs(vgic_cpu_ranges, offset);
-	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS:
-	case KVM_DEV_ARM_VGIC_GRP_ADDR_OFFSET:
-		return 0;
-	}
-	return -ENXIO;
-}
-
-static void vgic_destroy(struct kvm_device *dev)
+void vgic_destroy(struct kvm_device *dev)
 {
 	kfree(dev);
 }
 
-static int vgic_create(struct kvm_device *dev, u32 type)
+int vgic_create(struct kvm_device *dev, u32 type)
 {
 	return kvm_vgic_create(dev->kvm, type);
 }
-
-struct kvm_device_ops kvm_arm_vgic_v2_ops = {
-	.name = "kvm-arm-vgic",
-	.create = vgic_create,
-	.destroy = vgic_destroy,
-	.set_attr = vgic_set_attr,
-	.get_attr = vgic_get_attr,
-	.has_attr = vgic_has_attr,
-};
diff --git a/virt/kvm/arm/vgic.h b/virt/kvm/arm/vgic.h
new file mode 100644
index 0000000..e900aeb
--- /dev/null
+++ b/virt/kvm/arm/vgic.h
@@ -0,0 +1,113 @@
+/*
+ * Copyright (C) 2012-2014 ARM Ltd.
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * Derived from virt/kvm/arm/vgic.c
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
+#define VGIC_ADDR_UNDEF		(-1)
+#define IS_VGIC_ADDR_UNDEF(_x)  ((_x) == VGIC_ADDR_UNDEF)
+
+#define PRODUCT_ID_KVM      0x4b    /* ASCII code K */
+#define IMPLEMENTER_ARM     0x43b
+
+#define ACCESS_READ_VALUE	(1 << 0)
+#define ACCESS_READ_RAZ		(0 << 0)
+#define ACCESS_READ_MASK(x)	((x) & (1 << 0))
+#define ACCESS_WRITE_IGNORED	(0 << 1)
+#define ACCESS_WRITE_SETBIT	(1 << 1)
+#define ACCESS_WRITE_CLEARBIT	(2 << 1)
+#define ACCESS_WRITE_VALUE	(3 << 1)
+#define ACCESS_WRITE_MASK(x)	((x) & (3 << 1))
+
+#define VCPU_NOT_ALLOCATED ((u8)-1)
+
+unsigned long *vgic_bitmap_get_shared_map(struct vgic_bitmap *x);
+
+void vgic_update_state(struct kvm *kvm);
+int vgic_init_maps(struct vgic_dist *dist, int nr_cpus, int nr_irqs);
+
+u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x, int cpuid, u32 offset);
+u32 *vgic_bytemap_get_reg(struct vgic_bytemap *x, int cpuid, u32 offset);
+
+void vgic_dist_irq_set(struct kvm_vcpu *vcpu, int irq);
+void vgic_dist_irq_clear(struct kvm_vcpu *vcpu, int irq);
+void vgic_cpu_irq_clear(struct kvm_vcpu *vcpu, int irq);
+void vgic_bitmap_set_irq_val(struct vgic_bitmap *x, int cpuid,
+			     int irq, int val);
+
+void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
+void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
+
+bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq);
+void vgic_unqueue_irqs(struct kvm_vcpu *vcpu);
+
+void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
+		     phys_addr_t offset, int mode);
+bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
+			phys_addr_t offset);
+
+static inline
+u32 mmio_data_read(struct kvm_exit_mmio *mmio, u32 mask)
+{
+	return *((u32 *)mmio->data) & mask;
+}
+
+static inline
+void mmio_data_write(struct kvm_exit_mmio *mmio, u32 mask, u32 value)
+{
+	*((u32 *)mmio->data) = value & mask;
+}
+
+struct mmio_range {
+	phys_addr_t base;
+	unsigned long len;
+	int bits_per_irq;
+	bool (*handle_mmio)(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
+			    phys_addr_t offset);
+};
+
+#define IS_IN_RANGE(addr, alen, base, len) \
+	(((addr) >= (base)) && (((addr) + (alen)) < ((base) + (len))))
+
+const
+struct mmio_range *vgic_find_matching_range(const struct mmio_range *ranges,
+					    struct kvm_exit_mmio *mmio,
+					    phys_addr_t offset);
+
+bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
+			    struct kvm_exit_mmio *mmio,
+			    const struct mmio_range *ranges,
+			    unsigned long mmio_base);
+
+bool vgic_handle_enable_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
+			    phys_addr_t offset, int vcpu_id, int access);
+
+bool vgic_handle_pending_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
+			     phys_addr_t offset, int vcpu_id, int access);
+
+bool vgic_handle_cfg_reg(u32 *reg, struct kvm_exit_mmio *mmio,
+			 phys_addr_t offset);
+
+void vgic_kick_vcpus(struct kvm *kvm);
+
+int vgic_create(struct kvm_device *dev, u32 type);
+void vgic_destroy(struct kvm_device *dev);
+
+int vgic_has_attr_regs(const struct mmio_range *ranges, phys_addr_t offset);
+int vgic_set_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr);
+int vgic_get_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr);
+
+bool vgic_v2_init_emulation_ops(struct kvm *kvm, int type);
-- 
1.7.9.5
