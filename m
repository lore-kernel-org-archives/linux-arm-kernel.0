From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 22 Oct 2012 18:17:59 +0800
Subject: [PATCH 5/5] ASoC: sam9g20_wm8731: fix the issue for non-DT kernel
In-Reply-To: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
References: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1350901079-18307-5-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When register platform from DAIs, the platform device to PCM no longer
needed. So, fix it with this patch

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/mach-at91/board-sam9g20ek.c |    6 ------
 sound/soc/atmel/sam9g20_wm8731.c     |    2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

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
index 187dc65..0c5987a 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -182,7 +182,7 @@ static struct snd_soc_dai_link at91sam9g20ek_dai = {
 	.cpu_dai_name = "atmel-ssc-dai.0",
 	.codec_dai_name = "wm8731-hifi",
 	.init = at91sam9g20ek_wm8731_init,
-	.platform_name = "atmel-pcm-audio",
+	.platform_name = "atmel-ssc-dai.0",
 	.codec_name = "wm8731.0-001b",
 	.ops = &at91sam9g20ek_ops,
 };
-- 
1.7.9.5
