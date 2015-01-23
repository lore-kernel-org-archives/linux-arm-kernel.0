From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:56 +0100
Subject: [GIT PULL 27/36] arm/arm64: KVM: split GICv2 specific emulation code
 from vgic.c
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-28-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

vgic.c is currently a mixture of generic vGIC emulation code and
functions specific to emulating a GICv2. To ease the addition of
GICv3, split off strictly v2 specific parts into a new file
vgic-v2-emul.c.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

-------
As the diff isn't always obvious here (and to aid eventual rebases),
here is a list of high-level changes done to the code:
* added new file to respective arm/arm64 Makefiles
* moved GICv2 specific functions to vgic-v2-emul.c:
  - handle_mmio_misc()
  - handle_mmio_set_enable_reg()
  - handle_mmio_clear_enable_reg()
  - handle_mmio_set_pending_reg()
  - handle_mmio_clear_pending_reg()
  - handle_mmio_priority_reg()
  - vgic_get_target_reg()
  - vgic_set_target_reg()
  - handle_mmio_target_reg()
  - handle_mmio_cfg_reg()
  - handle_mmio_sgi_reg()
  - vgic_v2_unqueue_sgi()
  - read_set_clear_sgi_pend_reg()
  - write_set_clear_sgi_pend_reg()
  - handle_mmio_sgi_set()
  - handle_mmio_sgi_clear()
  - vgic_v2_handle_mmio()
  - vgic_get_sgi_sources()
  - vgic_dispatch_sgi()
  - vgic_v2_queue_sgi()
  - vgic_v2_map_resources()
  - vgic_v2_init()
  - vgic_v2_add_sgi_source()
  - vgic_v2_init_model()
  - vgic_v2_init_emulation()
  - handle_cpu_mmio_misc()
  - handle_mmio_abpr()
  - handle_cpu_mmio_ident()
  - vgic_attr_regs_access()
  - vgic_create() (renamed to vgic_v2_create())
  - vgic_destroy() (renamed to vgic_v2_destroy())
  - vgic_has_attr() (renamed to vgic_v2_has_attr())
  - vgic_set_attr() (renamed to vgic_v2_set_attr())
  - vgic_get_attr() (renamed to vgic_v2_get_attr())
  - struct kvm_mmio_range vgic_dist_ranges[]
  - struct kvm_mmio_range vgic_cpu_ranges[]
  - struct kvm_device_ops kvm_arm_vgic_v2_ops {}

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/Makefile       |   1 +
 arch/arm64/kvm/Makefile     |   1 +
 virt/kvm/arm/vgic-v2-emul.c | 847 ++++++++++++++++++++++++++++++++++++++++++++
 virt/kvm/arm/vgic.c         | 806 +----------------------------------------
 4 files changed, 850 insertions(+), 805 deletions(-)
 create mode 100644 virt/kvm/arm/vgic-v2-emul.c

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
index 32a0961..d957353 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -21,6 +21,7 @@ kvm-$(CONFIG_KVM_ARM_HOST) += guest.o reset.o sys_regs.o sys_regs_generic_v8.o
 
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2.o
+kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2-emul.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v2-switch.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v3.o
 kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v3-switch.o
