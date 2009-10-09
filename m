From: alan-jenkins@tuffmail.co.uk (Alan Jenkins)
Date: Fri,  9 Oct 2009 15:02:22 +0100
Subject: [PATCH 6/6] ARM: newfpe can no longer be compiled as a module -
	cleanup (part 2 of 2)
In-Reply-To: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
References: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
Message-ID: <1255096942-10451-6-git-send-email-alan-jenkins@tuffmail.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since fpmodule can no longer be removed, it doesn't need to save the old
value of fp_enter.

Also change module_init() to late_initcall() for consistency with
vfp/vfpmodule.c.  That will move it one step later, after the device
initcalls, but it will still run before /sbin/init.

Build tested only.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 arch/arm/nwfpe/fpmodule.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/nwfpe/fpmodule.c b/arch/arm/nwfpe/fpmodule.c
index 9a21f35..296a5b5 100644
--- a/arch/arm/nwfpe/fpmodule.c
+++ b/arch/arm/nwfpe/fpmodule.c
@@ -65,9 +65,6 @@ static struct notifier_block nwfpe_notifier_block = {
 /* external declarations for saved kernel symbols */
 extern void (*fp_enter)(void);
 
-/* Original value of fp_enter from kernel before patched by fpe_init. */
-static void (*orig_fp_enter)(void);
-
 /* forward declarations */
 extern void nwfpe_enter(void);
 
@@ -91,8 +88,7 @@ static int __init fpe_init(void)
 
 	thread_register_notifier(&nwfpe_notifier_block);
 
-	/* Save pointer to the old FP handler and then patch ourselves in */
-	orig_fp_enter = fp_enter;
+	/* Patch ourselves in as the FP handler. */
 	fp_enter = nwfpe_enter;
 
 	return 0;
@@ -155,4 +151,4 @@ void float_raise(signed char flags)
 		send_sig(SIGFPE, current, 1);
 }
 
-module_init(fpe_init);
+late_initcall(fpe_init);
-- 
1.6.3.2
