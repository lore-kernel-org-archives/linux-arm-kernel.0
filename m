From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 13 Nov 2015 07:58:53 +0100
Subject: [PATCH] ARM: PJ4: move coprocessor register access sequences to
 iwmmxt.S
Message-ID: <1447397933-13379-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PJ4 inline asm sequences in pj4-cp0.c cannot be built in Thumb-2 mode,
due to the way it performs arithmetic on the program counter, so it is
built in ARM mode instead. However, building C files in ARM mode under
CONFIG_THUMB2_KERNEL is problematic, since the instrumentation performed
by subsystems like ftrace does not expect having to deal with interworking
branches.

So instead, revert to building pj4-cp0.c in Thumb-2 mode, and move the
offending sequence to iwmmxt.S, which is not instrumented anyway, and is
already built in ARM mode unconditionally.

Reported-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/Makefile  |  1 -
 arch/arm/kernel/iwmmxt.S  | 21 +++++++++++++++++++++
 arch/arm/kernel/pj4-cp0.c | 24 ++----------------------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index af9e59bf3831..3c789496297f 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -73,7 +73,6 @@ obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o perf_callchain.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_xscale.o perf_event_v6.o \
 				   perf_event_v7.o
-CFLAGS_pj4-cp0.o		:= -marm
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
 obj-$(CONFIG_VDSO)		+= vdso.o
diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index 49fadbda8c63..e1776bf52480 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -14,6 +14,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/init.h>
 #include <linux/linkage.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
@@ -370,3 +371,23 @@ ENDPROC(iwmmxt_task_release)
 concan_owner:
 	.word	0
 
+#if defined(CONFIG_CPU_PJ4) || defined(CONFIG_CPU_PJ4B)
+
+	__INIT
+
+ENTRY(pj4_cp_access_read)
+	mrc	p15, 0, r0, c1, c0, 2
+	ret	lr
+ENDPROC(pj4_cp_access_read)
+
+ENTRY(pj4_cp_access_write)
+	mcr	p15, 0, r0, c1, c0, 2
+	mrc	p15, 0, r0, c1, c0, 2
+	mov	r0, r0
+	sub	pc, pc, #4
+	ret	lr
+ENDPROC(pj4_cp_access_write)
+
+	__FINIT
+
+#endif
diff --git a/arch/arm/kernel/pj4-cp0.c b/arch/arm/kernel/pj4-cp0.c
index 8153e36b2491..4f226e175734 100644
--- a/arch/arm/kernel/pj4-cp0.c
+++ b/arch/arm/kernel/pj4-cp0.c
@@ -49,28 +49,8 @@ static struct notifier_block __maybe_unused iwmmxt_notifier_block = {
 	.notifier_call	= iwmmxt_do,
 };
 
-
-static u32 __init pj4_cp_access_read(void)
-{
-	u32 value;
-
-	__asm__ __volatile__ (
-		"mrc	p15, 0, %0, c1, c0, 2\n\t"
-		: "=r" (value));
-	return value;
-}
-
-static void __init pj4_cp_access_write(u32 value)
-{
-	u32 temp;
-
-	__asm__ __volatile__ (
-		"mcr	p15, 0, %1, c1, c0, 2\n\t"
-		"mrc	p15, 0, %0, c1, c0, 2\n\t"
-		"mov	%0, %0\n\t"
-		"sub	pc, pc, #4\n\t"
-		: "=r" (temp) : "r" (value));
-}
+asmlinkage u32 pj4_cp_access_read(void);
+asmlinkage void pj4_cp_access_write(u32 value);
 
 static int __init pj4_get_iwmmxt_version(void)
 {
-- 
1.9.1
