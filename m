From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Nov 2017 22:20:04 +0000
Subject: do page fault in atomic bug on arm
In-Reply-To: <20171124202553.GV31757@n2100.armlinux.org.uk>
References: <d83cdbf1-0d27-fb82-14c8-3d37101c3c06@linaro.org>
 <20171121132001.GH31757@n2100.armlinux.org.uk>
 <64cbcda0-d040-4872-4a6b-7cd18375b4aa@linaro.org>
 <20171124192700.GU31757@n2100.armlinux.org.uk>
 <20171124202553.GV31757@n2100.armlinux.org.uk>
Message-ID: <20171124222004.GW31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 08:25:53PM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 24, 2017 at 07:27:00PM +0000, Russell King - ARM Linux wrote:
> > Adding Tixy, as he's more knowledgable in this area - I suggest
> > someone knowledgable in this area runs
> > 
> > 	ftracetest test.d/kprobe/multiple_kprobes.tc
> > 
> > and fixes these bugs... also running the entire ftracetest suite
> > would probably also be a very good idea.
> 
> There's some other stupidities as well:
> 
> trace_kprobe: Inserting kprobe at __error_lpae+0
> trace_kprobe: Inserting kprobe at str_lpae+0
> trace_kprobe: Inserting kprobe at __error_p+0
> trace_kprobe: Inserting kprobe at str_p1+0
> trace_kprobe: Inserting kprobe at str_p2+0
> trace_kprobe: Could not insert probe at str_p2+0: -22
> 
> str_lpae: .asciz "\nError: Kernel with LPAE support, but CPU does not support LPAE.\n"
> str_p1: .asciz  "\nError: unrecognized/unsupported processor variant (0x"
> str_p2: .asciz  ").\n"
> 
> So we successfully placed a kprobe on some ASCII strings, which are
> used prior to the kernel being properly up and running, which means
> we have to use relative references to these strings, and relative
> references to strings in other sections is not simple.
> 
> More worrying:
> 
> trace_kprobe: Inserting kprobe at __turn_mmu_on+0
> trace_kprobe: Inserting kprobe at __idmap_text_start+0
> trace_kprobe: Inserting kprobe at __turn_mmu_on_end+0
> ...
> trace_kprobe: Inserting kprobe at __idmap_text_end+0
> ...
> trace_kprobe: Inserting kprobe at secondary_startup+0
> trace_kprobe: Inserting kprobe at secondary_startup_arm+0
> trace_kprobe: Inserting kprobe at __secondary_switched+0
> trace_kprobe: Inserting kprobe at __secondary_data+0
> trace_kprobe: Inserting kprobe at __enable_mmu+0
> trace_kprobe: Inserting kprobe at __do_fixup_smp_on_up+0
> trace_kprobe: Inserting kprobe at __fixup_a_pv_table+0
> trace_kprobe: Inserting kprobe at fixup_pv_table+0
> trace_kprobe: Inserting kprobe at __lookup_processor_type+0
> trace_kprobe: Inserting kprobe at __lookup_processor_type_data+0
> 
> These are definitely a no-no for tracing, because they're part of the
> early startup code for the kernel when no stacks are available.
> 
> Some of these can't live in the special "do not use kprobes here"
> section as they need to be in other sections (like .idmap) because
> they need to be part of the identity-mapped code.

