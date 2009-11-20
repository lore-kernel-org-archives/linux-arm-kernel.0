From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 20 Nov 2009 13:04:04 +0100
Subject: [PATCH 4/8] S3C64xx: add HSMMC2 support
Message-ID: <b2e8f9f70911200404s7f6e38ebt4798075683208071@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the third SDHCI controller.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c6400/s3c6400.c          |    1 +
 arch/arm/mach-s3c6410/cpu.c              |    1 +
 arch/arm/plat-s3c/Kconfig                |    5 ++
 arch/arm/plat-s3c/Makefile               |    1 +
 arch/arm/plat-s3c/dev-hsmmc2.c           |   68 ++++++++++++++++++++++++++++++
 arch/arm/plat-s3c/include/plat/sdhci.h   |   25 +++++++++++
 arch/arm/plat-s3c64xx/setup-sdhci-gpio.c |   20 +++++++++
 7 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s3c/dev-hsmmc2.c

diff --git a/arch/arm/mach-s3c6400/s3c6400.c b/arch/arm/mach-s3c6400/s3c6400.c
index b42bdd0..d876ee5 100644
--- a/arch/arm/mach-s3c6400/s3c6400.c
+++ b/arch/arm/mach-s3c6400/s3c6400.c
@@ -45,6 +45,7 @@ void __init s3c6400_map_io(void)

 	s3c6400_default_sdhci0();
 	s3c6400_default_sdhci1();
+	s3c6400_default_sdhci2();

 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
diff --git a/arch/arm/mach-s3c6410/cpu.c b/arch/arm/mach-s3c6410/cpu.c
index 9b67c66..522c086 100644
--- a/arch/arm/mach-s3c6410/cpu.c
+++ b/arch/arm/mach-s3c6410/cpu.c
@@ -58,6 +58,7 @@ void __init s3c6410_map_io(void)
 	/* initialise device information early */
 	s3c6410_default_sdhci0();
 	s3c6410_default_sdhci1();
+	s3c6410_default_sdhci2();

 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
index 8931c5f..57e685b 100644
--- a/arch/arm/plat-s3c/Kconfig
+++ b/arch/arm/plat-s3c/Kconfig
@@ -178,6 +178,11 @@ config S3C_DEV_HSMMC1
 	help
 	  Compile in platform device definitions for HSMMC channel 1

+config S3C_DEV_HSMMC2
+	bool
+	help
+	  Compile in platform device definitions for HSMMC channel 2
+
 config S3C_DEV_I2C1
 	bool
 	help
diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index 3c09109..50444da 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_HAVE_PWM)		+= pwm.o

 obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
 obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
+obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
 obj-y				+= dev-i2c0.o
 obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
 obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
diff --git a/arch/arm/plat-s3c/dev-hsmmc2.c b/arch/arm/plat-s3c/dev-hsmmc2.c
new file mode 100644
index 0000000..49b6b68
--- /dev/null
+++ b/arch/arm/plat-s3c/dev-hsmmc2.c
@@ -0,0 +1,68 @@
+/* linux/arch/arm/plat-s3c/dev-hsmmc2.c
+ *
+ * Copyright (c) 2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * S3C series device definition for hsmmc device 2
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mmc/host.h>
+
+#include <mach/map.h>
+#include <plat/sdhci.h>
+#include <plat/devs.h>
+#include <plat/cpu.h>
+
+#define S3C_SZ_HSMMC	(0x1000)
+
+static struct resource s3c_hsmmc2_resource[] = {
+	[0] = {
+		.start = S3C_PA_HSMMC2,
+		.end   = S3C_PA_HSMMC2 + S3C_SZ_HSMMC - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_HSMMC2,
+		.end   = IRQ_HSMMC2,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static u64 s3c_device_hsmmc2_dmamask = 0xffffffffUL;
+
+struct s3c_sdhci_platdata s3c_hsmmc2_def_platdata = {
+	.max_width	= 4,
+	.host_caps	= (MMC_CAP_4_BIT_DATA |
+			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+};
+
+struct platform_device s3c_device_hsmmc2 = {
+	.name		= "s3c-sdhci",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(s3c_hsmmc2_resource),
+	.resource	= s3c_hsmmc2_resource,
+	.dev		= {
+		.dma_mask		= &s3c_device_hsmmc2_dmamask,
+		.coherent_dma_mask	= 0xffffffffUL,
+		.platform_data		= &s3c_hsmmc2_def_platdata,
+	},
+};
+
+void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
+{
+	struct s3c_sdhci_platdata *set = &s3c_hsmmc2_def_platdata;
+
+	set->max_width = pd->max_width;
+
+	if (pd->cfg_gpio)
+		set->cfg_gpio = pd->cfg_gpio;
+	if (pd->cfg_card)
+		set->cfg_card = pd->cfg_card;
+}
diff --git a/arch/arm/plat-s3c/include/plat/sdhci.h
b/arch/arm/plat-s3c/include/plat/sdhci.h
index f615308..d5a3b41 100644
--- a/arch/arm/plat-s3c/include/plat/sdhci.h
+++ b/arch/arm/plat-s3c/include/plat/sdhci.h
@@ -57,6 +57,7 @@ struct s3c_sdhci_platdata {
  */
 extern void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd);
 extern void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd);
