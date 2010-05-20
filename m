From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 May 2010 11:39:54 +0900
Subject: [PATCH v4 3/3] ARM: S5PV210: Adds Touchscreen support for S5PV210
In-Reply-To: <1274323194-16059-3-git-send-email-kgene.kim@samsung.com>
References: <1274323194-16059-1-git-send-email-kgene.kim@samsung.com>
	<1274323194-16059-2-git-send-email-kgene.kim@samsung.com>
	<1274323194-16059-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <1274323194-16059-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Ch <ch.naveen@samsung.com>

This patch adds touchscreen support for S5PV210.

Note: TSADC in S5PV210 support 2 touchscreen interfaces,
Only 1 is implemented as of now.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig            |    2 ++
 arch/arm/mach-s5pv210/cpu.c              |    2 ++
 arch/arm/mach-s5pv210/include/mach/map.h |    3 +++
 arch/arm/mach-s5pv210/mach-smdkv210.c    |   11 +++++++++++
 4 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 7601c28..b05988f 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -25,6 +25,8 @@ config MACH_SMDKV210
 	bool "SMDKV210"
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
+	select SAMSUNG_DEV_ADC
+	select SAMSUNG_DEV_TS
 	help
 	  Machine support for Samsung SMDKV210
 
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 2b776eb..359bdc8 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -74,6 +74,8 @@ static void s5pv210_idle(void)
 
 void __init s5pv210_map_io(void)
 {
+	s3c_device_adc.name	= "s3c64xx-adc";
+
 	iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));
 }
 
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 5adcb9f..e859570 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -75,8 +75,11 @@
 /* AC97 */
 #define S5PV210_PA_AC97		0xE2200000
 
+#define S5PV210_PA_ADC		(0xE1700000)
+
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5PV210_PA_UART
 #define S3C_PA_IIC		S5PV210_PA_IIC0
+#define SAMSUNG_PA_ADC		S5PV210_PA_ADC
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 3c29e18..b92beb6 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -25,6 +25,8 @@
 #include <plat/s5pv210.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
+#include <plat/adc.h>
+#include <plat/ts.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -74,6 +76,14 @@ static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 static struct platform_device *smdkv210_devices[] __initdata = {
 	&s5pv210_device_iis0,
 	&s5pv210_device_ac97,
+	&s3c_device_adc,
+	&s3c_device_ts,
+};
+
+static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
+	.delay			= 10000,
+	.presc			= 49,
+	.oversampling_shift	= 2,
 };
 
 static void __init smdkv210_map_io(void)
@@ -85,6 +95,7 @@ static void __init smdkv210_map_io(void)
 
 static void __init smdkv210_machine_init(void)
 {
+	s3c24xx_ts_set_platdata(&s3c_ts_platform);
 	platform_add_devices(smdkv210_devices, ARRAY_SIZE(smdkv210_devices));
 }
 
-- 
