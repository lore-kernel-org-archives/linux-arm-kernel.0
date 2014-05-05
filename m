From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 05 May 2014 12:57:17 +0200
Subject: [PATCH 5/7] ARM: EXYNOS: PM: use c15resume firmware method if secure
 firmware is enabled
In-Reply-To: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
References: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1399287439-31376-6-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use c15resume firmware method instead of accessing the registers
directly in exynos_cpu_restore_register() if secure firmware is
enabled.  This affects both PM resume method and cpuidle AFTR mode.

This patch shouldn't cause any functionality changes on boards that
don't use secure firmware.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/pm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 1679c51..18f6bf8 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -26,6 +26,7 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
+#include <asm/firmware.h>
 
 #include <plat/cpu.h>
 #include <plat/pm-common.h>
@@ -167,6 +168,9 @@ static void exynos_cpu_restore_register(void)
 {
 	unsigned long tmp;
 
+	if (call_firmware_op(c15resume, save_arm_register) == 0)
+		return;
+
 	/* Restore Power control register */
 	tmp = save_arm_register[0];
 
-- 
1.8.2.3
