From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 18:42:18 +0100
Subject: [PATCH 08/23] mmc: sdhci-s3c: remove platform dependencies
In-Reply-To: <1362505353-8873-1-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
Message-ID: <1362505353-8873-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

plat/regs-sdhci.h is not used anywhere but in the sdhci-s3c
driver, so it can become a local file there and all other
inclusions removed.

plat/sdhci.h is used only to define the platform devices,
and with the exception of the platform_data structure not
needed by the driver, so we can split out the platform_data
definition instead and leave the rest to platform code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-exynos/setup-sdhci-gpio.c         |  2 +-
 arch/arm/mach-s5pc100/setup-sdhci-gpio.c        |  1 -
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c        |  1 -
 arch/arm/plat-samsung/include/plat/regs-sdhci.h | 87 -------------------------
 arch/arm/plat-samsung/include/plat/sdhci.h      | 56 +---------------
 drivers/mmc/host/Kconfig                        |  2 +-
 drivers/mmc/host/sdhci-s3c-regs.h               | 87 +++++++++++++++++++++++++
 drivers/mmc/host/sdhci-s3c.c                    |  5 +-
 include/linux/platform_data/mmc-sdhci-s3c.h     | 56 ++++++++++++++++
 9 files changed, 148 insertions(+), 149 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-sdhci.h
 create mode 100644 drivers/mmc/host/sdhci-s3c-regs.h
 create mode 100644 include/linux/platform_data/mmc-sdhci-s3c.h

diff --git a/arch/arm/mach-exynos/setup-sdhci-gpio.c b/arch/arm/mach-exynos/setup-sdhci-gpio.c
index e8d08bf..d5b98c8 100644
--- a/arch/arm/mach-exynos/setup-sdhci-gpio.c
+++ b/arch/arm/mach-exynos/setup-sdhci-gpio.c
@@ -19,8 +19,8 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
 
+#include <mach/gpio.h>
 #include <plat/gpio-cfg.h>
-#include <plat/regs-sdhci.h>
 #include <plat/sdhci.h>
 
 void exynos4_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
diff --git a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
index 03c02d0..6010c03 100644
--- a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
@@ -19,7 +19,6 @@
 #include <linux/mmc/card.h>
 
 #include <plat/gpio-cfg.h>
-#include <plat/regs-sdhci.h>
 #include <plat/sdhci.h>
 
 void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
diff --git a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
index 3e3ac05..0512ada 100644
--- a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
@@ -20,7 +20,6 @@
 #include <linux/mmc/card.h>
 
 #include <plat/gpio-cfg.h>
-#include <plat/regs-sdhci.h>
 #include <plat/sdhci.h>
 
 void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
