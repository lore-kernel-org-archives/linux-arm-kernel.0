From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:02:54 +0000
Subject: [PATCH] ARM: S3C64XX: Squash SDHCI setup into one file
In-Reply-To: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
References: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264489385-13345-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Squash the SDHCI setup for both the S3C6400 and S3C6410 into one file and
make the S3C6410 case use the S3C6400 code.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/Kconfig                      |   17 ++---
 arch/arm/mach-s3c64xx/Makefile                     |    3 +-
 arch/arm/mach-s3c64xx/setup-sdhci-s3c6410.c        |   68 --------------------
 .../{setup-sdhci-s3c6400.c => setup-sdhci.c}       |   13 +++-
 arch/arm/plat-samsung/include/plat/sdhci.h         |   43 ++++++-------
 5 files changed, 37 insertions(+), 107 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/setup-sdhci-s3c6410.c
 rename arch/arm/mach-s3c64xx/{setup-sdhci-s3c6400.c => setup-sdhci.c} (81%)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 551bb3f..ce32e49 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -19,17 +19,12 @@ config CPU_S3C6410
 	help
 	  Enable S3C6410 CPU support
 
-config S3C6400_SETUP_SDHCI
-	bool
-	help
-	  Internal configuration for default SDHCI
-	  setup for S3C6400.
-
-config S3C6410_SETUP_SDHCI
-	bool
+config S3C64XX_SETUP_SDHCI
 	select S3C64XX_SETUP_SDHCI_GPIO
+	bool
 	help
-	  Internal helper functions for S3C6410 based SDHCI systems
+	  Internal configuration for default SDHCI setup for S3C6400 and
+	  S3C6410 SoCs.
 
 # S36400 Macchine support
 
@@ -38,7 +33,7 @@ config MACH_SMDK6400
 	select CPU_S3C6400
 	select S3C_DEV_HSMMC
 	select S3C_DEV_NAND
-	select S3C6400_SETUP_SDHCI
+	select S3C64XX_SETUP_SDHCI
 	help
 	  Machine support for the Samsung SMDK6400
 
@@ -61,7 +56,7 @@ config MACH_SMDK6410
 	select S3C_DEV_FB
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_USB_HSOTG
-	select S3C6410_SETUP_SDHCI
+	select S3C64XX_SETUP_SDHCI
 	select S3C64XX_SETUP_I2C1
 	select S3C64XX_SETUP_FB_24BPP
 	help
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 24a3bc3..21ddf6b 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -17,8 +17,7 @@ obj-$(CONFIG_CPU_S3C6410)	+= s3c6410.o
 
 # setup support
 
-obj-$(CONFIG_S3C6400_SETUP_SDHCI) += setup-sdhci-s3c6400.o
-obj-$(CONFIG_S3C6410_SETUP_SDHCI) += setup-sdhci-s3c6410.o
+obj-$(CONFIG_S3C64XX_SETUP_SDHCI) += setup-sdhci.o
 
 # Machine support
 
