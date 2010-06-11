From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 11 Jun 2010 21:49:10 +0200
Subject: [PATCH 7/9] ARM: SAMSUNG: Add crypto engine platform definition
In-Reply-To: <cover.1276284559.git.mcuelenaere@gmail.com>
References: <cover.1276284559.git.mcuelenaere@gmail.com>
Message-ID: <4C129336.4000703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the platform device used by the crypto engine driver.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/Kconfig                          |    2 +
 arch/arm/plat-samsung/Kconfig             |    5 +++
 arch/arm/plat-samsung/Makefile            |    1 +
 arch/arm/plat-samsung/dev-sss.c           |   46 +++++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h |    2 +
 5 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/dev-sss.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3f8718f..3e80510 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -680,6 +680,7 @@ config ARCH_S3C64XX
 	select S3C_DEV_NAND
 	select USB_ARCH_HAS_OHCI
 	select SAMSUNG_GPIOLIB_4BIT
+	select SAMSUNG_DEV_SSS
 	help
 	  Samsung S3C64XX series based systems
 
@@ -705,6 +706,7 @@ config ARCH_S5PC1XX
 	select HAVE_CLK
 	select CPU_V7
 	select ARM_L1_CACHE_SHIFT_6
+	select SAMSUNG_DEV_SSS
 	help
 	  Samsung S5PC1XX series based systems
 
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 229919e..c001d54 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -211,6 +211,11 @@ config SAMSUNG_DEV_TS
 	help
 	    Common in platform device definitions for touchscreen device
 
+config SAMSUNG_DEV_SSS
+	bool
+	help
+	    Compile in platform device definitions for Security Sub-Systems
+
 # DMA
 
 config S3C_DMA
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 4828849..43a3c64 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_S3C_DEV_RTC)	+= dev-rtc.o
 
 obj-$(CONFIG_SAMSUNG_DEV_ADC)	+= dev-adc.o
 obj-$(CONFIG_SAMSUNG_DEV_TS)	+= dev-ts.o
+obj-$(CONFIG_SAMSUNG_DEV_SSS)	+= dev-sss.o
 
 # DMA support
 
diff --git a/arch/arm/plat-samsung/dev-sss.c b/arch/arm/plat-samsung/dev-sss.c
new file mode 100644
index 0000000..6c662a1
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-sss.c
@@ -0,0 +1,46 @@
+/* linux/arch/arm/plat-samsung/dev-sss.c
+ *
+ * Copyright (c) 2010 Maurus Cuelenaere
+ *
+ * Based on arch/arm/plat-samsung/dev-hsmmc1.c
+ * original file Copyright (c) 2008 Simtec Electronics
+ *
+ * Samsung series device definition for security sub-system
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+#include <plat/devs.h>
+
+static struct resource s3c_sss_resource[] = {
+	{
+		.start = SAMSUNG_PA_SSS,
+		.end   = SAMSUNG_PA_SSS + SAMSUNG_SZ_SSS - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_SEC,
+		.end   = IRQ_SEC,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static u64 s3c_device_sss_dmamask = 0xffffffffUL;
+
+struct platform_device s3c_device_sss = {
+	.name		= "s3c-sss",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_sss_resource),
+	.resource	= s3c_sss_resource,
+	.dev		= {
+		.dma_mask		= &s3c_device_sss_dmamask,
+		.coherent_dma_mask	= 0xffffffffUL,
+	},
+};
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index ef69e56..c689fae 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -64,6 +64,8 @@ extern struct platform_device s3c_device_nand;
 extern struct platform_device s3c_device_usbgadget;
 extern struct platform_device s3c_device_usb_hsotg;
 
+extern struct platform_device s3c_device_sss;
+
 extern struct platform_device s5pv210_device_ac97;
 extern struct platform_device s5pv210_device_pcm0;
 extern struct platform_device s5pv210_device_pcm1;
-- 
1.7.1
