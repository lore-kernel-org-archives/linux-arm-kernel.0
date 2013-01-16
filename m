From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 13:00:48 -0500
Subject: [PATCH v6 05/13] ARM: KVM: Initial VGIC infrastructure code
In-Reply-To: <20130116180013.29393.49165.stgit@ubuntu>
References: <20130116180013.29393.49165.stgit@ubuntu>
Message-ID: <20130116180048.29393.33315.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Wire the basic framework code for VGIC support and the initial in-kernel
MMIO support code for the VGIC, used for the distributor emulation.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_host.h |    8 ++
 arch/arm/include/asm/kvm_vgic.h |   80 ++++++++++++++++++++
 arch/arm/kvm/Makefile           |    1 
 arch/arm/kvm/arm.c              |   27 +++++++
 arch/arm/kvm/interrupts.S       |    4 +
 arch/arm/kvm/mmio.c             |    3 +
 arch/arm/kvm/vgic.c             |  153 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 275 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/asm/kvm_vgic.h
 create mode 100644 arch/arm/kvm/vgic.c

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 869253c..feac7f4 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -37,6 +37,8 @@
 #define KVM_NR_PAGE_SIZES	1
 #define KVM_PAGES_PER_HPAGE(x)	(1UL<<31)
 
+#include <asm/kvm_vgic.h>
+
 struct kvm_vcpu;
 u32 *kvm_vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num, u32 mode);
 int kvm_target_cpu(void);
@@ -58,6 +60,9 @@ struct kvm_arch {
 
 	/* Stage-2 page table */
 	pgd_t *pgd;
+
+	/* Interrupt controller */
+	struct vgic_dist	vgic;
 };
 
 #define KVM_NR_MEM_OBJS     40
@@ -92,6 +97,9 @@ struct kvm_vcpu_arch {
 	struct vfp_hard_struct vfp_guest;
 	struct vfp_hard_struct *vfp_host;
 
+	/* VGIC state */
+	struct vgic_cpu vgic_cpu;
+
 	/*
 	 * Anything that is not used directly from assembly code goes
 	 * here.
diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
new file mode 100644
index 0000000..8a1aa9f
--- /dev/null
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -0,0 +1,80 @@
+/*
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __ASM_ARM_KVM_VGIC_H
+#define __ASM_ARM_KVM_VGIC_H
+
+#include <asm/hardware/gic.h>
+
+struct vgic_dist {
+};
+
+struct vgic_cpu {
+};
+
+struct kvm;
+struct kvm_vcpu;
+struct kvm_run;
+struct kvm_exit_mmio;
+
+#ifdef CONFIG_KVM_ARM_VGIC
+bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
+		      struct kvm_exit_mmio *mmio);
+
+#else
+static inline int kvm_vgic_hyp_init(void)
+{
+	return 0;
+}
+
+static inline int kvm_vgic_init(struct kvm *kvm)
+{
+	return 0;
+}
+
+static inline int kvm_vgic_create(struct kvm *kvm)
+{
+	return 0;
+}
+
+static inline int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+static inline void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu) {}
+static inline void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu) {}
+
+static inline int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+static inline bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
+				    struct kvm_exit_mmio *mmio)
+{
+	return false;
+}
+
+static inline int irqchip_in_kernel(struct kvm *kvm)
+{
+	return 0;
+}
+#endif
+
+#endif
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index ea27987..dece8ed 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -19,3 +19,4 @@ kvm-arm-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
 obj-y += kvm-arm.o init.o interrupts.o
 obj-y += arm.o guest.o mmu.o emulate.o reset.o
 obj-y += coproc.o coproc_a15.o mmio.o psci.o
+obj-$(CONFIG_KVM_ARM_VGIC) += vgic.o
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index c715751..d30a48c 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -62,6 +62,8 @@ static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u8 kvm_next_vmid;
 static DEFINE_SPINLOCK(kvm_vmid_lock);
 
+static bool vgic_present;
+
 static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
 {
 	BUG_ON(preemptible());
@@ -184,6 +186,9 @@ int kvm_dev_ioctl_check_extension(long ext)
 {
 	int r;
 	switch (ext) {
+	case KVM_CAP_IRQCHIP:
+		r = vgic_present;
+		break;
 	case KVM_CAP_USER_MEMORY:
 	case KVM_CAP_SYNC_MMU:
 	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
@@ -315,8 +320,16 @@ int __attribute_const__ kvm_target_cpu(void)
 
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 {
+	int ret;
+
 	/* Force users to call KVM_ARM_VCPU_INIT */
 	vcpu->arch.target = -1;
+
+	/* Set up VGIC */
+	ret = kvm_vgic_vcpu_init(vcpu);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -374,7 +387,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
  */
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
-	return !!v->arch.irq_lines;
+	return !!v->arch.irq_lines || kvm_vgic_vcpu_pending_irq(v);
 }
 
 /* Just ensure a guest exit from a particular CPU */
@@ -682,6 +695,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		update_vttbr(vcpu->kvm);
 
+		kvm_vgic_flush_hwstate(vcpu);
+
 		local_irq_disable();
 
 		/*
@@ -694,6 +709,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
 			local_irq_enable();
+			kvm_vgic_sync_hwstate(vcpu);
 			continue;
 		}
 
@@ -732,6 +748,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * Back from guest
 		 *************************************************************/
 
+		kvm_vgic_sync_hwstate(vcpu);
+
 		ret = handle_exit(vcpu, run, ret);
 	}
 
