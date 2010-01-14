From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:36 +0100
Subject: [PATCH 18/21] ARM: S5PC1XX: add sdhci platform helpers for s5pc110
	sub-platform
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-19-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Samsung S5PC110 SoC are newer Samsung SoCs. Like S5PC100 they are based
on CortexA8 ARM CPU, but have much more powerfull integrated periperals.
This patch adds common SDHCI platform helper for S5PC110 sub-platform.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc110/Kconfig            |   12 +++
 arch/arm/mach-s5pc110/Makefile           |    2 +
 arch/arm/mach-s5pc110/cpu.c              |    5 +
 arch/arm/mach-s5pc110/setup-sdhci-gpio.c |  123 ++++++++++++++++++++++++++++++
 arch/arm/mach-s5pc110/setup-sdhci.c      |   59 ++++++++++++++
 arch/arm/plat-s3c/include/plat/sdhci.h   |   64 +++++++++++++++
 6 files changed, 265 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pc110/setup-sdhci-gpio.c
 create mode 100644 arch/arm/mach-s5pc110/setup-sdhci.c

diff --git a/arch/arm/mach-s5pc110/Kconfig b/arch/arm/mach-s5pc110/Kconfig
index 6b4d977..0e13f54 100644
--- a/arch/arm/mach-s5pc110/Kconfig
+++ b/arch/arm/mach-s5pc110/Kconfig
@@ -32,4 +32,16 @@ config S5PC110_SETUP_I2C2
 	bool
 	help
 	  Common setup code for i2c bus 2.
+
+config S5PC110_SETUP_SDHCI
+        bool
+        select S5PC110_SETUP_SDHCI_GPIO
+        help
+          Internal helper functions for S5PC110 based SDHCI systems
+
+config S5PC110_SETUP_SDHCI_GPIO
+	bool
+	help
+	  Common setup code for SDHCI gpio.
+
 endif
diff --git a/arch/arm/mach-s5pc110/Makefile b/arch/arm/mach-s5pc110/Makefile
index 93311b3..cf8f4ef 100644
--- a/arch/arm/mach-s5pc110/Makefile
+++ b/arch/arm/mach-s5pc110/Makefile
@@ -21,5 +21,7 @@ obj-$(CONFIG_CPU_S5PC110)	+= uarts.o
 obj-$(CONFIG_S5PC110_SETUP_I2C0)	+= setup-i2c0.o
 obj-$(CONFIG_S5PC110_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5PC110_SETUP_I2C2)	+= setup-i2c2.o
