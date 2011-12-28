From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Wed, 28 Dec 2011 16:03:25 +0900
Subject: [PATCH 4/6] ARM: EXYNOS: Add hsotg device for NURI board
In-Reply-To: <1325055807-29347-1-git-send-email-jy0922.shim@samsung.com>
References: <1325055807-29347-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <1325055807-29347-4-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds hsotg device to the NURI board.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/Kconfig     |    1 +
 arch/arm/mach-exynos/mach-nuri.c |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index e931924..492a3f4 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -275,6 +275,7 @@ config MACH_NURI
 	select S5P_DEV_FIMC3
 	select S5P_DEV_MFC
 	select S5P_DEV_USB_EHCI
+	select S3C_DEV_USB_HSOTG
 	select S5P_SETUP_MIPIPHY
 	select EXYNOS4_DEV_DMA
 	select EXYNOS4_DEV_PD
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 3df8bf4..6093443 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -43,6 +43,7 @@
 #include <plat/fb.h>
 #include <plat/sdhci.h>
 #include <plat/ehci.h>
+#include <plat/udc-hs.h>
 #include <plat/clock.h>
 #include <plat/gpio-cfg.h>
 #include <plat/iic.h>
@@ -389,6 +390,7 @@ static struct regulator_consumer_supply __initdata max8997_ldo1_[] = {
 	REGULATOR_SUPPLY("vdd", "s5p-adc"), /* Used by CPU's ADC drv */
 };
 static struct regulator_consumer_supply __initdata max8997_ldo3_[] = {
+	REGULATOR_SUPPLY("vusb_d", "s3c-hsotg"), /* USB */
 	REGULATOR_SUPPLY("vdd11", "s5p-mipi-csis.0"), /* MIPI */
 };
 static struct regulator_consumer_supply __initdata max8997_ldo4_[] = {
@@ -401,7 +403,7 @@ static struct regulator_consumer_supply __initdata max8997_ldo7_[] = {
 	REGULATOR_SUPPLY("dig_18", "0-001f"), /* HCD803 */
 };
 static struct regulator_consumer_supply __initdata max8997_ldo8_[] = {
-	REGULATOR_SUPPLY("vusb_d", NULL), /* Used by CPU */
+	REGULATOR_SUPPLY("vusb_a", "s3c-hsotg"), /* USB */
 	REGULATOR_SUPPLY("vdac", NULL), /* Used by CPU */
 };
 static struct regulator_consumer_supply __initdata max8997_ldo11_[] = {
@@ -1112,6 +1114,9 @@ static void __init nuri_ehci_init(void)
 	s5p_ehci_set_platdata(pdata);
 }
 
+/* USB OTG */
+static struct s3c_hsotg_plat nuri_hsotg_pdata;
+
 /* CAMERA */
 static struct regulator_consumer_supply cam_vdda_supply[] = {
 	REGULATOR_SUPPLY("a_sensor", "0-001f"),
@@ -1270,6 +1275,7 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&exynos4_device_pd[PD_LCD0],
 	&exynos4_device_pd[PD_CAM],
 	&s5p_device_fimc_md,
+	&s3c_device_usb_hsotg,
 
 	/* NURI Devices */
 	&nuri_gpio_keys,
@@ -1315,6 +1321,7 @@ static void __init nuri_machine_init(void)
 	nuri_camera_init();
 
 	nuri_ehci_init();
+	s3c_hsotg_set_platdata(&nuri_hsotg_pdata);
 	clk_xusbxti.rate = 24000000;
 
 	/* Last */
-- 
1.7.5.4
