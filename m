From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 21 Nov 2013 11:24:10 +0000
Subject: [PATCH RFC v3 03/12] arm64: kernel: suspend/resume registers
 save/restore
In-Reply-To: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1385033059-25896-4-git-send-email-lorenzo.pieralisi@arm.com>
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
 arch/arm64/include/asm/proc-fns.h |  3 ++
 arch/arm64/include/asm/suspend.h  | 18 ++++++++++
 arch/arm64/mm/proc.S              | 69 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 arch/arm64/include/asm/suspend.h

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
index 0000000..a88558e
--- /dev/null
+++ b/arch/arm64/include/asm/suspend.h
@@ -0,0 +1,18 @@
+#ifndef __ASM_SUSPEND_H
+#define __ASM_SUSPEND_H
+
+#define NR_CTX_REGS 11
+
+/*
+ * struct cpu_suspend_ctx must be 16-byte aligned since it is allocated on
+ * the stack, which must be 16-byte aligned on v8
+ */
+struct cpu_suspend_ctx {
+	/*
+	 * This struct must be kept in sync with
+	 * cpu_do_{suspend/resume} in mm/proc.S
+	 */
+	u64 ctx_regs[NR_CTX_REGS];
+	u64 sp;
+} __aligned(16);
+#endif
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 421b99f..ef91046 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -80,6 +80,75 @@ ENTRY(cpu_do_idle)
 	ret
 ENDPROC(cpu_do_idle)
 
+#ifdef CONFIG_ARM64_CPU_SUSPEND
+/**
+ * cpu_do_suspend - save CPU registers context
+ *
+ * x0: virtual address of context pointer
+ */
+ENTRY(cpu_do_suspend)
+	mrs	x2, tpidr_el0
+	mrs	x3, tpidrro_el0
+	mrs	x4, contextidr_el1
+	mrs	x5, mair_el1
+	mrs	x6, cpacr_el1
+	mrs	x7, ttbr1_el1
+	mrs	x8, tcr_el1
+	mrs	x9, vbar_el1
+	mrs	x10, mdscr_el1
+	mrs	x11, oslsr_el1
+	mrs	x12, sctlr_el1
+	stp	x2, x3, [x0]
+	stp	x4, x5, [x0, #16]
+	stp	x6, x7, [x0, #32]
+	stp	x8, x9, [x0, #48]
+	stp	x10, x11, [x0, #64]
+	str	x12, [x0, #80]
+	ret
+ENDPROC(cpu_do_suspend)
+
+/**
+ * cpu_do_resume - restore CPU register context
+ *
+ * x0: Physical address of context pointer
+ * x1: ttbr0_el1 to be restored
+ *
+ * Returns:
+ *	sctlr_el1 value in x0
+ */
+ENTRY(cpu_do_resume)
+	/*
+	 * Invalidate local tlb entries before turning on MMU
+	 */
+	tlbi	vmalle1
+	ldp	x2, x3, [x0]
+	ldp	x4, x5, [x0, #16]
+	ldp	x6, x7, [x0, #32]
+	ldp	x8, x9, [x0, #48]
+	ldp	x10, x11, [x0, #64]
+	ldr	x12, [x0, #80]
+	msr	tpidr_el0, x2
+	msr	tpidrro_el0, x3
+	msr	contextidr_el1, x4
+	msr	mair_el1, x5
+	msr	cpacr_el1, x6
+	msr	ttbr0_el1, x1
+	msr	ttbr1_el1, x7
+	msr	tcr_el1, x8
+	msr	vbar_el1, x9
+	msr	mdscr_el1, x10
+	/*
+	 * Restore oslsr_el1 by writing oslar_el1
+	 */
+	ubfx	x11, x11, #1, #1
+	msr	oslar_el1, x11
+	mov	x0, x12
+	dsb	nsh		// Make sure local tlb invalidation completed
+	isb
+	ret
+ENDPROC(cpu_do_resume)
+#endif
+
 /*
  *	cpu_switch_mm(pgd_phys, tsk)
  *
-- 
1.8.4
