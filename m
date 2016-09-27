From: panand@redhat.com (Pratyush Anand)
Date: Tue, 27 Sep 2016 13:18:00 +0530
Subject: [PATCH V2 6/6] arm64: Add uprobe support
In-Reply-To: <cover.1474960629.git.panand@redhat.com>
References: <cover.1474960629.git.panand@redhat.com>
Message-ID: <41cc70043792e65cbc3b4cc4ad7fbf6379afa550.1474960629.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for uprobe on ARM64 architecture.

Unit tests for following have been done so far and they have been found
working
    1. Step-able instructions, like sub, ldr, add etc.
    2. Simulation-able like ret, cbnz, cbz etc.
    3. uretprobe
    4. Reject-able instructions like sev, wfe etc.
    5. trapped and abort xol path
    6. probe at unaligned user address.
    7. longjump test cases

Currently it does not support aarch32 instruction probing.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/Kconfig                      |   3 +
 arch/arm64/include/asm/cacheflush.h     |   1 +
 arch/arm64/include/asm/debug-monitors.h |   3 +
 arch/arm64/include/asm/ptrace.h         |   8 ++
 arch/arm64/include/asm/thread_info.h    |   5 +-
 arch/arm64/include/asm/uprobes.h        |  36 ++++++
 arch/arm64/kernel/probes/Makefile       |   2 +
 arch/arm64/kernel/probes/uprobes.c      | 221 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal.c              |   3 +
 arch/arm64/mm/flush.c                   |   2 +-
 10 files changed, 282 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/uprobes.h
 create mode 100644 arch/arm64/kernel/probes/uprobes.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 113326e637f0..2bee1b0b99af 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -236,6 +236,9 @@ config PGTABLE_LEVELS
 	default 3 if ARM64_16K_PAGES && ARM64_VA_BITS_47
 	default 4 if !ARM64_64K_PAGES && ARM64_VA_BITS_48
 
+config ARCH_SUPPORTS_UPROBES
+	def_bool y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 2e5fb976a572..e9f64ecb75ce 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -71,6 +71,7 @@ extern void __flush_dcache_area(void *addr, size_t len);
 extern void __clean_dcache_area_poc(void *addr, size_t len);
 extern void __clean_dcache_area_pou(void *addr, size_t len);
 extern long __flush_cache_user_range(unsigned long start, unsigned long end);
+extern void sync_icache_aliases(void *kaddr, unsigned long len);
 
 static inline void flush_cache_mm(struct mm_struct *mm)
 {
diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index b71420a12f26..a44cf5225429 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -68,6 +68,9 @@
 #define BRK64_ESR_MASK		0xFFFF
 #define BRK64_ESR_KPROBES	0x0004
 #define BRK64_OPCODE_KPROBES	(AARCH64_BREAK_MON | (BRK64_ESR_KPROBES << 5))
+/* uprobes BRK opcodes with ESR encoding  */
+#define BRK64_ESR_UPROBES	0x0005
+#define BRK64_OPCODE_UPROBES	(AARCH64_BREAK_MON | (BRK64_ESR_UPROBES << 5))
 
 /* AArch32 */
 #define DBG_ESR_EVT_BKPT	0x4
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index ada08b5b036d..513daf050e84 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -217,6 +217,14 @@ int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task);
 
 #include <asm-generic/ptrace.h>
 
+#define procedure_link_pointer(regs)	((regs)->regs[30])
+
+static inline void procedure_link_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	procedure_link_pointer(regs) = val;
+}
+
 #undef profile_pc
 extern unsigned long profile_pc(struct pt_regs *regs);
 
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index e9ea5a6bd449..f6859831462e 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -112,6 +112,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_NEED_RESCHED	1
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
+#define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
 #define TIF_NOHZ		7
 #define TIF_SYSCALL_TRACE	8
 #define TIF_SYSCALL_AUDIT	9
