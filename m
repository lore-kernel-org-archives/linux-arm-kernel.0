From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 18 Feb 2016 17:27:38 +0000
Subject: [PATCH] arm64: kasan: clear stale stack poison
Message-ID: <1455816458-19485-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is a followup to the discussion in [1].

When using KASAN and CPU idle and/or CPU hotplug, KASAN leaves the stack shadow
poisoned on exit from the kernel, and this poison is later hit when a CPU is
brought online and reuses that portion of the stack. Hitting the poison depends
on stackframe layout, so the bug only manifests in some configurations.

I think that the hotplug issue is generic, and x86 is affected. I couldn't spot
magic around idle, so x86 may be fine there. It would be great if someone
familiar with the x86 code could prove/disprove either of those assertions.

If x86 is affected, it likely makes sense to unpoison the stack in common code
prior to bringing a CPU online to avoid that.

For idle I'm not keen on having to perform a memset of THREAD_SIZE/8 every time
a CPU re-enters the kernel. I don't yet have numbers for how bad that is, but
it doesn't sound good.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/408961.html

---->8----
When a CPU is shut down or placed into a low power state, the functions
on the critical path to firmware never return, and hence their epilogues
never execute. When using KASAN, this means that the shadow entries for
the corresponding stack are poisoned but never unpoisoned. When a CPU
subsequently re-enters the kernel via another path, and begins using
the stack, it may hit stale poison values, leading to false-positive
KASAN failures.

We can't ensure that all functions on the critical path are not
instrumented. For CPU hotplug this includes lots of core code starting
from secondary_start_kernel, and for CPU idle we can't ensure that
specific functions are not instrumented, as the compiler always poisons
the stack even when told to not instrument a function:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69863

This patch works around the issue by forcefully unpoisoning the shadow
region for all stack on the critical path, before we return to
instrumented C code. As we cannot statically determine the stack usage
of code in the critical path, we must clear the shadow for all remaining
stack, meaning that we must clear up to 2K of shadow memory each time a
CPU enters the kernel from idle or hotplug.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/kasan.h  | 40 ++++++++++++++++++++++++++++++++++------
 arch/arm64/kernel/asm-offsets.c |  1 +
 arch/arm64/kernel/head.S        |  2 ++
 arch/arm64/kernel/sleep.S       |  2 ++
 4 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index 2774fa3..b75b171 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -1,10 +1,30 @@
 #ifndef __ASM_KASAN_H
 #define __ASM_KASAN_H
 
-#ifndef __ASSEMBLY__
-
+#ifndef LINKER_SCRIPT
 #ifdef CONFIG_KASAN
 
+#ifdef __ASSEMBLY__
+
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+
+	/*
+	 * Remove stale shadow posion for the stack left over from a prior
+	 * hot-unplug or idle exit, covering up to offset bytes above the
+	 * current stack pointer. Shadow poison above this is preserved.
+	 */
+	.macro kasan_unpoison_stack offset=0
+	add	x1, sp, #\offset
+	and	x0, x1, #~(THREAD_SIZE - 1)
+	add	x0, x0, #THREAD_INFO_SIZE
+	and	x1, x1, #(THREAD_SIZE - 1)
+	sub	x1, x1, #THREAD_INFO_SIZE
+	bl	kasan_unpoison_shadow
+	.endm
+
+#else /* __ASSEMBLY__ */
+
 #include <linux/linkage.h>
 #include <asm/memory.h>
 
@@ -30,9 +50,17 @@
 void kasan_init(void);
 asmlinkage void kasan_early_init(void);
 
-#else
+#endif /* __ASSEMBLY__ */
+
+#else /* CONFIG_KASAN */
+
+#ifdef __ASSEMBLY__
+	.macro kasan_unpoison_stack offset
+	.endm
+#else /* __ASSEMBLY */
 static inline void kasan_init(void) { }
-#endif
+#endif /* __ASSEMBLY__ */
 
-#endif
-#endif
+#endif /* CONFIG_KASAN */
+#endif /* LINKER_SCRIPT */
+#endif /* __ASM_KASAN_H */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index fffa4ac6..c615fa3 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -39,6 +39,7 @@ int main(void)
   DEFINE(TI_ADDR_LIMIT,		offsetof(struct thread_info, addr_limit));
   DEFINE(TI_TASK,		offsetof(struct thread_info, task));
   DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
+  DEFINE(THREAD_INFO_SIZE,	sizeof(struct thread_info));
   BLANK();
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
   BLANK();
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index ffe9c2b..a0c3ec7 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -29,6 +29,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 #include <asm/cputype.h>
+#include <asm/kasan.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
@@ -611,6 +612,7 @@ ENTRY(__secondary_switched)
 	and	x0, x0, #~(THREAD_SIZE - 1)
 	msr	sp_el0, x0			// save thread_info
 	mov	x29, #0
+	kasan_unpoison_stack
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
 
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index e33fe33..3b95841 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -2,6 +2,7 @@
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
+#include <asm/kasan.h>
 
 	.text
 /*
@@ -145,6 +146,7 @@ ENTRY(cpu_resume_mmu)
 ENDPROC(cpu_resume_mmu)
 	.popsection
 cpu_resume_after_mmu:
+	kasan_unpoison_stack 96
 	mov	x0, #0			// return zero on success
 	ldp	x19, x20, [sp, #16]
 	ldp	x21, x22, [sp, #32]
-- 
1.9.1
