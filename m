From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 8 Mar 2010 21:07:46 +0100
Subject: [PATCH 4/7] ARM: S3C64XX: Add touchscreen platform device
	definition
In-Reply-To: <20100308195911.GG24864@trinity.fluff.org>
References: <b2e8f9f71003081038u441531bfsba40c7a11d302ee0@mail.gmail.com>
	<20100308195911.GG24864@trinity.fluff.org>
Message-ID: <b2e8f9f71003081207v5a778290j8636f4cc5a66377b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the touchscreen platform device definition for S3C64XX boards.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
?arch/arm/mach-s3c64xx/Makefile | ? ?1 +
?arch/arm/mach-s3c64xx/dev-ts.c | ? 61 ++++++++++++++++++++++++++++++++++++++++
?arch/arm/plat-samsung/Kconfig ?| ? ?6 ++++
?3 files changed, 68 insertions(+), 0 deletions(-)
?create mode 100644 arch/arm/mach-s3c64xx/dev-ts.c

diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index d1d341a..02bc97f 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -60,3 +60,4 @@ obj-y ? ? ? ? ? ? ? ? ? ? ? ? += dev-rtc.o
?obj-$(CONFIG_S3C_ADC) ? ? ? ? ?+= dev-adc.o
?obj-$(CONFIG_SND_S3C24XX_SOC) ?+= dev-audio.o
?obj-$(CONFIG_S3C64XX_DEV_SPI) ?+= dev-spi.o
+obj-$(CONFIG_S3C64XX_DEV_TS) ?+= dev-ts.o
diff --git a/arch/arm/mach-s3c64xx/dev-ts.c b/arch/arm/mach-s3c64xx/dev-ts.c
new file mode 100644
index 0000000..17cc793
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/dev-ts.c
@@ -0,0 +1,61 @@
+/* linux/arch/arm/mach-s3c64xx/dev-ts.c
+ *
+ * Copyright (c) 2008 Simtec Electronics
+ * ? ? http://armlinux.simtec.co.uk/
+ * ? ? Ben Dooks <ben@simtec.co.uk>, <ben-linux@fluff.org>
+ *
+ * Adapted by Maurus Cuelenaere for s3c64xx
+ *
+ * S3C64XX series device definition for touchscreen device
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+#include <plat/devs.h>
+#include <plat/ts.h>
+
+static struct resource s3c_ts_resource[] = {
+ ? ? ? [0] = {
+ ? ? ? ? ? ? ? .start = S3C64XX_PA_ADC,
+ ? ? ? ? ? ? ? .end ? = S3C64XX_PA_ADC + SZ_256 - 1,
+ ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
+ ? ? ? },
+ ? ? ? [1] = {
+ ? ? ? ? ? ? ? .start = IRQ_TC,
+ ? ? ? ? ? ? ? .end ? = IRQ_TC,
+ ? ? ? ? ? ? ? .flags = IORESOURCE_IRQ,
+ ? ? ? },
+};
+
+struct platform_device s3c_device_ts = {
+ ? ? ? .name ? ? ? ? ? = "s3c64xx-ts",
+ ? ? ? .id ? ? ? ? ? ? = -1,
+ ? ? ? .num_resources ?= ARRAY_SIZE(s3c_ts_resource),
+ ? ? ? .resource ? ? ? = s3c_ts_resource,
+};
+
+void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *pd)
+{
+ ? ? ? struct s3c2410_ts_mach_info *npd;
+
+ ? ? ? if (!pd) {
+ ? ? ? ? ? ? ? printk(KERN_ERR "%s: no platform data\n", __func__);
+ ? ? ? ? ? ? ? return;
+ ? ? ? }
+
+ ? ? ? npd = kmemdup(pd, sizeof(struct s3c2410_ts_mach_info), GFP_KERNEL);
+ ? ? ? if (!npd)
+ ? ? ? ? ? ? ? printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+
+ ? ? ? s3c_device_ts.dev.platform_data = npd;
+}
+EXPORT_SYMBOL(s3c24xx_ts_set_platdata);
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index d552c65..5d3ef35 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -191,6 +191,12 @@ config S3C64XX_DEV_SPI
? ? ? ? ?Compile in platform device definitions for S3C64XX's type
? ? ? ? ?SPI controllers.

+config S3C64XX_DEV_TS
+ ? ? ? bool
+ ? ? ? help
+ ? ? ? ? ? Common in platform device definitions for S3C64XX touchscreen
+ ? ? ? ? ? device
+
?# DMA

?config S3C_DMA
--
1.7.0.1
