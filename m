From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sat, 15 Sep 2012 11:35:08 -0400
Subject: [PATCH 06/15] KVM: ARM: Initial skeleton to compile KVM support
In-Reply-To: <20120915153359.21241.86002.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
Message-ID: <20120915153508.21241.47712.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Targets KVM support for Cortex A-15 processors.

Contains all the framework components, make files, header files, some
tracing functionality, and basic user space API.

Only supported core is Cortex-A15 for now.

Most functionality is in arch/arm/kvm/* or arch/arm/include/asm/kvm_*.h.

?Nothing to see here. Move along, move along..."

Signed-off-by: Rusty Russell <rusty.russell@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 Documentation/virtual/kvm/api.txt  |   54 +++++-
 arch/arm/Kconfig                   |    2 
 arch/arm/Makefile                  |    1 
 arch/arm/include/asm/kvm.h         |   88 +++++++++
 arch/arm/include/asm/kvm_arm.h     |   28 +++
 arch/arm/include/asm/kvm_asm.h     |   30 +++
 arch/arm/include/asm/kvm_coproc.h  |   24 +++
 arch/arm/include/asm/kvm_emulate.h |  108 +++++++++++
 arch/arm/include/asm/kvm_host.h    |  172 ++++++++++++++++++
 arch/arm/kvm/Kconfig               |   44 +++++
 arch/arm/kvm/Makefile              |   21 ++
 arch/arm/kvm/arm.c                 |  345 ++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/coproc.c              |   22 ++
 arch/arm/kvm/emulate.c             |  127 +++++++++++++
 arch/arm/kvm/exports.c             |   21 ++
 arch/arm/kvm/guest.c               |  211 ++++++++++++++++++++++
 arch/arm/kvm/init.S                |   19 ++
 arch/arm/kvm/interrupts.S          |   19 ++
 arch/arm/kvm/mmu.c                 |   17 ++
 arch/arm/kvm/reset.c               |   74 ++++++++
 arch/arm/kvm/trace.h               |   52 +++++
 include/linux/kvm.h                |    2 
 22 files changed, 1477 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm.h
 create mode 100644 arch/arm/include/asm/kvm_arm.h
 create mode 100644 arch/arm/include/asm/kvm_asm.h
 create mode 100644 arch/arm/include/asm/kvm_coproc.h
 create mode 100644 arch/arm/include/asm/kvm_emulate.h
 create mode 100644 arch/arm/include/asm/kvm_host.h
 create mode 100644 arch/arm/kvm/Kconfig
 create mode 100644 arch/arm/kvm/Makefile
 create mode 100644 arch/arm/kvm/arm.c
 create mode 100644 arch/arm/kvm/coproc.c
 create mode 100644 arch/arm/kvm/emulate.c
 create mode 100644 arch/arm/kvm/exports.c
 create mode 100644 arch/arm/kvm/guest.c
 create mode 100644 arch/arm/kvm/init.S
 create mode 100644 arch/arm/kvm/interrupts.S
 create mode 100644 arch/arm/kvm/mmu.c
 create mode 100644 arch/arm/kvm/reset.c
 create mode 100644 arch/arm/kvm/trace.h

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 36befa7..67640c6 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -293,7 +293,7 @@ kvm_run' (see below).
 4.11 KVM_GET_REGS
 
 Capability: basic
-Architectures: all
+Architectures: all except ARM
 Type: vcpu ioctl
 Parameters: struct kvm_regs (out)
 Returns: 0 on success, -1 on error
@@ -314,7 +314,7 @@ struct kvm_regs {
 4.12 KVM_SET_REGS
 
 Capability: basic
-Architectures: all
+Architectures: all except ARM
 Type: vcpu ioctl
 Parameters: struct kvm_regs (in)
 Returns: 0 on success, -1 on error
@@ -600,7 +600,7 @@ struct kvm_fpu {
 4.24 KVM_CREATE_IRQCHIP
 
 Capability: KVM_CAP_IRQCHIP
-Architectures: x86, ia64
+Architectures: x86, ia64, ARM
 Type: vm ioctl
 Parameters: none
 Returns: 0 on success, -1 on error
@@ -608,7 +608,8 @@ Returns: 0 on success, -1 on error
 Creates an interrupt controller model in the kernel.  On x86, creates a virtual
 ioapic, a virtual PIC (two PICs, nested), and sets up future vcpus to have a
 local APIC.  IRQ routing for GSIs 0-15 is set to both PIC and IOAPIC; GSI 16-23
-only go to the IOAPIC.  On ia64, a IOSAPIC is created.
+only go to the IOAPIC.  On ia64, a IOSAPIC is created. On ARM, a GIC is
+created.
 
 
 4.25 KVM_IRQ_LINE
@@ -1732,6 +1733,11 @@ registers, find a list below:
         |                       |
   PPC   | KVM_REG_PPC_HIOR      | 64
 
+ARM registers are mapped using the lower 32 bits.  The upper 16 of that
+is the register group type, or coprocessor number:
+
+ARM core registers have the following id bit patterns:
+  0x4002 0000 0010 <index into the kvm_regs struct:32>
 
 4.69 KVM_GET_ONE_REG
 
@@ -1985,6 +1991,46 @@ the virtualized real-mode area (VRMA) facility, the kernel will
 re-create the VMRA HPTEs on the next KVM_RUN of any vcpu.)
 
 
+4.77 KVM_ARM_VCPU_INIT
+
+Capability: basic
+Architectures: arm
+Type: vcpu ioctl
+Parameters: struct struct kvm_vcpu_init (in)
+Returns: 0 on success; -1 on error
+Errors:
+ ?EINVAL: ???the target is unknown, or the combination of features is invalid.
+ ?ENOENT: ???a features bit specified is unknown.
+
+This tells KVM what type of CPU to present to the guest, and what
+optional features it should have. ?This will cause a reset of the cpu
+registers to their initial values. ?If this is not called, KVM_RUN will
+return ENOEXEC for that vcpu.
+
+Note that because some registers reflect machine topology, all vcpus
+should be created before this ioctl is invoked.
+
+
+4.78 KVM_GET_REG_LIST
+
+Capability: basic
+Architectures: arm
+Type: vcpu ioctl
+Parameters: struct kvm_reg_list (in/out)
+Returns: 0 on success; -1 on error
+Errors:
+ ?E2BIG: ????the reg index list is too big to fit in the array specified by
+ ????????????the user (the number required will be written into n).
+
+struct kvm_reg_list {
+	__u64 n; /* number of registers in reg[] */
+	__u64 reg[0];
+};
+
+This ioctl returns the guest registers that are supported for the
+KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
+
+
 5. The kvm_run structure
 ------------------------
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2f88d8d..c8fea8f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2336,3 +2336,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "arch/arm/kvm/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 30eae87..3bcc414 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -255,6 +255,7 @@ core-$(CONFIG_VFP)		+= arch/arm/vfp/
 # If we have a machine-specific directory, then include it in the build.
 core-y				+= arch/arm/kernel/ arch/arm/mm/ arch/arm/common/
 core-y				+= arch/arm/net/
