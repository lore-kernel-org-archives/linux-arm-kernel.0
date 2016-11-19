From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 19 Nov 2016 16:48:28 +0200
Subject: [RFT 3/6] ASoC: samsung: smdk_wm8580: Remove machine specific quirks
In-Reply-To: <1479566911-5580-1-git-send-email-krzk@kernel.org>
References: <1479566911-5580-1-git-send-email-krzk@kernel.org>
Message-ID: <1479566911-5580-4-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver no longer differentiates between machines (S3C24xx machines
are not supported by it) so there is no need to override I2S device id
in cpu_dai_name.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested. The driver did not override .platform_name which looks
suspicious to me. However I did not want to add changes which could have
some visible impact on output code.
---
 sound/soc/samsung/smdk_wm8580.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index 59fd3b8fd414..3bf33387dfeb 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -155,7 +155,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 	[PRI_PLAYBACK] = { /* Primary Playback i/f */
 		.name = "WM8580 PAIF RX",
 		.stream_name = "Playback",
-		.cpu_dai_name = "samsung-i2s.0",
+		.cpu_dai_name = "samsung-i2s.2",
 		.codec_dai_name = "wm8580-hifi-playback",
 		.platform_name = "samsung-i2s.0",
 		.codec_name = "wm8580.0-001b",
@@ -165,7 +165,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 	[PRI_CAPTURE] = { /* Primary Capture i/f */
 		.name = "WM8580 PAIF TX",
 		.stream_name = "Capture",
-		.cpu_dai_name = "samsung-i2s.0",
+		.cpu_dai_name = "samsung-i2s.2",
 		.codec_dai_name = "wm8580-hifi-capture",
 		.platform_name = "samsung-i2s.0",
 		.codec_name = "wm8580.0-001b",
@@ -202,12 +202,6 @@ static struct platform_device *smdk_snd_device;
 static int __init smdk_audio_init(void)
 {
 	int ret;
-	char *str;
-
-	str = (char *)smdk_dai[PRI_PLAYBACK].cpu_dai_name;
-	str[strlen(str) - 1] = '2';
-	str = (char *)smdk_dai[PRI_CAPTURE].cpu_dai_name;
-	str[strlen(str) - 1] = '2';
 
 	smdk_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!smdk_snd_device)
-- 
2.7.4