+extern void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd);

 /* Default platform data, exported so that per-cpu initialisation can
  * set the correct one when there are more than one cpu type selected.
@@ -64,11 +65,13 @@ extern void s3c_sdhci1_set_platdata(struct
s3c_sdhci_platdata *pd);

 extern struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata;
 extern struct s3c_sdhci_platdata s3c_hsmmc1_def_platdata;
+extern struct s3c_sdhci_platdata s3c_hsmmc2_def_platdata;

 /* Helper function availablity */

 extern void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void s3c64xx_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
+extern void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *, int w);

 /* S3C6400 SDHCI setup */

@@ -103,6 +106,17 @@ static inline void s3c6400_default_sdhci1(void)
 static inline void s3c6400_default_sdhci1(void) { }
 #endif /* CONFIG_S3C_DEV_HSMMC1 */

+#ifdef CONFIG_S3C_DEV_HSMMC2
+static inline void s3c6400_default_sdhci2(void)
+{
+	s3c_hsmmc2_def_platdata.clocks = s3c6400_hsmmc_clksrcs;
+	s3c_hsmmc2_def_platdata.cfg_gpio = s3c64xx_setup_sdhci2_cfg_gpio;
+	s3c_hsmmc2_def_platdata.cfg_card = s3c6400_setup_sdhci_cfg_card;
+}
+#else
+static inline void s3c6400_default_sdhci2(void) { }
+#endif /* CONFIG_S3C_DEV_HSMMC2 */
+
 #else
 static inline void s3c6400_default_sdhci0(void) { }
 static inline void s3c6400_default_sdhci1(void) { }
@@ -140,6 +154,17 @@ static inline void s3c6410_default_sdhci1(void)
 static inline void s3c6410_default_sdhci1(void) { }
 #endif /* CONFIG_S3C_DEV_HSMMC1 */

+#ifdef CONFIG_S3C_DEV_HSMMC2
+static inline void s3c6410_default_sdhci2(void)
+{
+	s3c_hsmmc2_def_platdata.clocks = s3c6410_hsmmc_clksrcs;
+	s3c_hsmmc2_def_platdata.cfg_gpio = s3c64xx_setup_sdhci2_cfg_gpio;
+	s3c_hsmmc2_def_platdata.cfg_card = s3c6410_setup_sdhci0_cfg_card;
+}
+#else
+static inline void s3c6410_default_sdhci2(void) { }
+#endif /* CONFIG_S3C_DEV_HSMMC2 */
+
 #else
 static inline void s3c6410_default_sdhci0(void) { }
 static inline void s3c6410_default_sdhci1(void) { }
diff --git a/arch/arm/plat-s3c64xx/setup-sdhci-gpio.c
b/arch/arm/plat-s3c64xx/setup-sdhci-gpio.c
index 5417123..a58c0cc 100644
--- a/arch/arm/plat-s3c64xx/setup-sdhci-gpio.c
+++ b/arch/arm/plat-s3c64xx/setup-sdhci-gpio.c
@@ -53,3 +53,23 @@ void s3c64xx_setup_sdhci1_cfg_gpio(struct
platform_device *dev, int width)
 	s3c_gpio_setpull(S3C64XX_GPG(6), S3C_GPIO_PULL_UP);
 	s3c_gpio_cfgpin(S3C64XX_GPG(6), S3C_GPIO_SFN(3));
 }
+
+void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+	unsigned int end;
+
+	end = S3C64XX_GPH(6 + width);
+
+	/* Set all the necessary GPH pins to special-function 1 */
+	for (gpio = S3C64XX_GPH(6); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	/* Set all the necessary GPC pins to special-function 1 */
+	for (gpio = S3C64XX_GPC(4); gpio < S3C64XX_GPC(6); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+}
-- 
1.6.5.3
