From: alan-jenkins@tuffmail.co.uk (Alan Jenkins)
Date: Fri,  9 Oct 2009 15:02:21 +0100
Subject: [PATCH 5/6] ARM: nwfpe can no longer be built as a module - remove
	dead code (part 1 of 2)
In-Reply-To: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
References: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
Message-ID: <1255096942-10451-5-git-send-email-alan-jenkins@tuffmail.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"ifdef MODULE" and module information will be discarded by the C
preprocessor, and the module_exit function will be discarded by the
linker. Therefore this code is completely dead and should be removed.

Also remove an unused prototype for fp_setup().

Build testing confirms that this does not change the resulting vmlinux.

Signed-off-by: Alan Jenkins <alan-jenkins:tuffmail.co.uk>
Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 arch/arm/nwfpe/fpmodule.c |   33 +++++----------------------------
 1 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/arch/arm/nwfpe/fpmodule.c b/arch/arm/nwfpe/fpmodule.c
index 4c0ab50..9a21f35 100644
--- a/arch/arm/nwfpe/fpmodule.c
+++ b/arch/arm/nwfpe/fpmodule.c
@@ -23,7 +23,7 @@
 
 #include "fpa11.h"
 
-#include <linux/module.h>
+#include <linux/kernel.h>
 
 /* XXX */
 #include <linux/errno.h>
@@ -40,21 +40,13 @@
 #include "fpmodule.h"
 #include "fpa11.inl"
 
-/* kernel symbols required for signal handling */
 #ifdef CONFIG_FPE_NWFPE_XP
 #define NWFPE_BITS "extended"
 #else
 #define NWFPE_BITS "double"
 #endif
 
-#ifdef MODULE
-void fp_send_sig(unsigned long sig, struct task_struct *p, int priv);
-#else
-#define fp_send_sig	send_sig
-#define kern_fp_enter	fp_enter
-
 extern char fpe_type[];
-#endif
 
 static int nwfpe_notify(struct notifier_block *self, unsigned long cmd, void *v)
 {
@@ -70,11 +62,8 @@ static struct notifier_block nwfpe_notifier_block = {
 	.notifier_call = nwfpe_notify,
 };
 
-/* kernel function prototypes required */
-void fp_setup(void);
-
 /* external declarations for saved kernel symbols */
-extern void (*kern_fp_enter)(void);
+extern void (*fp_enter)(void);
 
 /* Original value of fp_enter from kernel before patched by fpe_init. */
 static void (*orig_fp_enter)(void);
@@ -103,19 +92,12 @@ static int __init fpe_init(void)
 	thread_register_notifier(&nwfpe_notifier_block);
 
 	/* Save pointer to the old FP handler and then patch ourselves in */
-	orig_fp_enter = kern_fp_enter;
-	kern_fp_enter = nwfpe_enter;
+	orig_fp_enter = fp_enter;
+	fp_enter = nwfpe_enter;
 
 	return 0;
 }
 
-static void __exit fpe_exit(void)
-{
-	thread_unregister_notifier(&nwfpe_notifier_block);
-	/* Restore the values we saved earlier. */
-	kern_fp_enter = orig_fp_enter;
-}
-
 /*
 ScottB:  November 4, 1998
 
@@ -170,12 +152,7 @@ void float_raise(signed char flags)
 
 	/* Raise an exception if necessary.  */
 	if (fpsr & (flags << 16))
-		fp_send_sig(SIGFPE, current, 1);
+		send_sig(SIGFPE, current, 1);
 }
 
 module_init(fpe_init);
-module_exit(fpe_exit);
-
-MODULE_AUTHOR("Scott Bambrough <scottb@rebel.com>");
-MODULE_DESCRIPTION("NWFPE floating point emulator (" NWFPE_BITS " precision)");
-MODULE_LICENSE("GPL");
-- 
1.6.3.2
