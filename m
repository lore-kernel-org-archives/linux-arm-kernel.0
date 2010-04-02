From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 02 Apr 2010 08:22:22 +0200
Subject: [PATCH 2/2] ARM: S5PV210: add common HSMMC device helpers
In-Reply-To: <1270189342-30798-1-git-send-email-m.szyprowski@samsung.com>
References: <1270189342-30798-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1270189342-30798-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds sdhci platform helpers required by sdhci-s3c driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig              |   11 +++
 arch/arm/mach-s5pv210/Makefile             |    2 +
 arch/arm/mach-s5pv210/clock.c              |   50 ++++++++++-
 arch/arm/mach-s5pv210/cpu.c                |    7 ++
 arch/arm/mach-s5pv210/include/mach/map.h   |    9 ++
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c   |  123 ++++++++++++++++++++++++++++
 arch/arm/mach-s5pv210/setup-sdhci.c        |   59 +++++++++++++
 arch/arm/plat-samsung/include/plat/sdhci.h |   68 +++++++++++++++
 8 files changed, 324 insertions(+), 5 deletions(-)
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
index fb54e2d..11b5ab6 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -20,6 +20,8 @@ obj-$(CONFIG_CPU_S5PV210)	+= setup-i2c0.o
 obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
 obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
 obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
+obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
+obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index b9749f1..da65f71 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -299,25 +299,65 @@ static struct clksrc_clk clk_mout_mpll = {
 	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 4, .size = 1 },
 };
 
-static struct clk *clkset_uart_list[] = {
+static struct clk *clkset_default_list[] = {
 	[6] = &clk_mout_mpll.clk,
 	[7] = &clk_mout_epll.clk,
 };
 
-static struct clksrc_sources clkset_uart = {
-	.sources	= clkset_uart_list,
-	.nr_sources	= ARRAY_SIZE(clkset_uart_list),
+static struct clksrc_sources clkset_default = {
+	.sources	= clkset_default_list,
+	.nr_sources	= ARRAY_SIZE(clkset_default_list),
 };
 
 static struct clksrc_clk clksrcs[] = {
 	{
 		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 0,
+			.ctrlbit        = (1<<16),
+			.enable		= s5pv210_clk_ip2_ctrl,
+		},
+		.sources	= &clkset_default,
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 0, .size = 4, },
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 0, .size = 4, },
+	}, {
+		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 1,
+			.ctrlbit        = (1<<17),
+			.enable		= s5pv210_clk_ip2_ctrl,
+		},
+		.sources	= &clkset_default,
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 4, .size = 4, },
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 4, .size = 4, },
+	}, {
+		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 2,
+			.ctrlbit        = (1<<18),
+			.enable		= s5pv210_clk_ip2_ctrl,
+		},
+		.sources	= &clkset_default,
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 4, .size = 4, },
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 4, .size = 4, },
+	}, {
+		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 3,
+			.ctrlbit        = (1<<19),
+			.enable		= s5pv210_clk_ip2_ctrl,
+		},
+		.sources	= &clkset_default,
+		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 4, .size = 4, },
+		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 4, .size = 4, },
+	}, {
+		.clk	= {
 			.name		= "uclk1",
 			.id		= -1,
 			.ctrlbit	= (1<<17),
 			.enable		= s5pv210_clk_ip3_ctrl,
 		},
-		.sources = &clkset_uart,
+		.sources = &clkset_default,
 		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 16, .size = 4 },
 		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 16, .size = 4 },
 	}
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index fb80294..1cbe9eb 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -33,6 +33,7 @@
 #include <plat/clock.h>
 #include <plat/s5pv210.h>
 #include <plat/iic-core.h>
+#include <plat/sdhci.h>
 
 /* Initial IO mappings */
 
@@ -77,6 +78,12 @@ void __init s5pv210_map_io(void)
 {
 	iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));
 
+	/* initialise device information early */
+	s5pv210_default_sdhci0();
+	s5pv210_default_sdhci1();
+	s5pv210_default_sdhci2();
+	s5pv210_default_sdhci3();
+
 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 36bc608..63b983a 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -47,6 +47,12 @@
 
 #define S5PV210_PA_FB		(0xF8000000)
 
+#define S5PV210_PA_HSMMC(x)	(0xEB000000 + ((x) * 0x100000))
+#define S5PV210_PA_HSMMC0	S5PV210_PA_HSMMC(0)
+#define S5PV210_PA_HSMMC1	S5PV210_PA_HSMMC(1)
+#define S5PV210_PA_HSMMC2	S5PV210_PA_HSMMC(2)
+#define S5PV210_PA_HSMMC3	S5PV210_PA_HSMMC(3)
+
 #define S5PV210_PA_VIC0		(0xF2000000)
 #define S5P_PA_VIC0		S5PV210_PA_VIC0
 
@@ -64,6 +70,9 @@
 
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5PV210_PA_UART
+#define S3C_PA_HSMMC0		S5PV210_PA_HSMMC0
+#define S3C_PA_HSMMC1		S5PV210_PA_HSMMC1
+#define S3C_PA_HSMMC2		S5PV210_PA_HSMMC2
 #define S3C_PA_IIC		S5PV210_PA_IIC0
 #define S3C_PA_IIC1		S5PV210_PA_IIC1
 #define S3C_PA_IIC2		S5PV210_PA_IIC2
diff --git a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
new file mode 100644
index 0000000..629b7d2
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
@@ -0,0 +1,123 @@
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
+
+void s5pv210_setup_sdhci3_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+
+	/* Set all the necessary GPG3[0:1] pins to special-function 2 */
+	for (gpio = S5PV210_GPG3(0); gpio < S5PV210_GPG3(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	/* Data pin GPG3[3:6] to special-function 2 */
+	for (gpio = S5PV210_GPG3(3); gpio <= S5PV210_GPG3(6); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	s3c_gpio_setpull(S5PV210_GPG3(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV210_GPG3(2), S3C_GPIO_SFN(2));
+}
diff --git a/arch/arm/mach-s5pv210/setup-sdhci.c b/arch/arm/mach-s5pv210/setup-sdhci.c
new file mode 100644
index 0000000..2d97593
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-sdhci.c
@@ -0,0 +1,59 @@
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
+	[0] = "mmc_bus",
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
index 7d07cd7..86cd0ef 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -75,6 +75,10 @@ extern void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
 extern void s5pc100_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 extern void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
+extern void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
+extern void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
+extern void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
+extern void s5pv210_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
 
 /* S3C6400 SDHCI setup */
 
@@ -218,4 +222,68 @@ static inline void s5pc100_default_sdhci1(void) { }
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
+#ifdef CONFIG_S3C_DEV_HSMMC3
+static inline void s5pv210_default_sdhci3(void)
+{
+	s3c_hsmmc3_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
+	s3c_hsmmc3_def_platdata.cfg_gpio = s5pv210_setup_sdhci3_cfg_gpio;
+	s3c_hsmmc3_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
+}
+#else
+static inline void s5pv210_default_sdhci3(void) { }
+#endif /* CONFIG_S3C_DEV_HSMMC3 */
+
+#else
+static inline void s5pv210_default_sdhci0(void) { }
+static inline void s5pv210_default_sdhci1(void) { }
+static inline void s5pv210_default_sdhci2(void) { }
+static inline void s5pv210_default_sdhci3(void) { }
+#endif /* CONFIG_S5PC100_SETUP_SDHCI */
+
+
+
+
 #endif /* __PLAT_S3C_SDHCI_H */
-- 
1.6.4
