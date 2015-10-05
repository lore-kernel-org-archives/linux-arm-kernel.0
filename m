From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:37:08 +0200
Subject: [PATCH] ARM: pxa: z2: Fix section mismatch
Message-ID: <1444034228-9249-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The z2_power_off() function calls pxa27x_set_pwrmode(), which is marked
__init. z2_power_off() is set up as the power off handler, so will need
to stick around after __init data is discarded. Fix this by doing what
everyone else does and set the power mode from the board initialization
code instead.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/arm/mach-pxa/z2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index e1a121b36cfa..36caac726ea7 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -690,11 +690,8 @@ static void z2_power_off(void)
 	 */
 	PSPR = 0x0;
 	local_irq_disable();
-	pxa27x_set_pwrmode(PWRMODE_DEEPSLEEP);
 	pxa27x_cpu_pm_enter(PM_SUSPEND_MEM);
 }
-#else
-#define z2_power_off   NULL
 #endif
 
 /******************************************************************************
@@ -719,7 +716,10 @@ static void __init z2_init(void)
 	z2_keys_init();
 	z2_pmic_init();
 
+#ifdef CONFIG_PM
+	pxa27x_set_pwrmode(PWRMODE_DEEPSLEEP);
 	pm_power_off = z2_power_off;
+#endif
 }
 
 MACHINE_START(ZIPIT2, "Zipit Z2")
-- 
2.5.0
