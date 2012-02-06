From: robherring2@gmail.com (Rob Herring)
Date: Mon,  6 Feb 2012 15:03:19 -0600
Subject: [PATCH 2/3] ARM: make disable_fiq macro optional
In-Reply-To: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
References: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
Message-ID: <1328562200-8810-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Only rpc uses disable_fiq, so make its use conditional on ARCH_RPC.

With this, entry-macro.S is no longer needed for platforms that
select MULTI_IRQ_HANDLER and the include of it can be conditional.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/kernel/entry-armv.S |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 3a456c6..15caa06 100644
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
@@ -1101,7 +1103,9 @@ __stubs_start:
  * get out of that mode without clobbering one register.
  */
 vector_fiq:
+#ifdef CONFIG_ARCH_RPC
 	disable_fiq
+#endif
 	subs	pc, lr, #4
 
 /*=============================================================================
-- 
1.7.5.4