@@ -132,10 +133,12 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
+#define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_32BIT		(1 << TIF_32BIT)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
-				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE)
+				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
+				 _TIF_UPROBE)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
diff --git a/arch/arm64/include/asm/uprobes.h b/arch/arm64/include/asm/uprobes.h
new file mode 100644
index 000000000000..8d004073d0e8
--- /dev/null
+++ b/arch/arm64/include/asm/uprobes.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright (C) 2014-2016 Pratyush Anand <panand@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ASM_UPROBES_H
+#define _ASM_UPROBES_H
+
+#include <asm/debug-monitors.h>
+#include <asm/insn.h>
+#include <asm/probes.h>
+
+#define MAX_UINSN_BYTES		AARCH64_INSN_SIZE
+
+#define UPROBE_SWBP_INSN	BRK64_OPCODE_UPROBES
+#define UPROBE_SWBP_INSN_SIZE	AARCH64_INSN_SIZE
+#define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES
+
+typedef u32 uprobe_opcode_t;
+
+struct arch_uprobe_task {
+};
+
+struct arch_uprobe {
+	union {
+		u8 insn[MAX_UINSN_BYTES];
+		u8 ixol[MAX_UINSN_BYTES];
+	};
+	struct arch_probe_insn api;
+	bool simulate;
+};
+
+#endif
diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
index ce06312e3d34..89b6df613dde 100644
--- a/arch/arm64/kernel/probes/Makefile
+++ b/arch/arm64/kernel/probes/Makefile
@@ -1,3 +1,5 @@
 obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
 				   kprobes_trampoline.o		\
 				   simulate-insn.o
+obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o	\
+				   simulate-insn.o
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
new file mode 100644
index 000000000000..d30d13040346
--- /dev/null
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -0,0 +1,221 @@
+/*
+ * Copyright (C) 2014-2016 Pratyush Anand <panand@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/highmem.h>
+#include <linux/ptrace.h>
+#include <linux/uprobes.h>
+#include <asm/cacheflush.h>
+
+#include "decode-insn.h"
+
+#define UPROBE_INV_FAULT_CODE	UINT_MAX
+
+bool is_trap_insn(uprobe_opcode_t *insn)
+{
+	return false;
+}
+
+void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
+		void *src, unsigned long len)
+{
+	void *xol_page_kaddr = kmap_atomic(page);
+	void *dst = xol_page_kaddr + (vaddr & ~PAGE_MASK);
+
+	/* Initialize the slot */
+	memcpy(dst, src, len);
+
+	/* flush caches (dcache/icache) */
+	sync_icache_aliases(dst, len);
+
+	kunmap_atomic(xol_page_kaddr);
+}
+
+unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
+{
+	return instruction_pointer(regs);
+}
+
+int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
+		unsigned long addr)
+{
+	probe_opcode_t insn;
+
+	/* TODO: Currently we do not support AARCH32 instruction probing */
+	if (test_bit(TIF_32BIT, &mm->context.flags))
+		return -EINVAL;
+	else if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
+		return -EINVAL;
+
+	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
+
+	switch (arm_probe_decode_insn(insn, &auprobe->api)) {
+	case INSN_REJECTED:
+		return -EINVAL;
+
+	case INSN_GOOD_NO_SLOT:
+		auprobe->simulate = true;
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	struct uprobe_task *utask = current->utask;
+
+	/* Initialize with an invalid fault code to detect if ol insn trapped */
+	current->thread.fault_code = UPROBE_INV_FAULT_CODE;
+
+	/* Instruction points to execute ol */
+	instruction_pointer_set(regs, utask->xol_vaddr);
+
+	user_enable_single_step(current);
+
+	return 0;
+}
+
+int arch_uprobe_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	struct uprobe_task *utask = current->utask;
+
+	WARN_ON_ONCE(current->thread.fault_code != UPROBE_INV_FAULT_CODE);
+
+	/* Instruction points to execute next to breakpoint address */
+	instruction_pointer_set(regs, utask->vaddr + 4);
+
+	user_disable_single_step(current);
+
+	return 0;
+}
+bool arch_uprobe_xol_was_trapped(struct task_struct *t)
+{
+	/*
+	 * Between arch_uprobe_pre_xol and arch_uprobe_post_xol, if an xol
+	 * insn itself is trapped, then detect the case with the help of
+	 * invalid fault code which is being set in arch_uprobe_pre_xol
+	 */
+	if (t->thread.fault_code != UPROBE_INV_FAULT_CODE)
+		return true;
+
+	return false;
+}
+
+bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	probe_opcode_t insn;
+	unsigned long addr;
+
+	if (!auprobe->simulate)
+		return false;
+
+	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
+	addr = instruction_pointer(regs);
+
+	if (auprobe->api.handler)
+		auprobe->api.handler(insn, addr, regs);
+
+	return true;
+}
+
+void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	struct uprobe_task *utask = current->utask;
+
+	/*
+	 * Task has received a fatal signal, so reset back to probbed
+	 * address.
+	 */
+	instruction_pointer_set(regs, utask->vaddr);
+
+	user_disable_single_step(current);
+}
+
+bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
+		struct pt_regs *regs)
+{
+	/*
+	 * If a simple branch instruction (B) was called for retprobed
+	 * assembly label then return true even when regs->sp and ret->stack
+	 * are same. It will ensure that cleanup and reporting of return
+	 * instances corresponding to callee label is done when
+	 * handle_trampoline for called function is executed.
+	 */
+	if (ctx == RP_CHECK_CHAIN_CALL)
+		return regs->sp <= ret->stack;
+	else
+		return regs->sp < ret->stack;
+}
+
+unsigned long
+arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
+				  struct pt_regs *regs)
+{
+	unsigned long orig_ret_vaddr;
+
+	orig_ret_vaddr = procedure_link_pointer(regs);
+	/* Replace the return addr with trampoline addr */
+	procedure_link_pointer_set(regs, trampoline_vaddr);
+
+	return orig_ret_vaddr;
+}
+
+int arch_uprobe_exception_notify(struct notifier_block *self,
+				 unsigned long val, void *data)
+{
+	return NOTIFY_DONE;
+}
+
+static int uprobe_breakpoint_handler(struct pt_regs *regs,
+		unsigned int esr)
+{
+	if (user_mode(regs) && uprobe_pre_sstep_notifier(regs))
+		return DBG_HOOK_HANDLED;
+
+	return DBG_HOOK_ERROR;
+}
+
+static int uprobe_single_step_handler(struct pt_regs *regs,
+		unsigned int esr)
+{
+	struct uprobe_task *utask = current->utask;
+
+	if (user_mode(regs)) {
+		WARN_ON(utask &&
+			(instruction_pointer(regs) != utask->xol_vaddr + 4));
+
+		if (uprobe_post_sstep_notifier(regs))
+			return DBG_HOOK_HANDLED;
+	}
+
+	return DBG_HOOK_ERROR;
+}
+
+/* uprobe breakpoint handler hook */
+static struct break_hook uprobes_break_hook = {
+	.esr_mask = BRK64_ESR_MASK,
+	.esr_val = BRK64_ESR_UPROBES,
+	.fn = uprobe_breakpoint_handler,
+};
+
+/* uprobe single step handler hook */
+static struct step_hook uprobes_step_hook = {
+	.fn = uprobe_single_step_handler,
+};
+
+static int __init arch_init_uprobes(void)
+{
+	register_break_hook(&uprobes_break_hook);
+	register_step_hook(&uprobes_step_hook);
+
+	return 0;
+}
+
+device_initcall(arch_init_uprobes);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 404dd67080b9..c7b6de62f9d3 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -414,6 +414,9 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 		} else {
 			local_irq_enable();
 
+			if (thread_flags & _TIF_UPROBE)
+				uprobe_notify_resume(regs);
+
 			if (thread_flags & _TIF_SIGPENDING)
 				do_signal(regs);
 
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 8377329d8c97..2d78d5a9b89f 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -32,7 +32,7 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
 		__flush_icache_all();
 }
 
-static void sync_icache_aliases(void *kaddr, unsigned long len)
+void sync_icache_aliases(void *kaddr, unsigned long len)
 {
 	unsigned long addr = (unsigned long)kaddr;
 
-- 
2.7.4
