From: huawei.libin@huawei.com (Li Bin)
Date: Thu, 28 May 2015 13:51:03 +0800
Subject: [RFC PATCH 3/5] livepatch: ftrace: arm64: Add support for -mfentry on
 arm64
In-Reply-To: <1432792265-24076-1-git-send-email-huawei.libin@huawei.com>
References: <1432792265-24076-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <1432792265-24076-4-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch depends on the compiler's mfentry feature for arm64 that
proposed by this patchset. If the kernel is compiled with this feature,
the entry of each function like:
   foo:
       mov x9, x30
       bl __fentry__
       mov x30, x9
When -mfentry is used, the call is to '__fentry__' and not '_mcount'
and is done before the function's stack frame is set up. So __fentry__
is responsibel to protect parameter registers and corruptible registers.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 arch/arm64/Kconfig               |    1 +
 arch/arm64/include/asm/ftrace.h  |    5 +++
 arch/arm64/kernel/arm64ksyms.c   |    4 ++
 arch/arm64/kernel/entry-ftrace.S |   59 +++++++++++++++++++++++++++++++++++--
 scripts/recordmcount.pl          |    2 +-
 5 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ea435c9..7bb2468 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -60,6 +60,7 @@ config ARM64
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_FENTRY
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GENERIC_DMA_COHERENT
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index a7722b9..08eab52 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -13,7 +13,11 @@
 
 #include <asm/insn.h>
 
+#ifdef CC_USING_FENTRY
+#define MCOUNT_ADDR		((unsigned long)__fentry__)
+#else
 #define MCOUNT_ADDR		((unsigned long)_mcount)
+#endif
 #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -24,6 +28,7 @@
 #include <linux/compat.h>
 
 extern void _mcount(unsigned long);
