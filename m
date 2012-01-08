From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun,  8 Jan 2012 11:33:36 +0300
Subject: [PATCH] ARM: PXA: Zipit Z2: Fix oops in z2_power_off
Message-ID: <1326011616-3546-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa27x_set_pwrmode is marked with __init, so it's not legitimate
to call it in pm_power_off hook.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/z2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 0fb5617..8b0ce77 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -33,6 +33,7 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/suspend.h>
 
 #include <mach/pxa27x.h>
 #include <mach/mfp-pxa27x.h>
@@ -739,8 +740,7 @@ static void z2_power_off(void)
 	 */
 	PSPR = 0x0;
 	local_irq_disable();
-	pxa27x_set_pwrmode(PWRMODE_DEEPSLEEP);
-	pxa27x_cpu_pm_enter(PM_SUSPEND_MEM);
+	cpu_suspend(PWRMODE_DEEPSLEEP, pxa27x_finish_suspend);
 }
 #else
 #define z2_power_off   NULL
-- 
1.7.8.1
