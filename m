From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 05 Sep 2014 15:51:25 +0200
Subject: [PATCH v6 2/5] ARM: EXYNOS: add AFTR mode support to firmware do_idle
 method
In-Reply-To: <1409925088-4705-1-git-send-email-b.zolnierkie@samsung.com>
References: <1409925088-4705-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1409925088-4705-3-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms (i.e. EXYNOS ones) more than one idle mode is
available and we need to distinguish them in firmware do_idle method.

Add mode parameter to do_idle firmware method and AFTR mode support
to EXYNOS do_idle implementation.

This change is a preparation for adding secure firmware support to
EXYNOS cpuidle driver.

This patch shouldn't cause any functionality changes (please note
that do_idle firmware method is unused currently).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
v6:
- no changes

 arch/arm/include/asm/firmware.h |  2 +-
 arch/arm/mach-exynos/common.h   |  5 +++++
 arch/arm/mach-exynos/firmware.c | 10 ++++++++--
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/asm/firmware.h
index 5904f59..89aefe1 100644
--- a/arch/arm/include/asm/firmware.h
+++ b/arch/arm/include/asm/firmware.h
@@ -28,7 +28,7 @@ struct firmware_ops {
 	/*
 	 * Enters CPU idle mode
 	 */
-	int (*do_idle)(void);
+	int (*do_idle)(unsigned long mode);
 	/*
 	 * Sets boot address of specified physical CPU
 	 */
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index c218200..2d830df 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -119,6 +119,11 @@ extern void __iomem *sysram_base_addr;
 extern void __iomem *pmu_base_addr;
 void exynos_sysram_init(void);
 
+enum {
+	FW_DO_IDLE_SLEEP,
+	FW_DO_IDLE_AFTR,
+};
+
 void exynos_firmware_init(void);
 
 extern u32 exynos_get_eint_wake_mask(void);
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index f5e626d..e57b7c3 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -28,9 +28,15 @@
 #define EXYNOS_BOOT_ADDR	0x8
 #define EXYNOS_BOOT_FLAG	0xc
 
-static int exynos_do_idle(void)
+static int exynos_do_idle(unsigned long mode)
 {
-	exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
+	switch (mode) {
+	case FW_DO_IDLE_AFTR:
+		exynos_smc(SMC_CMD_CPU0AFTR, 0, 0, 0);
+		break;
+	case FW_DO_IDLE_SLEEP:
+		exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
+	}
 	return 0;
 }
 
-- 
1.8.2.3