+extern void __fentry__(unsigned long);
 extern void *return_address(unsigned int);
 
 struct dyn_arch_ftrace {
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index a85843d..f0455d3 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -63,5 +63,9 @@ EXPORT_SYMBOL(change_bit);
 EXPORT_SYMBOL(test_and_change_bit);
 
 #ifdef CONFIG_FUNCTION_TRACER
+#ifdef CC_USING_FENTRY
+EXPORT_SYMBOL(__fentry__);
+#else
 EXPORT_SYMBOL(_mcount);
 #endif
+#endif
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index fde793b..18cfe5b 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -93,27 +93,57 @@
 	ldr	\reg, [\reg]
 	.endm
 
+	/* for instrumented function's parent */
+	.macro fentry_get_parent_fp reg
+	ldr	\reg, [x29]
+	.endm
+
 	/* for instrumented function */
 	.macro mcount_get_pc0 reg
 	mcount_adjust_addr	\reg, x30
 	.endm
 
+	/* for instrumented function */
+	.macro fentry_get_pc0 reg
+	mcount_adjust_addr	\reg, x30
+	.endm
+
 	.macro mcount_get_pc reg
 	ldr	\reg, [x29, #8]
 	mcount_adjust_addr	\reg, \reg
 	.endm
 
+	.macro fentry_get_pc reg
+	ldr	\reg, [x29, #8]
+	mcount_adjust_addr	\reg, \reg
+	.endm
+
 	.macro mcount_get_lr reg
 	ldr	\reg, [x29]
 	ldr	\reg, [\reg, #8]
 	mcount_adjust_addr	\reg, \reg
 	.endm
 
+	.macro fentry_get_lr reg, base
+	ldr	\reg, [\base, #72]	//S_X9
+	mcount_adjust_addr	\reg, \reg
+	.endm
+
 	.macro mcount_get_lr_addr reg
 	ldr	\reg, [x29]
 	add	\reg, \reg, #8
 	.endm
 
+	.macro fentry_get_lr_addr reg, base
+	add	\reg, \base, #72	//S_X9
+	.endm
+
+#ifdef	CC_USING_FENTRY
+#define	function_hook	__fentry__
+#else
+#define	function_hook	_mcount
+#endif
+
 #ifndef CONFIG_DYNAMIC_FTRACE
 /*
  * void _mcount(unsigned long return_address)
@@ -123,7 +153,7 @@
  *     - tracer function to probe instrumented function's entry,
  *     - ftrace_graph_caller to set up an exit hook
  */
-ENTRY(_mcount)
+ENTRY(function_hook)
 	mcount_enter
 	save_mcount_regs
 
@@ -133,8 +163,13 @@ ENTRY(_mcount)
 	cmp	x0, x2			// if (ftrace_trace_function
 	b.eq	skip_ftrace_call	//     != ftrace_stub) {
 
+#ifdef CC_USING_FENTRY
+	fentry_get_pc	x0		//       function's pc
+	fentry_get_lr	x1, sp		//       function's lr (= parent's pc)
+#else
 	mcount_get_pc	x0		//       function's pc
 	mcount_get_lr	x1		//       function's lr (= parent's pc)
+#endif
 	blr	x2			//   (*ftrace_trace_function)(pc, lr);
 
 #ifndef CONFIG_FUNCTION_GRAPH_TRACER
@@ -161,7 +196,7 @@ skip_ftrace_call:
 	restore_mcount_regs
 	mcount_exit
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-ENDPROC(_mcount)
+ENDPROC(function_hook)
 
 #else /* CONFIG_DYNAMIC_FTRACE */
 /*
@@ -170,9 +205,9 @@ ENDPROC(_mcount)
  * and later on, NOP to branch to ftrace_caller() when enabled or branch to
  * NOP when disabled per-function base.
  */
-ENTRY(_mcount)
+ENTRY(function_hook)
 	ret
-ENDPROC(_mcount)
+ENDPROC(function_hook)
 
 /*
  * void ftrace_caller(unsigned long return_address)
@@ -189,8 +224,13 @@ ENTRY(ftrace_caller)
 
 	adrp	x0, function_trace_op
 	ldr	x2, [x0, #:lo12:function_trace_op]
+#ifdef CC_USING_FENTRY
+	fentry_get_pc0	x0		//     function's pc
+	fentry_get_lr	x1, sp		//     function's lr
+#else
 	mcount_get_pc0	x0		//     function's pc
 	mcount_get_lr	x1		//     function's lr
+#endif
 	mov	x3, #0
 
 	.global ftrace_call
@@ -237,8 +277,13 @@ ENTRY(ftrace_regs_caller)
 
 	adrp	x0, function_trace_op
 	ldr	x2, [x0, #:lo12:function_trace_op]
+#ifdef CC_USING_FENTRY
+	fentry_get_pc0	x0		//     function's pc
+	fentry_get_lr	x1, sp		//     function's lr
+#else
 	mcount_get_pc0	x0		//     function's pc
 	mcount_get_lr	x1		//     function's lr
+#endif
 	mov	x3, sp
 
 	.global ftrace_regs_call
@@ -282,9 +327,15 @@ ENDPROC(ftrace_stub)
  * and run return_to_handler() later on its exit.
  */
 ENTRY(ftrace_graph_caller)
+#ifdef CC_USING_FENTRY
+	fentry_get_lr_addr	x0, sp	//     pointer to function's saved lr
+	fentry_get_pc		x1	//     function's pc
+	fentry_get_parent_fp	x2	//     parent's fp
+#else
 	mcount_get_lr_addr	  x0	//     pointer to function's saved lr
 	mcount_get_pc		  x1	//     function's pc
 	mcount_get_parent_fp	  x2	//     parent's fp
+#endif
 	bl	prepare_ftrace_return	// prepare_ftrace_return(&lr, pc, fp)
 
 	restore_mcount_regs
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 826470d..5020d96 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -279,7 +279,7 @@ if ($arch eq "x86_64") {
 } elsif ($arch eq "arm64") {
     $alignment = 3;
     $section_type = '%progbits';
-    $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_AARCH64_CALL26\\s+_mcount\$";
+    $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_AARCH64_CALL26\\s+(_mcount|__fentry__)\$";
     $type = ".quad";
 } elsif ($arch eq "ia64") {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
-- 
1.7.1
