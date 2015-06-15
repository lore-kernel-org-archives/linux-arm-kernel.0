From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Mon, 15 Jun 2015 18:47:25 +0900
Subject: [PATCH] ARM: EXYNOS: Remove duplicated define of SLEEP_MAGIC
Message-ID: <1434361645-10233-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The magic cookie for entering sleep state was defined and used in two
different places: firmware.c and suspend.c. Move it to one common place
to reduce duplication.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/mach-exynos/common.h   | 6 ++++++
 arch/arm/mach-exynos/firmware.c | 2 --
 arch/arm/mach-exynos/suspend.c  | 4 +---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index e3a9256ed55f..153492513c40 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -128,6 +128,12 @@ void exynos_firmware_init(void);
 
 /* CPU BOOT mode flag for Exynos3250 SoC bootloader */
 #define C2_STATE	(1 << 3)
+/*
+ * Magic values for bootloader indicating chosen low power mode.
+ * See also Documentation/arm/Samsung/Bootloader-interface.txt
+ */
+#define EXYNOS_SLEEP_MAGIC	0x00000bad
+#define EXYNOS_AFTR_MAGIC	0xfcba0d10
 
 void exynos_set_boot_flag(unsigned int cpu, unsigned int mode);
 void exynos_clear_boot_flag(unsigned int cpu, unsigned int mode);
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index 245f6dec1ded..111cfbf66fdb 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -25,8 +25,6 @@
 #include "common.h"
 #include "smc.h"
 
-#define EXYNOS_SLEEP_MAGIC	0x00000bad
-#define EXYNOS_AFTR_MAGIC	0xfcba0d10
 #define EXYNOS_BOOT_ADDR	0x8
 #define EXYNOS_BOOT_FLAG	0xc
 
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index f572219c7a40..c506f8e9c3e5 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -38,8 +38,6 @@
 #include "regs-pmu.h"
 #include "exynos-pmu.h"
 
-#define S5P_CHECK_SLEEP 0x00000BAD
-
 #define REG_TABLE_END (-1U)
 
 #define EXYNOS5420_CPU_STATE	0x28
@@ -331,7 +329,7 @@ static void exynos_pm_enter_sleep_mode(void)
 {
 	/* Set value of power down register for sleep mode */
 	exynos_sys_powerdown_conf(SYS_SLEEP);
-	pmu_raw_writel(S5P_CHECK_SLEEP, S5P_INFORM1);
+	pmu_raw_writel(EXYNOS_SLEEP_MAGIC, S5P_INFORM1);
 }
 
 static void exynos_pm_prepare(void)
-- 
2.1.4
