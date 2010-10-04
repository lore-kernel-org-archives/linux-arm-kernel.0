From: sw.youn@samsung.com (Seungwhan Youn)
Date: Mon,  4 Oct 2010 20:46:40 +0900
Subject: [PATCH 4/10] ARM: S5PV210: Add S/PDIF platform device
In-Reply-To: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
Message-ID: <1286192800-18487-1-git-send-email-sw.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add S/PDIF platform device to support S/PDIF PCM audio
on S5PV210.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 arch/arm/mach-s5pv210/dev-audio.c         |   40 +++++++++++++++++++++++++++++
 arch/arm/mach-s5pv210/include/mach/map.h  |    3 ++
 arch/arm/mach-s5pv210/mach-smdkc110.c     |    1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c     |    1 +
 arch/arm/plat-samsung/include/plat/devs.h |    1 +
 5 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/dev-audio.c b/arch/arm/mach-s5pv210/dev-audio.c
index 21dc6cf..4a02cdd 100644
--- a/arch/arm/mach-s5pv210/dev-audio.c
+++ b/arch/arm/mach-s5pv210/dev-audio.c
@@ -325,3 +325,43 @@ struct platform_device s5pv210_device_ac97 = {
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
+
+/* S/PDIF Controller platform_device */
+
+static int s5pv210_spdif_cfg_gpio(struct platform_device *pdev)
+{
+	s3c_gpio_cfgpin_range(S5PV210_GPC1(0), 2, S3C_GPIO_SFN(3));
+
+	return 0;
+}
+
+static struct resource s5pv210_spdif_resource[] = {
+	[0] = {
+		.start	= S5PV210_PA_SPDIF,
+		.end	= S5PV210_PA_SPDIF + 0x100 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= DMACH_SPDIF,
+		.end	= DMACH_SPDIF,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct s3c_audio_pdata samsung_spdif_pdata = {
+	.cfg_gpio = s5pv210_spdif_cfg_gpio,
+};
+
+static u64 s5pv210_spdif_dmamask = DMA_BIT_MASK(32);
+
+struct platform_device s5pv210_device_spdif = {
+	.name		= "samsung-spdif",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5pv210_spdif_resource),
+	.resource	= s5pv210_spdif_resource,
+	.dev = {
+		.platform_data = &samsung_spdif_pdata,
+		.dma_mask = &s5pv210_spdif_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+};
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 12a409f..9669f69 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -84,6 +84,9 @@
 #define S5PV210_PA_SDRAM	(0x20000000)
 #define S5P_PA_SDRAM		S5PV210_PA_SDRAM
 
+/* S/PDIF */
+#define S5PV210_PA_SPDIF	0xE1100000
+
 /* I2S */
 #define S5PV210_PA_IIS0		0xEEE30000
 #define S5PV210_PA_IIS1		0xE2100000
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index 8211bb8..a282513 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -81,6 +81,7 @@ static struct s3c_ide_platdata smdkc110_ide_pdata __initdata = {
 static struct platform_device *smdkc110_devices[] __initdata = {
 	&s5pv210_device_iis0,
 	&s5pv210_device_ac97,
+	&s5pv210_device_spdif,
 	&s3c_device_cfcon,
 	&s3c_device_i2c0,
 	&s3c_device_i2c1,
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index fbbc0a3..c38c110 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -103,6 +103,7 @@ static struct samsung_keypad_platdata smdkv210_keypad_data __initdata = {
 static struct platform_device *smdkv210_devices[] __initdata = {
 	&s5pv210_device_iis0,
 	&s5pv210_device_ac97,
+	&s5pv210_device_spdif,
 	&s3c_device_adc,
 	&s3c_device_cfcon,
 	&s3c_device_hsmmc0,
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index a1c3b93..328b40d 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -87,6 +87,7 @@ extern struct platform_device s5pv210_device_pcm2;
 extern struct platform_device s5pv210_device_iis0;
 extern struct platform_device s5pv210_device_iis1;
 extern struct platform_device s5pv210_device_iis2;
+extern struct platform_device s5pv210_device_spdif;
 
 extern struct platform_device s5p6442_device_pcm0;
 extern struct platform_device s5p6442_device_pcm1;
-- 
1.6.2.5
