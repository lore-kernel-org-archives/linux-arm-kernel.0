From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:16 +0900
Subject: [PATCH 19/27] ARM: S5PC100: 2nd Change to using
	s3c_gpio_cfgall_range()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-20-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the code setting range of GPIO pins' configuration and
pull state to use the recently introduced s3c_gpio_cfgpin_range().
NOTE: This is for missed things from the previous patch.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pc100/dev-spi.c      |   17 +++++---------
 arch/arm/mach-s5pc100/setup-i2c0.c   |    6 +---
 arch/arm/mach-s5pc100/setup-i2c1.c   |    6 +---
 arch/arm/mach-s5pc100/setup-ide.c    |   42 ++++++++++++---------------------
 arch/arm/mach-s5pc100/setup-keypad.c |   17 +++----------
 5 files changed, 29 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mach-s5pc100/dev-spi.c b/arch/arm/mach-s5pc100/dev-spi.c
index c1c5aed..57b1979 100644
--- a/arch/arm/mach-s5pc100/dev-spi.c
+++ b/arch/arm/mach-s5pc100/dev-spi.c
@@ -38,25 +38,20 @@ static int s5pc100_spi_cfg_gpio(struct platform_device *pdev)
 {
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin_range(S5PC100_GPB(0), 3, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(S5PC100_GPB(0), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5PC100_GPB(1), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5PC100_GPB(2), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgall_range(S5PC100_GPB(0), 3,
+				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 		break;
 
 	case 1:
-		s3c_gpio_cfgpin_range(S5PC100_GPB(4), 3, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(S5PC100_GPB(4), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5PC100_GPB(5), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5PC100_GPB(6), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgall_range(S5PC100_GPB(4), 3,
+				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 		break;
 
 	case 2:
 		s3c_gpio_cfgpin(S5PC100_GPG3(0), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin_range(S5PC100_GPB(2), 2, S3C_GPIO_SFN(3));
 		s3c_gpio_setpull(S5PC100_GPG3(0), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5PC100_GPG3(2), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5PC100_GPG3(3), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgall_range(S5PC100_GPB(2), 2,
+				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
 		break;
 
 	default:
diff --git a/arch/arm/mach-s5pc100/setup-i2c0.c b/arch/arm/mach-s5pc100/setup-i2c0.c
index dd3174e..eaef7a3 100644
--- a/arch/arm/mach-s5pc100/setup-i2c0.c
+++ b/arch/arm/mach-s5pc100/setup-i2c0.c
@@ -23,8 +23,6 @@ struct platform_device; /* don't need the contents */
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgpin(S5PC100_GPD(3), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PC100_GPD(3), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PC100_GPD(4), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PC100_GPD(4), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S5PC100_GPD(3), 2,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5pc100/setup-i2c1.c b/arch/arm/mach-s5pc100/setup-i2c1.c
index d1fec26..aaff74a 100644
--- a/arch/arm/mach-s5pc100/setup-i2c1.c
+++ b/arch/arm/mach-s5pc100/setup-i2c1.c
@@ -23,8 +23,6 @@ struct platform_device; /* don't need the contents */
 
 void s3c_i2c1_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgpin(S5PC100_GPD(5), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PC100_GPD(5), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PC100_GPD(6), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PC100_GPD(6), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S5PC100_GPD(5), 2,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5pc100/setup-ide.c b/arch/arm/mach-s5pc100/setup-ide.c
index 8357567..d8b0d0e 100644
--- a/arch/arm/mach-s5pc100/setup-ide.c
+++ b/arch/arm/mach-s5pc100/setup-ide.c
@@ -17,52 +17,40 @@
 #include <mach/regs-clock.h>
 #include <plat/gpio-cfg.h>
 
+static void s5pc100_ide_cfg_gpios(unsigned int base, unsigned int nr)
+{
+	s3c_gpio_cfgall_range(base, nr, S3C_GPIO_SFN(4), S3C_GPIO_PULL_NONE);
+
+	for (; nr > 0; nr--, base++)
+		s5p_gpio_set_drvstr(base, S5P_GPIO_DRVSTR_LV4);
+}
+
 void s5pc100_ide_setup_gpio(void)
 {
 	u32 reg;
-	u32 gpio = 0;
 
 	/* Independent CF interface, CF chip select configuration */
 	reg = readl(S5PC100_MEM_SYS_CFG) & (~0x3f);
 	writel(reg | MEM_SYS_CFG_EBI_FIX_PRI_CFCON, S5PC100_MEM_SYS_CFG);
 
 	/* CF_Add[0 - 2], CF_IORDY, CF_INTRQ, CF_DMARQ, CF_DMARST, CF_DMACK */
-	for (gpio = S5PC100_GPJ0(0); gpio <= S5PC100_GPJ0(7); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
+	s5pc100_ide_cfg_gpios(S5PC100_GPJ0(0), 8);
 
 	/*CF_Data[0 - 7] */
-	for (gpio = S5PC100_GPJ2(0); gpio <= S5PC100_GPJ2(7); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
+	s5pc100_ide_cfg_gpios(S5PC100_GPJ2(0), 8);
 
 	/* CF_Data[8 - 15] */
-	for (gpio = S5PC100_GPJ3(0); gpio <= S5PC100_GPJ3(7); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
+	s5pc100_ide_cfg_gpios(S5PC100_GPJ3(0), 8);
 
 	/* CF_CS0, CF_CS1, CF_IORD, CF_IOWR */
-	for (gpio = S5PC100_GPJ4(0); gpio <= S5PC100_GPJ4(3); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
+	s5pc100_ide_cfg_gpios(S5PC100_GPJ4(0), 4);
 
 	/* EBI_OE, EBI_WE */
-	for (gpio = S5PC100_GPK0(6); gpio <= S5PC100_GPK0(7); gpio++)
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0));
+	s3c_gpio_cfgpin_range(S5PC100_GPK0(6), 2, S3C_GPIO_SFN(0));
 
 	/* CF_OE, CF_WE */
-	for (gpio = S5PC100_GPK1(6); gpio <= S5PC100_GPK1(7); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S5PC100_GPK1(6), 8,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 
 	/* CF_CD */
 	s3c_gpio_cfgpin(S5PC100_GPK3(5), S3C_GPIO_SFN(2));
diff --git a/arch/arm/mach-s5pc100/setup-keypad.c b/arch/arm/mach-s5pc100/setup-keypad.c
index d0837a7..966b49f 100644
--- a/arch/arm/mach-s5pc100/setup-keypad.c
+++ b/arch/arm/mach-s5pc100/setup-keypad.c
@@ -15,20 +15,11 @@
 
 void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
 {
-	unsigned int gpio;
-	unsigned int end;
-
 	/* Set all the necessary GPH3 pins to special-function 3: KP_ROW[x] */
-	end = S5PC100_GPH3(rows);
-	for (gpio = S5PC100_GPH3(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S5PC100_GPH3(0), rows,
+			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
 
 	/* Set all the necessary GPH2 pins to special-function 3: KP_COL[x] */
-	end = S5PC100_GPH2(cols);
-	for (gpio = S5PC100_GPH2(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S5PC100_GPH2(0), cols,
+			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
 }
-- 
1.6.2.5