Okay, this is what I came up with, and seems to solve the problem
here.  It's quite a large patch though, as it shuffles around how
we deal with exception entry, and knowing whether we should dump
the stacked registers.  This particular patch also contains a few
debugging bits too.

 arch/arm/include/asm/exception.h |  3 +--
 arch/arm/include/asm/sections.h  | 21 +++++++++++++++++++++
 arch/arm/include/asm/traps.h     | 12 ------------
 arch/arm/kernel/entry-armv.S     |  6 +-----
 arch/arm/kernel/entry-common.S   |  1 +
 arch/arm/kernel/entry-header.S   | 13 +++++++++++++
 arch/arm/kernel/head-common.S    | 12 ++++++------
 arch/arm/kernel/head.S           |  2 +-
 arch/arm/kernel/stacktrace.c     | 14 ++------------
 arch/arm/kernel/traps.c          |  4 ++--
 arch/arm/kernel/vmlinux.lds.S    |  6 +++---
 arch/arm/mm/fault.c              |  5 ++---
 arch/arm/probes/kprobes/core.c   | 14 +++++++++++---
 kernel/trace/trace_kprobe.c      |  3 +++
 14 files changed, 67 insertions(+), 49 deletions(-)

diff --git a/arch/arm/include/asm/exception.h b/arch/arm/include/asm/exception.h
index a7273ad9587a..58e039a851af 100644
--- a/arch/arm/include/asm/exception.h
+++ b/arch/arm/include/asm/exception.h
@@ -10,11 +10,10 @@
 
 #include <linux/interrupt.h>
 
-#define __exception	__attribute__((section(".exception.text")))
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 #define __exception_irq_entry	__irq_entry
 #else
-#define __exception_irq_entry	__exception
+#define __exception_irq_entry
 #endif
 
 #endif /* __ASM_ARM_EXCEPTION_H */
diff --git a/arch/arm/include/asm/sections.h b/arch/arm/include/asm/sections.h
index 63dfe1f10335..4ceb4f757d4d 100644
--- a/arch/arm/include/asm/sections.h
+++ b/arch/arm/include/asm/sections.h
@@ -6,4 +6,25 @@
 
 extern char _exiprom[];
 
+extern char __idmap_text_start[];
+extern char __idmap_text_end[];
+extern char __entry_text_start[];
+extern char __entry_text_end[];
+extern char __hyp_idmap_text_start[];
+extern char __hyp_idmap_text_end[];
+
+static inline bool in_entry_text(unsigned long addr)
+{
+	return memory_contains(__entry_text_start, __entry_text_end,
+			       (void *)addr, 1);
+}
+
+static inline bool in_idmap_text(unsigned long addr)
+{
+	void *a = (void *)addr;
+	return memory_contains(__idmap_text_start, __idmap_text_end, a, 1) ||
+	       memory_contains(__hyp_idmap_text_start, __hyp_idmap_text_end,
+			       a, 1);
+}
+
 #endif	/* _ASM_ARM_SECTIONS_H */
diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index f9a6c5fc3fd1..a00288d75ee6 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -28,18 +28,6 @@ static inline int __in_irqentry_text(unsigned long ptr)
 	       ptr < (unsigned long)&__irqentry_text_end;
 }
 
-static inline int in_exception_text(unsigned long ptr)
-{
-	extern char __exception_text_start[];
-	extern char __exception_text_end[];
-	int in;
-
-	in = ptr >= (unsigned long)&__exception_text_start &&
-	     ptr < (unsigned long)&__exception_text_end;
-
-	return in ? : __in_irqentry_text(ptr);
-}
-
 extern void __init early_trap_init(void *);
 extern void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame);
 extern void ptrace_break(struct task_struct *tsk, struct pt_regs *regs);
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 10ad44f3886a..b8ab97dfdd17 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -82,11 +82,7 @@
 #endif
 	.endm
 