@@ -1006,6 +1024,13 @@ static int init_hyp_mode(void)
 		}
 	}
 
+	/*
+	 * Init HYP view of VGIC
+	 */
+	err = kvm_vgic_hyp_init();
+	if (err)
+		goto out_free_vfp;
+
 	kvm_info("Hyp mode initialized successfully\n");
 	return 0;
 out_free_vfp:
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 702743e..b19ee80 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -94,6 +94,8 @@ ENTRY(__kvm_vcpu_run)
 
 	save_host_regs
 
+	restore_vgic_state
+
 	@ Store hardware CP15 state and load guest state
 	read_cp15_state store_to_vcpu = 0
 	write_cp15_state read_from_vcpu = 1
@@ -187,6 +189,8 @@ after_vfp_restore:
 	read_cp15_state store_to_vcpu = 1
 	write_cp15_state read_from_vcpu = 0
 
+	save_vgic_state
+
 	restore_host_regs
 	clrex				@ Clear exclusive monitor
 	mov	r0, r1			@ Return the return code
diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index 0144baf..98a870f 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -148,6 +148,9 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	if (mmio.is_write)
 		memcpy(mmio.data, vcpu_reg(vcpu, rt), mmio.len);
 
+	if (vgic_handle_mmio(vcpu, run, &mmio))
+		return 1;
+
 	kvm_prepare_mmio(run, &mmio);
 	return 0;
 }
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
new file mode 100644
index 0000000..c400661
--- /dev/null
+++ b/arch/arm/kvm/vgic.c
@@ -0,0 +1,153 @@
+/*
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/kvm.h>
+#include <linux/kvm_host.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <asm/kvm_emulate.h>
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
+static u32 mmio_data_read(struct kvm_exit_mmio *mmio, u32 mask)
+{
+	return *((u32 *)mmio->data) & mask;
+}
+
+static void mmio_data_write(struct kvm_exit_mmio *mmio, u32 mask, u32 value)
+{
+	*((u32 *)mmio->data) = value & mask;
+}
+
+/**
+ * vgic_reg_access - access vgic register
+ * @mmio:   pointer to the data describing the mmio access
+ * @reg:    pointer to the virtual backing of vgic distributor data
+ * @offset: least significant 2 bits used for word offset
+ * @mode:   ACCESS_ mode (see defines above)
+ *
+ * Helper to make vgic register access easier using one of the access
+ * modes defined for vgic register access
+ * (read,raz,write-ignored,setbit,clearbit,write)
+ */
+static void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
+			    phys_addr_t offset, int mode)
+{
+	int word_offset = (offset & 3) * 8;
+	u32 mask = (1UL << (mmio->len * 8)) - 1;
+	u32 regval;
+
+	/*
+	 * Any alignment fault should have been delivered to the guest
+	 * directly (ARM ARM B3.12.7 "Prioritization of aborts").
+	 */
+
+	if (reg) {
+		regval = *reg;
+	} else {
+		BUG_ON(mode != (ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED));
+		regval = 0;
+	}
+
+	if (mmio->is_write) {
+		u32 data = mmio_data_read(mmio, mask) << word_offset;
+		switch (ACCESS_WRITE_MASK(mode)) {
+		case ACCESS_WRITE_IGNORED:
+			return;
+
+		case ACCESS_WRITE_SETBIT:
+			regval |= data;
+			break;
+
+		case ACCESS_WRITE_CLEARBIT:
+			regval &= ~data;
+			break;
+
+		case ACCESS_WRITE_VALUE:
+			regval = (regval & ~(mask << word_offset)) | data;
+			break;
+		}
+		*reg = regval;
+	} else {
+		switch (ACCESS_READ_MASK(mode)) {
+		case ACCESS_READ_RAZ:
+			regval = 0;
+			/* fall through */
+
+		case ACCESS_READ_VALUE:
+			mmio_data_write(mmio, mask, regval >> word_offset);
+		}
+	}
+}
+
+/*
+ * I would have liked to use the kvm_bus_io_*() API instead, but it
+ * cannot cope with banked registers (only the VM pointer is passed
+ * around, and we need the vcpu). One of these days, someone please
+ * fix it!
+ */
+struct mmio_range {
+	phys_addr_t base;
+	unsigned long len;
+	bool (*handle_mmio)(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
+			    phys_addr_t offset);
+};
+
+static const struct mmio_range vgic_ranges[] = {
+	{}
+};
+
+static const
+struct mmio_range *find_matching_range(const struct mmio_range *ranges,
+				       struct kvm_exit_mmio *mmio,
+				       phys_addr_t base)
+{
+	const struct mmio_range *r = ranges;
+	phys_addr_t addr = mmio->phys_addr - base;
+
+	while (r->len) {
+		if (addr >= r->base &&
+		    (addr + mmio->len) <= (r->base + r->len))
+			return r;
+		r++;
+	}
+
+	return NULL;
+}
+
+/**
+ * vgic_handle_mmio - handle an in-kernel MMIO access
+ * @vcpu:	pointer to the vcpu performing the access
+ * @run:	pointer to the kvm_run structure
+ * @mmio:	pointer to the data describing the access
+ *
+ * returns true if the MMIO access has been performed in kernel space,
+ * and false if it needs to be emulated in user space.
+ */
+bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
+		      struct kvm_exit_mmio *mmio)
+{
+	return KVM_EXIT_MMIO;
+}
