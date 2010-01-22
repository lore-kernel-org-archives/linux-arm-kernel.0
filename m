From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 22 Jan 2010 23:47:14 +0100
Subject: [PATCH 3/4] ARM: S3C64XX: Add touchscreen platform device definition
Message-ID: <b2e8f9f71001221447h66136f0djc8652fe96093eb12@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: S3C64XX: Add touchscreen platform device definition

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/plat-s3c64xx/Kconfig  |    5 +++
 arch/arm/plat-s3c64xx/Makefile |    4 +++
 arch/arm/plat-s3c64xx/dev-ts.c |   58 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s3c64xx/dev-ts.c

diff --git a/arch/arm/plat-s3c64xx/Kconfig b/arch/arm/plat-s3c64xx/Kconfig
index 37b4519..7b5b417 100644
--- a/arch/arm/plat-s3c64xx/Kconfig
+++ b/arch/arm/plat-s3c64xx/Kconfig
@@ -72,4 +72,9 @@ config S3C64XX_SETUP_SDHCI_GPIO
 	help
 	  Common setup code for S3C64XX SDHCI GPIO configurations

+config S3C64XX_DEV_TS
+	bool
+	help
+	  Common platform code for S3C64XX touchscreen device
+
 endif
diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
index 80255a5..74fb958 100644
--- a/arch/arm/plat-s3c64xx/Makefile
+++ b/arch/arm/plat-s3c64xx/Makefile
@@ -40,6 +40,10 @@ obj-$(CONFIG_S3C64XX_DMA)	+= dma.o

 obj-$(CONFIG_S3C_ADC)		+= dev-adc.o

+# TS support
+
+obj-$(CONFIG_S3C64XX_DEV_TS)	+= dev-ts.o
+
 # Device setup

 obj-$(CONFIG_S3C64XX_SETUP_I2C0) += setup-i2c0.o
diff --git a/arch/arm/plat-s3c64xx/dev-ts.c b/arch/arm/plat-s3c64xx/dev-ts.c
new file mode 100644
index 0000000..11ccd33
--- /dev/null
+++ b/arch/arm/plat-s3c64xx/dev-ts.c
@@ -0,0 +1,58 @@
+/* linux/arch/arm/plat-s3c64xx/dev-ts.c
+ *
+ * Copyright 2010 Maurus Cuelenaere
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
+	[0] = {
+		.start = S3C64XX_PA_ADC,
+		.end   = S3C64XX_PA_ADC + SZ_256 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_TC,
+		.end   = IRQ_TC,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_ts = {
+	.name		= "s3c64xx-ts",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_ts_resource),
+	.resource	= s3c_ts_resource,
+};
+EXPORT_SYMBOL(s3c_device_ts);
+
+void __init s3c_ts_set_platdata(struct s3c_ts_mach_info *pd)
+{
+	struct s3c_ts_mach_info *npd;
+
+	if (!pd) {
+		printk(KERN_ERR "%s: no platform data\n", __func__);
+		return;
+	}
+
+	npd = kmemdup(pd, sizeof(struct s3c_ts_mach_info), GFP_KERNEL);
+	if (!npd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+
+	s3c_device_ts.dev.platform_data = npd;
+}
+EXPORT_SYMBOL(s3c_ts_set_platdata);
-- 
1.6.6.1
