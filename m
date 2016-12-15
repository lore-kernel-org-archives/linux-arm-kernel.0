From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Dec 2016 12:20:53 +0000
Subject: Applied "ASoC: atmel: tse850: rely on the ssc to register as a cpu
 dai by itself" to the asoc tree
In-Reply-To: <1481052157-23400-3-git-send-email-peda@axentia.se>
Message-ID: <E1cHV1p-0000av-9J@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: atmel: tse850: rely on the ssc to register as a cpu dai by itself

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

>From ca8c7f233fa2c40e2a23f982dc33d947f28ad207 Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Tue, 6 Dec 2016 20:22:37 +0100
Subject: [PATCH] ASoC: atmel: tse850: rely on the ssc to register as a cpu dai
 by itself

This breaks devicetree compatibility, but in this case that is ok. All
affected units are either on my desk, or running an even older version
of the driver that is not compatible with the upstreamed version anyway
(and when these other units are eventually updated, they will get a
fresh dtb as well, so that is not a significant problem either).

All of that is of course assuming that noone else has managed to build
something that can use this driver, but that seems extremely improbable.

Signed-off-by: Peter Rosin <peda@axentia.se>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/axentia,tse850-pcm5142.txt      | 11 ++++++++---
 sound/soc/atmel/tse850-pcm5142.c                   | 23 +++-------------------
 2 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt b/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
index 5b9b38f578bb..fdb25b492514 100644
--- a/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
+++ b/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
@@ -2,8 +2,7 @@ Devicetree bindings for the Axentia TSE-850 audio complex
 
 Required properties:
   - compatible: "axentia,tse850-pcm5142"
-  - axentia,ssc-controller: The phandle of the atmel SSC controller used as
-    cpu dai.
+  - axentia,cpu-dai: The phandle of the cpu dai.
   - axentia,audio-codec: The phandle of the PCM5142 codec.
   - axentia,add-gpios: gpio specifier that controls the mixer.
   - axentia,loop1-gpios: gpio specifier that controls loop relays on channel 1.
@@ -43,6 +42,12 @@ the PCM5142 codec.
 
 Example:
 
+	&ssc0 {
+		#sound-dai-cells = <0>;
+
+		status = "okay";
+	};
+
 	&i2c {
 		codec: pcm5142 at 4c {
 			compatible = "ti,pcm5142";
@@ -77,7 +82,7 @@ Example:
 	sound {
 		compatible = "axentia,tse850-pcm5142";
 
-		axentia,ssc-controller = <&ssc0>;
+		axentia,cpu-dai = <&ssc0>;
 		axentia,audio-codec = <&codec>;
 
 		axentia,add-gpios = <&pioA 8 GPIO_ACTIVE_LOW>;
diff --git a/sound/soc/atmel/tse850-pcm5142.c b/sound/soc/atmel/tse850-pcm5142.c
index ac6a814c8ecf..a72c7d642026 100644
--- a/sound/soc/atmel/tse850-pcm5142.c
+++ b/sound/soc/atmel/tse850-pcm5142.c
@@ -51,11 +51,7 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
-#include "atmel_ssc_dai.h"
-
 struct tse850_priv {
-	int ssc_id;
-
 	struct gpio_desc *add;
 	struct gpio_desc *loop1;
 	struct gpio_desc *loop2;
@@ -329,23 +325,20 @@ static int tse850_dt_init(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *codec_np, *cpu_np;
-	struct snd_soc_card *card = &tse850_card;
 	struct snd_soc_dai_link *dailink = &tse850_dailink;
-	struct tse850_priv *tse850 = snd_soc_card_get_drvdata(card);
 
 	if (!np) {
 		dev_err(&pdev->dev, "only device tree supported\n");
 		return -EINVAL;
 	}
 
-	cpu_np = of_parse_phandle(np, "axentia,ssc-controller", 0);
+	cpu_np = of_parse_phandle(np, "axentia,cpu-dai", 0);
 	if (!cpu_np) {
-		dev_err(&pdev->dev, "failed to get dai and pcm info\n");
+		dev_err(&pdev->dev, "failed to get cpu dai\n");
 		return -EINVAL;
 	}
 	dailink->cpu_of_node = cpu_np;
 	dailink->platform_of_node = cpu_np;
-	tse850->ssc_id = of_alias_get_id(cpu_np, "ssc");
 	of_node_put(cpu_np);
 
 	codec_np = of_parse_phandle(np, "axentia,audio-codec", 0);
@@ -415,23 +408,14 @@ static int tse850_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = atmel_ssc_set_audio(tse850->ssc_id);
-	if (ret != 0) {
-		dev_err(dev,
-			"failed to set SSC %d for audio\n", tse850->ssc_id);
-		goto err_disable_ana;
-	}
-
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		dev_err(dev, "snd_soc_register_card failed\n");
-		goto err_put_audio;
+		goto err_disable_ana;
 	}
 
 	return 0;
 
-err_put_audio:
-	atmel_ssc_put_audio(tse850->ssc_id);
 err_disable_ana:
 	regulator_disable(tse850->ana);
 	return ret;
@@ -443,7 +427,6 @@ static int tse850_remove(struct platform_device *pdev)
 	struct tse850_priv *tse850 = snd_soc_card_get_drvdata(card);
 
 	snd_soc_unregister_card(card);
-	atmel_ssc_put_audio(tse850->ssc_id);
 	regulator_disable(tse850->ana);
 
 	return 0;
-- 
2.11.0
