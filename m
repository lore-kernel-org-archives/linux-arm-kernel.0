From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 25 Oct 2011 19:35:30 +0900
Subject: [PATCH 2/3 v3] ARM: EXYNOS4: Use generic power domain on
	EXYNOS4210/4212
Message-ID: <4EA690F2.8010309@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch use the generic power domain framework instead of
specific code depend on samsung SoC.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/mach-armlex4210.c     |    3 +++
 arch/arm/mach-exynos4/mach-nuri.c           |   24 ++++++++++++------------
 arch/arm/mach-exynos4/mach-origen.c         |   19 +++++++------------
 arch/arm/mach-exynos4/mach-smdk4x12.c       |    3 +++
 arch/arm/mach-exynos4/mach-smdkv310.c       |   17 ++++++-----------
 arch/arm/mach-exynos4/mach-universal_c210.c |   26 ++++++++++++--------------
 6 files changed, 43 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-exynos4/mach-armlex4210.c b/arch/arm/mach-exynos4/mach-armlex4210.c
index b482c62..a077305 100644
--- a/arch/arm/mach-exynos4/mach-armlex4210.c
+++ b/arch/arm/mach-exynos4/mach-armlex4210.c
@@ -27,6 +27,7 @@
 #include <plat/sdhci.h>
 
 #include <mach/map.h>
+#include <mach/pm-exynos4.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define ARMLEX4210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -195,6 +196,8 @@ static void __init armlex4210_map_io(void)
 
 static void __init armlex4210_machine_init(void)
 {
+	exynos4210_init_pm_domains();
+
 	armlex4210_smsc911x_init();
 
 	armlex4210_sdhci_init();
diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index 816a502..ef10fa0 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -47,12 +47,12 @@
 #include <plat/gpio-cfg.h>
 #include <plat/iic.h>
 #include <plat/mfc.h>
-#include <plat/pd.h>
 #include <plat/fimc-core.h>
 #include <plat/camport.h>
 #include <plat/mipi_csis.h>
 
 #include <mach/map.h>
+#include <mach/pm-exynos4.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define NURI_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -1266,9 +1266,6 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&s5p_device_mfc,
 	&s5p_device_mfc_l,
 	&s5p_device_mfc_r,
-	&exynos4_device_pd[PD_MFC],
-	&exynos4_device_pd[PD_LCD0],
-	&exynos4_device_pd[PD_CAM],
 	&s5p_device_fimc_md,
 
 	/* NURI Devices */
@@ -1295,6 +1292,8 @@ static void __init nuri_reserve(void)
 
 static void __init nuri_machine_init(void)
 {
+	exynos4210_init_pm_domains();
+
 	nuri_sdhci_init();
 	nuri_tsp_init();
 	nuri_power_init();
@@ -1318,14 +1317,15 @@ static void __init nuri_machine_init(void)
 
 	/* Last */
 	platform_add_devices(nuri_devices, ARRAY_SIZE(nuri_devices));
-	s5p_device_mfc.dev.parent = &exynos4_device_pd[PD_MFC].dev;
-	s5p_device_fimd0.dev.parent = &exynos4_device_pd[PD_LCD0].dev;
-
-	s5p_device_fimc0.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_fimc1.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_fimc2.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_fimc3.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_mipi_csis0.dev.parent = &exynos4_device_pd[PD_CAM].dev;
+
+	exynos4_add_device_to_domain(&exynos4_pd_mfc, &s5p_device_mfc);
+	exynos4_add_device_to_domain(&exynos4_pd_lcd0, &s5p_device_fimd0);
+
+	exynos4_add_device_to_domain(&exynos4_pd_cam, &s5p_device_fimc0);
+	exynos4_add_device_to_domain(&exynos4_pd_cam, &s5p_device_fimc1);
+	exynos4_add_device_to_domain(&exynos4_pd_cam, &s5p_device_fimc2);
+	exynos4_add_device_to_domain(&exynos4_pd_cam, &s5p_device_fimc3);
+	exynos4_add_device_to_domain(&exynos4_pd_cam, &s5p_device_mipi_csis0);
 }
 
 MACHINE_START(NURI, "NURI")
diff --git a/arch/arm/mach-exynos4/mach-origen.c b/arch/arm/mach-exynos4/mach-origen.c
index f80b563..dc4237e 100644
--- a/arch/arm/mach-exynos4/mach-origen.c
+++ b/arch/arm/mach-exynos4/mach-origen.c
@@ -37,11 +37,11 @@
 #include <plat/clock.h>
 #include <plat/gpio-cfg.h>
 #include <plat/backlight.h>
-#include <plat/pd.h>
 #include <plat/fb.h>
 #include <plat/mfc.h>
 
 #include <mach/map.h>
+#include <mach/pm-exynos4.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define ORIGEN_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -606,13 +606,6 @@ static struct platform_device *origen_devices[] __initdata = {
 	&s5p_device_mfc_l,
 	&s5p_device_mfc_r,
 	&s5p_device_mixer,
-	&exynos4_device_pd[PD_LCD0],
-	&exynos4_device_pd[PD_TV],
-	&exynos4_device_pd[PD_G3D],
-	&exynos4_device_pd[PD_LCD1],
-	&exynos4_device_pd[PD_CAM],
-	&exynos4_device_pd[PD_GPS],
-	&exynos4_device_pd[PD_MFC],
 	&origen_device_gpiokeys,
 	&origen_lcd_hv070wsa,
 };