+core-y 				+= arch/arm/kvm/
 core-y				+= $(machdirs) $(platdirs)
 
 drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/
diff --git a/arch/arm/include/asm/kvm.h b/arch/arm/include/asm/kvm.h
new file mode 100644
index 0000000..a13b582
--- /dev/null
+++ b/arch/arm/include/asm/kvm.h
@@ -0,0 +1,88 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#ifndef __ARM_KVM_H__
+#define __ARM_KVM_H__
+
+#include <asm/types.h>
+
+#define __KVM_HAVE_GUEST_DEBUG
+
+#define KVM_REG_SIZE(id)						\
+	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
+
+struct kvm_regs {
+	__u32 usr_regs[15];	/* R0_usr - R14_usr */
+	__u32 svc_regs[3];	/* SP_svc, LR_svc, SPSR_svc */
+	__u32 abt_regs[3];	/* SP_abt, LR_abt, SPSR_abt */
+	__u32 und_regs[3];	/* SP_und, LR_und, SPSR_und */
+	__u32 irq_regs[3];	/* SP_irq, LR_irq, SPSR_irq */
+	__u32 fiq_regs[8];	/* R8_fiq - R14_fiq, SPSR_fiq */
+	__u32 pc;		/* The program counter (r15) */
+	__u32 cpsr;		/* The guest CPSR */
+};
+
+/* Supported Processor Types */
+#define KVM_ARM_TARGET_CORTEX_A15	(0xC0F)
+
+struct kvm_vcpu_init {
+	__u32 target;
+	__u32 features[7];
+};
+
+struct kvm_sregs {
+};
+
+struct kvm_fpu {
+};
+
+struct kvm_guest_debug_arch {
+};
+
+struct kvm_debug_exit_arch {
+};
+
+struct kvm_sync_regs {
+};
+
+struct kvm_arch_memory_slot {
+};
+
+/* For KVM_VCPU_GET_REG_LIST. */
+struct kvm_reg_list {
+	__u64 n; /* number of regs */
+	__u64 reg[0];
+};
+
+/* If you need to interpret the index values, here is the key: */
+#define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
+#define KVM_REG_ARM_COPROC_SHIFT	16
+#define KVM_REG_ARM_32_OPC2_MASK	0x0000000000000007
+#define KVM_REG_ARM_32_OPC2_SHIFT	0
+#define KVM_REG_ARM_OPC1_MASK		0x0000000000000078
+#define KVM_REG_ARM_OPC1_SHIFT		3
+#define KVM_REG_ARM_CRM_MASK		0x0000000000000780
+#define KVM_REG_ARM_CRM_SHIFT		7
+#define KVM_REG_ARM_32_CRN_MASK		0x0000000000007800
+#define KVM_REG_ARM_32_CRN_SHIFT	11
+
+/* Normal registers are mapped as coprocessor 16. */
+#define KVM_REG_ARM_CORE		(0x0010 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM_CORE_REG(name)	(offsetof(struct kvm_regs, name) / 4)
+
+#endif /* __ARM_KVM_H__ */
diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
new file mode 100644
index 0000000..2f9d28e
--- /dev/null
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#ifndef __ARM_KVM_ARM_H__
+#define __ARM_KVM_ARM_H__
+
+/* Supported Processor Types */
+#define CORTEX_A15	(0xC0F)
+
+/* Multiprocessor Affinity Register */
+#define MPIDR_CPUID	(0x3 << 0)
+
+#endif /* __ARM_KVM_ARM_H__ */
diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
new file mode 100644
index 0000000..44591f9
--- /dev/null
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#ifndef __ARM_KVM_ASM_H__
+#define __ARM_KVM_ASM_H__
+
+#define ARM_EXCEPTION_RESET	  0
+#define ARM_EXCEPTION_UNDEFINED   1
+#define ARM_EXCEPTION_SOFTWARE    2
+#define ARM_EXCEPTION_PREF_ABORT  3
+#define ARM_EXCEPTION_DATA_ABORT  4
+#define ARM_EXCEPTION_IRQ	  5
+#define ARM_EXCEPTION_FIQ	  6
+
+#endif /* __ARM_KVM_ASM_H__ */
diff --git a/arch/arm/include/asm/kvm_coproc.h b/arch/arm/include/asm/kvm_coproc.h
new file mode 100644
index 0000000..b6d023d
--- /dev/null
+++ b/arch/arm/include/asm/kvm_coproc.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2012 Rusty Russell IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#ifndef __ARM_KVM_COPROC_H__
+#define __ARM_KVM_COPROC_H__
+#include <linux/kvm_host.h>
+
+void kvm_reset_coprocs(struct kvm_vcpu *vcpu);
+
+#endif /* __ARM_KVM_COPROC_H__ */
diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
new file mode 100644
index 0000000..9e29335
--- /dev/null
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -0,0 +1,108 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#ifndef __ARM_KVM_EMULATE_H__
+#define __ARM_KVM_EMULATE_H__
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_asm.h>
+
+u32 *vcpu_reg_mode(struct kvm_vcpu *vcpu, u8 reg_num, enum vcpu_mode mode);
+
+static inline u8 __vcpu_mode(u32 cpsr)
+{
+	u8 modes_table[32] = {
+		0xf, 0xf, 0xf, 0xf, 0xf, 0xf, 0xf, 0xf,
+		0xf, 0xf, 0xf, 0xf, 0xf, 0xf, 0xf, 0xf,
+		MODE_USR,	/* 0x0 */
+		MODE_FIQ,	/* 0x1 */
+		MODE_IRQ,	/* 0x2 */
+		MODE_SVC,	/* 0x3 */
+		0xf, 0xf, 0xf,
+		MODE_ABT,	/* 0x7 */
+		0xf, 0xf, 0xf,
+		MODE_UND,	/* 0xb */
+		0xf, 0xf, 0xf,
+		MODE_SYS	/* 0xf */
+	};
+
+	return modes_table[cpsr & 0x1f];
+}
+
+static inline enum vcpu_mode vcpu_mode(struct kvm_vcpu *vcpu)
+{
+	u8 mode = __vcpu_mode(vcpu->arch.regs.cpsr);
+	BUG_ON(mode == 0xf);
+	return mode;
+}
+
+/*
+ * Return the SPSR for the specified mode of the virtual CPU.
+ */
+static inline u32 *vcpu_spsr_mode(struct kvm_vcpu *vcpu, enum vcpu_mode mode)
+{
+	switch (mode) {
+	case MODE_SVC:
+		return &vcpu->arch.regs.svc_regs[2];
+	case MODE_ABT:
+		return &vcpu->arch.regs.abt_regs[2];
+	case MODE_UND:
+		return &vcpu->arch.regs.und_regs[2];
+	case MODE_IRQ:
+		return &vcpu->arch.regs.irq_regs[2];
+	case MODE_FIQ:
+		return &vcpu->arch.regs.fiq_regs[7];
+	default:
+		BUG();
+	}
+}
+
+/* Get vcpu register for current mode */
+static inline u32 *vcpu_reg(struct kvm_vcpu *vcpu, unsigned long reg_num)
+{
+	return vcpu_reg_mode(vcpu, reg_num, vcpu_mode(vcpu));
+}
+
+static inline u32 *vcpu_pc(struct kvm_vcpu *vcpu)
+{
+	return vcpu_reg(vcpu, 15);
+}
+
+static inline u32 *vcpu_cpsr(struct kvm_vcpu *vcpu)
+{
+	return &vcpu->arch.regs.cpsr;
+}
+
+/* Get vcpu SPSR for current mode */
+static inline u32 *vcpu_spsr(struct kvm_vcpu *vcpu)
+{
+	return vcpu_spsr_mode(vcpu, vcpu_mode(vcpu));
+}
+
+static inline bool mode_has_spsr(struct kvm_vcpu *vcpu)
+{
+	return (vcpu_mode(vcpu) < MODE_USR);
+}
+
+static inline bool vcpu_mode_priv(struct kvm_vcpu *vcpu)
+{
+	BUG_ON(vcpu_mode(vcpu) > MODE_SYS);
+	return vcpu_mode(vcpu) != MODE_USR;
+}
+
+#endif /* __ARM_KVM_EMULATE_H__ */
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
new file mode 100644
index 0000000..24959f4
--- /dev/null
+++ b/arch/arm/include/asm/kvm_host.h
@@ -0,0 +1,172 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#ifndef __ARM_KVM_HOST_H__
+#define __ARM_KVM_HOST_H__
+
+#include <asm/kvm.h>
+
+#define KVM_MAX_VCPUS 4
+#define KVM_MEMORY_SLOTS 32
+#define KVM_PRIVATE_MEM_SLOTS 4
+#define KVM_COALESCED_MMIO_PAGE_OFFSET 1
+
+#define NUM_FEATURES 0
+
+/* We don't currently support large pages. */
+#define KVM_HPAGE_GFN_SHIFT(x)	0
+#define KVM_NR_PAGE_SIZES	1
+#define KVM_PAGES_PER_HPAGE(x)	(1UL<<31)
+
+struct kvm_vcpu;
+u32 *kvm_vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num, u32 mode);
+int kvm_target_cpu(void);
+int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
+void kvm_reset_coprocs(struct kvm_vcpu *vcpu);
+
+struct kvm_arch {
+	/* The VMID generation used for the virt. memory system */
+	u64    vmid_gen;
+	u32    vmid;
+
+	/* 1-level 2nd stage table and lock */
+	spinlock_t pgd_lock;
+	pgd_t *pgd;
+
+	/* VTTBR value associated with above pgd and vmid */
+	u64    vttbr;
+};
+
+#define EXCEPTION_NONE      0
+#define EXCEPTION_RESET     0x80
+#define EXCEPTION_UNDEFINED 0x40
+#define EXCEPTION_SOFTWARE  0x20
+#define EXCEPTION_PREFETCH  0x10
+#define EXCEPTION_DATA      0x08
+#define EXCEPTION_IMPRECISE 0x04
+#define EXCEPTION_IRQ       0x02
+#define EXCEPTION_FIQ       0x01
+
+#define KVM_NR_MEM_OBJS     40
+
+/*
+ * We don't want allocation failures within the mmu code, so we preallocate
+ * enough memory for a single page fault in a cache.
+ */
+struct kvm_mmu_memory_cache {
+	int nobjs;
+	void *objects[KVM_NR_MEM_OBJS];
+};
+
+/*
+ * Modes used for short-hand mode determinition in the world-switch code and
+ * in emulation code.
+ *
+ * Note: These indices do NOT correspond to the value of the CPSR mode bits!
+ */
+enum vcpu_mode {
+	MODE_FIQ = 0,
+	MODE_IRQ,
+	MODE_SVC,
+	MODE_ABT,
+	MODE_UND,
+	MODE_USR,
+	MODE_SYS
+};
+
+/* 0 is reserved as an invalid value. */
+enum cp15_regs {
+	c0_MPIDR=1,		/* MultiProcessor ID Register */
+	c0_CSSELR,		/* Cache Size Selection Register */
+	c1_SCTLR,		/* System Control Register */
+	c1_ACTLR,		/* Auxilliary Control Register */
+	c1_CPACR,		/* Coprocessor Access Control */
+	c2_TTBR0,		/* Translation Table Base Register 0 */
+	c2_TTBR0_high,		/* TTBR0 top 32 bits */
+	c2_TTBR1,		/* Translation Table Base Register 1 */
+	c2_TTBR1_high,		/* TTBR1 top 32 bits */
+	c2_TTBCR,		/* Translation Table Base Control R. */
+	c3_DACR,		/* Domain Access Control Register */
+	c5_DFSR,		/* Data Fault Status Register */
+	c5_IFSR,		/* Instruction Fault Status Register */
+	c5_ADFSR,		/* Auxilary Data Fault Status Register */
+	c5_AIFSR,		/* Auxilary Instruction Fault Status Register */
+	c6_DFAR,		/* Data Fault Address Register */
+	c6_IFAR,		/* Instruction Fault Address Register */
+	c10_PRRR,		/* Primary Region Remap Register */
+	c10_NMRR,		/* Normal Memory Remap Register */
+	c12_VBAR,		/* Vector Base Address Register */
+	c13_CID,		/* Context ID Register */
+	c13_TID_URW,		/* Thread ID, User R/W */
+	c13_TID_URO,		/* Thread ID, User R/O */
+	c13_TID_PRIV,		/* Thread ID, Priveleged */
+
+	nr_cp15_regs
+};
+
+struct kvm_vcpu_arch {
+	struct kvm_regs regs;
+
+	u32 target; /* Currently KVM_ARM_TARGET_CORTEX_A15 */
+	DECLARE_BITMAP(features, NUM_FEATURES);
+
+	/* System control coprocessor (cp15) */
+	u32 cp15[nr_cp15_regs];
+
+	/* The CPU type we expose to the VM */
+	u32 midr;
+
+	/* Exception Information */
+	u32 hsr;		/* Hyp Syndrom Register */
+	u32 hdfar;		/* Hyp Data Fault Address Register */
+	u32 hifar;		/* Hyp Inst. Fault Address Register */
+	u32 hpfar;		/* Hyp IPA Fault Address Register */
+
+	/* IO related fields */
+	struct {
+		bool sign_extend;	/* for byte/halfword loads */
+		u32  rd;
+	} mmio;
+
+	/* Interrupt related fields */
+	u32 irq_lines;		/* IRQ and FIQ levels */
+
+	/* Hyp exception information */
+	u32 hyp_pc;		/* PC when exception was taken from Hyp mode */
+
+	/* Cache some mmu pages needed inside spinlock regions */
+	struct kvm_mmu_memory_cache mmu_page_cache;
+};
+
+struct kvm_vm_stat {
+	u32 remote_tlb_flush;
+};
+
+struct kvm_vcpu_stat {
+	u32 halt_wakeup;
+};
+
+struct kvm_vcpu_init;
+int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
+			const struct kvm_vcpu_init *init);
+unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
+int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
+struct kvm_one_reg;
+int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+#endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
new file mode 100644
index 0000000..a07ddcc
--- /dev/null
+++ b/arch/arm/kvm/Kconfig
@@ -0,0 +1,44 @@
+#
+# KVM configuration
+#
+
+source "virt/kvm/Kconfig"
+
+menuconfig VIRTUALIZATION
+	bool "Virtualization"
+	---help---
+	  Say Y here to get to see options for using your Linux host to run
+	  other operating systems inside virtual machines (guests).
+	  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and
+	  disabled.
+
+if VIRTUALIZATION
+
+config KVM
+	bool "Kernel-based Virtual Machine (KVM) support"
+	select PREEMPT_NOTIFIERS
+	select ANON_INODES
+	select KVM_MMIO
+	depends on ARM_VIRT_EXT && ARM_LPAE
+	---help---
+	  Support hosting virtualized guest machines. You will also
+	  need to select one or more of the processor modules below.
+
+	  This module provides access to the hardware capabilities through
+	  a character device node named /dev/kvm.
+
+	  If unsure, say N.
+
+config KVM_ARM_HOST
+	bool "KVM host support for ARM cpus."
+	depends on KVM
+	depends on MMU
+	depends on CPU_V7 && ARM_VIRT_EXT
+	---help---
+	  Provides host support for ARM processors.
+
+source drivers/virtio/Kconfig
+
+endif # VIRTUALIZATION
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
new file mode 100644
index 0000000..db8c8f4
--- /dev/null
+++ b/arch/arm/kvm/Makefile
@@ -0,0 +1,21 @@
+#
+# Makefile for Kernel-based Virtual Machine module
+#
+
+plus_virt := $(call as-instr,.arch_extension virt,+virt)
+ifeq ($(plus_virt),+virt)
+	plus_virt_def := -DREQUIRES_VIRT=1
+endif
+
+ccflags-y += -Ivirt/kvm -Iarch/arm/kvm
+CFLAGS_arm.o := -I. $(plus_virt_def)
+CFLAGS_mmu.o := -I.
+
+AFLAGS_init.o := -Wa,-march=armv7-a$(plus_virt)
+AFLAGS_interrupts.o := -Wa,-march=armv7-a$(plus_virt)
+
+obj-$(CONFIG_KVM_ARM_HOST) += init.o interrupts.o exports.o
+
+obj-$(CONFIG_KVM_ARM_HOST) += $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
+
+obj-$(CONFIG_KVM_ARM_HOST) += arm.o guest.o mmu.o emulate.o reset.o coproc.o
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
new file mode 100644
index 0000000..fd6fa9b
--- /dev/null
+++ b/arch/arm/kvm/arm.c
@@ -0,0 +1,345 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/kvm_host.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/fs.h>
+#include <linux/mman.h>
+#include <linux/sched.h>
+#include <trace/events/kvm.h>
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
+#include <asm/unified.h>
+#include <asm/uaccess.h>
+#include <asm/ptrace.h>
+#include <asm/mman.h>
+#include <asm/cputype.h>
+
+#ifdef REQUIRES_VIRT
+__asm__(".arch_extension	virt");
+#endif
+
+int kvm_arch_hardware_enable(void *garbage)
+{
+	return 0;
+}
+
+int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
+}
+
+void kvm_arch_hardware_disable(void *garbage)
+{
+}
+
+int kvm_arch_hardware_setup(void)
+{
+	return 0;
+}
+
+void kvm_arch_hardware_unsetup(void)
+{
+}
+
+void kvm_arch_check_processor_compat(void *rtn)
+{
+	*(int *)rtn = 0;
+}
+
+void kvm_arch_sync_events(struct kvm *kvm)
+{
+}
+
+int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
+{
+	if (type)
+		return -EINVAL;
+
+	return 0;
+}
+
+int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
+{
+	return VM_FAULT_SIGBUS;
+}
+
+void kvm_arch_free_memslot(struct kvm_memory_slot *free,
+			   struct kvm_memory_slot *dont)
+{
+}
+
+int kvm_arch_create_memslot(struct kvm_memory_slot *slot, unsigned long npages)
+{
+	return 0;
+}
+
+void kvm_arch_destroy_vm(struct kvm *kvm)
+{
+	int i;
+
+	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+		if (kvm->vcpus[i]) {
+			kvm_arch_vcpu_free(kvm->vcpus[i]);
+			kvm->vcpus[i] = NULL;
+		}
+	}
+}
+
+int kvm_dev_ioctl_check_extension(long ext)
+{
+	int r;
+	switch (ext) {
+	case KVM_CAP_USER_MEMORY:
+	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
+	case KVM_CAP_ONE_REG:
+		r = 1;
+		break;
+	case KVM_CAP_COALESCED_MMIO:
+		r = KVM_COALESCED_MMIO_PAGE_OFFSET;
+		break;
+	default:
+		r = 0;
+		break;
+	}
+	return r;
+}
+
+long kvm_arch_dev_ioctl(struct file *filp,
+			unsigned int ioctl, unsigned long arg)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_set_memory_region(struct kvm *kvm,
+			       struct kvm_userspace_memory_region *mem,
+			       struct kvm_memory_slot old,
+			       int user_alloc)
+{
+	return 0;
+}
+
+int kvm_arch_prepare_memory_region(struct kvm *kvm,
+				   struct kvm_memory_slot *memslot,
+				   struct kvm_memory_slot old,
+				   struct kvm_userspace_memory_region *mem,
+				   int user_alloc)
+{
+	return 0;
+}
+
+void kvm_arch_commit_memory_region(struct kvm *kvm,
+				   struct kvm_userspace_memory_region *mem,
+				   struct kvm_memory_slot old,
+				   int user_alloc)
+{
+}
+
+void kvm_arch_flush_shadow_all(struct kvm *kvm)
+{
+}
+
+void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
+				   struct kvm_memory_slot *slot)
+{
+}
+
+struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
+{
+	int err;
+	struct kvm_vcpu *vcpu;
+
+	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
+	if (!vcpu) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = kvm_vcpu_init(vcpu, kvm, id);
+	if (err)
+		goto free_vcpu;
+
+	return vcpu;
+free_vcpu:
+	kmem_cache_free(kvm_vcpu_cache, vcpu);
+out:
+	return ERR_PTR(err);
+}
+
+void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
+{
+}
+
+void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
+{
+	kvm_arch_vcpu_free(vcpu);
+}
+
+int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+int __attribute_const__ kvm_target_cpu(void)
+{
+	unsigned int midr;
+
+	midr = read_cpuid_id();
+	switch ((midr >> 4) & 0xfff) {
+	case KVM_ARM_TARGET_CORTEX_A15:
+		return KVM_ARM_TARGET_CORTEX_A15;
+	default:
+		return -EINVAL;
+	}
+}
+
+int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
+{
+}
+
+void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+{
+}
+
+void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
+{
+}
+
+int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
+					struct kvm_guest_debug *dbg)
+{
+	return -EINVAL;
+}
+
+
+int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
+				    struct kvm_mp_state *mp_state)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
+				    struct kvm_mp_state *mp_state)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
+{
+	return 0;
+}
+
+int kvm_arch_vcpu_in_guest_mode(struct kvm_vcpu *v)
+{
+	return 0;
+}
+
+int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	return -EINVAL;
+}
+
+long kvm_arch_vcpu_ioctl(struct file *filp,
+			 unsigned int ioctl, unsigned long arg)
+{
+	struct kvm_vcpu *vcpu = filp->private_data;
+	void __user *argp = (void __user *)arg;
+
+	switch (ioctl) {
+	case KVM_ARM_VCPU_INIT: {
+		struct kvm_vcpu_init init;
+
+		if (copy_from_user(&init, argp, sizeof init))
+			return -EFAULT;
+
+		return kvm_vcpu_set_target(vcpu, &init);
+
+	}
+	case KVM_SET_ONE_REG:
+	case KVM_GET_ONE_REG: {
+		struct kvm_one_reg reg;
+		if (copy_from_user(&reg, argp, sizeof(reg)))
+			return -EFAULT;
+		if (ioctl == KVM_SET_ONE_REG)
+			return kvm_arm_set_reg(vcpu, &reg);
+		else
+			return kvm_arm_get_reg(vcpu, &reg);
+	}
+	case KVM_GET_REG_LIST: {
+		struct kvm_reg_list __user *user_list = argp;
+		struct kvm_reg_list reg_list;
+		unsigned n;
+
+		if (copy_from_user(&reg_list, user_list, sizeof reg_list))
+			return -EFAULT;
+		n = reg_list.n;
+		reg_list.n = kvm_arm_num_regs(vcpu);
+		if (copy_to_user(user_list, &reg_list, sizeof reg_list))
+			return -EFAULT;
+		if (n < reg_list.n)
+			return -E2BIG;
+		return kvm_arm_copy_reg_indices(vcpu, user_list->reg);
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
+{
+	return -EINVAL;
+}
+
+long kvm_arch_vm_ioctl(struct file *filp,
+		       unsigned int ioctl, unsigned long arg)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_init(void *opaque)
+{
+	return 0;
+}
+
+void kvm_arch_exit(void)
+{
+}
+
+static int arm_init(void)
+{
+	int rc = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	return rc;
+}
+
+static void __exit arm_exit(void)
+{
+	kvm_exit();
+}
+
+module_init(arm_init);
+module_exit(arm_exit)
diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
new file mode 100644
index 0000000..4b9dad8
--- /dev/null
+++ b/arch/arm/kvm/coproc.c
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+#include <linux/kvm_host.h>
+
+void kvm_reset_coprocs(struct kvm_vcpu *vcpu)
+{
+}
diff --git a/arch/arm/kvm/emulate.c b/arch/arm/kvm/emulate.c
new file mode 100644
index 0000000..690bbb3
--- /dev/null
+++ b/arch/arm/kvm/emulate.c
@@ -0,0 +1,127 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <asm/kvm_emulate.h>
+
+#define REG_OFFSET(_reg) \
+	(offsetof(struct kvm_regs, _reg) / sizeof(u32))
+
+#define USR_REG_OFFSET(_num) REG_OFFSET(usr_regs[_num])
+
+static const unsigned long vcpu_reg_offsets[MODE_SYS + 1][16] = {
+	/* FIQ Registers */
+	{
+		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
+		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
+		USR_REG_OFFSET(6), USR_REG_OFFSET(7),
+		REG_OFFSET(fiq_regs[1]), /* r8 */
+		REG_OFFSET(fiq_regs[1]), /* r9 */
+		REG_OFFSET(fiq_regs[2]), /* r10 */
+		REG_OFFSET(fiq_regs[3]), /* r11 */
+		REG_OFFSET(fiq_regs[4]), /* r12 */
+		REG_OFFSET(fiq_regs[5]), /* r13 */
+		REG_OFFSET(fiq_regs[6]), /* r14 */
+		REG_OFFSET(pc)		 /* r15 */
+	},
+
+	/* IRQ Registers */
+	{
+		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
+		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
+		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
+		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
+		USR_REG_OFFSET(12),
+		REG_OFFSET(irq_regs[0]), /* r13 */
+		REG_OFFSET(irq_regs[1]), /* r14 */
+		REG_OFFSET(pc)	         /* r15 */
+	},
+
+	/* SVC Registers */
+	{
+		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
+		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
+		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
+		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
+		USR_REG_OFFSET(12),
+		REG_OFFSET(svc_regs[0]), /* r13 */
+		REG_OFFSET(svc_regs[1]), /* r14 */
+		REG_OFFSET(pc)		 /* r15 */
+	},
+
+	/* ABT Registers */
+	{
+		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
+		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
+		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
+		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
+		USR_REG_OFFSET(12),
+		REG_OFFSET(abt_regs[0]), /* r13 */
+		REG_OFFSET(abt_regs[1]), /* r14 */
+		REG_OFFSET(pc)	         /* r15 */
+	},
+
+	/* UND Registers */
+	{
+		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
+		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
+		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
+		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
+		USR_REG_OFFSET(12),
+		REG_OFFSET(und_regs[0]), /* r13 */
+		REG_OFFSET(und_regs[1]), /* r14 */
+		REG_OFFSET(pc)	         /* r15 */
+	},
+
+	/* USR Registers */
+	{
+		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
+		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
+		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
+		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
+		USR_REG_OFFSET(12),
+		REG_OFFSET(usr_regs[13]), /* r13 */
+		REG_OFFSET(usr_regs[14]), /* r14 */
+		REG_OFFSET(pc)	          /* r15 */
+	},
+
+	/* SYS Registers */
+	{
+		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
+		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
+		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
+		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
+		USR_REG_OFFSET(12),
+		REG_OFFSET(usr_regs[13]), /* r13 */
+		REG_OFFSET(usr_regs[14]), /* r14 */
+		REG_OFFSET(pc)	          /* r15 */
+	},
+};
+
+/*
+ * Return a pointer to the register number valid in the specified mode of
+ * the virtual CPU.
+ */
+u32 *vcpu_reg_mode(struct kvm_vcpu *vcpu, u8 reg_num, u32 mode)
+{
+	u32 *reg_array = (u32 *)&vcpu->arch.regs;
+
+	BUG_ON(reg_num > 15);
+	BUG_ON(mode > MODE_SYS);
+
+	return reg_array + vcpu_reg_offsets[mode][reg_num];
+}
diff --git a/arch/arm/kvm/exports.c b/arch/arm/kvm/exports.c
new file mode 100644
index 0000000..3e38c95
--- /dev/null
+++ b/arch/arm/kvm/exports.c
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/module.h>
+
+EXPORT_SYMBOL_GPL(smp_send_reschedule);
diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
new file mode 100644
index 0000000..19a5389
--- /dev/null
+++ b/arch/arm/kvm/guest.c
@@ -0,0 +1,211 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/kvm_host.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/fs.h>
+#include <asm/uaccess.h>
+#include <asm/kvm.h>
+#include <asm/kvm_asm.h>
+#include <asm/kvm_emulate.h>
+
+#define VM_STAT(x) { #x, offsetof(struct kvm, stat.x), KVM_STAT_VM }
+#define VCPU_STAT(x) { #x, offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU }
+
+struct kvm_stats_debugfs_item debugfs_entries[] = {
+	{ NULL }
+};
+
+int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+static u64 core_reg_offset_from_id(u64 id)
+{
+	return id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_CORE);
+}
+
+static int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	u32 __user *uaddr = (u32 __user *)(long)reg->addr;
+	struct kvm_regs *regs = &vcpu->arch.regs;
+	u64 off;
+
+	if (KVM_REG_SIZE(reg->id) != 4)
+		return -ENOENT;
+
+	/* Our ID is an index into the kvm_regs struct. */
+	off = core_reg_offset_from_id(reg->id);
+	if (off >= sizeof(*regs) / KVM_REG_SIZE(reg->id))
+		return -ENOENT;
+
+	return put_user(((u32 *)regs)[off], uaddr);
+}
+
+static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	u32 __user *uaddr = (u32 __user *)(long)reg->addr;
+	struct kvm_regs *regs = &vcpu->arch.regs;
+	u64 off, val;
+
+	if (KVM_REG_SIZE(reg->id) != 4)
+		return -ENOENT;
+
+	/* Our ID is an index into the kvm_regs struct. */
+	off = core_reg_offset_from_id(reg->id);
+	if (off >= sizeof(*regs) / KVM_REG_SIZE(reg->id))
+		return -ENOENT;
+
+	if (get_user(val, uaddr) != 0)
+		return -EFAULT;
+
+	if (off == KVM_REG_ARM_CORE_REG(cpsr)) {
+		if (__vcpu_mode(val) == 0xf)
+			return -EINVAL;
+	}
+
+	((u32 *)regs)[off] = val;
+	return 0;
+}
+
+int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+{
+	return -EINVAL;
+}
+
+static unsigned long num_core_regs(void)
+{
+	return sizeof(struct kvm_regs) / sizeof(u32);
+}
+
+/**
+ * kvm_arm_num_regs - how many registers do we present via KVM_GET_ONE_REG
+ *
+ * This is for all registers.
+ */
+unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
+{
+	return num_core_regs();
+}
+
+/**
+ * kvm_arm_copy_reg_indices - get indices of all registers.
+ *
+ * We do core registers right here, then we apppend coproc regs.
+ */
+int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
+{
+	unsigned int i;
+	const u64 core_reg = KVM_REG_ARM | KVM_REG_SIZE_U32 | KVM_REG_ARM_CORE;
+
+	for (i = 0; i < sizeof(struct kvm_regs)/sizeof(u32); i++) {
+		if (put_user(core_reg | i, uindices))
+			return -EFAULT;
+		uindices++;
+	}
+
+	return 0;
+}
+
+int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	/* We currently use nothing arch-specific in upper 32 bits */
+	if ((reg->id & ~KVM_REG_SIZE_MASK) >> 32 != KVM_REG_ARM >> 32)
+		return -EINVAL;
+
+	/* Register group 16 means we want a core register. */
+	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
+		return get_core_reg(vcpu, reg);
+
+	return -EINVAL;
+}
+
+int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	/* We currently use nothing arch-specific in upper 32 bits */
+	if ((reg->id & ~KVM_REG_SIZE_MASK) >> 32 != KVM_REG_ARM >> 32)
+		return -EINVAL;
+
+	/* Register group 16 means we set a core register. */
+	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
+		return set_core_reg(vcpu, reg);
+
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
+				  struct kvm_sregs *sregs)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
+				  struct kvm_sregs *sregs)
+{
+	return -EINVAL;
+}
+
+int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
+			const struct kvm_vcpu_init *init)
+{
+	unsigned int i;
+
+	/* We can only do a cortex A15 for now. */
+	if (init->target != kvm_target_cpu())
+		return -EINVAL;
+
+	vcpu->arch.target = init->target;
+	bitmap_zero(vcpu->arch.features, NUM_FEATURES);
+
+	/* -ENOENT for unknown features, -EINVAL for invalid combinations. */
+	for (i = 0; i < sizeof(init->features)*8; i++) {
+		if (init->features[i / 32] & (1 << (i % 32))) {
+			if (i >= NUM_FEATURES)
+				return -ENOENT;
+			set_bit(i, vcpu->arch.features);
+		}
+	}
+
+	/* Now we know what it is, we can reset it. */
+	return kvm_reset_vcpu(vcpu);
+}
+
+int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
+				  struct kvm_translation *tr)
+{
+	return -EINVAL;
+}
diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
new file mode 100644
index 0000000..1dc8926
--- /dev/null
+++ b/arch/arm/kvm/init.S
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+#include <asm/asm-offsets.h>
+#include <asm/kvm_asm.h>
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
new file mode 100644
index 0000000..1dc8926
--- /dev/null
+++ b/arch/arm/kvm/interrupts.S
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+#include <asm/asm-offsets.h>
+#include <asm/kvm_asm.h>
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
new file mode 100644
index 0000000..10ed464
--- /dev/null
+++ b/arch/arm/kvm/mmu.c
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
new file mode 100644
index 0000000..290a13d
--- /dev/null
+++ b/arch/arm/kvm/reset.c
@@ -0,0 +1,74 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kvm_host.h>
+#include <linux/kvm.h>
+
+#include <asm/unified.h>
+#include <asm/ptrace.h>
+#include <asm/cputype.h>
+#include <asm/kvm_arm.h>
+#include <asm/kvm_coproc.h>
+
+/******************************************************************************
+ * Cortex-A15 Reset Values
+ */
+
+static const int a15_max_cpu_idx = 3;
+
+static struct kvm_regs a15_regs_reset = {
+	.cpsr = SVC_MODE | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT,
+};
+
+
+/*******************************************************************************
+ * Exported reset function
+ */
+
+/**
+ * kvm_reset_vcpu - sets core registers and cp15 registers to reset value
+ * @vcpu: The VCPU pointer
+ *
+ * This function finds the right table above and sets the registers on the
+ * virtual CPU struct to their architectually defined reset values.
+ */
+int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct kvm_regs *cpu_reset;
+
+	switch (vcpu->arch.target) {
+	case KVM_ARM_TARGET_CORTEX_A15:
+		if (vcpu->vcpu_id > a15_max_cpu_idx)
+			return -EINVAL;
+		cpu_reset = &a15_regs_reset;
+		vcpu->arch.midr = read_cpuid_id();
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	/* Reset core registers */
+	memcpy(&vcpu->arch.regs, cpu_reset, sizeof(vcpu->arch.regs));
+
+	/* Reset CP15 registers */
+	kvm_reset_coprocs(vcpu);
+
+	return 0;
+}
diff --git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h
new file mode 100644
index 0000000..f8869c1
--- /dev/null
+++ b/arch/arm/kvm/trace.h
@@ -0,0 +1,52 @@
+#if !defined(_TRACE_KVM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_KVM_H
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kvm
+
+/*
+ * Tracepoints for entry/exit to guest
+ */
+TRACE_EVENT(kvm_entry,
+	TP_PROTO(unsigned long vcpu_pc),
+	TP_ARGS(vcpu_pc),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	vcpu_pc		)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc		= vcpu_pc;
+	),
+
+	TP_printk("PC: 0x%08lx", __entry->vcpu_pc)
+);
+
+TRACE_EVENT(kvm_exit,
+	TP_PROTO(unsigned long vcpu_pc),
+	TP_ARGS(vcpu_pc),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	vcpu_pc		)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc		= vcpu_pc;
+	),
+
+	TP_printk("PC: 0x%08lx", __entry->vcpu_pc)
+);
+
+
+
+#endif /* _TRACE_KVM_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH arch/arm/kvm
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index d808694..a960f66 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -911,6 +911,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_SET_ONE_REG		  _IOW(KVMIO,  0xac, struct kvm_one_reg)
 /* VM is being stopped by host */
 #define KVM_KVMCLOCK_CTRL	  _IO(KVMIO,   0xad)
+#define KVM_ARM_VCPU_INIT	  _IOW(KVMIO,  0xae, struct kvm_vcpu_init)
+#define KVM_GET_REG_LIST	  _IOWR(KVMIO, 0xb0, struct kvm_reg_list)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
