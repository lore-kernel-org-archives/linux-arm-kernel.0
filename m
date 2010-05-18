From: jassi.brar@samsung.com (Jassi Brar)
Date: Tue, 18 May 2010 16:03:02 +0900
Subject: [PATCH 8/9] ARM: S5P6440: Add audio platform devices
In-Reply-To: <1274166128-6429-1-git-send-email-jassi.brar@samsung.com>
References: <1274166128-6429-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <1274166182-8258-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define platform devices for all audio devices found on S5P6440

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p6440/Makefile            |    3 +
 arch/arm/mach-s5p6440/dev-audio.c         |  129 +++++++++++++++++++++++++++++
 arch/arm/mach-s5p6440/include/mach/map.h  |    6 ++
 arch/arm/plat-samsung/include/plat/devs.h |    3 +
 4 files changed, 141 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5p6440/dev-audio.c

diff --git a/arch/arm/mach-s5p6440/Makefile b/arch/arm/mach-s5p6440/Makefile
index 3f243dd..5fd17d3 100644
--- a/arch/arm/mach-s5p6440/Makefile
+++ b/arch/arm/mach-s5p6440/Makefile
@@ -17,3 +17,6 @@ obj-$(CONFIG_CPU_S5P6440)	+= cpu.o init.o clock.o gpio.o dma.o
 # machine support
 
 obj-$(CONFIG_MACH_SMDK6440)	+= mach-smdk6440.o
+
+# device support
+obj-y				+= dev-audio.o
diff --git a/arch/arm/mach-s5p6440/dev-audio.c b/arch/arm/mach-s5p6440/dev-audio.c
new file mode 100644
index 0000000..f1563ea
--- /dev/null
+++ b/arch/arm/mach-s5p6440/dev-audio.c
@@ -0,0 +1,127 @@
+/* linux/arch/arm/mach-s5p6440/dev-audio.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co. Ltd
+ *	Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+
+#include <plat/gpio-cfg.h>
+#include <plat/audio.h>
+
+#include <mach/gpio.h>
+#include <mach/map.h>
+#include <mach/dma.h>
+#include <mach/irqs.h>
+
+static int s5p6440_cfg_i2s(struct platform_device *pdev)
+{
+	/* configure GPIO for i2s port */
+	switch (pdev->id) {
+	case -1:
+		s3c_gpio_cfgpin(S5P6440_GPR(4), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6440_GPR(5), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6440_GPR(6), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6440_GPR(7), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6440_GPR(8), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6440_GPR(13), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S5P6440_GPR(14), S3C_GPIO_SFN(5));
+		break;
+
+	default:
+		printk(KERN_ERR "Invalid Device %d\n", pdev->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct s3c_audio_pdata s3c_i2s_pdata = {
+	.cfg_gpio = s5p6440_cfg_i2s,
+};
+
+static struct resource s5p6440_iis0_resource[] = {
+	[0] = {
+		.start = S5P6440_PA_I2S,
+		.end   = S5P6440_PA_I2S + 0x100 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = DMACH_I2S0_TX,
+		.end   = DMACH_I2S0_TX,
+		.flags = IORESOURCE_DMA,
+	},
+	[2] = {
+		.start = DMACH_I2S0_RX,
+		.end   = DMACH_I2S0_RX,
+		.flags = IORESOURCE_DMA,
+	},
+};
+
+struct platform_device s5p6440_device_iis = {
+	.name		  = "s3c64xx-iis-v4",
+	.id		  = -1,
+	.num_resources	  = ARRAY_SIZE(s5p6440_iis0_resource),
+	.resource	  = s5p6440_iis0_resource,
+	.dev = {
+		.platform_data = &s3c_i2s_pdata,
+	},
+};
+
+/* PCM Controller platform_devices */
+
+static int s5p6440_pcm_cfg_gpio(struct platform_device *pdev)
+{
+	switch (pdev->id) {
+	case 0:
+		s3c_gpio_cfgpin(S5P6440_GPR(7), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6440_GPR(13), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6440_GPR(14), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6440_GPR(8), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6440_GPR(6), S3C_GPIO_SFN(2));
+		break;
+
+	default:
+		printk(KERN_DEBUG "Invalid PCM Controller number!");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct s3c_audio_pdata s3c_pcm_pdata = {
+	.cfg_gpio = s5p6440_pcm_cfg_gpio,
+};
+
+static struct resource s5p6440_pcm0_resource[] = {
+	[0] = {
+		.start = S5P6440_PA_PCM,
+		.end   = S5P6440_PA_PCM + 0x100 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = DMACH_PCM0_TX,
+		.end   = DMACH_PCM0_TX,
+		.flags = IORESOURCE_DMA,
+	},
+	[2] = {
+		.start = DMACH_PCM0_RX,
+		.end   = DMACH_PCM0_RX,
+		.flags = IORESOURCE_DMA,
+	},
+};
+
+struct platform_device s5p6440_device_pcm = {
+	.name		  = "samsung-pcm",
+	.id		  = 0,
+	.num_resources	  = ARRAY_SIZE(s5p6440_pcm0_resource),
+	.resource	  = s5p6440_pcm0_resource,
+	.dev = {
+		.platform_data = &s3c_pcm_pdata,
+	},
+};
diff --git a/arch/arm/mach-s5p6440/include/mach/map.h b/arch/arm/mach-s5p6440/include/mach/map.h
index 0275784..72aedad 100644
--- a/arch/arm/mach-s5p6440/include/mach/map.h
+++ b/arch/arm/mach-s5p6440/include/mach/map.h
@@ -63,6 +63,12 @@
 #define S5P6440_PA_SDRAM	(0x20000000)
 #define S5P_PA_SDRAM		S5P6440_PA_SDRAM
 
+/* I2S */
+#define S5P6440_PA_I2S		0xF2000000
+
+/* PCM */
+#define S5P6440_PA_PCM		0xF2100000
+
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5P6440_PA_UART
 #define S3C_PA_IIC		S5P6440_PA_IIC0
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 17c8ff8..4380ca6 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -84,6 +84,9 @@ extern struct platform_device s5p6442_device_pcm1;
 extern struct platform_device s5p6442_device_iis0;
 extern struct platform_device s5p6442_device_iis1;
 
+extern struct platform_device s5p6440_device_pcm;
+extern struct platform_device s5p6440_device_iis;
+
 /* s3c2440 specific devices */
 
 #ifdef CONFIG_CPU_S3C2440
-- 
1.6.2.5