@@ -657,6 +650,8 @@ static void __init origen_reserve(void)
 
 static void __init origen_machine_init(void)
 {
+	exynos4210_init_pm_domains();
+
 	origen_power_init();
 
 	s3c_i2c0_set_platdata(NULL);
@@ -679,12 +674,12 @@ static void __init origen_machine_init(void)
 
 	platform_add_devices(origen_devices, ARRAY_SIZE(origen_devices));
 
-	s5p_device_fimd0.dev.parent = &exynos4_device_pd[PD_LCD0].dev;
+	exynos4_add_device_to_domain(&exynos4_pd_lcd0, &s5p_device_fimd0);
 
-	s5p_device_hdmi.dev.parent = &exynos4_device_pd[PD_TV].dev;
-	s5p_device_mixer.dev.parent = &exynos4_device_pd[PD_TV].dev;
+	exynos4_add_device_to_domain(&exynos4_pd_tv, &s5p_device_hdmi);
+	exynos4_add_device_to_domain(&exynos4_pd_tv, &s5p_device_mixer);
 
-	s5p_device_mfc.dev.parent = &exynos4_device_pd[PD_MFC].dev;
+	exynos4_add_device_to_domain(&exynos4_pd_mfc, &s5p_device_mfc);
 
 	samsung_bl_set(&origen_bl_gpio_info, &origen_bl_data);
 }
diff --git a/arch/arm/mach-exynos4/mach-smdk4x12.c b/arch/arm/mach-exynos4/mach-smdk4x12.c
index fcf2e0e..a6f2d1c 100644
--- a/arch/arm/mach-exynos4/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos4/mach-smdk4x12.c
@@ -35,6 +35,7 @@
 #include <plat/sdhci.h>
 
 #include <mach/map.h>
+#include <mach/pm-exynos4.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDK4X12_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -256,6 +257,8 @@ static void __init smdk4x12_map_io(void)
 
 static void __init smdk4x12_machine_init(void)
 {
+	exynos4x12_init_pm_domains();
+
 	s3c_i2c0_set_platdata(NULL);
 	i2c_register_board_info(0, smdk4x12_i2c_devs0,
 				ARRAY_SIZE(smdk4x12_i2c_devs0));
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
index cec2afa..b35effe 100644
--- a/arch/arm/mach-exynos4/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -34,7 +34,6 @@
 #include <plat/keypad.h>
 #include <plat/sdhci.h>
 #include <plat/iic.h>
-#include <plat/pd.h>
 #include <plat/gpio-cfg.h>
 #include <plat/backlight.h>
 #include <plat/mfc.h>
@@ -42,6 +41,7 @@
 #include <plat/clock.h>
 
 #include <mach/map.h>
+#include <mach/pm-exynos4.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV310_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -265,13 +265,6 @@ static struct platform_device *smdkv310_devices[] __initdata = {
 	&s5p_device_mfc,
 	&s5p_device_mfc_l,
 	&s5p_device_mfc_r,
-	&exynos4_device_pd[PD_MFC],
-	&exynos4_device_pd[PD_G3D],
-	&exynos4_device_pd[PD_LCD0],
-	&exynos4_device_pd[PD_LCD1],
-	&exynos4_device_pd[PD_CAM],
-	&exynos4_device_pd[PD_TV],
-	&exynos4_device_pd[PD_GPS],
 	&exynos4_device_spdif,
 	&exynos4_device_sysmmu,
 	&samsung_asoc_dma,
@@ -326,8 +319,8 @@ static void s5p_tv_setup(void)
 	s3c_gpio_setpull(EXYNOS4_GPX3(7), S3C_GPIO_PULL_NONE);
 
 	/* setup dependencies between TV devices */
-	s5p_device_hdmi.dev.parent = &exynos4_device_pd[PD_TV].dev;
-	s5p_device_mixer.dev.parent = &exynos4_device_pd[PD_TV].dev;
+	exynos4_add_device_to_domain(&exynos4_pd_tv, &s5p_device_hdmi);
+	exynos4_add_device_to_domain(&exynos4_pd_tv, &s5p_device_mixer);
 }
 
 static void __init smdkv310_map_io(void)
