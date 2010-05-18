From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 May 2010 20:44:56 +0900
Subject: [PATCH v2 7/9] ARM: S5P6440: Adds Touchscreen support for S5P6440
Message-ID: <1274183096-16133-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna <ch.naveen@samsung.com>

This patch adds touchscreen support for S5P6440.

Signed-off-by: Naveen Krishna Ch <ch.naveen at samsung.com
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/Kconfig            |    2 ++
 arch/arm/mach-s5p6440/cpu.c              |    2 ++
 arch/arm/mach-s5p6440/include/mach/map.h |    3 +++
 arch/arm/mach-s5p6440/mach-smdk6440.c    |   12 ++++++++++++
 4 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p6440/Kconfig b/arch/arm/mach-s5p6440/Kconfig
index 4c29ff8..597e1a9 100644
--- a/arch/arm/mach-s5p6440/Kconfig
+++ b/arch/arm/mach-s5p6440/Kconfig
@@ -15,6 +15,8 @@ config CPU_S5P6440
 config MACH_SMDK6440
 	bool "SMDK6440"
 	select CPU_S5P6440
+	select SAMSUNG_DEV_TS
+	select SAMSUNG_DEV_ADC
 	help
 	  Machine support for the Samsung SMDK6440
 
diff --git a/arch/arm/mach-s5p6440/cpu.c b/arch/arm/mach-s5p6440/cpu.c
index 1794131..e461955 100644
--- a/arch/arm/mach-s5p6440/cpu.c
+++ b/arch/arm/mach-s5p6440/cpu.c
@@ -61,6 +61,8 @@ static void s5p6440_idle(void)
 void __init s5p6440_map_io(void)
 {
 	/* initialize any device information early */
+	s3c_device_ts.name      = "s3c64xx-ts";
+	s3c_device_adc.name	= "s3c64xx-adc";
 }
 
 void __init s5p6440_init_clocks(int xtal)
diff --git a/arch/arm/mach-s5p6440/include/mach/map.h b/arch/arm/mach-s5p6440/include/mach/map.h
index 8924e5a..52e7930 100644
--- a/arch/arm/mach-s5p6440/include/mach/map.h
+++ b/arch/arm/mach-s5p6440/include/mach/map.h
@@ -61,8 +61,11 @@
 #define S5P6440_PA_SDRAM	(0x20000000)
 #define S5P_PA_SDRAM		S5P6440_PA_SDRAM
 
+#define S5P6440_PA_ADC		(0xF3000000)
+
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5P6440_PA_UART
 #define S3C_PA_IIC		S5P6440_PA_IIC0
+#define SAMSUNG_PA_ADC		S5P6440_PA_ADC
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5p6440/mach-smdk6440.c b/arch/arm/mach-s5p6440/mach-smdk6440.c
index 3ae88f2..177701b 100644
--- a/arch/arm/mach-s5p6440/mach-smdk6440.c
+++ b/arch/arm/mach-s5p6440/mach-smdk6440.c
@@ -38,6 +38,8 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/pll.h>
+#include <plat/adc.h>
+#include <plat/ts.h>
 
 #define S5P6440_UCON_DEFAULT    (S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -84,6 +86,14 @@ static struct s3c2410_uartcfg smdk6440_uartcfgs[] __initdata = {
 };
 
 static struct platform_device *smdk6440_devices[] __initdata = {
+	&s3c_device_adc,
+	&s3c_device_ts,
+};
+
+static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
+	.delay			= 10000,
+	.presc			= 49,
+	.oversampling_shift	= 2,
 };
 
 static void __init smdk6440_map_io(void)
@@ -95,6 +105,8 @@ static void __init smdk6440_map_io(void)
 
 static void __init smdk6440_machine_init(void)
 {
+	s3c24xx_ts_set_platdata(&s3c_ts_platform);
+
 	platform_add_devices(smdk6440_devices, ARRAY_SIZE(smdk6440_devices));
 }
 
-- 
1.6.2.5
