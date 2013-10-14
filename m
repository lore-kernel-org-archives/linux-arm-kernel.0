From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 14 Oct 2013 12:03:00 +0100
Subject: [PATCH v2 03/13] arm64: kernel: suspend/resume registers save/restore
In-Reply-To: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1381748590-14279-4-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Power management software requires the kernel to save and restore
CPU registers while going through suspend and resume operations
triggered by kernel subsystems like CPU idle and suspend to RAM.

This patch implements code that provides save and restore mechanism
for the arm v8 implementation. Memory for the context is passed as
parameter to both cpu_do_suspend and cpu_do_resume functions, and allows
the callers to implement context allocation as they deem fit.

The registers that are saved and restored correspond to the registers set
actually required by the kernel to be up and running which represents a
subset of v8 ISA.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/proc-fns.h      |  3 ++
 arch/arm64/include/asm/suspend.h       | 27 ++++++++++++
 arch/arm64/include/asm/suspendmacros.h | 75 ++++++++++++++++++++++++++++++++++
 arch/arm64/mm/proc.S                   | 30 ++++++++++++++
 4 files changed, 135 insertions(+)
 create mode 100644 arch/arm64/include/asm/suspend.h
 create mode 100644 arch/arm64/include/asm/suspendmacros.h

diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
index 7cdf466..0c657bb 100644
--- a/arch/arm64/include/asm/proc-fns.h
+++ b/arch/arm64/include/asm/proc-fns.h
@@ -26,11 +26,14 @@
 #include <asm/page.h>
 
 struct mm_struct;
+struct cpu_suspend_ctx;
 
 extern void cpu_cache_off(void);
 extern void cpu_do_idle(void);
 extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
 extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
+extern void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
+extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
 
 #include <asm/memory.h>
 
diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
new file mode 100644
index 0000000..2b9f1a9
--- /dev/null
+++ b/arch/arm64/include/asm/suspend.h
@@ -0,0 +1,27 @@
+#ifndef __ASM_SUSPEND_H
+#define __ASM_SUSPEND_H
+
+/*
+ * struct cpu_suspend_ctx must be 16-byte aligned since it is allocated on
+ * the stack, which must be 16-byte aligned on v8
+ */
+struct cpu_suspend_ctx {
+	/*
+	 * This struct must be kept in sync with
+	 * suspend_save_ctx/suspend_restore_ctx
+	 * macros in asm/suspendmacros.h
+	 */
+	struct {
+		u64 tpidr_el0;
+		u64 tpidrro_el0;
+		u64 contextidr_el1;
+		u64 mair_el1;
+		u64 cpacr_el1;
+		u64 ttbr1_el1;
+		u64 tcr_el1;
+		u64 vbar_el1;
+		u64 sctlr_el1;
+	} ctx_regs;
+	u64 sp;
+} __aligned(16);
+#endif
diff --git a/arch/arm64/include/asm/suspendmacros.h b/arch/arm64/include/asm/suspendmacros.h
new file mode 100644
index 0000000..9203e76
--- /dev/null
+++ b/arch/arm64/include/asm/suspendmacros.h
@@ -0,0 +1,75 @@
+/*
+ * suspend state saving and restoring macros
+ *
+ * Copyright (C) 2013 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
+/*
+ * suspend_save_ctx - save registers required to suspend a cpu
+ *
+ * x0: register where context base address is stored
+ * macro clobbers {x2 - x10}
+ *
+ * Registers to be saved must be kept consistent with
+ * struct cpu_suspend_ctx
+ */
+.macro suspend_save_ctx
+	mrs	x2, tpidr_el0
+	mrs	x3, tpidrro_el0
+	mrs	x4, contextidr_el1
+	mrs	x5, mair_el1
+	mrs	x6, cpacr_el1
+	mrs	x7, ttbr1_el1
+	mrs	x8, tcr_el1
+	mrs	x9, vbar_el1
+	mrs	x10, sctlr_el1
+	stp	x2, x3, [x0]
+	stp	x4, x5, [x0, #16]
+	stp	x6, x7, [x0, #32]
+	stp	x8, x9, [x0, #48]
+	str	x10, [x0, #64]
+.endm
+
+/*
+ * suspend_restore_ctx - restore registers required to suspend a cpu
+ *
+ * x0: register where context base address is stored
+ * x1: ttbr0_el1 value to be restored
+ *
+ * Upon completion x0 contains saved sctlr_el1
+ *
+ * macro clobbers {x2 - x10}
+ *
+ * Registers to be restored must be kept consistent with
+ * struct cpu_suspend_ctx
+ */
+.macro suspend_restore_ctx
+	ldp	x2, x3, [x0]
+	ldp	x4, x5, [x0, #16]
+	ldp	x6, x7, [x0, #32]
+	ldp	x8, x9, [x0, #48]
+	ldr	x10, [x0, #64]
+	msr	tpidr_el0, x2
+	msr	tpidrro_el0, x3
+	msr	contextidr_el1, x4
+	msr	mair_el1, x5
+	msr	cpacr_el1, x6
+	msr	ttbr0_el1, x1
+	msr	ttbr1_el1, x7
+	msr	tcr_el1, x8
+	msr	vbar_el1, x9
+	mov	x0, x10
+.endm
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index b1b31bb..6ee3b99 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -25,6 +25,7 @@
 #include <asm/hwcap.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
+#include <asm/suspendmacros.h>
 
 #include "proc-macros.S"
 
@@ -80,6 +81,35 @@ ENTRY(cpu_do_idle)
 	ret
 ENDPROC(cpu_do_idle)
 
+#ifdef CONFIG_ARM64_CPU_SUSPEND
+/**
+ * cpu_do_suspend - save CPU registers context
+ * x0: virtual address of context pointer
+ */
+ENTRY(cpu_do_suspend)
+	suspend_save_ctx
+	ret
+ENDPROC(cpu_do_suspend)
+
+/**
+ * cpu_do_resume - restore CPU register context
+ *
+ *
+ * x0: Physical address of context pointer
+ * x1: ttbr0_el1 to be restored
+ *
+ * Returns:
+ *	sctlr_el1 value in x0
+ */
+ENTRY(cpu_do_resume)
+	tlbi	vmalle1is	// make sure tlb entries are invalidated
+	suspend_restore_ctx
+	isb
+	dsb	sy
+	ret
+ENDPROC(cpu_do_resume)
+#endif
+
 /*
  *	cpu_switch_mm(pgd_phys, tsk)
  *
-- 
1.8.4
