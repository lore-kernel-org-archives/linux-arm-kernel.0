From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Sep 2012 13:34:31 +0800
Subject: [PATCH 02/34] ASoC: mx27vis: retrieve gpio numbers from platform_data
In-Reply-To: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1347860103-4141-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than including mach/iomux-mx27.h to define gpio numbers and set
up the pins, the patch moves all these into machine code and has the
gpio numbers passed to driver via platform_data.  As the result, we
can remove the mach/iomux-mx27.h inclusion from driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Javier Martin <javier.martin@vista-silicon.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel at alsa-project.org
---
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   42 ++++++++++++++++++++++++++-
 include/linux/platform_data/asoc-mx27vis.h  |   11 +++++++
 sound/soc/fsl/mx27vis-aic32x4.c             |   42 +++++++++++++--------------
 3 files changed, 72 insertions(+), 23 deletions(-)
 create mode 100644 include/linux/platform_data/asoc-mx27vis.h

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index f264ddd..5627229 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -33,6 +33,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/leds.h>
 #include <linux/memblock.h>
+#include <linux/platform_data/asoc-mx27vis.h>
 #include <media/soc_camera.h>
 #include <sound/tlv320aic32x4.h>
 #include <asm/mach-types.h>
@@ -58,6 +59,11 @@
 #define EXPBOARD_BIT1		(GPIO_PORTD + 27)
 #define EXPBOARD_BIT0		(GPIO_PORTD + 28)
 
