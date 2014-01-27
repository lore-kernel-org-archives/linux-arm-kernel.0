From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 27 Jan 2014 01:08:20 -0500
Subject: [PATCH 5/9] ARM: remove redundant cpuidle_idle_call()
In-Reply-To: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1390802904-28399-6-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core idle loop now takes care of it.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/process.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 725b8c95e0..34a59b7614 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -30,7 +30,6 @@
 #include <linux/uaccess.h>
 #include <linux/random.h>
 #include <linux/hw_breakpoint.h>
-#include <linux/cpuidle.h>
 #include <linux/leds.h>
 #include <linux/reboot.h>
 
@@ -133,7 +132,11 @@ EXPORT_SYMBOL_GPL(arm_pm_restart);
 
 void (*arm_pm_idle)(void);
 
-static void default_idle(void)
+/*
+ * Called from the core idle loop.
+ */
+
+void arch_cpu_idle(void)
 {
 	if (arm_pm_idle)
 		arm_pm_idle();
@@ -163,15 +166,6 @@ void arch_cpu_idle_dead(void)
 #endif
 
 /*
- * Called from the core idle loop.
- */
-void arch_cpu_idle(void)
-{
-	if (cpuidle_idle_call())
-		default_idle();
-}
-
-/*
  * Called by kexec, immediately prior to machine_kexec().
  *
  * This must completely disable all secondary CPUs; simply causing those CPUs
-- 
1.8.4.108.g55ea5f6