diff --git a/arch/arm/plat-samsung/include/plat/regs-sdhci.h b/arch/arm/plat-samsung/include/plat/regs-sdhci.h
deleted file mode 100644
index e34049a..0000000
--- a/arch/arm/plat-samsung/include/plat/regs-sdhci.h
+++ /dev/null
@@ -1,87 +0,0 @@
-/* linux/arch/arm/plat-s3c/include/plat/regs-sdhci.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C Platform - SDHCI (HSMMC) register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __PLAT_S3C_SDHCI_REGS_H
-#define __PLAT_S3C_SDHCI_REGS_H __FILE__
-
-#define S3C_SDHCI_CONTROL2			(0x80)
-#define S3C_SDHCI_CONTROL3			(0x84)
-#define S3C64XX_SDHCI_CONTROL4			(0x8C)
-
-#define S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR	(1 << 31)
-#define S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK		(1 << 30)
-#define S3C_SDHCI_CTRL2_CDINVRXD3		(1 << 29)
-#define S3C_SDHCI_CTRL2_SLCARDOUT		(1 << 28)
-
-#define S3C_SDHCI_CTRL2_FLTCLKSEL_MASK		(0xf << 24)
-#define S3C_SDHCI_CTRL2_FLTCLKSEL_SHIFT		(24)
-#define S3C_SDHCI_CTRL2_FLTCLKSEL(_x)		((_x) << 24)
-
-#define S3C_SDHCI_CTRL2_LVLDAT_MASK		(0xff << 16)
-#define S3C_SDHCI_CTRL2_LVLDAT_SHIFT		(16)
-#define S3C_SDHCI_CTRL2_LVLDAT(_x)		((_x) << 16)
-
-#define S3C_SDHCI_CTRL2_ENFBCLKTX		(1 << 15)
-#define S3C_SDHCI_CTRL2_ENFBCLKRX		(1 << 14)
-#define S3C_SDHCI_CTRL2_SDCDSEL			(1 << 13)
-#define S3C_SDHCI_CTRL2_SDSIGPC			(1 << 12)
-#define S3C_SDHCI_CTRL2_ENBUSYCHKTXSTART	(1 << 11)
-
-#define S3C_SDHCI_CTRL2_DFCNT_MASK		(0x3 << 9)
-#define S3C_SDHCI_CTRL2_DFCNT_SHIFT		(9)
-#define S3C_SDHCI_CTRL2_DFCNT_NONE		(0x0 << 9)
-#define S3C_SDHCI_CTRL2_DFCNT_4SDCLK		(0x1 << 9)
-#define S3C_SDHCI_CTRL2_DFCNT_16SDCLK		(0x2 << 9)
-#define S3C_SDHCI_CTRL2_DFCNT_64SDCLK		(0x3 << 9)
-
-#define S3C_SDHCI_CTRL2_ENCLKOUTHOLD		(1 << 8)
-#define S3C_SDHCI_CTRL2_RWAITMODE		(1 << 7)
-#define S3C_SDHCI_CTRL2_DISBUFRD		(1 << 6)
-#define S3C_SDHCI_CTRL2_SELBASECLK_MASK		(0x3 << 4)
-#define S3C_SDHCI_CTRL2_SELBASECLK_SHIFT	(4)
-#define S3C_SDHCI_CTRL2_PWRSYNC			(1 << 3)
-#define S3C_SDHCI_CTRL2_ENCLKOUTMSKCON		(1 << 1)
-#define S3C_SDHCI_CTRL2_HWINITFIN		(1 << 0)
-
-#define S3C_SDHCI_CTRL3_FCSEL3			(1 << 31)
-#define S3C_SDHCI_CTRL3_FCSEL2			(1 << 23)
-#define S3C_SDHCI_CTRL3_FCSEL1			(1 << 15)
-#define S3C_SDHCI_CTRL3_FCSEL0			(1 << 7)
-
-#define S3C_SDHCI_CTRL3_FIA3_MASK		(0x7f << 24)
-#define S3C_SDHCI_CTRL3_FIA3_SHIFT		(24)
-#define S3C_SDHCI_CTRL3_FIA3(_x)		((_x) << 24)
-
-#define S3C_SDHCI_CTRL3_FIA2_MASK		(0x7f << 16)
-#define S3C_SDHCI_CTRL3_FIA2_SHIFT		(16)
-#define S3C_SDHCI_CTRL3_FIA2(_x)		((_x) << 16)
-
-#define S3C_SDHCI_CTRL3_FIA1_MASK		(0x7f << 8)
-#define S3C_SDHCI_CTRL3_FIA1_SHIFT		(8)
-#define S3C_SDHCI_CTRL3_FIA1(_x)		((_x) << 8)
-
-#define S3C_SDHCI_CTRL3_FIA0_MASK		(0x7f << 0)
-#define S3C_SDHCI_CTRL3_FIA0_SHIFT		(0)
-#define S3C_SDHCI_CTRL3_FIA0(_x)		((_x) << 0)
-
-#define S3C64XX_SDHCI_CONTROL4_DRIVE_MASK	(0x3 << 16)
-#define S3C64XX_SDHCI_CONTROL4_DRIVE_SHIFT	(16)
-#define S3C64XX_SDHCI_CONTROL4_DRIVE_2mA	(0x0 << 16)
-#define S3C64XX_SDHCI_CONTROL4_DRIVE_4mA	(0x1 << 16)
-#define S3C64XX_SDHCI_CONTROL4_DRIVE_7mA	(0x2 << 16)
-#define S3C64XX_SDHCI_CONTROL4_DRIVE_9mA	(0x3 << 16)
-
-#define S3C64XX_SDHCI_CONTROL4_BUSY		(1)
-
-#endif /* __PLAT_S3C_SDHCI_REGS_H */
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 9b87f38..1e0aab0 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -18,62 +18,9 @@
 #ifndef __PLAT_S3C_SDHCI_H
 #define __PLAT_S3C_SDHCI_H __FILE__
 
