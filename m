From: jassi.brar@samsung.com (Jassi Brar)
Date: Tue, 18 May 2010 14:10:44 +0900
Subject: [PATCH 6/9] ARM: S5P6442: Add audio platform devices
In-Reply-To: <1274159402-19265-1-git-send-email-jassi.brar@samsung.com>
References: <1274159402-19265-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <1274159444-19457-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define platform devices for all audio devices found on S5P6442

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p6442/Makefile            |    3 +
 arch/arm/mach-s5p6442/dev-audio.c         |  201 +++++++++++++++++++++++++++++
 arch/arm/mach-s5p6442/include/mach/map.h  |    8 +
 arch/arm/plat-samsung/include/plat/devs.h |    5 +
 4 files changed, 217 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5p6442/dev-audio.c

diff --git a/arch/arm/mach-s5p6442/Makefile b/arch/arm/mach-s5p6442/Makefile
index 17bd22e..bf30550 100644
--- a/arch/arm/mach-s5p6442/Makefile
+++ b/arch/arm/mach-s5p6442/Makefile
@@ -17,3 +17,6 @@ obj-$(CONFIG_CPU_S5P6442)	+= cpu.o init.o clock.o dma.o
 # machine support
 
 obj-$(CONFIG_MACH_SMDK6442)	+= mach-smdk6442.o
