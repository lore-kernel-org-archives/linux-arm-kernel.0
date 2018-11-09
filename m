From: vincenzo.frascino@arm.com (Vincenzo Frascino)
Date: Fri,  9 Nov 2018 12:37:17 +0000
Subject: [PATCH 14/27] arm64: compat: Generate asm offsets for signals
In-Reply-To: <20181109123730.8743-1-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
Message-ID: <20181109123730.8743-15-vincenzo.frascino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates asm-offsets for arm64 to generate the correct offsets
for compat signals.

They will be useful for the implementation of the compat sigreturn
trampolines in vDSO context.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/signal32.h | 14 +++++++++++++-
 arch/arm64/kernel/asm-offsets.c   |  6 ++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index 1f05268f4c6d..a6fd7be1b22a 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -52,7 +52,7 @@ struct compat_ucontext {
 	compat_stack_t			uc_stack;
 	struct compat_sigcontext	uc_mcontext;
 	compat_sigset_t			uc_sigmask;
-	int 				__unused[32 - (sizeof(compat_sigset_t) / sizeof(int))];
+	int				__unused[32 - (sizeof(compat_sigset_t) / sizeof(int))];
 	compat_ulong_t			uc_regspace[128] __attribute__((__aligned__(8)));
 };
 
@@ -66,6 +66,18 @@ struct compat_rt_sigframe {
 	struct compat_sigframe sig;
 };
 
+/* Macros for asm-offsets.c */
+#define OFFSET_OF_COMPAT_SIGFRAME_REGS (				\
+			offsetof(struct compat_sigframe, uc) +		\
+			offsetof(struct compat_ucontext, uc_mcontext) +	\
+			offsetof(struct compat_sigcontext, arm_r0))
+
+#define OFFSET_OF_COMPAT_RT_SIGFRAME_REGS (				\
+			offsetof(struct compat_rt_sigframe, sig) +	\
+			offsetof(struct compat_sigframe, uc) +		\
+			offsetof(struct compat_ucontext, uc_mcontext) +	\
+			offsetof(struct compat_sigcontext, arm_r0))
+
 int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 		       struct pt_regs *regs);
 int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 06cfd2363a86..4f8317c23908 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -30,6 +30,7 @@
 #include <asm/fixmap.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
+#include <asm/signal32.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <linux/kbuild.h>
@@ -81,6 +82,11 @@ int main(void)
   DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
+#ifdef CONFIG_COMPAT
+  DEFINE(COMPAT_SIGFRAME_REGS_OFFSET,		OFFSET_OF_COMPAT_SIGFRAME_REGS);
+  DEFINE(COMPAT_RT_SIGFRAME_REGS_OFFSET,	OFFSET_OF_COMPAT_RT_SIGFRAME_REGS);
+  BLANK();
+#endif
   DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id.counter));
   BLANK();
   DEFINE(VMA_VM_MM,		offsetof(struct vm_area_struct, vm_mm));
-- 
2.19.1