+#include <linux/platform_data/mmc-sdhci-s3c.h>
 #include <plat/devs.h>
 
-struct platform_device;
-struct mmc_host;
-struct mmc_card;
-struct mmc_ios;
-
-enum cd_types {
-	S3C_SDHCI_CD_INTERNAL,	/* use mmc internal CD line */
-	S3C_SDHCI_CD_EXTERNAL,	/* use external callback */
-	S3C_SDHCI_CD_GPIO,	/* use external gpio pin for CD line */
-	S3C_SDHCI_CD_NONE,	/* no CD line, use polling to detect card */
-	S3C_SDHCI_CD_PERMANENT,	/* no CD line, card permanently wired to host */
-};
-
-/**
- * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
- * @max_width: The maximum number of data bits supported.
- * @host_caps: Standard MMC host capabilities bit field.
- * @host_caps2: The second standard MMC host capabilities bit field.
- * @cd_type: Type of Card Detection method (see cd_types enum above)
- * @ext_cd_init: Initialize external card detect subsystem. Called on
- *		 sdhci-s3c driver probe when cd_type == S3C_SDHCI_CD_EXTERNAL.
- *		 notify_func argument is a callback to the sdhci-s3c driver
- *		 that triggers the card detection event. Callback arguments:
- *		 dev is pointer to platform device of the host controller,
- *		 state is new state of the card (0 - removed, 1 - inserted).
- * @ext_cd_cleanup: Cleanup external card detect subsystem. Called on
- *		 sdhci-s3c driver remove when cd_type == S3C_SDHCI_CD_EXTERNAL.
- *		 notify_func argument is the same callback as for ext_cd_init.
- * @ext_cd_gpio: gpio pin used for external CD line, valid only if
- *		 cd_type == S3C_SDHCI_CD_GPIO
- * @ext_cd_gpio_invert: invert values for external CD gpio line
- * @cfg_gpio: Configure the GPIO for a specific card bit-width
- *
- * Initialisation data specific to either the machine or the platform
- * for the device driver to use or call-back when configuring gpio or
- * card speed information.
-*/
-struct s3c_sdhci_platdata {
-	unsigned int	max_width;
-	unsigned int	host_caps;
-	unsigned int	host_caps2;
-	unsigned int	pm_caps;
-	enum cd_types	cd_type;
-
-	int		ext_cd_gpio;
-	bool		ext_cd_gpio_invert;
-	int	(*ext_cd_init)(void (*notify_func)(struct platform_device *,
-						   int state));
-	int	(*ext_cd_cleanup)(void (*notify_func)(struct platform_device *,
-						      int state));
-
-	void	(*cfg_gpio)(struct platform_device *dev, int width);
-};
-
 /* s3c_sdhci_set_platdata() - common helper for setting SDHCI platform data
  * @pd: The default platform data for this device.
  * @set: Pointer to the platform data to fill in.
@@ -378,5 +325,4 @@ static inline void s3c_sdhci_setname(int id, char *name)
 		break;
 	}
 }
-
 #endif /* __PLAT_S3C_SDHCI_H */
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d88219e..d054744 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -180,7 +180,7 @@ config MMC_SDHCI_TEGRA
 
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
-	depends on MMC_SDHCI && PLAT_SAMSUNG
+	depends on MMC_SDHCI && PLAT_SAMSUNG_SINGLE
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the Samsung S3C
diff --git a/drivers/mmc/host/sdhci-s3c-regs.h b/drivers/mmc/host/sdhci-s3c-regs.h
new file mode 100644
index 0000000..e34049a
--- /dev/null
+++ b/drivers/mmc/host/sdhci-s3c-regs.h
@@ -0,0 +1,87 @@
+/* linux/arch/arm/plat-s3c/include/plat/regs-sdhci.h
+ *
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C Platform - SDHCI (HSMMC) register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __PLAT_S3C_SDHCI_REGS_H
+#define __PLAT_S3C_SDHCI_REGS_H __FILE__
+
+#define S3C_SDHCI_CONTROL2			(0x80)
+#define S3C_SDHCI_CONTROL3			(0x84)
+#define S3C64XX_SDHCI_CONTROL4			(0x8C)
+
+#define S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR	(1 << 31)
+#define S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK		(1 << 30)
+#define S3C_SDHCI_CTRL2_CDINVRXD3		(1 << 29)
+#define S3C_SDHCI_CTRL2_SLCARDOUT		(1 << 28)
+
+#define S3C_SDHCI_CTRL2_FLTCLKSEL_MASK		(0xf << 24)
+#define S3C_SDHCI_CTRL2_FLTCLKSEL_SHIFT		(24)
+#define S3C_SDHCI_CTRL2_FLTCLKSEL(_x)		((_x) << 24)
+
+#define S3C_SDHCI_CTRL2_LVLDAT_MASK		(0xff << 16)
+#define S3C_SDHCI_CTRL2_LVLDAT_SHIFT		(16)
+#define S3C_SDHCI_CTRL2_LVLDAT(_x)		((_x) << 16)
+
+#define S3C_SDHCI_CTRL2_ENFBCLKTX		(1 << 15)
+#define S3C_SDHCI_CTRL2_ENFBCLKRX		(1 << 14)
+#define S3C_SDHCI_CTRL2_SDCDSEL			(1 << 13)
+#define S3C_SDHCI_CTRL2_SDSIGPC			(1 << 12)
+#define S3C_SDHCI_CTRL2_ENBUSYCHKTXSTART	(1 << 11)
+
+#define S3C_SDHCI_CTRL2_DFCNT_MASK		(0x3 << 9)
+#define S3C_SDHCI_CTRL2_DFCNT_SHIFT		(9)
+#define S3C_SDHCI_CTRL2_DFCNT_NONE		(0x0 << 9)
+#define S3C_SDHCI_CTRL2_DFCNT_4SDCLK		(0x1 << 9)
+#define S3C_SDHCI_CTRL2_DFCNT_16SDCLK		(0x2 << 9)
+#define S3C_SDHCI_CTRL2_DFCNT_64SDCLK		(0x3 << 9)
+
+#define S3C_SDHCI_CTRL2_ENCLKOUTHOLD		(1 << 8)
+#define S3C_SDHCI_CTRL2_RWAITMODE		(1 << 7)
+#define S3C_SDHCI_CTRL2_DISBUFRD		(1 << 6)
+#define S3C_SDHCI_CTRL2_SELBASECLK_MASK		(0x3 << 4)
+#define S3C_SDHCI_CTRL2_SELBASECLK_SHIFT	(4)
+#define S3C_SDHCI_CTRL2_PWRSYNC			(1 << 3)
+#define S3C_SDHCI_CTRL2_ENCLKOUTMSKCON		(1 << 1)
+#define S3C_SDHCI_CTRL2_HWINITFIN		(1 << 0)
+
+#define S3C_SDHCI_CTRL3_FCSEL3			(1 << 31)
+#define S3C_SDHCI_CTRL3_FCSEL2			(1 << 23)
+#define S3C_SDHCI_CTRL3_FCSEL1			(1 << 15)
+#define S3C_SDHCI_CTRL3_FCSEL0			(1 << 7)
+
+#define S3C_SDHCI_CTRL3_FIA3_MASK		(0x7f << 24)
+#define S3C_SDHCI_CTRL3_FIA3_SHIFT		(24)
+#define S3C_SDHCI_CTRL3_FIA3(_x)		((_x) << 24)
+
+#define S3C_SDHCI_CTRL3_FIA2_MASK		(0x7f << 16)
+#define S3C_SDHCI_CTRL3_FIA2_SHIFT		(16)
+#define S3C_SDHCI_CTRL3_FIA2(_x)		((_x) << 16)
+
+#define S3C_SDHCI_CTRL3_FIA1_MASK		(0x7f << 8)
+#define S3C_SDHCI_CTRL3_FIA1_SHIFT		(8)
+#define S3C_SDHCI_CTRL3_FIA1(_x)		((_x) << 8)
+
+#define S3C_SDHCI_CTRL3_FIA0_MASK		(0x7f << 0)
+#define S3C_SDHCI_CTRL3_FIA0_SHIFT		(0)
+#define S3C_SDHCI_CTRL3_FIA0(_x)		((_x) << 0)
+
+#define S3C64XX_SDHCI_CONTROL4_DRIVE_MASK	(0x3 << 16)
+#define S3C64XX_SDHCI_CONTROL4_DRIVE_SHIFT	(16)
+#define S3C64XX_SDHCI_CONTROL4_DRIVE_2mA	(0x0 << 16)
+#define S3C64XX_SDHCI_CONTROL4_DRIVE_4mA	(0x1 << 16)
+#define S3C64XX_SDHCI_CONTROL4_DRIVE_7mA	(0x2 << 16)
+#define S3C64XX_SDHCI_CONTROL4_DRIVE_9mA	(0x3 << 16)
+
+#define S3C64XX_SDHCI_CONTROL4_BUSY		(1)
+
+#endif /* __PLAT_S3C_SDHCI_REGS_H */
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 7363efe..e4f52b5 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/mmc-sdhci-s3c.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -28,9 +29,7 @@
 
 #include <linux/mmc/host.h>
 
