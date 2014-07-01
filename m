From: xerofoify@gmail.com (Nicholas Krause)
Date: Mon, 30 Jun 2014 23:11:02 -0400
Subject: [PATCH 1/2] Deletes  arch/arm/mach-gemini/idle.c
Message-ID: <1404184262-6178-1-git-send-email-xerofoify@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch deletes the above file in order to remove the function
in this file that may cause races. In addition this function is
no longer needed due to commit 8182a34d85698 fixing this issue.
Therefore gemmi_idle is no longer needed and due to in being the
only function in this file I am removing it.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/arm/mach-gemini/idle.c | 30 ------------------------------
 1 file changed, 30 deletions(-)
 delete mode 100644 arch/arm/mach-gemini/idle.c

diff --git a/arch/arm/mach-gemini/idle.c b/arch/arm/mach-gemini/idle.c
deleted file mode 100644
index 2880f5a..0000000
--- a/arch/arm/mach-gemini/idle.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * arch/arm/mach-gemini/idle.c
- */
-
-#include <linux/init.h>
-#include <asm/system_misc.h>
-#include <asm/proc-fns.h>
-
-static void gemini_idle(void)
-{
-	/*
-	 * Because of broken hardware we have to enable interrupts or the CPU
-	 * will never wakeup... Acctualy it is not very good to enable
-	 * interrupts first since scheduler can miss a tick, but there is
-	 * no other way around this. Platforms that needs it for power saving
-	 * should enable it in init code, since by default it is
-	 * disabled.
-	 */
-
-	local_irq_disable();
-	cpu_do_idle();
-}
-
-static int __init gemini_idle_init(void)
-{
-	arm_pm_idle = gemini_idle;
-	return 0;
-}
-
-arch_initcall(gemini_idle_init);
-- 
1.9.1