+#define AMP_GAIN_0		(GPIO_PORTF + 9)
+#define AMP_GAIN_1		(GPIO_PORTF + 8)
+#define AMP_MUTE_SDL		(GPIO_PORTE + 5)
+#define AMP_MUTE_SDR		(GPIO_PORTF + 7)
+
 static const int visstrim_m10_pins[] __initconst = {
 	/* UART1 (console) */
 	PE12_PF_UART1_TXD,
@@ -139,6 +145,11 @@ static const int visstrim_m10_pins[] __initconst = {
 	EXPBOARD_BIT2 | GPIO_GPIO | GPIO_IN | GPIO_PUEN,
 	EXPBOARD_BIT1 | GPIO_GPIO | GPIO_IN | GPIO_PUEN,
 	EXPBOARD_BIT0 | GPIO_GPIO | GPIO_IN | GPIO_PUEN,
+	/* Audio AMP control */
+	AMP_GAIN_0 | GPIO_GPIO | GPIO_OUT,
+	AMP_GAIN_1 | GPIO_GPIO | GPIO_OUT,
+	AMP_MUTE_SDL | GPIO_GPIO | GPIO_OUT,
+	AMP_MUTE_SDR | GPIO_GPIO | GPIO_OUT,
 };
 
 static struct gpio visstrim_m10_version_gpios[] = {
@@ -166,6 +177,26 @@ static const struct gpio visstrim_m10_gpios[] __initconst = {
 		.flags = GPIOF_DIR_OUT | GPIOF_INIT_LOW,
 		.label = "usbotg_cs",
 	},
+	{
+		.gpio = AMP_GAIN_0,
+		.flags = GPIOF_DIR_OUT,
+		.label = "amp-gain-0",
+	},
+	{
+		.gpio = AMP_GAIN_1,
+		.flags = GPIOF_DIR_OUT,
+		.label = "amp-gain-1",
+	},
+	{
+		.gpio = AMP_MUTE_SDL,
+		.flags = GPIOF_DIR_OUT,
+		.label = "amp-mute-sdl",
+	},
+	{
+		.gpio = AMP_MUTE_SDR,
+		.flags = GPIOF_DIR_OUT,
+		.label = "amp-mute-sdr",
+	},
 };
 
 /* Camera */
@@ -405,6 +436,14 @@ static const struct imx_ssi_platform_data visstrim_m10_ssi_pdata __initconst = {
 	.flags			= IMX_SSI_DMA | IMX_SSI_SYN,
 };
 
+/* Audio */
+static const struct snd_mx27vis_platform_data snd_mx27vis_pdata __initconst = {
+	.amp_gain0_gpio = AMP_GAIN_0,
+	.amp_gain1_gpio = AMP_GAIN_1,
+	.amp_mutel_gpio = AMP_MUTE_SDL,
+	.amp_muter_gpio = AMP_MUTE_SDR,
+};
+
 static void __init visstrim_m10_revision(void)
 {
 	int exp_version = 0;
@@ -463,7 +502,8 @@ static void __init visstrim_m10_board_init(void)
 	imx27_add_fec(NULL);
 	imx_add_gpio_keys(&visstrim_gpio_keys_platform_data);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
-	imx_add_platform_device("mx27vis", 0, NULL, 0, NULL, 0);
+	imx_add_platform_device("mx27vis", 0, NULL, 0, &snd_mx27vis_pdata,
+				sizeof(snd_mx27vis_pdata));
 	platform_device_register_resndata(NULL, "soc-camera-pdrv", 0, NULL, 0,
 				      &iclink_tvp5150, sizeof(iclink_tvp5150));
 	gpio_led_register_device(0, &visstrim_m10_led_data);
diff --git a/include/linux/platform_data/asoc-mx27vis.h b/include/linux/platform_data/asoc-mx27vis.h
new file mode 100644
index 0000000..409adcd
--- /dev/null
+++ b/include/linux/platform_data/asoc-mx27vis.h
@@ -0,0 +1,11 @@
+#ifndef __PLATFORM_DATA_ASOC_MX27VIS_H
+#define __PLATFORM_DATA_ASOC_MX27VIS_H
+
+struct snd_mx27vis_platform_data {
+	int amp_gain0_gpio;
+	int amp_gain1_gpio;
+	int amp_mutel_gpio;
+	int amp_muter_gpio;
+};
+
+#endif /* __PLATFORM_DATA_ASOC_MX27VIS_H */
diff --git a/sound/soc/fsl/mx27vis-aic32x4.c b/sound/soc/fsl/mx27vis-aic32x4.c
index f6d04ad..2b76877 100644
--- a/sound/soc/fsl/mx27vis-aic32x4.c
+++ b/sound/soc/fsl/mx27vis-aic32x4.c
@@ -26,13 +26,13 @@
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/asoc-mx27vis.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 #include <asm/mach-types.h>
-#include <mach/iomux-mx27.h>
 
 #include "../codecs/tlv320aic32x4.h"
 #include "imx-ssi.h"
@@ -41,20 +41,12 @@
 #define MX27VIS_AMP_GAIN	0
 #define MX27VIS_AMP_MUTE	1
 
-#define MX27VIS_PIN_G0		(GPIO_PORTF + 9)
-#define MX27VIS_PIN_G1		(GPIO_PORTF + 8)
-#define MX27VIS_PIN_SDL		(GPIO_PORTE + 5)
-#define MX27VIS_PIN_SDR		(GPIO_PORTF + 7)
-
 static int mx27vis_amp_gain;
 static int mx27vis_amp_mute;
-
-static const int mx27vis_amp_pins[] = {
-	MX27VIS_PIN_G0 | GPIO_GPIO | GPIO_OUT,
-	MX27VIS_PIN_G1 | GPIO_GPIO | GPIO_OUT,
-	MX27VIS_PIN_SDL | GPIO_GPIO | GPIO_OUT,
-	MX27VIS_PIN_SDR | GPIO_GPIO | GPIO_OUT,
-};
+static int mx27vis_amp_gain0_gpio;
+static int mx27vis_amp_gain1_gpio;
+static int mx27vis_amp_mutel_gpio;
+static int mx27vis_amp_muter_gpio;
 
 static int mx27vis_aic32x4_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params)
@@ -109,13 +101,13 @@ static int mx27vis_amp_set(struct snd_kcontrol *kcontrol,
 
 	switch (reg) {
 	case MX27VIS_AMP_GAIN:
-		gpio_set_value(MX27VIS_PIN_G0, value & 1);
-		gpio_set_value(MX27VIS_PIN_G1, value >> 1);
+		gpio_set_value(mx27vis_amp_gain0_gpio, value & 1);
+		gpio_set_value(mx27vis_amp_gain1_gpio, value >> 1);
 		mx27vis_amp_gain = value;
 		break;
 	case MX27VIS_AMP_MUTE:
-		gpio_set_value(MX27VIS_PIN_SDL, value & 1);
-		gpio_set_value(MX27VIS_PIN_SDR, value >> 1);
+		gpio_set_value(mx27vis_amp_mutel_gpio, value & 1);
+		gpio_set_value(mx27vis_amp_muter_gpio, value >> 1);
 		mx27vis_amp_mute = value;
 		break;
 	}
@@ -190,8 +182,19 @@ static struct snd_soc_card mx27vis_aic32x4 = {
 
 static int __devinit mx27vis_aic32x4_probe(struct platform_device *pdev)
 {
+	struct snd_mx27vis_platform_data *pdata = pdev->dev.platform_data;
 	int ret;
 
+	if (!pdata) {
+		dev_err(&pdev->dev, "No platform data supplied\n");
+		return -EINVAL;
+	}
+
+	mx27vis_amp_gain0_gpio = pdata->amp_gain0_gpio;
+	mx27vis_amp_gain1_gpio = pdata->amp_gain1_gpio;
+	mx27vis_amp_mutel_gpio = pdata->amp_mutel_gpio;
+	mx27vis_amp_muter_gpio = pdata->amp_muter_gpio;
+
 	mx27vis_aic32x4.dev = &pdev->dev;
 	ret = snd_soc_register_card(&mx27vis_aic32x4);
 	if (ret) {
@@ -213,11 +216,6 @@ static int __devinit mx27vis_aic32x4_probe(struct platform_device *pdev)
 			IMX_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0)
 	);
 
-	ret = mxc_gpio_setup_multiple_pins(mx27vis_amp_pins,
-			ARRAY_SIZE(mx27vis_amp_pins), "MX27VIS_AMP");
-	if (ret)
-		printk(KERN_ERR "ASoC: unable to setup gpios\n");
-
 	return ret;
 }
 
-- 
1.7.9.5