-#include <plat/sdhci.h>
-#include <plat/regs-sdhci.h>
-
+#include "sdhci-s3c-regs.h"
 #include "sdhci.h"
 
 #define MAX_BUS_CLK	(4)
diff --git a/include/linux/platform_data/mmc-sdhci-s3c.h b/include/linux/platform_data/mmc-sdhci-s3c.h
new file mode 100644
index 0000000..249f023
--- /dev/null
+++ b/include/linux/platform_data/mmc-sdhci-s3c.h
@@ -0,0 +1,56 @@
+#ifndef __PLATFORM_DATA_SDHCI_S3C_H
+#define __PLATFORM_DATA_SDHCI_S3C_H
+
+struct platform_device;
+
+enum cd_types {
+	S3C_SDHCI_CD_INTERNAL,	/* use mmc internal CD line */
+	S3C_SDHCI_CD_EXTERNAL,	/* use external callback */
+	S3C_SDHCI_CD_GPIO,	/* use external gpio pin for CD line */
+	S3C_SDHCI_CD_NONE,	/* no CD line, use polling to detect card */
+	S3C_SDHCI_CD_PERMANENT,	/* no CD line, card permanently wired to host */
+};
+
+/**
+ * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
+ * @max_width: The maximum number of data bits supported.
+ * @host_caps: Standard MMC host capabilities bit field.
+ * @host_caps2: The second standard MMC host capabilities bit field.
+ * @cd_type: Type of Card Detection method (see cd_types enum above)
+ * @ext_cd_init: Initialize external card detect subsystem. Called on
+ *		 sdhci-s3c driver probe when cd_type == S3C_SDHCI_CD_EXTERNAL.
+ *		 notify_func argument is a callback to the sdhci-s3c driver
+ *		 that triggers the card detection event. Callback arguments:
+ *		 dev is pointer to platform device of the host controller,
+ *		 state is new state of the card (0 - removed, 1 - inserted).
+ * @ext_cd_cleanup: Cleanup external card detect subsystem. Called on
+ *		 sdhci-s3c driver remove when cd_type == S3C_SDHCI_CD_EXTERNAL.
+ *		 notify_func argument is the same callback as for ext_cd_init.
+ * @ext_cd_gpio: gpio pin used for external CD line, valid only if
+ *		 cd_type == S3C_SDHCI_CD_GPIO
+ * @ext_cd_gpio_invert: invert values for external CD gpio line
+ * @cfg_gpio: Configure the GPIO for a specific card bit-width
+ *
+ * Initialisation data specific to either the machine or the platform
+ * for the device driver to use or call-back when configuring gpio or
+ * card speed information.
+*/
+struct s3c_sdhci_platdata {
+	unsigned int	max_width;
+	unsigned int	host_caps;
+	unsigned int	host_caps2;
+	unsigned int	pm_caps;
+	enum cd_types	cd_type;
+
+	int		ext_cd_gpio;
+	bool		ext_cd_gpio_invert;
+	int	(*ext_cd_init)(void (*notify_func)(struct platform_device *,
+						   int state));
+	int	(*ext_cd_cleanup)(void (*notify_func)(struct platform_device *,
+						      int state));
+
+	void	(*cfg_gpio)(struct platform_device *dev, int width);
+};
+
+
+#endif /* __PLATFORM_DATA_SDHCI_S3C_H */
-- 
1.8.1.2
