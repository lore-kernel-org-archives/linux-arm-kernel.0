From: salyzyn@android.com (Mark Salyzyn)
Date: Wed, 15 Nov 2017 14:05:11 -0800
Subject: [PATCH 1/6] arm64: compat: Use vDSO sigreturn trampolines if available
In-Reply-To: <20171115220529.14458-1-salyzyn@android.com>
References: <20171115220529.14458-1-salyzyn@android.com>
Message-ID: <20171115220529.14458-2-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

If the compat vDSO is enabled, it replaces the sigreturn page.
Therefore, we use the sigreturn trampolines the vDSO provides instead.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm64/include/asm/vdso.h |  3 +++
 arch/arm64/kernel/signal32.c  | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 839ce0031bd5..f2a952338f1e 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -28,6 +28,9 @@
 #ifndef __ASSEMBLY__
 
 #include <generated/vdso-offsets.h>
+#ifdef CONFIG_VDSO32
+#include <generated/vdso32-offsets.h>
+#endif
 
 #define VDSO_SYMBOL(base, name)						   \
 ({									   \
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 4f0c0aa14cba..37095782622d 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -28,6 +28,7 @@
 #include <asm/signal32.h>
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
+#include <asm/vdso.h>
 
 struct compat_vfp_sigframe {
 	compat_ulong_t	magic;
@@ -433,6 +434,19 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		retcode = ptr_to_compat(ka->sa.sa_restorer);
 	} else {
 		/* Set up sigreturn pointer */
+#ifdef CONFIG_VDSO32
+		void *vdso_base = current->mm->context.vdso;
+		void *trampoline =
+			(ka->sa.sa_flags & SA_SIGINFO
+			 ? (thumb
+			    ? VDSO_SYMBOL(vdso_base, compat_rt_sigreturn_thumb)
+			    : VDSO_SYMBOL(vdso_base, compat_rt_sigreturn_arm))
+			 : (thumb
+			    ? VDSO_SYMBOL(vdso_base, compat_sigreturn_thumb)
+			    : VDSO_SYMBOL(vdso_base, compat_sigreturn_arm)));
+
+		retcode = ptr_to_compat(trampoline) + thumb;
+#else
 		void *sigreturn_base = current->mm->context.vdso;
 		unsigned int idx = thumb << 1;
 
@@ -440,6 +454,7 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 			idx += 3;
 
 		retcode = ptr_to_compat(sigreturn_base) + (idx << 2) + thumb;
+#endif
 	}
 
 	regs->regs[0]	= usig;
-- 
2.15.0.448.gf294e3d99a-goog