+obj-$(CONFIG_S5PC110_SETUP_SDHCI)       += setup-sdhci.o
+obj-$(CONFIG_S5PC110_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 
 # machine support
diff --git a/arch/arm/mach-s5pc110/cpu.c b/arch/arm/mach-s5pc110/cpu.c
index d16ba68..e72582f 100644
--- a/arch/arm/mach-s5pc110/cpu.c
+++ b/arch/arm/mach-s5pc110/cpu.c
@@ -86,6 +86,11 @@ void __init s5pc110_map_io(void)
 	iotable_init(s5pc110_iodesc, ARRAY_SIZE(s5pc110_iodesc));
 
 	/* initialise device information early */
+	s5pc110_default_sdhci0();
+	s5pc110_default_sdhci1();
+	s5pc110_default_sdhci2();
+	s5pc110_default_sdhci3();
+
 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
diff --git a/arch/arm/mach-s5pc110/setup-sdhci-gpio.c b/arch/arm/mach-s5pc110/setup-sdhci-gpio.c
new file mode 100644
index 0000000..49db2a0
--- /dev/null
+++ b/arch/arm/mach-s5pc110/setup-sdhci-gpio.c
@@ -0,0 +1,123 @@
+/* linux/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c
+ *
+ * Copyright 2009 Samsung Eletronics
+ *
+ * S5PC110 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
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
+void s5pc110_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+
+	/* Set all the necessary GPG0/GPG1 pins to special-function 2 */
+	for (gpio = S5PC110_GPG0(0); gpio < S5PC110_GPG0(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+	switch (width) {
+	case 8:
+		/* GPG1[3:6] special-funtion 3 */
+		for (gpio = S5PC110_GPG1(3); gpio <= S5PC110_GPG1(6); gpio++) {
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		}
+	case 4:
+		/* GPG0[3:6] special-funtion 2 */
+		for (gpio = S5PC110_GPG0(3); gpio <= S5PC110_GPG0(6); gpio++) {
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		}
+	default:
+		break;
+	}
+
+	s3c_gpio_setpull(S5PC110_GPG0(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC110_GPG0(2), S3C_GPIO_SFN(2));
+}
+
+void s5pc110_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+
+	/* Set all the necessary GPG1[0:1] pins to special-function 2 */
+	for (gpio = S5PC110_GPG1(0); gpio < S5PC110_GPG1(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	/* Data pin GPG1[3:6] to special-function 2 */
+	for (gpio = S5PC110_GPG1(3); gpio <= S5PC110_GPG1(6); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	s3c_gpio_setpull(S5PC110_GPG1(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC110_GPG1(2), S3C_GPIO_SFN(2));
+}
+
+void s5pc110_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+
+	/* Set all the necessary GPG2[0:1] pins to special-function 2 */
+	for (gpio = S5PC110_GPG2(0); gpio < S5PC110_GPG2(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	switch (width) {
+	case 8:
+		/* Data pin GPG3[3:6] to special-function 3 */
+		for (gpio = S5PC110_GPG3(3); gpio <= S5PC110_GPG3(6); gpio++) {
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		}
+	case 4:
+		/* Data pin GPG2[3:6] to special-function 2 */
+		for (gpio = S5PC110_GPG2(3); gpio <= S5PC110_GPG2(6); gpio++) {
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		}
+	default:
+		break;
+	}
+
+	s3c_gpio_setpull(S5PC110_GPG2(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC110_GPG2(2), S3C_GPIO_SFN(2));
+}
+
+void s5pc110_setup_sdhci3_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+
+	/* Set all the necessary GPG3[0:1] pins to special-function 2 */
+	for (gpio = S5PC110_GPG3(0); gpio < S5PC110_GPG3(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	/* Data pin GPG3[3:6] to special-function 2 */
+	for (gpio = S5PC110_GPG3(3); gpio <= S5PC110_GPG3(6); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	s3c_gpio_setpull(S5PC110_GPG3(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC110_GPG3(2), S3C_GPIO_SFN(2));
+}
diff --git a/arch/arm/mach-s5pc110/setup-sdhci.c b/arch/arm/mach-s5pc110/setup-sdhci.c
new file mode 100644
index 0000000..c368bb5
--- /dev/null
+++ b/arch/arm/mach-s5pc110/setup-sdhci.c
@@ -0,0 +1,59 @@
+/* linux/arch/arm/mach-s5pc100/setup-sdhci.c
+ *
+ * Copyright 2008 Samsung Electronics
+ *
+ * S5PC100 - Helper functions for settign up SDHCI device(s) (HSMMC)
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
+char *s5pc110_hsmmc_clksrcs[4] = {
+	[0] = "mmc-bus",
+};
+
+void s5pc110_setup_sdhci_cfg_card(struct platform_device *dev,
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
diff --git a/arch/arm/plat-s3c/include/plat/sdhci.h b/arch/arm/plat-s3c/include/plat/sdhci.h
index 5319867..5f0a14d 100644
--- a/arch/arm/plat-s3c/include/plat/sdhci.h
+++ b/arch/arm/plat-s3c/include/plat/sdhci.h
@@ -75,6 +75,10 @@ extern void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
 extern void s5pc100_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 extern void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
+extern void s5pc110_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
+extern void s5pc110_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
+extern void s5pc110_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
+extern void s5pc110_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
 
 /* S3C6400 SDHCI setup */
 
@@ -223,4 +227,64 @@ static inline void s5pc100_default_sdhci1(void) { }
 static inline void s5pc100_default_sdhci2(void) { }
 #endif /* CONFIG_S5PC100_SETUP_SDHCI */
 
+/* S5PC110 SDHCI setup */
+#ifdef CONFIG_S5PC110_SETUP_SDHCI
+extern char *s5pc110_hsmmc_clksrcs[4];
+
+extern void s5pc110_setup_sdhci_cfg_card(struct platform_device *dev,
+					   void __iomem *r,
+					   struct mmc_ios *ios,
+					   struct mmc_card *card);
+
+#ifdef CONFIG_S3C_DEV_HSMMC
+static inline void s5pc110_default_sdhci0(void)
+{
+	s3c_hsmmc0_def_platdata.clocks = s5pc110_hsmmc_clksrcs;
+	s3c_hsmmc0_def_platdata.cfg_gpio = s5pc110_setup_sdhci0_cfg_gpio;
+	s3c_hsmmc0_def_platdata.cfg_card = s5pc110_setup_sdhci_cfg_card;
+}
+#else
+static inline void s5pc100_default_sdhci0(void) { }
+#endif /* CONFIG_S3C_DEV_HSMMC */
+
+#ifdef CONFIG_S3C_DEV_HSMMC1
+static inline void s5pc110_default_sdhci1(void)
+{
+	s3c_hsmmc1_def_platdata.clocks = s5pc110_hsmmc_clksrcs;
+	s3c_hsmmc1_def_platdata.cfg_gpio = s5pc110_setup_sdhci1_cfg_gpio;
+	s3c_hsmmc1_def_platdata.cfg_card = s5pc110_setup_sdhci_cfg_card;
+}
+#else
+static inline void s5pc110_default_sdhci1(void) { }
+#endif /* CONFIG_S3C_DEV_HSMMC1 */
+
+#ifdef CONFIG_S3C_DEV_HSMMC2
+static inline void s5pc110_default_sdhci2(void)
+{
+	s3c_hsmmc2_def_platdata.clocks = s5pc110_hsmmc_clksrcs;
+	s3c_hsmmc2_def_platdata.cfg_gpio = s5pc110_setup_sdhci2_cfg_gpio;
+	s3c_hsmmc2_def_platdata.cfg_card = s5pc110_setup_sdhci_cfg_card;
+}
+#else
+static inline void s5pc110_default_sdhci2(void) { }
+#endif /* CONFIG_S3C_DEV_HSMMC2 */
+
+#ifdef CONFIG_S3C_DEV_HSMMC3
+static inline void s5pc110_default_sdhci3(void)
+{
+	s3c_hsmmc3_def_platdata.clocks = s5pc110_hsmmc_clksrcs;
+	s3c_hsmmc3_def_platdata.cfg_gpio = s5pc110_setup_sdhci3_cfg_gpio;
+	s3c_hsmmc3_def_platdata.cfg_card = s5pc110_setup_sdhci_cfg_card;
+}
+#else
+static inline void s5pc110_default_sdhci3(void) { }
+#endif /* CONFIG_S3C_DEV_HSMMC3 */
+
+#else
+static inline void s5pc110_default_sdhci0(void) { }
+static inline void s5pc110_default_sdhci1(void) { }
+static inline void s5pc110_default_sdhci2(void) { }
+static inline void s5pc110_default_sdhci3(void) { }
+#endif /* CONFIG_S5PC100_SETUP_SDHCI */
+
 #endif /* __PLAT_S3C_SDHCI_H */
-- 
1.6.4
