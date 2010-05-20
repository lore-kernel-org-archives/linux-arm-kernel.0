From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 May 2010 11:39:53 +0900
Subject: [PATCH v4 2/3] ARM: S5P6440: Adds Touchscreen support for S5P6440
In-Reply-To: <1274323194-16059-2-git-send-email-kgene.kim@samsung.com>
References: <1274323194-16059-1-git-send-email-kgene.kim@samsung.com>
	<1274323194-16059-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <1274323194-16059-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Ch <ch.naveen@samsung.com>

This patch adds touchscreen support for S5P6440.

Signed-off-by: Naveen Krishna Ch <ch.naveen at samsung.com
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/Kconfig            |    2 ++
 arch/arm/mach-s5p6440/cpu.c              |    1 +
 arch/arm/mach-s5p6440/include/mach/map.h |    3 +++
 arch/arm/mach-s5p6440/mach-smdk6440.c    |   12 ++++++++++++
 4 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p6440/Kconfig b/arch/arm/mach-s5p6440/Kconfig
index 77aeffd..ef00cb7 100644
--- a/arch/arm/mach-s5p6440/Kconfig
+++ b/arch/arm/mach-s5p6440/Kconfig
@@ -16,6 +16,8 @@ config CPU_S5P6440
 config MACH_SMDK6440
 	bool "SMDK6440"
 	select CPU_S5P6440
+	select SAMSUNG_DEV_TS
+	select SAMSUNG_DEV_ADC
 	help
 	  Machine support for the Samsung SMDK6440
 
diff --git a/arch/arm/mach-s5p6440/cpu.c b/arch/arm/mach-s5p6440/cpu.c
index ca3b320..b2fe6a5 100644
--- a/arch/arm/mach-s5p6440/cpu.c
+++ b/arch/arm/mach-s5p6440/cpu.c
@@ -61,6 +61,7 @@ static void s5p6440_idle(void)
 void __init s5p6440_map_io(void)
 {
 	/* initialize any device information early */
+	s3c_device_adc.name	= "s3c64xx-adc";
 }
 
 void __init s5p6440_init_clocks(int xtal)
diff --git a/arch/arm/mach-s5p6440/include/mach/map.h b/arch/arm/mach-s5p6440/include/mach/map.h
index 72aedad..13c1ee7 100644
--- a/arch/arm/mach-s5p6440/include/mach/map.h
+++ b/arch/arm/mach-s5p6440/include/mach/map.h
@@ -69,8 +69,11 @@
 /* PCM */
 #define S5P6440_PA_PCM		0xF2100000
 
+#define S5P6440_PA_ADC		(0xF3000000)
+
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5P6440_PA_UART
 #define S3C_PA_IIC		S5P6440_PA_IIC0
+#define SAMSUNG_PA_ADC		S5P6440_PA_ADC
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5p6440/mach-smdk6440.c b/arch/arm/mach-s5p6440/mach-smdk6440.c
index d7fede9..f994817 100644
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
@@ -85,6 +87,14 @@ static struct s3c2410_uartcfg smdk6440_uartcfgs[] __initdata = {
 
 static struct platform_device *smdk6440_devices[] __initdata = {
 	&s5p6440_device_iis,
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
@@ -96,6 +106,8 @@ static void __init smdk6440_map_io(void)
 
 static void __init smdk6440_machine_init(void)
 {
+	s3c24xx_ts_set_platdata(&s3c_ts_platform);
+
 	platform_add_devices(smdk6440_devices, ARRAY_SIZE(smdk6440_devices));
 }
 
-- 
