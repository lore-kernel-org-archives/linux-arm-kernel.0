From: robherring2@gmail.com (Rob Herring)
Date: Wed,  8 Feb 2012 19:33:38 -0600
Subject: [PATCH v2 3/4] ARM: make entry-macro.S depend on !MULTI_IRQ_HANDLER
In-Reply-To: <1328751219-2552-1-git-send-email-robherring2@gmail.com>
References: <1328751219-2552-1-git-send-email-robherring2@gmail.com>
Message-ID: <1328751219-2552-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With the removal of disable_fiq on rpc and addition MULTI_IRQ_HANDLER,
entry-macro.S is no longer needed for platforms that select
MULTI_IRQ_HANDLER and the include of it can be conditional.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/kernel/entry-armv.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 3a456c6..5558f56 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -19,7 +19,9 @@
 #include <asm/glue-df.h>
 #include <asm/glue-pf.h>
 #include <asm/vfpmacros.h>
+#ifndef CONFIG_MULTI_IRQ_HANDLER
 #include <mach/entry-macro.S>
+#endif
 #include <asm/thread_notify.h>
 #include <asm/unwind.h>
 #include <asm/unistd.h>
@@ -1101,7 +1103,6 @@ __stubs_start:
  * get out of that mode without clobbering one register.
  */
 vector_fiq:
-	disable_fiq
 	subs	pc, lr, #4
 
 /*=============================================================================
-- 
1.7.5.4
