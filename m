From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 8 Jan 2012 21:59:02 +0100
Subject: [PATCH 3/3] S3C2443: add power domain for usb phy
In-Reply-To: <201201082156.44142.heiko@sntech.de>
References: <201201082156.44142.heiko@sntech.de>
Message-ID: <201201082159.02368.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phy-power-handling is common to S3C2443/2416/2450, so introduce a
s3c2443-pm-common.c to handle this for all of them.

This makes it possible to remove the raw write to the PWRCFG-register
from the s3c-hsudc driver.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2416/Kconfig             |    1 +
 arch/arm/mach-s3c2443/Kconfig             |    1 +
 arch/arm/plat-s3c24xx/Kconfig             |    7 +++
 arch/arm/plat-s3c24xx/Makefile            |    1 +
 arch/arm/plat-s3c24xx/s3c2443-pm-common.c |   65 +++++++++++++++++++++++++++++
 drivers/usb/gadget/s3c-hsudc.c            |    6 ---
 6 files changed, 75 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/plat-s3c24xx/s3c2443-pm-common.c

diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
index 84c7b03..240aef7 100644
--- a/arch/arm/mach-s3c2416/Kconfig
+++ b/arch/arm/mach-s3c2416/Kconfig
@@ -15,6 +15,7 @@ config CPU_S3C2416
 	select CPU_LLSERIAL_S3C2440
 	select SAMSUNG_CLKSRC
 	select S3C2443_CLOCK
+	select S3C2443_PM_COMMON
 	help
 	  Support for the S3C2416 SoC from the S3C24XX line
 
diff --git a/arch/arm/mach-s3c2443/Kconfig b/arch/arm/mach-s3c2443/Kconfig
index 8814031..3bff23f 100644
--- a/arch/arm/mach-s3c2443/Kconfig
+++ b/arch/arm/mach-s3c2443/Kconfig
@@ -10,6 +10,7 @@ config CPU_S3C2443
 	select CPU_LLSERIAL_S3C2440
 	select SAMSUNG_CLKSRC
 	select S3C2443_CLOCK
+	select S3C2443_PM_COMMON
 	help
 	  Support for the S3C2443 SoC from the S3C24XX line
 
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index d8973ac..0a9f37c 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -50,6 +50,13 @@ config S3C2443_CLOCK
 	  Clock code for the S3C2443 and similar processors, which includes
 	  the S3C2416 and S3C2450.
 
+config S3C2443_PM_COMMON
+	bool
+	select PM_GENERIC_DOMAINS
+	help
+	  Common power management code for the S3C2443 and similar processors,
+	  which include the S3C2416 and S3C2450.
+
 config S3C24XX_DCLK
 	bool
 	help
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index b2b0112..300f77c 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_PM)		+= irq-pm.o
 obj-$(CONFIG_PM)		+= sleep.o
 obj-$(CONFIG_S3C2410_CLOCK)	+= s3c2410-clock.o
 obj-$(CONFIG_S3C2443_CLOCK)	+= s3c2443-clock.o
+obj-$(CONFIG_S3C2443_PM_COMMON)	+= s3c2443-pm-common.o
 obj-$(CONFIG_S3C2410_DMA)	+= dma.o
 obj-$(CONFIG_S3C2410_IOTIMING)	+= s3c2410-iotiming.o
 obj-$(CONFIG_S3C2412_IOTIMING)	+= s3c2412-iotiming.o
diff --git a/arch/arm/plat-s3c24xx/s3c2443-pm-common.c b/arch/arm/plat-s3c24xx/s3c2443-pm-common.c
new file mode 100644
index 0000000..b9aaf9a
--- /dev/null
+++ b/arch/arm/plat-s3c24xx/s3c2443-pm-common.c
@@ -0,0 +1,65 @@
+/*
+ * S3C2443,S3C2416,S3C2450 Power management support
+ *
+ * Copyright (c) 2011 Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+*/
+
+#include <linux/io.h>
+#include <linux/pm_domain.h>
+
+#include <mach/regs-s3c2443-clock.h>
+#include <plat/devs.h>
+
+
+static int s3c2443_usbphy_off(struct generic_pm_domain *domain)
+{
+	u32 val;
+
+	val = __raw_readl(S3C2443_PWRCFG);
+	val &= ~(S3C2443_PWRCFG_USBPHY);
+	__raw_writel(val, S3C2443_PWRCFG);
+
+	return 0;
+}
+
+static int s3c2443_usbphy_on(struct generic_pm_domain *domain)
+{
+	u32 val;
+
+	val = __raw_readl(S3C2443_PWRCFG);
+	val |= S3C2443_PWRCFG_USBPHY;
+	__raw_writel(val, S3C2443_PWRCFG);
+
+	return 0;
+}
+
+static struct generic_pm_domain s3c2443_usbphy_pd = {
+	.power_off = s3c2443_usbphy_off,
+	.power_on = s3c2443_usbphy_on,
+};
+
+static int __init s3c2443_pm_common_init(void)
+{
+	pm_genpd_init(&s3c2443_usbphy_pd, NULL, false);
+	pm_genpd_add_device(&s3c2443_usbphy_pd, &s3c_device_usb_hsudc.dev);
+
+	return 0;
+}
+arch_initcall(s3c2443_pm_common_init);
+
+static __init int s3c2443_pm_common_late_initcall(void)
+{
+	pm_genpd_poweroff_unused();
+	return 0;
+}
+late_initcall(s3c2443_pm_common_late_initcall);
diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
index 5e87293..9a81ad3 100644
--- a/drivers/usb/gadget/s3c-hsudc.c
+++ b/drivers/usb/gadget/s3c-hsudc.c
@@ -195,9 +195,6 @@ static void s3c_hsudc_init_phy(void)
 {
 	u32 cfg;
 
-	cfg = readl(S3C2443_PWRCFG) | S3C2443_PWRCFG_USBPHY;
-	writel(cfg, S3C2443_PWRCFG);
-
 	cfg = readl(S3C2443_URSTCON);
 	cfg |= (S3C2443_URSTCON_FUNCRST | S3C2443_URSTCON_PHYRST);
 	writel(cfg, S3C2443_URSTCON);
@@ -229,9 +226,6 @@ static void s3c_hsudc_uninit_phy(void)
 {
 	u32 cfg;
 
-	cfg = readl(S3C2443_PWRCFG) & ~S3C2443_PWRCFG_USBPHY;
-	writel(cfg, S3C2443_PWRCFG);
-
 	writel(S3C2443_PHYPWR_FSUSPEND, S3C2443_PHYPWR);
 
 	cfg = readl(S3C2443_UCLKCON) & ~S3C2443_UCLKCON_FUNC_CLKEN;
-- 
1.7.2.3
