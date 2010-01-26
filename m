From: jassisinghbrar@gmail.com (jassisinghbrar at gmail.com)
Date: Tue, 26 Jan 2010 14:51:39 +0900
Subject: [PATCH 1/3] ARM: S3C64XX: Add AC97 platform resources
Message-ID: <1264485101-13782-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

This patch defines the platform device and the resources: IRQ, DMA and MEM,
needed by the AC97 controller driver.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c/include/plat/audio.h |    8 +++
 arch/arm/plat-s3c/include/plat/devs.h  |    3 +
 arch/arm/plat-s3c64xx/dev-audio.c      |   78 ++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c/include/plat/audio.h b/arch/arm/plat-s3c/include/plat/audio.h
index f22d23b..e07c941 100644
--- a/arch/arm/plat-s3c/include/plat/audio.h
+++ b/arch/arm/plat-s3c/include/plat/audio.h
@@ -8,6 +8,14 @@
  * published by the Free Software Foundation.
  */
 
+/* The machine init code calls s3c*_ac97_setup_gpio with
+ * one of these defines in order to select appropriate bank
+ * of GPIO for AC97 pins
+ */
+#define S3C64XX_AC97_GPD  0
+#define S3C64XX_AC97_GPE  1
+extern void s3c64xx_ac97_setup_gpio(int);
+
 /**
  * struct s3c_audio_pdata - common platform data for audio device drivers
  * @cfg_gpio: Callback function to setup mux'ed pins in I2S/PCM/AC97 mode
diff --git a/arch/arm/plat-s3c/include/plat/devs.h b/arch/arm/plat-s3c/include/plat/devs.h
index c6f9b73..65317eb 100644
--- a/arch/arm/plat-s3c/include/plat/devs.h
+++ b/arch/arm/plat-s3c/include/plat/devs.h
@@ -35,7 +35,10 @@ extern struct platform_device s3c64xx_device_spi1;
 extern struct platform_device s3c64xx_device_pcm0;
 extern struct platform_device s3c64xx_device_pcm1;
 
+extern struct platform_device s3c64xx_device_ac97;
+
 extern struct platform_device s3c_device_ts;
+
 extern struct platform_device s3c_device_fb;
 extern struct platform_device s3c_device_ohci;
 extern struct platform_device s3c_device_lcd;
diff --git a/arch/arm/plat-s3c64xx/dev-audio.c b/arch/arm/plat-s3c64xx/dev-audio.c
index f6b7bfb..63088b7 100644
--- a/arch/arm/plat-s3c64xx/dev-audio.c
+++ b/arch/arm/plat-s3c64xx/dev-audio.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
 
 #include <mach/irqs.h>
 #include <mach/map.h>
@@ -254,3 +255,80 @@ struct platform_device s3c64xx_device_pcm1 = {
 	},
 };
 EXPORT_SYMBOL(s3c64xx_device_pcm1);
+
+/* AC97 Controller platform devices */
+
+static int s3c64xx_ac97_cfg_gpd(struct platform_device *pdev)
+{
+	s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C64XX_GPD0_AC97_BITCLK);
+	s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C64XX_GPD1_AC97_nRESET);
+	s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C64XX_GPD2_AC97_SYNC);
+	s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C64XX_GPD3_AC97_SDI);
+	s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C64XX_GPD4_AC97_SDO);
+
+	return 0;
+}
+
+static int s3c64xx_ac97_cfg_gpe(struct platform_device *pdev)
+{
+	s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C64XX_GPE0_AC97_BITCLK);
+	s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C64XX_GPE1_AC97_nRESET);
+	s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_AC97_SYNC);
+	s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_AC97_SDI);
+	s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_AC97_SDO);
+
+	return 0;
+}
+
+static struct resource s3c64xx_ac97_resource[] = {
+	[0] = {
+		.start = S3C64XX_PA_AC97,
+		.end   = S3C64XX_PA_AC97 + 0x100 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = DMACH_AC97_PCMOUT,
+		.end   = DMACH_AC97_PCMOUT,
+		.flags = IORESOURCE_DMA,
+	},
+	[2] = {
+		.start = DMACH_AC97_PCMIN,
+		.end   = DMACH_AC97_PCMIN,
+		.flags = IORESOURCE_DMA,
+	},
+	[3] = {
+		.start = DMACH_AC97_MICIN,
+		.end   = DMACH_AC97_MICIN,
+		.flags = IORESOURCE_DMA,
+	},
+	[4] = {
+		.start = IRQ_AC97,
+		.end   = IRQ_AC97,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c_audio_pdata s3c_ac97_pdata;
+
+static u64 s3c64xx_ac97_dmamask = DMA_BIT_MASK(32);
+
+struct platform_device s3c64xx_device_ac97 = {
+	.name		  = "s3c-ac97",
+	.id		  = -1,
+	.num_resources	  = ARRAY_SIZE(s3c64xx_ac97_resource),
+	.resource	  = s3c64xx_ac97_resource,
+	.dev = {
+		.platform_data = &s3c_ac97_pdata,
+		.dma_mask = &s3c64xx_ac97_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+};
+EXPORT_SYMBOL(s3c64xx_device_ac97);
+
+void __init s3c64xx_ac97_setup_gpio(int num)
+{
+	if (num == S3C64XX_AC97_GPD)
+		s3c_ac97_pdata.cfg_gpio = s3c64xx_ac97_cfg_gpd;
+	else
+		s3c_ac97_pdata.cfg_gpio = s3c64xx_ac97_cfg_gpe;
+}
-- 
1.6.2.5