-#ifdef CONFIG_KPROBES
-	.section	.kprobes.text,"ax",%progbits
-#else
-	.text
-#endif
+	.section	.entry.text,"ax",%progbits
 
 /*
  * Invalid mode handlers
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index e655dcd0a933..3c4f88701f22 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -37,6 +37,7 @@ saved_pc	.req	lr
 #define TRACE(x...)
 #endif
 
+	.section .entry.text,"ax",%progbits
 	.align	5
 #if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING))
 /*
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index d523cd8439a3..e2d216ad70f0 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -300,6 +300,8 @@
 	mov	r2, sp
 	ldr	r1, [r2, #\offset + S_PSR]	@ get calling cpsr
 	ldr	lr, [r2, #\offset + S_PC]!	@ get pc
+	tst	r1, #0xcf
+	bne	oops
 	msr	spsr_cxsf, r1			@ save in spsr_svc
 #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_32v6K)
 	@ We must avoid clrex due to Cortex-A15 erratum #830321
@@ -314,6 +316,17 @@
 						@ after ldm {}^
 	add	sp, sp, #\offset + PT_REGS_SIZE
 	movs	pc, lr				@ return & move spsr_svc into cpsr
+oops:	.word	0xe7f001f2
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+	.pushsection .rodata.str, "aMS", %progbits, 1
+2:	.asciz	"Returning to usermode but unexpected PSR bits set?"
+	.popsection
+	.pushsection __bug_table, "aw"
+	.align	2
+	.word	oops, 2b
+	.hword	\@
+	.popsection
+#endif
 #elif defined(CONFIG_CPU_V7M)
 	@ V7M restore.
 	@ Note that we don't need to do clrex here as clearing the local
diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 21dde771a7dd..a989d84c4c38 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -201,10 +201,10 @@ ENDPROC(__lookup_processor_type)
 
 __error_lpae:
 #ifdef CONFIG_DEBUG_LL
-	adr	r0, str_lpae
+	adr	r0, 1f
 	bl 	printascii
 	b	__error
-str_lpae: .asciz "\nError: Kernel with LPAE support, but CPU does not support LPAE.\n"
+1:	.asciz	"\nError: Kernel with LPAE support, but CPU does not support LPAE.\n"
 #else
 	b	__error
 #endif
@@ -213,15 +213,15 @@ ENDPROC(__error_lpae)
 
 __error_p:
 #ifdef CONFIG_DEBUG_LL
-	adr	r0, str_p1
+	adr	r0, 1f
 	bl	printascii
 	mov	r0, r9
 	bl	printhex8
-	adr	r0, str_p2
+	adr	r0, 2f
 	bl	printascii
 	b	__error
-str_p1:	.asciz	"\nError: unrecognized/unsupported processor variant (0x"
-str_p2:	.asciz	").\n"
+1:	.asciz	"\nError: unrecognized/unsupported processor variant (0x"
+2:	.asciz	").\n"
 	.align
 #endif
 ENDPROC(__error_p)
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 6b1148cafffd..7ea72ce41329 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -415,7 +415,7 @@ ENDPROC(secondary_startup_arm)
 	/*
 	 * r6  = &secondary_data
 	 */
-ENTRY(__secondary_switched)
+__secondary_switched:
 	ldr	sp, [r7, #12]			@ get secondary_data.stack
 	mov	fp, #0
 	b	secondary_start_kernel
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 65228bf4c6df..a56e7c856ab5 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -3,6 +3,7 @@
 #include <linux/sched/debug.h>
 #include <linux/stacktrace.h>
 
+#include <asm/sections.h>
 #include <asm/stacktrace.h>
 #include <asm/traps.h>
 
@@ -63,7 +64,6 @@ EXPORT_SYMBOL(walk_stackframe);
 #ifdef CONFIG_STACKTRACE
 struct stack_trace_data {
 	struct stack_trace *trace;
-	unsigned long last_pc;
 	unsigned int no_sched_functions;
 	unsigned int skip;
 };
@@ -87,16 +87,7 @@ static int save_trace(struct stackframe *frame, void *d)
 	if (trace->nr_entries >= trace->max_entries)
 		return 1;
 
-	/*
-	 * in_exception_text() is designed to test if the PC is one of
-	 * the functions which has an exception stack above it, but
-	 * unfortunately what is in frame->pc is the return LR value,
-	 * not the saved PC value.  So, we need to track the previous
-	 * frame PC value when doing this.
-	 */
-	addr = data->last_pc;
-	data->last_pc = frame->pc;
-	if (!in_exception_text(addr))
+	if (!in_entry_text(frame->pc))
 		return 0;
 
 	regs = (struct pt_regs *)frame->sp;
@@ -114,7 +105,6 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 	struct stackframe frame;
 
 	data.trace = trace;
-	data.last_pc = ULONG_MAX;
 	data.skip = trace->skip;
 	data.no_sched_functions = nosched;
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 5de2bc46153f..95978073db53 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -73,7 +73,7 @@ void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long
 	printk("Function entered at [<%08lx>] from [<%08lx>]\n", where, from);
 #endif
 
-	if (in_exception_text(where))
+	if (in_entry_text(from))
 		dump_mem("", "Exception stack", frame + 4, frame + 4 + sizeof(struct pt_regs));
 }
 
