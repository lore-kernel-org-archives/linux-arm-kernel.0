From: banajit.g@samsung.com (Banajit Goswami)
Date: Fri, 15 Jul 2011 20:12:43 +0530
Subject: [PATCH 3/8] ARM: EXYNOS4: Add PWM backlight support on Samsung
	SMDKC210 board
In-Reply-To: <1310740968-26722-1-git-send-email-banajit.g@samsung.com>
References: <1310740968-26722-1-git-send-email-banajit.g@samsung.com>
Message-ID: <1310740968-26722-4-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for LCD backlight using PWM timer for
Samsung SMDKC210 board.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig         |    2 ++
 arch/arm/mach-exynos4/mach-smdkc210.c |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index e27f044..65d48c1 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -110,6 +110,8 @@ config MACH_SMDKC210
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
+	select SAMSUNG_DEV_PWM
+	select SAMSUNG_DEV_BACKLIGHT
 	select EXYNOS4_DEV_PD
 	select EXYNOS4_DEV_SYSMMU
 	select EXYNOS4_SETUP_I2C1
diff --git a/arch/arm/mach-exynos4/mach-smdkc210.c b/arch/arm/mach-exynos4/mach-smdkc210.c
index e645f7a..f606ea7 100644
--- a/arch/arm/mach-exynos4/mach-smdkc210.c
+++ b/arch/arm/mach-exynos4/mach-smdkc210.c
@@ -15,6 +15,7 @@
 #include <linux/smsc911x.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
+#include <linux/pwm_backlight.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -27,6 +28,8 @@
 #include <plat/sdhci.h>
 #include <plat/iic.h>
 #include <plat/pd.h>
+#include <plat/gpio-cfg.h>
+#include <plat/backlight.h>
 
 #include <mach/map.h>
 
@@ -191,6 +194,17 @@ static void __init smdkc210_smsc911x_init(void)
 		     (0x1 << S5P_SROM_BCX__TACS__SHIFT), S5P_SROM_BC1);
 }
 
+/* LCD Backlight data */
+static struct samsung_bl_gpio_info smdkc210_bl_gpio_info = {
+	.no = EXYNOS4_GPD0(1),
+	.func = S3C_GPIO_SFN(2),
+};
+
+static struct platform_pwm_backlight_data smdkc210_bl_data = {
+	.pwm_id = 1,
+	.pwm_period_ns  = 1000,
+};
+
 static void __init smdkc210_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -210,6 +224,8 @@ static void __init smdkc210_machine_init(void)
 	s3c_sdhci2_set_platdata(&smdkc210_hsmmc2_pdata);
 	s3c_sdhci3_set_platdata(&smdkc210_hsmmc3_pdata);
 
+	samsung_bl_set(&smdkc210_bl_gpio_info, &smdkc210_bl_data);
+
 	platform_add_devices(smdkc210_devices, ARRAY_SIZE(smdkc210_devices));
 }
 
-- 
1.7.2.3
