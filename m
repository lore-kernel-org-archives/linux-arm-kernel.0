From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Thu,  8 Sep 2016 14:53:23 +0100
Subject: [PATCH 7/8] arm64: compat: Use vDSO sigreturn trampolines if available
In-Reply-To: <20160908135324.7112-1-kevin.brodsky@arm.com>
References: <20160908135324.7112-1-kevin.brodsky@arm.com>
Message-ID: <20160908135324.7112-8-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the compat vDSO is enabled, it replaces the vector page. Therefore,
we use the sigreturn trampolines it provides instead of those in the
vector page.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
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
index 9de7d128e0e0..b72a4180a531 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -28,6 +28,7 @@
 #include <asm/signal32.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
+#include <asm/vdso.h>
 
 struct compat_vfp_sigframe {
 	compat_ulong_t	magic;
@@ -438,6 +439,19 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		retcode = ptr_to_compat(ka->sa.sa_restorer);
 	} else {
 		/* Set up sigreturn pointer */
+#ifdef CONFIG_VDSO32
+		void *vdso_page = current->mm->context.vdso;
+		void *trampoline =
+			(ka->sa.sa_flags & SA_SIGINFO
+			 ? (thumb
+			    ? VDSO_SYMBOL(vdso_page, compat_rt_sigreturn_thumb)
+			    : VDSO_SYMBOL(vdso_page, compat_rt_sigreturn_arm))
+			 : (thumb
+			    ? VDSO_SYMBOL(vdso_page, compat_sigreturn_thumb)
+			    : VDSO_SYMBOL(vdso_page, compat_sigreturn_arm)));
+
+		retcode = ptr_to_compat(trampoline) + thumb;
+#else
 		unsigned int idx = thumb << 1;
 
 		if (ka->sa.sa_flags & SA_SIGINFO)
@@ -446,6 +460,7 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		retcode = AARCH32_VECTORS_BASE +
 			  AARCH32_KERN_SIGRET_CODE_OFFSET +
 			  (idx << 2) + thumb;
+#endif
 	}
 
 	regs->regs[0]	= usig;
-- 
2.8.2
