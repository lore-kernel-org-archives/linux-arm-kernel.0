From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:17 +0900
Subject: [PATCH 20/27] ARM: S5PV210: 2nd Change to using
	s3c_gpio_cfgall_range()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-21-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the code setting range of GPIO pins' configuration and
pull state to use the recently introduced s3c_gpio_cfgpin_range().
NOTE: This is for missed things from the previous patch.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/dev-spi.c      |   19 +++++--------
 arch/arm/mach-s5pv210/setup-i2c0.c   |    6 +---
 arch/arm/mach-s5pv210/setup-i2c1.c   |    6 +---
 arch/arm/mach-s5pv210/setup-i2c2.c   |    6 +---
 arch/arm/mach-s5pv210/setup-ide.c    |   49 +++++++++++++--------------------
 arch/arm/mach-s5pv210/setup-keypad.c |   16 +++--------
 6 files changed, 36 insertions(+), 66 deletions(-)

diff --git a/arch/arm/mach-s5pv210/dev-spi.c b/arch/arm/mach-s5pv210/dev-spi.c
index 826cdbc..e3249a4 100644
--- a/arch/arm/mach-s5pv210/dev-spi.c
+++ b/arch/arm/mach-s5pv210/dev-spi.c
@@ -35,23 +35,15 @@ static char *spi_src_clks[] = {
  */
 static int s5pv210_spi_cfg_gpio(struct platform_device *pdev)
 {
+	unsigned int base;
+
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin(S5PV210_GPB(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPB(1), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPB(2), S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(S5PV210_GPB(0), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5PV210_GPB(1), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5PV210_GPB(2), S3C_GPIO_PULL_UP);
+		base = S5PV210_GPB(0);
 		break;
 
 	case 1:
-		s3c_gpio_cfgpin(S5PV210_GPB(4), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPB(5), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPB(6), S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(S5PV210_GPB(4), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5PV210_GPB(5), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5PV210_GPB(6), S3C_GPIO_PULL_UP);
+		base = S5PV210_GPB(4);
 		break;
 
 	default:
@@ -59,6 +51,9 @@ static int s5pv210_spi_cfg_gpio(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	s3c_gpio_cfgall_range(base, 3,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-s5pv210/setup-i2c0.c b/arch/arm/mach-s5pv210/setup-i2c0.c
index d38f7cb..0f1cc3a 100644
--- a/arch/arm/mach-s5pv210/setup-i2c0.c
+++ b/arch/arm/mach-s5pv210/setup-i2c0.c
@@ -23,8 +23,6 @@ struct platform_device; /* don't need the contents */
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgpin(S5PV210_GPD1(0), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PV210_GPD1(0), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PV210_GPD1(1), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PV210_GPD1(1), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S5PV210_GPD1(0), 2,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5pv210/setup-i2c1.c b/arch/arm/mach-s5pv210/setup-i2c1.c
index 148bb78..f61365a 100644
--- a/arch/arm/mach-s5pv210/setup-i2c1.c
+++ b/arch/arm/mach-s5pv210/setup-i2c1.c
@@ -23,8 +23,6 @@ struct platform_device; /* don't need the contents */
 
 void s3c_i2c1_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgpin(S5PV210_GPD1(2), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PV210_GPD1(2), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PV210_GPD1(3), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PV210_GPD1(3), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S5PV210_GPD1(2), 2,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5pv210/setup-i2c2.c b/arch/arm/mach-s5pv210/setup-i2c2.c
index 2396cb8..2f91b5c 100644
--- a/arch/arm/mach-s5pv210/setup-i2c2.c
+++ b/arch/arm/mach-s5pv210/setup-i2c2.c
@@ -23,8 +23,6 @@ struct platform_device; /* don't need the contents */
 
 void s3c_i2c2_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgpin(S5PV210_GPD1(4), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PV210_GPD1(4), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PV210_GPD1(5), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PV210_GPD1(5), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S5PV210_GPD1(4), 2,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5pv210/setup-ide.c b/arch/arm/mach-s5pv210/setup-ide.c
index b558b1c..d7cd10f 100644
--- a/arch/arm/mach-s5pv210/setup-ide.c
+++ b/arch/arm/mach-s5pv210/setup-ide.c
@@ -15,36 +15,25 @@
 
 #include <plat/gpio-cfg.h>
 
+static void s5pv210_ide_cfg_gpios(unsigned int base, unsigned int nr)
+{
+	s3c_gpio_cfgall_range(base, nr, S3C_GPIO_SFN(4), S3C_GPIO_PULL_NONE);
+
+	for (; nr > 0; nr--, base++)
+		s5p_gpio_set_drvstr(base, S5P_GPIO_DRVSTR_LV4);
+}
+
 void s5pv210_ide_setup_gpio(void)
 {
-	unsigned int gpio = 0;
-
-	for (gpio = S5PV210_GPJ0(0); gpio <= S5PV210_GPJ0(7); gpio++) {
-		/* CF_Add[0 - 2], CF_IORDY, CF_INTRQ, CF_DMARQ, CF_DMARST,
-			CF_DMACK */
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
-
-	for (gpio = S5PV210_GPJ2(0); gpio <= S5PV210_GPJ2(7); gpio++) {
-		/*CF_Data[0 - 7] */
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
-
-	for (gpio = S5PV210_GPJ3(0); gpio <= S5PV210_GPJ3(7); gpio++) {
-		/* CF_Data[8 - 15] */
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
-
-	for (gpio = S5PV210_GPJ4(0); gpio <= S5PV210_GPJ4(3); gpio++) {
-		/* CF_CS0, CF_CS1, CF_IORD, CF_IOWR */
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
+	/* CF_Add[0 - 2], CF_IORDY, CF_INTRQ, CF_DMARQ, CF_DMARST, CF_DMACK */
+	s5pv210_ide_cfg_gpios(S5PV210_GPJ0(0), 8);
+
+	/* CF_Data[0 - 7] */
+	s5pv210_ide_cfg_gpios(S5PV210_GPJ2(0), 8);
+
+	/* CF_Data[8 - 15] */
+	s5pv210_ide_cfg_gpios(S5PV210_GPJ3(0), 8);
+
+	/* CF_CS0, CF_CS1, CF_IORD, CF_IOWR */
+	s5pv210_ide_cfg_gpios(S5PV210_GPJ4(0), 4);
 }
diff --git a/arch/arm/mach-s5pv210/setup-keypad.c b/arch/arm/mach-s5pv210/setup-keypad.c
index 37b2790..cb3f409 100644
--- a/arch/arm/mach-s5pv210/setup-keypad.c
+++ b/arch/arm/mach-s5pv210/setup-keypad.c
@@ -16,19 +16,11 @@
 
 void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
 {
-	unsigned int gpio, end;
-
 	/* Set all the necessary GPH3 pins to special-function 3: KP_ROW[x] */
-	end = S5PV210_GPH3(rows);
-	for (gpio = S5PV210_GPH3(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S5PV210_GPH3(0), rows,
+			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
 
 	/* Set all the necessary GPH2 pins to special-function 3: KP_COL[x] */
-	end = S5PV210_GPH2(cols);
-	for (gpio = S5PV210_GPH2(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S5PV210_GPH2(0), cols,
+			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
 }
-- 
1.6.2.5