@@ -344,6 +337,8 @@ static void __init smdkv310_reserve(void)
 
 static void __init smdkv310_machine_init(void)
 {
+	exynos4210_init_pm_domains();
+
 	s3c_i2c1_set_platdata(NULL);
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
@@ -366,7 +361,7 @@ static void __init smdkv310_machine_init(void)
 	clk_xusbxti.rate = 24000000;
 
 	platform_add_devices(smdkv310_devices, ARRAY_SIZE(smdkv310_devices));
-	s5p_device_mfc.dev.parent = &exynos4_device_pd[PD_MFC].dev;
+	exynos4_add_device_to_domain(&exynos4_pd_mfc, &s5p_device_mfc);
 }
 
 MACHINE_START(SMDKV310, "SMDKV310")
diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c b/arch/arm/mach-exynos4/mach-universal_c210.c
index 2096c8b..6235c40 100644
--- a/arch/arm/mach-exynos4/mach-universal_c210.c
+++ b/arch/arm/mach-exynos4/mach-universal_c210.c
@@ -35,13 +35,13 @@
 #include <plat/fb.h>
 #include <plat/mfc.h>
 #include <plat/sdhci.h>
-#include <plat/pd.h>
 #include <plat/regs-fb-v4.h>
 #include <plat/fimc-core.h>
 #include <plat/camport.h>
 #include <plat/mipi_csis.h>
 
 #include <mach/map.h>
+#include <mach/pm-exynos4.h>
 
 #include <media/v4l2-mediabus.h>
 #include <media/s5p_fimc.h>
@@ -969,7 +969,6 @@ static struct platform_device *universal_devices[] __initdata = {
 	&s3c_device_i2c5,
 	&s5p_device_i2c_hdmiphy,
 	&hdmi_fixed_voltage,
-	&exynos4_device_pd[PD_TV],
 	&s5p_device_hdmi,
 	&s5p_device_sdo,
 	&s5p_device_mixer,
@@ -982,9 +981,6 @@ static struct platform_device *universal_devices[] __initdata = {
 	&s5p_device_mfc,
 	&s5p_device_mfc_l,
 	&s5p_device_mfc_r,
-	&exynos4_device_pd[PD_MFC],
-	&exynos4_device_pd[PD_LCD0],
-	&exynos4_device_pd[PD_CAM],
 	&cam_i_core_fixed_reg_dev,
 	&cam_s_if_fixed_reg_dev,
 	&s5p_device_fimc_md,
@@ -1007,8 +1003,8 @@ void s5p_tv_setup(void)
 	s3c_gpio_setpull(EXYNOS4_GPX3(7), S3C_GPIO_PULL_NONE);
 
 	/* setup dependencies between TV devices */
-	s5p_device_hdmi.dev.parent = &exynos4_device_pd[PD_TV].dev;
-	s5p_device_mixer.dev.parent = &exynos4_device_pd[PD_TV].dev;
+	exynos4_add_device_to_domain(&exynos4_pd_tv, &s5p_device_hdmi);
+	exynos4_add_device_to_domain(&exynos4_pd_tv, &s5p_device_mixer);
 }
 
 static void __init universal_reserve(void)
@@ -1018,6 +1014,8 @@ static void __init universal_reserve(void)
 
 static void __init universal_machine_init(void)
 {
+	exynos4210_init_pm_domains();
+
 	universal_sdhci_init();
 	s5p_tv_setup();
 
@@ -1043,14 +1041,14 @@ static void __init universal_machine_init(void)
 	/* Last */
 	platform_add_devices(universal_devices, ARRAY_SIZE(universal_devices));
 
-	s5p_device_mfc.dev.parent = &exynos4_device_pd[PD_MFC].dev;
-	s5p_device_fimd0.dev.parent = &exynos4_device_pd[PD_LCD0].dev;
+	exynos4_add_device_to_domain(&exynos4_pd_mfc, &s5p_device_mfc);
+	exynos4_add_device_to_domain(&exynos4_pd_lcd0, &s5p_device_fimd0);
 
-	s5p_device_fimc0.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_fimc1.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_fimc2.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_fimc3.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_mipi_csis0.dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	exynos4_add_device_to_domain(&exynos4_pd_cam, &s5p_device_fimc0);
+	exynos4_add_device_to_domain(&exynos4_pd_cam, &s5p_device_fimc1);
+	exynos4_add_device_to_domain(&exynos4_pd_cam, &s5p_device_fimc2);
+	exynos4_add_device_to_domain(&exynos4_pd_cam, &s5p_device_fimc3);
+	exynos4_add_device_to_domain(&exynos4_pd_cam, &s5p_device_mipi_csis0);
 }
 
 MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
-- 
1.7.0.4