+
+# device support
+obj-y				+= dev-audio.o
diff --git a/arch/arm/mach-s5p6442/dev-audio.c b/arch/arm/mach-s5p6442/dev-audio.c
new file mode 100644
index 0000000..17cdd82
--- /dev/null
+++ b/arch/arm/mach-s5p6442/dev-audio.c
@@ -0,0 +1,197 @@
+/* linux/arch/arm/mach-s5p6442/dev-audio.c
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
+static int s5p6442_cfg_i2s(struct platform_device *pdev)
+{
+	/* configure GPIO for i2s port */
+	switch (pdev->id) {
+	case 1:
+		s3c_gpio_cfgpin(S5P6442_GPC1(0), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6442_GPC1(1), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6442_GPC1(2), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6442_GPC1(3), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6442_GPC1(4), S3C_GPIO_SFN(2));
+		break;
+
+	case -1:
+		s3c_gpio_cfgpin(S5P6442_GPC0(0), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6442_GPC0(1), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6442_GPC0(2), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6442_GPC0(3), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S5P6442_GPC0(4), S3C_GPIO_SFN(2));
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
+	.cfg_gpio = s5p6442_cfg_i2s,
+};
+
+static struct resource s5p6442_iis0_resource[] = {
+	[0] = {
+		.start = S5P6442_PA_I2S0,
+		.end   = S5P6442_PA_I2S0 + 0x100 - 1,
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
+struct platform_device s5p6442_device_iis0 = {
+	.name		  = "s3c64xx-iis-v4",
+	.id		  = -1,
+	.num_resources	  = ARRAY_SIZE(s5p6442_iis0_resource),
+	.resource	  = s5p6442_iis0_resource,
+	.dev = {
+		.platform_data = &s3c_i2s_pdata,
+	},
+}; EXPORT_SYMBOL(s5p6442_device_iis0);
+
+static struct resource s5p6442_iis1_resource[] = {
+	[0] = {
+		.start = S5P6442_PA_I2S1,
+		.end   = S5P6442_PA_I2S1 + 0x100 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = DMACH_I2S1_TX,
+		.end   = DMACH_I2S1_TX,
+		.flags = IORESOURCE_DMA,
+	},
+	[2] = {
+		.start = DMACH_I2S1_RX,
+		.end   = DMACH_I2S1_RX,
+		.flags = IORESOURCE_DMA,
+	},
+};
+
+struct platform_device s5p6442_device_iis1 = {
+	.name		  = "s3c64xx-iis",
+	.id		  = 1,
+	.num_resources	  = ARRAY_SIZE(s5p6442_iis1_resource),
+	.resource	  = s5p6442_iis1_resource,
+	.dev = {
+		.platform_data = &s3c_i2s_pdata,
+	},
+}; EXPORT_SYMBOL(s5p6442_device_iis1);
+
+/* PCM Controller platform_devices */
+
+static int s5p6442_pcm_cfg_gpio(struct platform_device *pdev)
+{
+	switch (pdev->id) {
+	case 0:
+		s3c_gpio_cfgpin(S5P6442_GPC0(0), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S5P6442_GPC0(1), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S5P6442_GPC0(2), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S5P6442_GPC0(3), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S5P6442_GPC0(4), S3C_GPIO_SFN(3));
+		break;
+
+	case 1:
+		s3c_gpio_cfgpin(S5P6442_GPC1(0), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S5P6442_GPC1(1), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S5P6442_GPC1(2), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S5P6442_GPC1(3), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin(S5P6442_GPC1(4), S3C_GPIO_SFN(3));
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
+	.cfg_gpio = s5p6442_pcm_cfg_gpio,
+};
+
+static struct resource s5p6442_pcm0_resource[] = {
+	[0] = {
+		.start = S5P6442_PA_PCM0,
+		.end   = S5P6442_PA_PCM0 + 0x100 - 1,
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
+struct platform_device s5p6442_device_pcm0 = {
+	.name		  = "samsung-pcm",
+	.id		  = 0,
+	.num_resources	  = ARRAY_SIZE(s5p6442_pcm0_resource),
+	.resource	  = s5p6442_pcm0_resource,
+	.dev = {
+		.platform_data = &s3c_pcm_pdata,
+	},
+}; EXPORT_SYMBOL(s5p6442_device_pcm0);
+
+static struct resource s5p6442_pcm1_resource[] = {
+	[0] = {
+		.start = S5P6442_PA_PCM1,
+		.end   = S5P6442_PA_PCM1 + 0x100 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = DMACH_PCM1_TX,
+		.end   = DMACH_PCM1_TX,
+		.flags = IORESOURCE_DMA,
+	},
+	[2] = {
+		.start = DMACH_PCM1_RX,
+		.end   = DMACH_PCM1_RX,
+		.flags = IORESOURCE_DMA,
+	},
+};
+
+struct platform_device s5p6442_device_pcm1 = {
+	.name		  = "samsung-pcm",
+	.id		  = 1,
+	.num_resources	  = ARRAY_SIZE(s5p6442_pcm1_resource),
+	.resource	  = s5p6442_pcm1_resource,
+	.dev = {
+		.platform_data = &s3c_pcm_pdata,
+	},
+}; EXPORT_SYMBOL(s5p6442_device_pcm1);
diff --git a/arch/arm/mach-s5p6442/include/mach/map.h b/arch/arm/mach-s5p6442/include/mach/map.h
index a263d77..7568dc0 100644
--- a/arch/arm/mach-s5p6442/include/mach/map.h
+++ b/arch/arm/mach-s5p6442/include/mach/map.h
@@ -54,6 +54,14 @@
 #define S5P6442_PA_SDRAM	(0x20000000)
 #define S5P_PA_SDRAM		S5P6442_PA_SDRAM
 
+/* I2S */
+#define S5P6442_PA_I2S0		0xC0B00000
+#define S5P6442_PA_I2S1		0xF2200000
+
+/* PCM */
+#define S5P6442_PA_PCM0		0xF2400000
+#define S5P6442_PA_PCM1		0xF2500000
+
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5P6442_PA_UART
 #define S3C_PA_IIC		S5P6442_PA_IIC0
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 10cfcbb..17c8ff8 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -79,6 +79,11 @@ extern struct platform_device s5pc100_device_iis0;
 extern struct platform_device s5pc100_device_iis1;
 extern struct platform_device s5pc100_device_iis2;
 
+extern struct platform_device s5p6442_device_pcm0;
+extern struct platform_device s5p6442_device_pcm1;
+extern struct platform_device s5p6442_device_iis0;
+extern struct platform_device s5p6442_device_iis1;
+
 /* s3c2440 specific devices */
 
 #ifdef CONFIG_CPU_S3C2440
-- 
1.6.2.5
