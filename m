From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 May 2010 14:59:44 +0900
Subject: [PATCH 7/8] ARM: S5P6440: Add RTC Driver support
Message-ID: <1274162384-2017-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Taekgyun Ko <taeggyun.ko@samsung.com>

This patch adds RTC driver support for S5P6440.
S5P6440 RTC uses existing RTC driver for S3C64XX.

Signed-off-by: Taekgyun Ko <taeggyun.ko@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/Kconfig            |    1 +
 arch/arm/mach-s5p6440/include/mach/map.h |    2 +-
 arch/arm/mach-s5p6440/mach-smdk6440.c    |    1 +
 drivers/rtc/Kconfig                      |   11 +++++------
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s5p6440/Kconfig b/arch/arm/mach-s5p6440/Kconfig
index 4c29ff8..56d3aaf 100644
--- a/arch/arm/mach-s5p6440/Kconfig
+++ b/arch/arm/mach-s5p6440/Kconfig
@@ -15,6 +15,7 @@ config CPU_S5P6440
 config MACH_SMDK6440
 	bool "SMDK6440"
 	select CPU_S5P6440
+	select S3C_DEV_RTC
 	help
 	  Machine support for the Samsung SMDK6440
 
diff --git a/arch/arm/mach-s5p6440/include/mach/map.h b/arch/arm/mach-s5p6440/include/mach/map.h
index 8924e5a..d14f12e 100644
--- a/arch/arm/mach-s5p6440/include/mach/map.h
+++ b/arch/arm/mach-s5p6440/include/mach/map.h
@@ -36,7 +36,6 @@
 #define S5P_PA_TIMER		S5P6440_PA_TIMER
 
 #define S5P6440_PA_RTC		(0xEA100000)
-#define S5P_PA_RTC		S5P6440_PA_RTC
 
 #define S5P6440_PA_WDT		(0xEA200000)
 #define S5P_PA_WDT		S5P6440_PA_WDT
@@ -64,5 +63,6 @@
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5P6440_PA_UART
 #define S3C_PA_IIC		S5P6440_PA_IIC0
+#define S3C_PA_RTC		S5P6440_PA_RTC
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5p6440/mach-smdk6440.c b/arch/arm/mach-s5p6440/mach-smdk6440.c
index 3ae88f2..a905db6 100644
--- a/arch/arm/mach-s5p6440/mach-smdk6440.c
+++ b/arch/arm/mach-s5p6440/mach-smdk6440.c
@@ -84,6 +84,7 @@ static struct s3c2410_uartcfg smdk6440_uartcfgs[] __initdata = {
 };
 
 static struct platform_device *smdk6440_devices[] __initdata = {
+	&s3c_device_rtc,
 };
 
 static void __init smdk6440_map_io(void)
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8cabeeb..3677323 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -629,17 +629,16 @@ config RTC_DRV_OMAP
 	  module called rtc-omap.
 
 config RTC_DRV_S3C
-	tristate "Samsung S3C series SoC RTC"
-	depends on ARCH_S3C2410 || ARCH_S3C64XX
+	tristate "Samsung SoCs RTC"
+	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5P6440
 	help
 	  RTC (Realtime Clock) driver for the clock inbuilt into the
-	  Samsung S3C series of SoCs. This can provide periodic
-	  interrupt rates from 1Hz to 64Hz for user programs, and
-	  wakeup from Alarm.
+	  Samsung SoCs. This can provide periodic interrupt rates from
+	  1Hz to 64Hz for user programs, and wakeup from Alarm.
 
 	  The driver currently supports the common features on all the
 	  S3C range, such as the S3C2410, S3C2412, S3C2413, S3C2440,
-	  S3C2442 and S3C64XX.
+	  S3C2442 and S3C64XX, and S5P6440.
 
 	  This driver can also be build as a module. If so, the module
 	  will be called rtc-s3c.
-- 
1.6.2.5