diff --git a/virt/kvm/arm/vgic-v2-emul.c b/virt/kvm/arm/vgic-v2-emul.c
new file mode 100644
index 0000000..19c6210
--- /dev/null
+++ b/virt/kvm/arm/vgic-v2-emul.c
@@ -0,0 +1,847 @@
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
+#define GICC_ARCH_VERSION_V2		0x2
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
+	return vgic_handle_set_pending_reg(vcpu->kvm, mmio, offset,
+					   vcpu->vcpu_id);
+}
+
+static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
+					  struct kvm_exit_mmio *mmio,
+					  phys_addr_t offset)
+{
+	return vgic_handle_clear_pending_reg(vcpu->kvm, mmio, offset,
+					     vcpu->vcpu_id);
+}
+
+static bool handle_mmio_priority_reg(struct kvm_vcpu *vcpu,
+				     struct kvm_exit_mmio *mmio,
+				     phys_addr_t offset)
+{
+	u32 *reg = vgic_bytemap_get_reg(&vcpu->kvm->arch.vgic.irq_priority,
+					vcpu->vcpu_id, offset);
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
+
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
+		u32 roreg;
+
+		roreg = 1 << vcpu->vcpu_id;
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
+
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
+	int min_sgi = (offset & ~0x3);
+	int max_sgi = min_sgi + 3;
+	int vcpu_id = vcpu->vcpu_id;
+	u32 reg = 0;
+
+	/* Copy source SGIs from distributor side */
+	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
+		u8 sources = *vgic_get_sgi_sources(dist, vcpu_id, sgi);
+
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
+	int min_sgi = (offset & ~0x3);
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
+
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
+static const struct kvm_mmio_range vgic_dist_ranges[] = {
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
+	if (!is_in_range(mmio->phys_addr, mmio->len, base,
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
+			vgic_dist_irq_set_pending(vcpu, sgi);
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
+		vgic_dist_irq_clear_pending(vcpu, irq);
+		vgic_cpu_irq_clear(vcpu, irq);
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * kvm_vgic_map_resources - Configure global VGIC state before running any VCPUs
+ * @kvm: pointer to the kvm struct
+ *
+ * Map the virtual CPU interface into the VM before running any VCPUs.  We
+ * can't do this at creation time, because user space must first set the
+ * virtual CPU interface address in the guest physical address space.
+ */
+static int vgic_v2_map_resources(struct kvm *kvm,
+				 const struct vgic_params *params)
+{
+	int ret = 0;
+
+	if (!irqchip_in_kernel(kvm))
+		return 0;
+
+	mutex_lock(&kvm->lock);
+
+	if (vgic_ready(kvm))
+		goto out;
+
+	if (IS_VGIC_ADDR_UNDEF(kvm->arch.vgic.vgic_dist_base) ||
+	    IS_VGIC_ADDR_UNDEF(kvm->arch.vgic.vgic_cpu_base)) {
+		kvm_err("Need to set vgic cpu and dist addresses first\n");
+		ret = -ENXIO;
+		goto out;
+	}
+
+	/*
+	 * Initialize the vgic if this hasn't already been done on demand by
+	 * accessing the vgic state from userspace.
+	 */
+	ret = vgic_init(kvm);
+	if (ret) {
+		kvm_err("Unable to allocate maps\n");
+		goto out;
+	}
+
+	ret = kvm_phys_addr_ioremap(kvm, kvm->arch.vgic.vgic_cpu_base,
+				    params->vcpu_base, KVM_VGIC_V2_CPU_SIZE,
+				    true);
+	if (ret) {
+		kvm_err("Unable to remap VGIC CPU to VCPU\n");
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
+static void vgic_v2_add_sgi_source(struct kvm_vcpu *vcpu, int irq, int source)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
+	*vgic_get_sgi_sources(dist, vcpu->vcpu_id, irq) |= 1 << source;
+}
+
+static int vgic_v2_init_model(struct kvm *kvm)
+{
+	int i;
+
+	for (i = VGIC_NR_PRIVATE_IRQS; i < kvm->arch.vgic.nr_irqs; i += 4)
+		vgic_set_target_reg(kvm, 0, i);
+
+	return 0;
+}
+
+void vgic_v2_init_emulation(struct kvm *kvm)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+
+	dist->vm_ops.handle_mmio = vgic_v2_handle_mmio;
+	dist->vm_ops.queue_sgi = vgic_v2_queue_sgi;
+	dist->vm_ops.add_sgi_source = vgic_v2_add_sgi_source;
+	dist->vm_ops.init_model = vgic_v2_init_model;
+	dist->vm_ops.map_resources = vgic_v2_map_resources;
+
+	kvm->arch.max_vcpus = VGIC_V2_MAX_CPUS;
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
+static const struct kvm_mmio_range vgic_cpu_ranges[] = {
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
+	const struct kvm_mmio_range *r = NULL, *ranges;
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
+	ret = vgic_init(dev->kvm);
+	if (ret)
+		goto out;
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
+	r = vgic_find_range(ranges, &mmio, offset);
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
+static int vgic_v2_create(struct kvm_device *dev, u32 type)
+{
+	return kvm_vgic_create(dev->kvm, type);
+}
+
+static void vgic_v2_destroy(struct kvm_device *dev)
+{
+	kfree(dev);
+}
+
+static int vgic_v2_set_attr(struct kvm_device *dev,
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
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
+		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
+		u32 reg;
+
+		if (get_user(reg, uaddr))
+			return -EFAULT;
+
+		return vgic_attr_regs_access(dev, attr, &reg, true);
+	}
+
+	}
+
+	return -ENXIO;
+}
+
+static int vgic_v2_get_attr(struct kvm_device *dev,
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
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
+		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
+		u32 reg = 0;
+
+		ret = vgic_attr_regs_access(dev, attr, &reg, false);
+		if (ret)
+			return ret;
+		return put_user(reg, uaddr);
+	}
+
+	}
+
+	return -ENXIO;
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
+struct kvm_device_ops kvm_arm_vgic_v2_ops = {
+	.name = "kvm-arm-vgic-v2",
+	.create = vgic_v2_create,
+	.destroy = vgic_v2_destroy,
+	.set_attr = vgic_v2_set_attr,
+	.get_attr = vgic_v2_get_attr,
+	.has_attr = vgic_v2_has_attr,
+};
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index ce6c998..0e84292 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -77,12 +77,8 @@
 
 #include "vgic.h"
 
-#define GICC_ARCH_VERSION_V2	0x2
-
 static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu);
 static void vgic_retire_lr(int lr_nr, int irq, struct kvm_vcpu *vcpu);
-static u8 *vgic_get_sgi_sources(struct vgic_dist *dist, int vcpu_id, int sgi);
-static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
 static struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr);
 static void vgic_set_lr(struct kvm_vcpu *vcpu, int lr, struct vgic_lr lr_desc);
 
@@ -421,41 +417,6 @@ void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
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
 bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
 			phys_addr_t offset)
 {
@@ -486,22 +447,6 @@ bool vgic_handle_enable_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
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
 bool vgic_handle_set_pending_reg(struct kvm *kvm,
 				 struct kvm_exit_mmio *mmio,
 				 phys_addr_t offset, int vcpu_id)
@@ -575,109 +520,6 @@ bool vgic_handle_clear_pending_reg(struct kvm *kvm,
 	return false;
 }
 
-static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
-					struct kvm_exit_mmio *mmio,
-					phys_addr_t offset)
-{
-	return vgic_handle_set_pending_reg(vcpu->kvm, mmio, offset,
-					   vcpu->vcpu_id);
-}
-
-static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
-					  struct kvm_exit_mmio *mmio,
-					  phys_addr_t offset)
-{
-	return vgic_handle_clear_pending_reg(vcpu->kvm, mmio, offset,
-					     vcpu->vcpu_id);
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
@@ -745,39 +587,6 @@ bool vgic_handle_cfg_reg(u32 *reg, struct kvm_exit_mmio *mmio,
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
-static void vgic_v2_add_sgi_source(struct kvm_vcpu *vcpu, int irq, int source)
-{
-	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
-
-	*vgic_get_sgi_sources(dist, vcpu->vcpu_id, irq) |= 1 << source;
-}
-
 /**
  * vgic_unqueue_irqs - move pending IRQs from LRs to the distributor
  * @vgic_cpu: Pointer to the vgic_cpu struct holding the LRs
@@ -838,168 +647,6 @@ void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
 	}
 }
 
-/* Handle reads of GICD_CPENDSGIRn and GICD_SPENDSGIRn */
-static bool read_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
-					struct kvm_exit_mmio *mmio,
-					phys_addr_t offset)
-{
-	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
-	int sgi;
-	int min_sgi = (offset & ~0x3);
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
-	int min_sgi = (offset & ~0x3);
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
-static const struct kvm_mmio_range vgic_dist_ranges[] = {
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
 const
 struct kvm_mmio_range *vgic_find_range(const struct kvm_mmio_range *ranges,
 				       struct kvm_exit_mmio *mmio,
@@ -1127,24 +774,6 @@ bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	return true;
 }
 
-static bool vgic_v2_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
-				struct kvm_exit_mmio *mmio)
-{
-	unsigned long base = vcpu->kvm->arch.vgic.vgic_dist_base;
-
-	if (!is_in_range(mmio->phys_addr, mmio->len, base,
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
@@ -1169,52 +798,6 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	return vcpu->kvm->arch.vgic.vm_ops.handle_mmio(vcpu, run, mmio);
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
-			vgic_dist_irq_set_pending(vcpu, sgi);
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
@@ -1368,6 +951,7 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
 /*
  * Queue an interrupt to a CPU virtual interface. Return true on success,
  * or false if it wasn't possible to queue it.
+ * sgi_source must be zero for any non-SGI interrupts.
  */
 bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 {
@@ -1418,37 +1002,6 @@ bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
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
-		vgic_dist_irq_clear_pending(vcpu, irq);
-		vgic_cpu_irq_clear(vcpu, irq);
-		return true;
-	}
-
-	return false;
-}
-
 static bool vgic_queue_hwirq(struct kvm_vcpu *vcpu, int irq)
 {
 	if (!vgic_can_sample_irq(vcpu, irq))
@@ -1894,16 +1447,6 @@ void kvm_vgic_destroy(struct kvm *kvm)
 	dist->nr_cpus = 0;
 }
 
-static int vgic_v2_init_model(struct kvm *kvm)
-{
-	int i;
-
-	for (i = VGIC_NR_PRIVATE_IRQS; i < kvm->arch.vgic.nr_irqs; i += 4)
-		vgic_set_target_reg(kvm, 0, i);
-
-	return 0;
-}
-
 /*
  * Allocate and initialize the various data structures. Must be called
  * with kvm->lock held!
@@ -1994,73 +1537,6 @@ out:
 	return ret;
 }
 
-/**
- * kvm_vgic_map_resources - Configure global VGIC state before running any VCPUs
- * @kvm: pointer to the kvm struct
- *
- * Map the virtual CPU interface into the VM before running any VCPUs.  We
- * can't do this at creation time, because user space must first set the
- * virtual CPU interface address in the guest physical address space.
- */
-static int vgic_v2_map_resources(struct kvm *kvm,
-				 const struct vgic_params *params)
-{
-	int ret = 0;
-
-	if (!irqchip_in_kernel(kvm))
-		return 0;
-
-	mutex_lock(&kvm->lock);
-
-	if (vgic_ready(kvm))
-		goto out;
-
-	if (IS_VGIC_ADDR_UNDEF(kvm->arch.vgic.vgic_dist_base) ||
-	    IS_VGIC_ADDR_UNDEF(kvm->arch.vgic.vgic_cpu_base)) {
-		kvm_err("Need to set vgic cpu and dist addresses first\n");
-		ret = -ENXIO;
-		goto out;
-	}
-
-	/*
-	 * Initialize the vgic if this hasn't already been done on demand by
-	 * accessing the vgic state from userspace.
-	 */
-	ret = vgic_init(kvm);
-	if (ret) {
-		kvm_err("Unable to allocate maps\n");
-		goto out;
-	}
-
-	ret = kvm_phys_addr_ioremap(kvm, kvm->arch.vgic.vgic_cpu_base,
-				    params->vcpu_base, KVM_VGIC_V2_CPU_SIZE,
-				    true);
-	if (ret) {
-		kvm_err("Unable to remap VGIC CPU to VCPU\n");
-		goto out;
-	}
-
-	kvm->arch.vgic.ready = true;
-out:
-	if (ret)
-		kvm_vgic_destroy(kvm);
-	mutex_unlock(&kvm->lock);
-	return ret;
-}
-
-void vgic_v2_init_emulation(struct kvm *kvm)
-{
-	struct vgic_dist *dist = &kvm->arch.vgic;
-
-	dist->vm_ops.handle_mmio = vgic_v2_handle_mmio;
-	dist->vm_ops.queue_sgi = vgic_v2_queue_sgi;
-	dist->vm_ops.add_sgi_source = vgic_v2_add_sgi_source;
-	dist->vm_ops.init_model = vgic_v2_init_model;
-	dist->vm_ops.map_resources = vgic_v2_map_resources;
-
-	kvm->arch.max_vcpus = VGIC_V2_MAX_CPUS;
-}
-
 static int init_vgic_model(struct kvm *kvm, int type)
 {
 	switch (type) {
@@ -2210,188 +1686,6 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
 	return r;
 }
 
-static bool handle_cpu_mmio_misc(struct kvm_vcpu *vcpu,
-				 struct kvm_exit_mmio *mmio, phys_addr_t offset)
-{
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
-static const struct kvm_mmio_range vgic_cpu_ranges[] = {
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
-	const struct kvm_mmio_range *r = NULL, *ranges;
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
-	ret = vgic_init(dev->kvm);
-	if (ret)
-		goto out;
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
-	r = vgic_find_range(ranges, &mmio, offset);
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
-
-	ret = 0;
-out_vgic_unlock:
-	spin_unlock(&vgic->lock);
-out:
-	mutex_unlock(&dev->kvm->lock);
-	return ret;
-}
-
 int vgic_set_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	int r;
@@ -2451,31 +1745,6 @@ int vgic_set_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 	return -ENXIO;
 }
 
-static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
-{
-	int ret;
-
-	ret = vgic_set_common_attr(dev, attr);
-	if (ret != -ENXIO)
-		return ret;
-
-	switch (attr->group) {
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
-
-	}
-
-	return -ENXIO;
-}
-
 int vgic_get_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	int r = -ENXIO;
@@ -2506,31 +1775,6 @@ int vgic_get_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 	return r;
 }
 
-static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
-{
-	int ret;
-
-	ret = vgic_get_common_attr(dev, attr);
-	if (ret != -ENXIO)
-		return ret;
-
-	switch (attr->group) {
-	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
-	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
-		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
-		u32 reg = 0;
-
-		ret = vgic_attr_regs_access(dev, attr, &reg, false);
-		if (ret)
-			return ret;
-		return put_user(reg, uaddr);
-	}
-
-	}
-
-	return -ENXIO;
-}
-
 int vgic_has_attr_regs(const struct kvm_mmio_range *ranges, phys_addr_t offset)
 {
 	struct kvm_exit_mmio dev_attr_mmio;
@@ -2542,54 +1786,6 @@ int vgic_has_attr_regs(const struct kvm_mmio_range *ranges, phys_addr_t offset)
 		return -ENXIO;
 }
 
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
-		return 0;
-	case KVM_DEV_ARM_VGIC_GRP_CTRL:
-		switch (attr->attr) {
-		case KVM_DEV_ARM_VGIC_CTRL_INIT:
-			return 0;
-		}
-	}
-	return -ENXIO;
-}
-
-void vgic_destroy(struct kvm_device *dev)
-{
-	kfree(dev);
-}
-
-int vgic_create(struct kvm_device *dev, u32 type)
-{
-	return kvm_vgic_create(dev->kvm, type);
-}
-
-struct kvm_device_ops kvm_arm_vgic_v2_ops = {
-	.name = "kvm-arm-vgic",
-	.create = vgic_create,
-	.destroy = vgic_destroy,
-	.set_attr = vgic_set_attr,
-	.get_attr = vgic_get_attr,
-	.has_attr = vgic_has_attr,
-};
-
 static void vgic_init_maintenance_interrupt(void *info)
 {
 	enable_percpu_irq(vgic->maint_irq, 0);
-- 
2.1.2.330.g565301e.dirty
