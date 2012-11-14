From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 14 Nov 2012 18:09:10 +0800
Subject: [Patch v6 3/4] ASoC: atmel-ssc-dai: match new method of dai and pcm
 register
In-Reply-To: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
References: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1352887751-21848-4-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unneeded code with the new method of dai and pcm register

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Change since v5
  - initial patch
  - split from the previous patch
---
 arch/arm/mach-at91/at91sam9260_devices.c |    9 ---------
 arch/arm/mach-at91/board-sam9g20ek.c     |    6 ------
 sound/soc/atmel/sam9g20_wm8731.c         |   12 ++++++++++--
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index df7bebf..6959fd2 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -768,14 +768,6 @@ static inline void configure_ssc_pins(unsigned pins)
 		at91_set_A_periph(AT91_PIN_PB21, 1);
 }
 
-static struct platform_device at91sam9260_ssc_dai_device = {
-	.name	= "atmel-ssc-dai",
-	.id	= 0,
-	.dev	= {
-		.parent	= &(at91sam9260_ssc_device.dev),
-	},
-};
-
 /*
  * SSC controllers are accessed through library code, instead of any
  * kind of all-singing/all-dancing driver.  For example one could be
@@ -800,7 +792,6 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins)
 	}
 
 	platform_device_register(pdev);
-	platform_device_register(&at91sam9260_ssc_dai_device);
 }
 
 #else
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 5b6a6f9..ebdbf42 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -353,11 +353,6 @@ static struct i2c_board_info __initdata ek_i2c_devices[] = {
         },
 };
 
-static struct platform_device sam9g20ek_pcm_device = {
-	.name	= "atmel-pcm-audio",
-	.id = -1,
-};
-
 static struct platform_device sam9g20ek_audio_device = {
 	.name   = "at91sam9g20ek-audio",
 	.id     = -1,
@@ -365,7 +360,6 @@ static struct platform_device sam9g20ek_audio_device = {
 
 static void __init ek_add_device_audio(void)
 {
-	platform_device_register(&sam9g20ek_pcm_device);
 	platform_device_register(&sam9g20ek_audio_device);
 }
 
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 228ca6a..4deba18 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -179,10 +179,10 @@ static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link at91sam9g20ek_dai = {
 	.name = "WM8731",
 	.stream_name = "WM8731 PCM",
-	.cpu_dai_name = "atmel-ssc-dai.0",
+	.cpu_dai_name = "at91rm9200_ssc.0",
 	.codec_dai_name = "wm8731-hifi",
 	.init = at91sam9g20ek_wm8731_init,
-	.platform_name = "atmel-pcm-audio",
+	.platform_name = "at91rm9200_ssc.0",
 	.codec_name = "wm8731.0-001b",
 	.ops = &at91sam9g20ek_ops,
 };
@@ -204,6 +204,12 @@ static int __devinit at91sam9g20ek_audio_probe(struct platform_device *pdev)
 	if (!(machine_is_at91sam9g20ek() || machine_is_at91sam9g20ek_2mmc()))
 		return -ENODEV;
 
+	ret = atmel_ssc_set_audio(0);
+	if (ret) {
+		dev_err(&pdev->dev, "ssc channel is not valid\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Codec MCLK is supplied by PCK0 - set it up.
 	 */
@@ -241,6 +247,7 @@ err_mclk:
 	clk_put(mclk);
 	mclk = NULL;
 err:
+	atmel_ssc_put_audio(0);
 	return ret;
 }
 
@@ -248,6 +255,7 @@ static int __devexit at91sam9g20ek_audio_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
+	atmel_ssc_put_audio(0);
 	snd_soc_unregister_card(card);
 	clk_put(mclk);
 	mclk = NULL;
-- 
1.7.9.5
