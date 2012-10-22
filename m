From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 22 Oct 2012 02:49:25 -0400
Subject: [PATCH v3 04/14] KVM: ARM: Initial skeleton to compile KVM support
In-Reply-To: <20121022064831.18444.73273.stgit@ubuntu>
References: <20121022064831.18444.73273.stgit@ubuntu>
Message-ID: <20121022064924.18444.76189.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Targets KVM support for Cortex A-15 processors.

Contains all the framework components, make files, header files, some
tracing functionality, and basic user space API.

Only supported core is Cortex-A15 for now.

Most functionality is in arch/arm/kvm/* or arch/arm/include/asm/kvm_*.h.

Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Rusty Russell <rusty.russell@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 Documentation/virtual/kvm/api.txt  |   58 ++++++
 arch/arm/Kconfig                   |    2 
 arch/arm/Makefile                  |    1 
 arch/arm/include/asm/kvm_arm.h     |   24 +++
 arch/arm/include/asm/kvm_asm.h     |   58 ++++++
 arch/arm/include/asm/kvm_coproc.h  |   24 +++
 arch/arm/include/asm/kvm_emulate.h |   50 +++++
 arch/arm/include/asm/kvm_host.h    |  120 +++++++++++++
 arch/arm/include/uapi/asm/kvm.h    |   83 +++++++++
 arch/arm/kvm/Kconfig               |   44 +++++
 arch/arm/kvm/Makefile              |   21 ++
 arch/arm/kvm/arm.c                 |  343 ++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/coproc.c              |   22 ++
 arch/arm/kvm/emulate.c             |  151 ++++++++++++++++
 arch/arm/kvm/guest.c               |  221 +++++++++++++++++++++++
 arch/arm/kvm/init.S                |   19 ++
 arch/arm/kvm/interrupts.S          |   19 ++
 arch/arm/kvm/mmu.c                 |   17 ++
 arch/arm/kvm/reset.c               |   74 ++++++++
 arch/arm/kvm/trace.h               |   52 +++++
 include/uapi/linux/kvm.h           |    7 +
 21 files changed, 1406 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_arm.h
 create mode 100644 arch/arm/include/asm/kvm_asm.h
 create mode 100644 arch/arm/include/asm/kvm_coproc.h
 create mode 100644 arch/arm/include/asm/kvm_emulate.h
 create mode 100644 arch/arm/include/asm/kvm_host.h
 create mode 100644 arch/arm/include/uapi/asm/kvm.h
 create mode 100644 arch/arm/kvm/Kconfig
 create mode 100644 arch/arm/kvm/Makefile
 create mode 100644 arch/arm/kvm/arm.c
 create mode 100644 arch/arm/kvm/coproc.c
 create mode 100644 arch/arm/kvm/emulate.c
 create mode 100644 arch/arm/kvm/guest.c
 create mode 100644 arch/arm/kvm/init.S
 create mode 100644 arch/arm/kvm/interrupts.S
 create mode 100644 arch/arm/kvm/mmu.c
 create mode 100644 arch/arm/kvm/reset.c
 create mode 100644 arch/arm/kvm/trace.h

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 4258180..b56bbd5 100644
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
@@ -1774,6 +1775,14 @@ registers, find a list below:
   PPC   | KVM_REG_PPC_VPA_SLB   | 128
   PPC   | KVM_REG_PPC_VPA_DTL   | 128
 
+ARM registers are mapped using the lower 32 bits.  The upper 16 of that
+is the register group type, or coprocessor number:
+
+ARM core registers have the following id bit patterns:
+  0x4002 0000 0010 <index into the kvm_regs struct:16>
+
+
+
 4.69 KVM_GET_ONE_REG
 
 Capability: KVM_CAP_ONE_REG
@@ -1791,6 +1800,7 @@ The list of registers accessible using this interface is identical to the
 list in 4.68.
 
 
+
 4.70 KVM_KVMCLOCK_CTRL
 
 Capability: KVM_CAP_KVMCLOCK_CTRL
@@ -2072,6 +2082,46 @@ KVM_S390_INT_EXTERNAL_CALL (vcpu) - sigp external call; source cpu in parm
 Note that the vcpu ioctl is asynchronous to vcpu execution.
 
 
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
index 73067ef..263d47a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2310,3 +2310,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "arch/arm/kvm/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index f023e3a..361a683 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -256,6 +256,7 @@ core-$(CONFIG_XEN)		+= arch/arm/xen/
 core-y				+= arch/arm/kernel/ arch/arm/mm/ arch/arm/common/
 core-y				+= arch/arm/net/
 core-y				+= arch/arm/crypto/
+core-y 				+= arch/arm/kvm/
 core-y				+= $(machdirs) $(platdirs)
 
 drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/
diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
new file mode 100644
index 0000000..c196a22
--- /dev/null
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -0,0 +1,24 @@
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
+#include <asm/types.h>
+
+#endif /* __ARM_KVM_ARM_H__ */
diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
new file mode 100644
index 0000000..48ddf99
--- /dev/null
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -0,0 +1,58 @@
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
+/* 0 is reserved as an invalid value. */
+#define c0_MPIDR	1	/* MultiProcessor ID Register */
+#define c0_CSSELR	2	/* Cache Size Selection Register */
+#define c1_SCTLR	3	/* System Control Register */
+#define c1_ACTLR	4	/* Auxilliary Control Register */
+#define c1_CPACR	5	/* Coprocessor Access Control */
+#define c2_TTBR0	6	/* Translation Table Base Register 0 */
+#define c2_TTBR0_high	7	/* TTBR0 top 32 bits */
+#define c2_TTBR1	8	/* Translation Table Base Register 1 */
+#define c2_TTBR1_high	9	/* TTBR1 top 32 bits */
+#define c2_TTBCR	10	/* Translation Table Base Control R. */
+#define c3_DACR		11	/* Domain Access Control Register */
+#define c5_DFSR		12	/* Data Fault Status Register */
+#define c5_IFSR		13	/* Instruction Fault Status Register */
+#define c5_ADFSR	14	/* Auxilary Data Fault Status R */
+#define c5_AIFSR	15	/* Auxilary Instrunction Fault Status R */
+#define c6_DFAR		16	/* Data Fault Address Register */
+#define c6_IFAR		17	/* Instruction Fault Address Register */
+#define c9_L2CTLR	18	/* Cortex A15 L2 Control Register */
+#define c10_PRRR	19	/* Primary Region Remap Register */
+#define c10_NMRR	20	/* Normal Memory Remap Register */
+#define c12_VBAR	21	/* Vector Base Address Register */
+#define c13_CID		22	/* Context ID Register */
+#define c13_TID_URW	23	/* Thread ID, User R/W */
+#define c13_TID_URO	24	/* Thread ID, User R/O */
+#define c13_TID_PRIV	25	/* Thread ID, Priveleged */
+#define NR_CP15_REGS	26	/* Number of regs (incl. invalid) */
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
index 0000000..7d3e904
--- /dev/null
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -0,0 +1,50 @@
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
+u32 *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num);
+u32 *vcpu_spsr(struct kvm_vcpu *vcpu);
+
+static inline u32 *vcpu_pc(struct kvm_vcpu *vcpu)
+{
+	return &vcpu->arch.regs.pc;
+}
+
+static inline u32 *vcpu_cpsr(struct kvm_vcpu *vcpu)
+{
+	return &vcpu->arch.regs.cpsr;
+}
+
+static inline bool mode_has_spsr(struct kvm_vcpu *vcpu)
+{
+	unsigned long cpsr_mode = vcpu->arch.regs.cpsr & MODE_MASK;
+	return (cpsr_mode > USR_MODE && cpsr_mode < SYSTEM_MODE);
+}
+
+static inline bool vcpu_mode_priv(struct kvm_vcpu *vcpu)
+{
+	unsigned long cpsr_mode = vcpu->arch.regs.cpsr & MODE_MASK;
+	return cpsr_mode > USR_MODE;;
+}
+
+#endif /* __ARM_KVM_EMULATE_H__ */
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
new file mode 100644
index 0000000..15d4c0b
--- /dev/null
+++ b/arch/arm/include/asm/kvm_host.h
@@ -0,0 +1,120 @@
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
+#include <asm/kvm_asm.h>
+
+#define KVM_MAX_VCPUS NR_CPUS
+#define KVM_MEMORY_SLOTS 32
+#define KVM_PRIVATE_MEM_SLOTS 4
+#define KVM_COALESCED_MMIO_PAGE_OFFSET 1
+
+#define KVM_VCPU_MAX_FEATURES 0
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
+	/* VTTBR value associated with below pgd and vmid */
+	u64    vttbr;
+
+	/*
+	 * Anything that is not used directly from assembly code goes
+	 * here.
+	 */
+
+	/* The VMID generation used for the virt. memory system */
+	u64    vmid_gen;
+	u32    vmid;
+
+	/* Stage-2 page table */
+	pgd_t *pgd;
+};
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
+struct kvm_vcpu_arch {
+	struct kvm_regs regs;
+
+	int target; /* Processor target */
+	DECLARE_BITMAP(features, KVM_VCPU_MAX_FEATURES);
+
+	/* System control coprocessor (cp15) */
+	u32 cp15[NR_CP15_REGS];
+
+	/* The CPU type we expose to the VM */
+	u32 midr;
+
+	/* Exception Information */
+	u32 hsr;		/* Hyp Syndrom Register */
+	u32 hxfar;		/* Hyp Data/Inst Fault Address Register */
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
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
new file mode 100644
index 0000000..bfc2123
--- /dev/null
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -0,0 +1,83 @@
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
+#define KVM_ARM_TARGET_CORTEX_A15	0
+#define KVM_ARM_NUM_TARGETS		1
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
index 0000000..7acf3ea
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
+obj-$(CONFIG_KVM_ARM_HOST) += init.o interrupts.o
+
+obj-$(CONFIG_KVM_ARM_HOST) += $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
+
+obj-$(CONFIG_KVM_ARM_HOST) += arm.o guest.o mmu.o emulate.o reset.o coproc.o
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
new file mode 100644
index 0000000..ead5a4e
--- /dev/null
+++ b/arch/arm/kvm/arm.c
@@ -0,0 +1,343 @@
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
+	unsigned long implementor = read_cpuid_implementor();
+	unsigned long part_number = read_cpuid_part_number();
+
+	if (implementor != IMPLEMENTOR_ARM)
+		return -EINVAL;
+
+	switch (part_number) {
+	case PART_NUMBER_CORTEX_A15:
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
+/* NOP: Compiling as a module not supported */
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
+module_init(arm_init);
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
index 0000000..4e25b65
--- /dev/null
+++ b/arch/arm/kvm/emulate.c
@@ -0,0 +1,151 @@
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
+#define VCPU_NR_MODES 6
+#define REG_OFFSET(_reg) \
+	(offsetof(struct kvm_regs, _reg) / sizeof(u32))
+
+#define USR_REG_OFFSET(_num) REG_OFFSET(usr_regs[_num])
+
+static const unsigned long vcpu_reg_offsets[VCPU_NR_MODES][15] = {
+	/* USR/SYS Registers */
+	{
+		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
+		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
+		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
+		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
+		USR_REG_OFFSET(12), USR_REG_OFFSET(13),	USR_REG_OFFSET(14),
+	},
+
+	/* FIQ Registers */
+	{
+		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
+		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
+		USR_REG_OFFSET(6), USR_REG_OFFSET(7),
+		REG_OFFSET(fiq_regs[0]), /* r8 */
+		REG_OFFSET(fiq_regs[1]), /* r9 */
+		REG_OFFSET(fiq_regs[2]), /* r10 */
+		REG_OFFSET(fiq_regs[3]), /* r11 */
+		REG_OFFSET(fiq_regs[4]), /* r12 */
+		REG_OFFSET(fiq_regs[5]), /* r13 */
+		REG_OFFSET(fiq_regs[6]), /* r14 */
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
+	},
+};
+
+/*
+ * Return a pointer to the register number valid in the current mode of
+ * the virtual CPU.
+ */
+u32 *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num)
+{
+	u32 *reg_array = (u32 *)&vcpu->arch.regs;
+	u32 mode = *vcpu_cpsr(vcpu) & MODE_MASK;
+
+	BUG_ON(reg_num >= 15);
+
+	switch (mode) {
+	case USR_MODE...SVC_MODE:
+		mode &= ~MODE32_BIT; /* 0 ... 3 */
+		break;
+
+	case ABT_MODE:
+		mode = 4;
+		break;
+
+	case UND_MODE:
+		mode = 5;
+		break;
+
+	case SYSTEM_MODE:
+		mode = 0;
+		break;
+
+	default:
+		BUG();
+	}
+
+	return reg_array + vcpu_reg_offsets[mode][reg_num];
+}
+
+/*
+ * Return the SPSR for the current mode of the virtual CPU.
+ */
+u32 *vcpu_spsr(struct kvm_vcpu *vcpu)
+{
+	u32 mode = *vcpu_cpsr(vcpu) & MODE_MASK;
+	switch (mode) {
+	case SVC_MODE:
+		return &vcpu->arch.regs.svc_regs[2];
+	case ABT_MODE:
+		return &vcpu->arch.regs.abt_regs[2];
+	case UND_MODE:
+		return &vcpu->arch.regs.und_regs[2];
+	case IRQ_MODE:
+		return &vcpu->arch.regs.irq_regs[2];
+	case FIQ_MODE:
+		return &vcpu->arch.regs.fiq_regs[7];
+	default:
+		BUG();
+	}
+}
diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
new file mode 100644
index 0000000..4fd0467
--- /dev/null
+++ b/arch/arm/kvm/guest.c
@@ -0,0 +1,221 @@
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
+		unsigned long mode = val & MODE_MASK;
+		switch (mode) {
+		case USR_MODE:
+		case FIQ_MODE:
+		case IRQ_MODE:
+		case SVC_MODE:
+		case ABT_MODE:
+		case UND_MODE:
+			break;
+		default:
+			return -EINVAL;
+		}
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
+	bitmap_zero(vcpu->arch.features, KVM_VCPU_MAX_FEATURES);
+
+	/* -ENOENT for unknown features, -EINVAL for invalid combinations. */
+	for (i = 0; i < sizeof(init->features)*8; i++) {
+		if (init->features[i / 32] & (1 << (i % 32))) {
+			if (i >= KVM_VCPU_MAX_FEATURES)
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
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 65ad5c6..ba9feed 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -759,6 +759,11 @@ struct kvm_dirty_tlb {
 #define KVM_REG_SIZE_U512	0x0060000000000000ULL
 #define KVM_REG_SIZE_U1024	0x0070000000000000ULL
 
+struct kvm_reg_list {
+	__u64 n; /* number of regs */
+	__u64 reg[0];
+};
+
 struct kvm_one_reg {
 	__u64 id;
 	__u64 addr;
@@ -925,6 +930,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_SET_ONE_REG		  _IOW(KVMIO,  0xac, struct kvm_one_reg)
 /* VM is being stopped by host */
 #define KVM_KVMCLOCK_CTRL	  _IO(KVMIO,   0xad)
+#define KVM_ARM_VCPU_INIT	  _IOW(KVMIO,  0xae, struct kvm_vcpu_init)
+#define KVM_GET_REG_LIST	  _IOWR(KVMIO, 0xb0, struct kvm_reg_list)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