diff --git a/arch/arm/mach-s3c64xx/setup-sdhci-s3c6410.c b/arch/arm/mach-s3c64xx/setup-sdhci-s3c6410.c
deleted file mode 100644
index 8d714a1..0000000
--- a/arch/arm/mach-s3c64xx/setup-sdhci-s3c6410.c
+++ /dev/null
@@ -1,68 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/setup-sdhci.c
- *
- * Copyright 2008 Simtec Electronics
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C6410 - Helper functions for settign up SDHCI device(s) (HSMMC)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-
-#include <linux/mmc/card.h>
-#include <linux/mmc/host.h>
-
-#include <plat/regs-sdhci.h>
-#include <plat/sdhci.h>
-
-/* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
-
-char *s3c6410_hsmmc_clksrcs[4] = {
-	[0] = "hsmmc",
-	[1] = "hsmmc",
-	[2] = "mmc_bus",
-	/* [3] = "48m", - note not successfully used yet */
-};
-
-
-void s3c6410_setup_sdhci0_cfg_card(struct platform_device *dev,
-				    void __iomem *r,
-				    struct mmc_ios *ios,
-				    struct mmc_card *card)
-{
-	u32 ctrl2, ctrl3;
-
-	/* don't need to alter anything acording to card-type */
-
-	writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA, r + S3C64XX_SDHCI_CONTROL4);
-
-	ctrl2 = readl(r + S3C_SDHCI_CONTROL2);
-	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
-	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
-		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
-		  S3C_SDHCI_CTRL2_ENFBCLKRX |
-		  S3C_SDHCI_CTRL2_DFCNT_NONE |
-		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
-
-	if (ios->clock < 25 * 1000000)
-		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
-			 S3C_SDHCI_CTRL3_FCSEL2 |
-			 S3C_SDHCI_CTRL3_FCSEL1 |
-			 S3C_SDHCI_CTRL3_FCSEL0);
-	else
-		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
-
-	printk(KERN_INFO "%s: CTRL 2=%08x, 3=%08x\n", __func__, ctrl2, ctrl3);
-	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
-	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
-}
-
diff --git a/arch/arm/mach-s3c64xx/setup-sdhci-s3c6400.c b/arch/arm/mach-s3c64xx/setup-sdhci.c
similarity index 81%
rename from arch/arm/mach-s3c64xx/setup-sdhci-s3c6400.c
rename to arch/arm/mach-s3c64xx/setup-sdhci.c
index ec96a58..1a94203 100644
--- a/arch/arm/mach-s3c64xx/setup-sdhci-s3c6400.c
+++ b/arch/arm/mach-s3c64xx/setup-sdhci.c
@@ -5,7 +5,7 @@
  *	Ben Dooks <ben@simtec.co.uk>
  *	http://armlinux.simtec.co.uk/
  *
- * S3C6410 - Helper functions for settign up SDHCI device(s) (HSMMC)
+ * S3C6400/S3C6410 - Helper functions for settign up SDHCI device(s) (HSMMC)
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -26,7 +26,7 @@
 
 /* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
 
-char *s3c6400_hsmmc_clksrcs[4] = {
+char *s3c64xx_hsmmc_clksrcs[4] = {
 	[0] = "hsmmc",
 	[1] = "hsmmc",
 	[2] = "mmc_bus",
@@ -61,3 +61,12 @@ void s3c6400_setup_sdhci_cfg_card(struct platform_device *dev,
 	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
 }
 
+void s3c6410_setup_sdhci_cfg_card(struct platform_device *dev,
+				  void __iomem *r,
+				  struct mmc_ios *ios,
+				  struct mmc_card *card)
+{
+	writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA, r + S3C64XX_SDHCI_CONTROL4);
+
+	s3c6400_setup_sdhci_cfg_card(dev, r, ios, card);
+}
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 5319867..7d07cd7 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -78,8 +78,8 @@ extern void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 
 /* S3C6400 SDHCI setup */
 
