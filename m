From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 17 Nov 2009 08:41:21 +0100
Subject: [PATCH 11/14] ARM: S5PC1xx: add platform helpers for i2c adapter
	devices
In-Reply-To: <1258443684-19525-11-git-send-email-m.szyprowski@samsung.com>
References: <1258443684-19525-1-git-send-email-m.szyprowski@samsung.com>
	<1258443684-19525-2-git-send-email-m.szyprowski@samsung.com>
	<1258443684-19525-3-git-send-email-m.szyprowski@samsung.com>
	<1258443684-19525-4-git-send-email-m.szyprowski@samsung.com>
	<1258443684-19525-5-git-send-email-m.szyprowski@samsung.com>
	<1258443684-19525-6-git-send-email-m.szyprowski@samsung.com>
	<1258443684-19525-7-git-send-email-m.szyprowski@samsung.com>
	<1258443684-19525-8-git-send-email-m.szyprowski@samsung.com>
	<1258443684-19525-9-git-send-email-m.szyprowski@samsung.com>
	<1258443684-19525-10-git-send-email-m.szyprowski@samsung.com>
	<1258443684-19525-11-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1258443684-19525-12-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Samsung S5PC100 has I2C bus controller compatible with the one known from
previous SoCs series. Add required platform setup and support code that
it can be used with s3c2410-i2c driver.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc100/cpu.c        |    4 ++++
 arch/arm/plat-s5pc1xx/Kconfig      |    4 ++--
 arch/arm/plat-s5pc1xx/Makefile     |    4 ++--
 arch/arm/plat-s5pc1xx/setup-i2c0.c |    7 ++++++-
 arch/arm/plat-s5pc1xx/setup-i2c1.c |    7 ++++++-
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
index a23ca57..1319e3d 100644
--- a/arch/arm/mach-s5pc100/cpu.c
+++ b/arch/arm/mach-s5pc100/cpu.c
@@ -75,6 +75,10 @@ void __init s5pc100_map_io(void)
 	iotable_init(s5pc100_iodesc, ARRAY_SIZE(s5pc100_iodesc));
 
 	/* initialise device information early */
+
+	/* the i2c devices are directly compatible with s3c2440 */
+	s3c_i2c0_setname("s3c2440-i2c");
+	s3c_i2c1_setname("s3c2440-i2c");
 }
 
 void __init s5pc100_init_clocks(int xtal)
diff --git a/arch/arm/plat-s5pc1xx/Kconfig b/arch/arm/plat-s5pc1xx/Kconfig
index 6ac48a6..1fc25b9 100644
--- a/arch/arm/plat-s5pc1xx/Kconfig
+++ b/arch/arm/plat-s5pc1xx/Kconfig
@@ -42,7 +42,7 @@ config S5PC1XX_SETUP_FB_24BPP
 	help
           Common setup code for S5PC1XX with an 24bpp RGB display helper.
 
-config S5PC100_SETUP_I2C0
+config S5PC1XX_SETUP_I2C0
 	bool
 	default y
 	help
@@ -51,7 +51,7 @@ config S5PC100_SETUP_I2C0
 	  Note, currently since i2c0 is always compiled, this setup helper
 	  is always compiled with it.
 
-config S5PC100_SETUP_I2C1
+config S5PC1XX_SETUP_I2C1
 	bool
 	help
 	  Common setup code for i2c bus 1.
diff --git a/arch/arm/plat-s5pc1xx/Makefile b/arch/arm/plat-s5pc1xx/Makefile
index 3d2ac71..40ee957 100644
--- a/arch/arm/plat-s5pc1xx/Makefile
+++ b/arch/arm/plat-s5pc1xx/Makefile
@@ -26,5 +26,5 @@ obj-$(CONFIG_CPU_S5PC100_CLOCK)	+= s5pc100-clock.o
 
 obj-$(CONFIG_S5P_GPIO_CFG_S5PC1XX) += gpio-config.o
 obj-$(CONFIG_S5PC1XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
-obj-$(CONFIG_S5PC100_SETUP_I2C0) += setup-i2c0.o
-obj-$(CONFIG_S5PC100_SETUP_I2C1) += setup-i2c1.o
+obj-$(CONFIG_S5PC1XX_SETUP_I2C0) += setup-i2c0.o
+obj-$(CONFIG_S5PC1XX_SETUP_I2C1) += setup-i2c1.o
diff --git a/arch/arm/plat-s5pc1xx/setup-i2c0.c b/arch/arm/plat-s5pc1xx/setup-i2c0.c
index 3d00c02..5e4a7c3 100644
--- a/arch/arm/plat-s5pc1xx/setup-i2c0.c
+++ b/arch/arm/plat-s5pc1xx/setup-i2c0.c
@@ -17,9 +17,14 @@
 
 struct platform_device; /* don't need the contents */
 
+#include <linux/gpio.h>
 #include <plat/iic.h>
+#include <plat/gpio-cfg.h>
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
-	/* Pin configuration would be needed */
+	s3c_gpio_cfgpin(S5PC100_GPD(3), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PC100_GPD(3), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC100_GPD(4), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PC100_GPD(4), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/plat-s5pc1xx/setup-i2c1.c b/arch/arm/plat-s5pc1xx/setup-i2c1.c
index c8f3ca4..a0a8b4a 100644
--- a/arch/arm/plat-s5pc1xx/setup-i2c1.c
+++ b/arch/arm/plat-s5pc1xx/setup-i2c1.c
@@ -17,9 +17,14 @@
 
 struct platform_device; /* don't need the contents */
 
+#include <linux/gpio.h>
 #include <plat/iic.h>
+#include <plat/gpio-cfg.h>
 
 void s3c_i2c1_cfg_gpio(struct platform_device *dev)
 {
-	/* Pin configuration would be needed */
+	s3c_gpio_cfgpin(S5PC100_GPD(5), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PC100_GPD(5), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC100_GPD(6), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PC100_GPD(6), S3C_GPIO_PULL_UP);
 }
-- 
1.6.4
