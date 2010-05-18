From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 May 2010 14:59:49 +0900
Subject: [PATCH 8/8] ARM: S5PV210: Add RTC Driver support
Message-ID: <1274162389-2058-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Taekgyun Ko <taeggyun.ko@samsung.com>

This patch adds RTC driver support for S5PV210/S5PC110.
S5PV210 RTC uses existing RTC driver for S3C64XX.

Signed-off-by: Taekgyun Ko <taeggyun.ko@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig            |    2 ++
 arch/arm/mach-s5pv210/include/mach/map.h |    3 +++
 arch/arm/mach-s5pv210/mach-smdkc110.c    |    1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c    |    1 +
 drivers/rtc/Kconfig                      |    5 +++--
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index af33a1a..6c88a67 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -24,6 +24,7 @@ config MACH_SMDKV210
 	bool "SMDKV210"
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
+	select S3C_DEV_RTC
 	help
 	  Machine support for Samsung SMDKV210
 
@@ -31,6 +32,7 @@ config MACH_SMDKC110
 	bool "SMDKC110"
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
+	select S3C_DEV_RTC
 	help
 	  Machine support for Samsung SMDKC110
 	  S5PC110(MCP) is one of package option of S5PV210
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index c22694c..3ef1117 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -32,6 +32,8 @@
 
 #define S5PV210_PA_SYSTIMER	(0xE2600000)
 
+#define S5PV210_PA_RTC		(0xE2800000)
+
 #define S5PV210_PA_UART		(0xE2900000)
 
 #define S5P_PA_UART0		(S5PV210_PA_UART + 0x0)
@@ -61,5 +63,6 @@
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5PV210_PA_UART
 #define S3C_PA_IIC		S5PV210_PA_IIC0
+#define S3C_PA_RTC		S5PV210_PA_RTC
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index ab4869d..898ccb7 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -72,6 +72,7 @@ static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 };
 
 static struct platform_device *smdkc110_devices[] __initdata = {
+	&s3c_device_rtc,
 };
 
 static void __init smdkc110_map_io(void)
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index a278832..b554a13 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -72,6 +72,7 @@ static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 };
 
 static struct platform_device *smdkv210_devices[] __initdata = {
+	&s3c_device_rtc,
 };
 
 static void __init smdkv210_map_io(void)
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 3677323..81a5a3d 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -630,7 +630,7 @@ config RTC_DRV_OMAP
 
 config RTC_DRV_S3C
 	tristate "Samsung SoCs RTC"
-	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5P6440
+	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5P6440 || ARCH_S5PV210
 	help
 	  RTC (Realtime Clock) driver for the clock inbuilt into the
 	  Samsung SoCs. This can provide periodic interrupt rates from
@@ -638,7 +638,8 @@ config RTC_DRV_S3C
 
 	  The driver currently supports the common features on all the
 	  S3C range, such as the S3C2410, S3C2412, S3C2413, S3C2440,
-	  S3C2442 and S3C64XX, and S5P6440.
+	  S3C2442 and S3C64XX, and S5P range, such as the S5P6440 and
+	  S5PV210/S5PC110.
 
 	  This driver can also be build as a module. If so, the module
 	  will be called rtc-s3c.
-- 
1.6.2.5