-#ifdef CONFIG_S3C6400_SETUP_SDHCI
-extern char *s3c6400_hsmmc_clksrcs[4];
+#ifdef CONFIG_S3C64XX_SETUP_SDHCI
+extern char *s3c64xx_hsmmc_clksrcs[4];
 
 #ifdef CONFIG_S3C_DEV_HSMMC
 extern void s3c6400_setup_sdhci_cfg_card(struct platform_device *dev,
@@ -89,7 +89,7 @@ extern void s3c6400_setup_sdhci_cfg_card(struct platform_device *dev,
 
 static inline void s3c6400_default_sdhci0(void)
 {
-	s3c_hsmmc0_def_platdata.clocks = s3c6400_hsmmc_clksrcs;
+	s3c_hsmmc0_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc0_def_platdata.cfg_gpio = s3c64xx_setup_sdhci0_cfg_gpio;
 	s3c_hsmmc0_def_platdata.cfg_card = s3c6400_setup_sdhci_cfg_card;
 }
@@ -101,7 +101,7 @@ static inline void s3c6400_default_sdhci0(void) { }
 #ifdef CONFIG_S3C_DEV_HSMMC1
 static inline void s3c6400_default_sdhci1(void)
 {
-	s3c_hsmmc1_def_platdata.clocks = s3c6400_hsmmc_clksrcs;
+	s3c_hsmmc1_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s3c64xx_setup_sdhci1_cfg_gpio;
 	s3c_hsmmc1_def_platdata.cfg_card = s3c6400_setup_sdhci_cfg_card;
 }
@@ -112,7 +112,7 @@ static inline void s3c6400_default_sdhci1(void) { }
 #ifdef CONFIG_S3C_DEV_HSMMC2
 static inline void s3c6400_default_sdhci2(void)
 {
-	s3c_hsmmc2_def_platdata.clocks = s3c6400_hsmmc_clksrcs;
+	s3c_hsmmc2_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = s3c64xx_setup_sdhci2_cfg_gpio;
 	s3c_hsmmc2_def_platdata.cfg_card = s3c6400_setup_sdhci_cfg_card;
 }
@@ -120,27 +120,19 @@ static inline void s3c6400_default_sdhci2(void)
 static inline void s3c6400_default_sdhci2(void) { }
 #endif /* CONFIG_S3C_DEV_HSMMC2 */
 
-#else
-static inline void s3c6400_default_sdhci0(void) { }
-static inline void s3c6400_default_sdhci1(void) { }
-#endif /* CONFIG_S3C6400_SETUP_SDHCI */
-
 /* S3C6410 SDHCI setup */
 
-#ifdef CONFIG_S3C6410_SETUP_SDHCI
-extern char *s3c6410_hsmmc_clksrcs[4];
-
-extern void s3c6410_setup_sdhci0_cfg_card(struct platform_device *dev,
-					   void __iomem *r,
-					   struct mmc_ios *ios,
-					   struct mmc_card *card);
+extern void s3c6410_setup_sdhci_cfg_card(struct platform_device *dev,
+					 void __iomem *r,
+					 struct mmc_ios *ios,
+					 struct mmc_card *card);
 
 #ifdef CONFIG_S3C_DEV_HSMMC
 static inline void s3c6410_default_sdhci0(void)
 {
-	s3c_hsmmc0_def_platdata.clocks = s3c6410_hsmmc_clksrcs;
+	s3c_hsmmc0_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc0_def_platdata.cfg_gpio = s3c64xx_setup_sdhci0_cfg_gpio;
-	s3c_hsmmc0_def_platdata.cfg_card = s3c6410_setup_sdhci0_cfg_card;
+	s3c_hsmmc0_def_platdata.cfg_card = s3c6410_setup_sdhci_cfg_card;
 }
 #else
 static inline void s3c6410_default_sdhci0(void) { }
@@ -149,9 +141,9 @@ static inline void s3c6410_default_sdhci0(void) { }
 #ifdef CONFIG_S3C_DEV_HSMMC1
 static inline void s3c6410_default_sdhci1(void)
 {
-	s3c_hsmmc1_def_platdata.clocks = s3c6410_hsmmc_clksrcs;
+	s3c_hsmmc1_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s3c64xx_setup_sdhci1_cfg_gpio;
-	s3c_hsmmc1_def_platdata.cfg_card = s3c6410_setup_sdhci0_cfg_card;
+	s3c_hsmmc1_def_platdata.cfg_card = s3c6410_setup_sdhci_cfg_card;
 }
 #else
 static inline void s3c6410_default_sdhci1(void) { }
@@ -160,9 +152,9 @@ static inline void s3c6410_default_sdhci1(void) { }
 #ifdef CONFIG_S3C_DEV_HSMMC2
 static inline void s3c6410_default_sdhci2(void)
 {
-	s3c_hsmmc2_def_platdata.clocks = s3c6410_hsmmc_clksrcs;
+	s3c_hsmmc2_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = s3c64xx_setup_sdhci2_cfg_gpio;
-	s3c_hsmmc2_def_platdata.cfg_card = s3c6410_setup_sdhci0_cfg_card;
+	s3c_hsmmc2_def_platdata.cfg_card = s3c6410_setup_sdhci_cfg_card;
 }
 #else
 static inline void s3c6410_default_sdhci2(void) { }
@@ -171,7 +163,10 @@ static inline void s3c6410_default_sdhci2(void) { }
 #else
 static inline void s3c6410_default_sdhci0(void) { }
 static inline void s3c6410_default_sdhci1(void) { }
-#endif /* CONFIG_S3C6410_SETUP_SDHCI */
+static inline void s3c6400_default_sdhci0(void) { }
+static inline void s3c6400_default_sdhci1(void) { }
+
+#endif /* CONFIG_S3C64XX_SETUP_SDHCI */
 
 /* S5PC100 SDHCI setup */
 
-- 
1.6.0.4
