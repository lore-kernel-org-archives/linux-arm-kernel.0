From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 17 May 2010 08:53:15 +0200
Subject: [PATCH 7/7] ARM: S5PV210: add common HSMMC device helpers
In-Reply-To: <1274079195-18105-1-git-send-email-m.szyprowski@samsung.com>
References: <1274079195-18105-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1274079195-18105-8-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds sdhci platform helpers required by sdhci-s3c driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig              |   11 +++
 arch/arm/mach-s5pv210/Makefile             |    2 +
 arch/arm/mach-s5pv210/cpu.c                |    6 ++
 arch/arm/mach-s5pv210/include/mach/map.h   |    5 ++
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c   |  103 ++++++++++++++++++++++++++++
 arch/arm/mach-s5pv210/setup-sdhci.c        |   62 +++++++++++++++++
 arch/arm/plat-samsung/include/plat/sdhci.h |   55 +++++++++++++++
 7 files changed, 244 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/setup-sdhci-gpio.c
 create mode 100644 arch/arm/mach-s5pv210/setup-sdhci.c

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 8b5975a..16fbc06 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -30,6 +30,17 @@ config S5PV210_SETUP_FB_24BPP
 	help
           Common setup code for S5PV210 with an 24bpp RGB display helper.
 
+config S5PV210_SETUP_SDHCI
+        bool
+        select S5PV210_SETUP_SDHCI_GPIO
+        help
+          Internal helper functions for S5PV210 based SDHCI systems
+
+config S5PV210_SETUP_SDHCI_GPIO
+	bool
+	help
+	  Common setup code for SDHCI gpio.
+
 config MACH_SMDKV210
 	bool "SMDKV210"
 	select CPU_S5PV210
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index ea7119a..0579d36 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -20,6 +20,8 @@ obj-$(CONFIG_CPU_S5PV210)	+= setup-i2c0.o
 obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
 obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
 obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
+obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
+obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 2d4a3d2..c5d53ab 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -33,6 +33,7 @@
 #include <plat/clock.h>
 #include <plat/s5pv210.h>
 #include <plat/iic-core.h>
+#include <plat/sdhci.h>
 
 /* Initial IO mappings */
 
@@ -77,6 +78,11 @@ void __init s5pv210_map_io(void)
 {
 	iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));
 
+	/* initialise device information early */
+	s5pv210_default_sdhci0();
+	s5pv210_default_sdhci1();
+	s5pv210_default_sdhci2();
+
 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 36bc608..def7762 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -47,6 +47,8 @@
 
 #define S5PV210_PA_FB		(0xF8000000)
 
+#define S5PV210_PA_HSMMC(x)	(0xEB000000 + ((x) * 0x100000))
+
 #define S5PV210_PA_VIC0		(0xF2000000)
 #define S5P_PA_VIC0		S5PV210_PA_VIC0
 
@@ -64,6 +66,9 @@
 
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5PV210_PA_UART
+#define S3C_PA_HSMMC0		S5PV210_PA_HSMMC(0)
+#define S3C_PA_HSMMC1		S5PV210_PA_HSMMC(1)
+#define S3C_PA_HSMMC2		S5PV210_PA_HSMMC(2)
 #define S3C_PA_IIC		S5PV210_PA_IIC0
 #define S3C_PA_IIC1		S5PV210_PA_IIC1
 #define S3C_PA_IIC2		S5PV210_PA_IIC2