@@ -434,7 +434,7 @@ static int call_undef_hook(struct pt_regs *regs, unsigned int instr)
 	return fn ? fn(regs, instr) : 1;
 }
 
-asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
+asmlinkage void do_undefinstr(struct pt_regs *regs)
 {
 	unsigned int instr;
 	siginfo_t info;
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index ee53f6518872..84a1ae3ce46e 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -105,9 +105,9 @@ SECTIONS
 	.text : {			/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
 			IDMAP_TEXT
-			__exception_text_start = .;
-			*(.exception.text)
-			__exception_text_end = .;
+			__entry_text_start = .;
+			*(.entry.text)
+			__entry_text_end = .;
 			IRQENTRY_TEXT
 			SOFTIRQENTRY_TEXT
 			TEXT_TEXT
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 42f585379e19..b75eada23d0a 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -21,7 +21,6 @@
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
 
-#include <asm/exception.h>
 #include <asm/pgtable.h>
 #include <asm/system_misc.h>
 #include <asm/system_info.h>
@@ -545,7 +544,7 @@ hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *)
 /*
  * Dispatch a data abort to the relevant handler.
  */
-asmlinkage void __exception
+asmlinkage void
 do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
 	const struct fsr_info *inf = fsr_info + fsr_fs(fsr);
@@ -578,7 +577,7 @@ hook_ifault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *
 	ifsr_info[nr].name = name;
 }
 
-asmlinkage void __exception
+asmlinkage void
 do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 {
 	const struct fsr_info *inf = ifsr_info + fsr_fs(ifsr);
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 52d1cd14fda4..e90cc8a08186 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -32,6 +32,7 @@
 #include <linux/percpu.h>
 #include <linux/bug.h>
 #include <asm/patch.h>
+#include <asm/sections.h>
 
 #include "../decode-arm.h"
 #include "../decode-thumb.h"
@@ -64,9 +65,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	int is;
 	const struct decode_checker **checkers;
 
-	if (in_exception_text(addr))
-		return -EINVAL;
-
 #ifdef CONFIG_THUMB2_KERNEL
 	thumb = true;
 	addr &= ~1; /* Bit 0 would normally be set to indicate Thumb code */
@@ -680,3 +678,13 @@ int __init arch_init_kprobes()
 #endif
 	return 0;
 }
+
+bool arch_within_kprobe_blacklist(unsigned long addr)
+{
+	void *a = (void *)addr;
+
+	return __in_irqentry_text(addr) ||
+	       in_entry_text(addr) ||
+	       in_idmap_text(addr) ||
+	       memory_contains(__kprobes_text_start, __kprobes_text_end, a, 1);
+}
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 8a907e12b6b9..b0a7068afa2d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -472,6 +472,9 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 	else
 		tk->rp.kp.flags |= KPROBE_FLAG_DISABLED;
 
+	pr_info("Inserting kprobe at %s+%lu\n",
+			trace_kprobe_symbol(tk), trace_kprobe_offset(tk));
+
 	if (trace_kprobe_is_return(tk))
 		ret = register_kretprobe(&tk->rp);
 	else


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
