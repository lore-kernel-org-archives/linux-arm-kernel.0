From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 05 May 2014 12:57:19 +0200
Subject: [PATCH 7/7] ARM: EXYNOS: cpuidle: add secure firmware support to AFTR
 mode code
In-Reply-To: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
References: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1399287439-31376-8-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Use do_idle firmware method instead of cpu_do_idle() on boards
  with secure firmware enabled.

* Use S5P_VA_SYSRAM_NS + 0x24 address for exynos_boot_vector_addr()
  and S5P_VA_SYSRAM_NS + 0x20 one for exynos_boot_vector_flag() on
  boards with secure firmware enabled.

This patch fixes hang on an attempt to enter AFTR mode for TRATS2
board (which uses EXYNOS4412 SoC with secure firmware enabled).

This patch shouldn't cause any functionality changes on boards that
don't use secure firmware.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/pm.c        | 8 ++++++--
 drivers/cpuidle/cpuidle-exynos.c | 7 ++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 3922968..ba4cd05 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -104,7 +104,9 @@ static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 
 static inline void __iomem *exynos_boot_vector_addr(void)
 {
-	if (samsung_rev() == EXYNOS4210_REV_1_1)
+	if (firmware_run())
+		return S5P_VA_SYSRAM_NS + 0x24;
+	else if (samsung_rev() == EXYNOS4210_REV_1_1)
 		return S5P_INFORM7;
 	else if (samsung_rev() == EXYNOS4210_REV_1_0)
 		return S5P_VA_SYSRAM + 0x24;
@@ -113,7 +115,9 @@ static inline void __iomem *exynos_boot_vector_addr(void)
 
 static inline void __iomem *exynos_boot_vector_flag(void)
 {
-	if (samsung_rev() == EXYNOS4210_REV_1_1)
+	if (firmware_run())
+		return S5P_VA_SYSRAM_NS + 0x20;
+	else if (samsung_rev() == EXYNOS4210_REV_1_1)
 		return S5P_INFORM6;
 	else if (samsung_rev() == EXYNOS4210_REV_1_0)
 		return S5P_VA_SYSRAM + 0x20;
diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuidle-exynos.c
index 7c01512..f90a4a0 100644
--- a/drivers/cpuidle/cpuidle-exynos.c
+++ b/drivers/cpuidle/cpuidle-exynos.c
@@ -17,13 +17,18 @@
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
 #include <asm/cpuidle.h>
+#include <asm/firmware.h>
 
 static void (*exynos_enter_aftr)(void);
 
 static int idle_finisher(unsigned long flags)
 {
 	exynos_enter_aftr();
-	cpu_do_idle();
+	if (firmware_run())
+		/* no need to check the return value on EXYNOS SoCs */
+		call_firmware_op(do_idle, FW_DO_IDLE_AFTR);
+	else
+		cpu_do_idle();
 
 	return 1;
 }
-- 
1.8.2.3
