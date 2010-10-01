From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:14 +0900
Subject: [PATCH 17/27] ARM: S3C64XX: 2nd Change to using
	s3c_gpio_cfgall_range()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-18-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the code setting range of GPIO pins' configuration and
pull state to use the recently introduced s3c_gpio_cfgpin_range().
NOTE: This is for missed things from the previous patch.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/setup-ide.c    |   10 +++-------
 arch/arm/mach-s3c64xx/setup-keypad.c |   17 ++++-------------
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/setup-ide.c b/arch/arm/mach-s3c64xx/setup-ide.c
index c12c315..de645e9 100644
--- a/arch/arm/mach-s3c64xx/setup-ide.c
+++ b/arch/arm/mach-s3c64xx/setup-ide.c
@@ -21,7 +21,6 @@
 void s3c64xx_ide_setup_gpio(void)
 {
 	u32 reg;
-	u32 gpio = 0;
 
 	reg = readl(S3C_MEM_SYS_CFG) & (~0x3f);
 
@@ -32,15 +31,12 @@ void s3c64xx_ide_setup_gpio(void)
 	s3c_gpio_cfgpin(S3C64XX_GPB(4), S3C_GPIO_SFN(4));
 
 	/* Set XhiDATA[15:0] pins as CF Data[15:0] */
-	for (gpio = S3C64XX_GPK(0); gpio <= S3C64XX_GPK(15); gpio++)
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(5));
+	s3c_gpio_cfgpin_range(S3C64XX_GPK(0), 16, S3C_GPIO_SFN(5));
 
 	/* Set XhiADDR[2:0] pins as CF ADDR[2:0] */
-	for (gpio = S3C64XX_GPL(0); gpio <= S3C64XX_GPL(2); gpio++)
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(6));
+	s3c_gpio_cfgpin_range(S3C64XX_GPL(0), 3, S3C_GPIO_SFN(6));
 
 	/* Set Xhi ctrl pins as CF ctrl pins(IORDY, IOWR, IORD, CE[0:1]) */
 	s3c_gpio_cfgpin(S3C64XX_GPM(5), S3C_GPIO_SFN(1));
-	for (gpio = S3C64XX_GPM(0); gpio <= S3C64XX_GPM(4); gpio++)
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(6));
+	s3c_gpio_cfgpin_range(S3C64XX_GPM(0), 5, S3C_GPIO_SFN(6));
 }
diff --git a/arch/arm/mach-s3c64xx/setup-keypad.c b/arch/arm/mach-s3c64xx/setup-keypad.c
index abc34e4..cc9b09c 100644
--- a/arch/arm/mach-s3c64xx/setup-keypad.c
+++ b/arch/arm/mach-s3c64xx/setup-keypad.c
@@ -15,20 +15,11 @@
 
 void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
 {
-	unsigned int gpio;
-	unsigned int end;
-
 	/* Set all the necessary GPK pins to special-function 3: KP_ROW[x] */
-	end = S3C64XX_GPK(8 + rows);
-	for (gpio = S3C64XX_GPK(8); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S3C64XX_GPK(8), 8 + rows,
+			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
 
 	/* Set all the necessary GPL pins to special-function 3: KP_COL[x] */
-	end = S3C64XX_GPL(0 + cols);
-	for (gpio = S3C64XX_GPL(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S3C64XX_GPL(0), cols,
+			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
 }
-- 
1.6.2.5
