From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 29 Jun 2011 20:00:15 +0200
Subject: [PATCH 1/5] ASoC: wm8731: rework power management
In-Reply-To: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
References: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- preserve crystal oscillator across suspend/resume sequence:
  enabled by default, it should be kept enabled on resume.
- if codec is in active state: set the active bit at resume time.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 sound/soc/codecs/wm8731.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 2dc964b..e65af3d 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -481,7 +481,8 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_OFF:
 		snd_soc_write(codec, WM8731_ACTIVE, 0x0);
-		snd_soc_write(codec, WM8731_PWR, 0xffff);
+		/* standby: keep crystal oscillator enabled */
+		snd_soc_write(codec, WM8731_PWR, 0x00df);
 		regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies),
 				       wm8731->supplies);
 		break;
@@ -533,6 +534,8 @@ static int wm8731_suspend(struct snd_soc_codec *codec, pm_message_t state)
 static int wm8731_resume(struct snd_soc_codec *codec)
 {
 	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	if (codec->active)
+		snd_soc_write(codec, WM8731_ACTIVE, 0x0001);
 
 	return 0;
 }
-- 
1.7.3
