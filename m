From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Nov 2016 17:26:31 +0000
Subject: Applied "ASoC: samsung: smdk_wm8580: Remove old platforms and drop
 mach-types usage" to the asoc tree
In-Reply-To: <1479669895-19124-3-git-send-email-krzk@kernel.org>
Message-ID: <E1c9Epz-0005o0-BN@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: samsung: smdk_wm8580: Remove old platforms and drop mach-types usage

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From cd9e2b62768c21c051c585f9d4935b4fa6e9603e Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 20 Nov 2016 21:24:52 +0200
Subject: [PATCH] ASoC: samsung: smdk_wm8580: Remove old platforms and drop
 mach-types usage

MACH_SMDKC100, MACH_SMDKV210 and MACH_SMDKC110 are no longer supported
so we can drop the dead code.  After this the driver no longer
differentiates between machines (S3C24xx machines are not supported by
it) so there is no need to override I2S device id in cpu_dai_name and
SEC_PLAYBACK dai_link can be removed as well.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/smdk_wm8580.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index 548bfd993788..de724ce7b955 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -14,8 +14,6 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
-#include <asm/mach-types.h>
-
 #include "../codecs/wm8580.h"
 #include "i2s.h"
 
@@ -147,7 +145,6 @@ static int smdk_wm8580_init_paiftx(struct snd_soc_pcm_runtime *rtd)
 enum {
 	PRI_PLAYBACK = 0,
 	PRI_CAPTURE,
-	SEC_PLAYBACK,
 };
 
 #define SMDK_DAI_FMT (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | \
@@ -157,7 +154,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 	[PRI_PLAYBACK] = { /* Primary Playback i/f */
 		.name = "WM8580 PAIF RX",
 		.stream_name = "Playback",
-		.cpu_dai_name = "samsung-i2s.0",
+		.cpu_dai_name = "samsung-i2s.2",
 		.codec_dai_name = "wm8580-hifi-playback",
 		.platform_name = "samsung-i2s.0",
 		.codec_name = "wm8580.0-001b",
@@ -167,7 +164,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 	[PRI_CAPTURE] = { /* Primary Capture i/f */
 		.name = "WM8580 PAIF TX",
 		.stream_name = "Capture",
-		.cpu_dai_name = "samsung-i2s.0",
+		.cpu_dai_name = "samsung-i2s.2",
 		.codec_dai_name = "wm8580-hifi-capture",
 		.platform_name = "samsung-i2s.0",
 		.codec_name = "wm8580.0-001b",
@@ -175,23 +172,13 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.init = smdk_wm8580_init_paiftx,
 		.ops = &smdk_ops,
 	},
-	[SEC_PLAYBACK] = { /* Sec_Fifo Playback i/f */
-		.name = "Sec_FIFO TX",
-		.stream_name = "Playback",
-		.cpu_dai_name = "samsung-i2s-sec",
-		.codec_dai_name = "wm8580-hifi-playback",
-		.platform_name = "samsung-i2s-sec",
-		.codec_name = "wm8580.0-001b",
-		.dai_fmt = SMDK_DAI_FMT,
-		.ops = &smdk_ops,
-	},
 };
 
 static struct snd_soc_card smdk = {
 	.name = "SMDK-I2S",
 	.owner = THIS_MODULE,
 	.dai_link = smdk_dai,
-	.num_links = 2,
+	.num_links = ARRAY_SIZE(smdk_dai),
 
 	.dapm_widgets = smdk_wm8580_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(smdk_wm8580_dapm_widgets),
@@ -204,17 +191,6 @@ static struct platform_device *smdk_snd_device;
 static int __init smdk_audio_init(void)
 {
 	int ret;
-	char *str;
-
-	if (machine_is_smdkc100()
-			|| machine_is_smdkv210() || machine_is_smdkc110()) {
-		smdk.num_links = 3;
-	} else if (machine_is_smdk6410()) {
-		str = (char *)smdk_dai[PRI_PLAYBACK].cpu_dai_name;
-		str[strlen(str) - 1] = '2';
-		str = (char *)smdk_dai[PRI_CAPTURE].cpu_dai_name;
-		str[strlen(str) - 1] = '2';
-	}
 
 	smdk_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!smdk_snd_device)
-- 
2.10.2
