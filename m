From: inderpal.singh@linaro.org (Inderpal Singh)
Date: Sat, 12 Nov 2011 10:31:48 +0530
Subject: [PATCH] ARM: SAMSUNG: Save/restore GPIO drive strength across
 suspend/resume
Message-ID: <1321074108-10025-1-git-send-email-inderpal.singh@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO driver strength settings are not preserved across suspend/resume
for s5pc100, s5pv210 and Exynos platforms which has been the cause of
mmc/sd card read/write failures after resume. Fix this by saving and
restoring the GPIO driver strength register settings across suspend/resume.

Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>
---
1. This change is applicable only for s5pc100, s5pv210 and Exynos
platforms. For all other platforms, the driver strength registers are
part of special port configuration register (SPCON) and these
registers are saved and restored separately from the GPIO bank
registers. For s5pc100, s5pv210 and Exynos platforms, the driver
strength values are saved along with the GPIO bank registers.

2. An additional entry is added to the 'pm_save' array of 'struct
samsung_gpio_chip' for saving driver strength values.

3. Tested with v210 and v310 smdk boards

 arch/arm/plat-samsung/include/plat/gpio-core.h |    2 +-
 arch/arm/plat-samsung/pm-gpio.c                |   13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index 1fe6917..8871b4c 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -69,7 +69,7 @@ struct samsung_gpio_chip {
 	int			group;
 	spinlock_t		 lock;
 #ifdef CONFIG_PM
-	u32			pm_save[4];
+	u32			pm_save[5];
 #endif
 };
 
diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
index 4be016e..5493f38 100644
--- a/arch/arm/plat-samsung/pm-gpio.c
+++ b/arch/arm/plat-samsung/pm-gpio.c
@@ -21,12 +21,14 @@
 
 #include <plat/gpio-core.h>
 #include <plat/pm.h>
+#include <plat/cpu.h>
 
 /* PM GPIO helpers */
 
 #define OFFS_CON	(0x00)
 #define OFFS_DAT	(0x04)
 #define OFFS_UP		(0x08)
+#define OFFS_DRV_STRGTH	(0x0C)
 
 static void samsung_gpio_pm_1bit_save(struct samsung_gpio_chip *chip)
 {
@@ -199,6 +201,9 @@ static void samsung_gpio_pm_4bit_save(struct samsung_gpio_chip *chip)
 	chip->pm_save[2] = __raw_readl(chip->base + OFFS_DAT);
 	chip->pm_save[3] = __raw_readl(chip->base + OFFS_UP);
 
+	if (soc_is_s5pc100() || soc_is_s5pv210() || soc_is_exynos4210())
+		chip->pm_save[4] = __raw_readl(chip->base + OFFS_DRV_STRGTH);
+
 	if (chip->chip.ngpio > 8)
 		chip->pm_save[0] = __raw_readl(chip->base - 4);
 }
@@ -285,6 +290,9 @@ static void samsung_gpio_pm_4bit_resume(struct samsung_gpio_chip *chip)
 	__raw_writel(chip->pm_save[2], base + OFFS_DAT);
 	__raw_writel(chip->pm_save[3], base + OFFS_UP);
 
+	if (soc_is_s5pc100() || soc_is_s5pv210() || soc_is_exynos4210())
+		__raw_writel(chip->pm_save[4], base + OFFS_DRV_STRGTH);
+
 	if (chip->chip.ngpio > 8) {
 		S3C_PMDBG("%s: CON4 %08x,%08x => %08x,%08x, DAT %08x => %08x\n",
 			  chip->chip.label, old_gpcon[0], old_gpcon[1],
@@ -338,12 +346,13 @@ void samsung_pm_save_gpios(void)
 
 		samsung_pm_save_gpio(ourchip);
 
-		S3C_PMDBG("%s: save %08x,%08x,%08x,%08x\n",
+		S3C_PMDBG("%s: save %08x,%08x,%08x,%08x,%08x\n",
 			  ourchip->chip.label,
 			  ourchip->pm_save[0],
 			  ourchip->pm_save[1],
 			  ourchip->pm_save[2],
-			  ourchip->pm_save[3]);
+			  ourchip->pm_save[3],
+			  ourchip->pm_save[4]);
 
 		gpio_nr += ourchip->chip.ngpio;
 		gpio_nr += CONFIG_S3C_GPIO_SPACE;
-- 
1.7.1
