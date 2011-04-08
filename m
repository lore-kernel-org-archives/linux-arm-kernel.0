From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Fri, 08 Apr 2011 13:22:11 +0900
Subject: [PATCH 3/4] ARM: EXYNOS4: Add usb ehci device to the NURI board
In-Reply-To: <1302236532-27636-1-git-send-email-jy0922.shim@samsung.com>
References: <1302236532-27636-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <1302236532-27636-3-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to support usb ehci device to the NURI board.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig     |    1 +
 arch/arm/mach-exynos4/mach-nuri.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 11b57a4..b92c1e5 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -171,6 +171,7 @@ config MACH_NURI
 	select S3C_DEV_I2C1
 	select S3C_DEV_I2C3
 	select S3C_DEV_I2C5
+	select S5P_DEV_USB_EHCI
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_I2C3
 	select EXYNOS4_SETUP_I2C5
diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index d13c5e8..40bd720 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -33,6 +33,8 @@
 #include <plat/sdhci.h>
 #include <plat/gpio-cfg.h>
 #include <plat/iic.h>
+#include <plat/ehci.h>
+#include <plat/clock.h>
 
 #include <mach/map.h>
 
@@ -347,6 +349,16 @@ static struct i2c_board_info i2c5_devs[] __initdata = {
 	/* max8997, To be updated */
 };
 
+/* USB EHCI */
+static struct s5p_ehci_platdata nuri_ehci_pdata;
+
+static void __init nuri_ehci_init(void)
+{
+	struct s5p_ehci_platdata *pdata = &nuri_ehci_pdata;
+
+	s5p_ehci_set_platdata(pdata);
+}
+
 static struct platform_device *nuri_devices[] __initdata = {
 	/* Samsung Platform Devices */
 	&emmc_fixed_voltage,
@@ -356,6 +368,7 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&s3c_device_wdt,
 	&s3c_device_timer[0],
 	&s3c_device_i2c3,
+	&s5p_device_ehci,
 
 	/* NURI Devices */
 	&nuri_gpio_keys,
@@ -380,6 +393,9 @@ static void __init nuri_machine_init(void)
 	i2c_register_board_info(3, i2c3_devs, ARRAY_SIZE(i2c3_devs));
 	i2c_register_board_info(5, i2c5_devs, ARRAY_SIZE(i2c5_devs));
 
+	nuri_ehci_init();
+	clk_xusbxti.rate = 24000000;
+
 	/* Last */
 	platform_add_devices(nuri_devices, ARRAY_SIZE(nuri_devices));
 }
-- 
1.7.0.4