diff --git a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
new file mode 100644
index 0000000..140c42e
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
@@ -0,0 +1,103 @@
+/* linux/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c
+ *
+ * Copyright 2009 Samsung Eletronics
+ *
+ * S5PV210 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+
+#include <mach/gpio.h>
+#include <plat/gpio-cfg.h>
+#include <plat/regs-sdhci.h>
+
+void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+
+	/* Set all the necessary GPG0/GPG1 pins to special-function 2 */
+	for (gpio = S5PV210_GPG0(0); gpio < S5PV210_GPG0(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+	switch (width) {
+	case 8:
+		/* GPG1[3:6] special-funtion 3 */
+		for (gpio = S5PV210_GPG1(3); gpio <= S5PV210_GPG1(6); gpio++) {
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		}
+	case 4:
+		/* GPG0[3:6] special-funtion 2 */
+		for (gpio = S5PV210_GPG0(3); gpio <= S5PV210_GPG0(6); gpio++) {
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		}
+	default:
+		break;
+	}
+
+	s3c_gpio_setpull(S5PV210_GPG0(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV210_GPG0(2), S3C_GPIO_SFN(2));
+}
+
+void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+
+	/* Set all the necessary GPG1[0:1] pins to special-function 2 */
+	for (gpio = S5PV210_GPG1(0); gpio < S5PV210_GPG1(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	/* Data pin GPG1[3:6] to special-function 2 */
+	for (gpio = S5PV210_GPG1(3); gpio <= S5PV210_GPG1(6); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	s3c_gpio_setpull(S5PV210_GPG1(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV210_GPG1(2), S3C_GPIO_SFN(2));
+}
+
+void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+
+	/* Set all the necessary GPG2[0:1] pins to special-function 2 */
+	for (gpio = S5PV210_GPG2(0); gpio < S5PV210_GPG2(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	switch (width) {
+	case 8:
+		/* Data pin GPG3[3:6] to special-function 3 */
+		for (gpio = S5PV210_GPG3(3); gpio <= S5PV210_GPG3(6); gpio++) {
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		}
+	case 4:
+		/* Data pin GPG2[3:6] to special-function 2 */
+		for (gpio = S5PV210_GPG2(3); gpio <= S5PV210_GPG2(6); gpio++) {
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		}
+	default:
+		break;
+	}
+
+	s3c_gpio_setpull(S5PV210_GPG2(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV210_GPG2(2), S3C_GPIO_SFN(2));
+}
diff --git a/arch/arm/mach-s5pv210/setup-sdhci.c b/arch/arm/mach-s5pv210/setup-sdhci.c
new file mode 100644
index 0000000..e70472b
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-sdhci.c
@@ -0,0 +1,62 @@
+/* linux/arch/arm/mach-s5pv200/setup-sdhci.c
+ *
+ * Copyright 2008 Samsung Electronics
+ *
+ * S5PV210 - Helper functions for settign up SDHCI device(s) (HSMMC)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+
+#include <plat/regs-sdhci.h>
+#include <plat/sdhci.h>
+
+/* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
+
+char *s5pv210_hsmmc_clksrcs[4] = {
+	[0] = "hsmmc",		/* HCLK */
+	[1] = "hsmmc",		/* HCLK */
+	[2] = "sclk_mmc",	/* mmc_bus */
+	/*[4] = reserved */
+};
+
+void s5pv210_setup_sdhci_cfg_card(struct platform_device *dev,
+				    void __iomem *r,
+				    struct mmc_ios *ios,
+				    struct mmc_card *card)
+{
+	u32 ctrl2, ctrl3;
+
+	/* don't need to alter anything acording to card-type */
+
+	writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA, r + S3C64XX_SDHCI_CONTROL4);
+
+	ctrl2 = readl(r + S3C_SDHCI_CONTROL2);
+	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
+	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
+		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
+		  S3C_SDHCI_CTRL2_ENFBCLKRX |
+		  S3C_SDHCI_CTRL2_DFCNT_NONE |
+		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
+
+	if (ios->clock < 25 * 1000000)
+		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
+			 S3C_SDHCI_CTRL3_FCSEL2 |
+			 S3C_SDHCI_CTRL3_FCSEL1 |
+			 S3C_SDHCI_CTRL3_FCSEL0);
+	else
+		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
+
+	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
+	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
+}
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 7d07cd7..13f9fb2 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -75,6 +75,9 @@ extern void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
 extern void s5pc100_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 extern void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
+extern void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
+extern void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
+extern void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 
 /* S3C6400 SDHCI setup */
 
@@ -218,4 +221,56 @@ static inline void s5pc100_default_sdhci1(void) { }
 static inline void s5pc100_default_sdhci2(void) { }
 #endif /* CONFIG_S5PC100_SETUP_SDHCI */
 
+
+/* S5PC110 SDHCI setup */
+#ifdef CONFIG_S5PV210_SETUP_SDHCI
+extern char *s5pv210_hsmmc_clksrcs[4];
+
+extern void s5pv210_setup_sdhci_cfg_card(struct platform_device *dev,
+					   void __iomem *r,
+					   struct mmc_ios *ios,
+					   struct mmc_card *card);
+
+#ifdef CONFIG_S3C_DEV_HSMMC
+static inline void s5pv210_default_sdhci0(void)
+{
+	s3c_hsmmc0_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
+	s3c_hsmmc0_def_platdata.cfg_gpio = s5pv210_setup_sdhci0_cfg_gpio;
+	s3c_hsmmc0_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
+}
+#else
+static inline void s5pc100_default_sdhci0(void) { }
+#endif /* CONFIG_S3C_DEV_HSMMC */
+
+#ifdef CONFIG_S3C_DEV_HSMMC1
+static inline void s5pv210_default_sdhci1(void)
+{
+	s3c_hsmmc1_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
+	s3c_hsmmc1_def_platdata.cfg_gpio = s5pv210_setup_sdhci1_cfg_gpio;
+	s3c_hsmmc1_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
+}
+#else
+static inline void s5pv210_default_sdhci1(void) { }
+#endif /* CONFIG_S3C_DEV_HSMMC1 */
+
+#ifdef CONFIG_S3C_DEV_HSMMC2
+static inline void s5pv210_default_sdhci2(void)
+{
+	s3c_hsmmc2_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
+	s3c_hsmmc2_def_platdata.cfg_gpio = s5pv210_setup_sdhci2_cfg_gpio;
+	s3c_hsmmc2_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
+}
+#else
+static inline void s5pv210_default_sdhci2(void) { }
+#endif /* CONFIG_S3C_DEV_HSMMC2 */
+
+#else
+static inline void s5pv210_default_sdhci0(void) { }
+static inline void s5pv210_default_sdhci1(void) { }
+static inline void s5pv210_default_sdhci2(void) { }
+#endif /* CONFIG_S5PC100_SETUP_SDHCI */
+
+
+
+
 #endif /* __PLAT_S3C_SDHCI_H */
-- 
1.6.4
