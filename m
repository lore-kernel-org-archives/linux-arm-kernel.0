From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 22 Oct 2012 18:17:58 +0800
Subject: [PATCH 4/5] ASoC: sam9g20_wm8731: convert to device tree support
In-Reply-To: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
References: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1350901079-18307-4-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Covert sam9g20 wm8731 to device tree support
And enable it through dts file
  
  Tested on sam9g20 EK board

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |   25 +++++++++++--
 sound/soc/atmel/Kconfig                     |    2 +-
 sound/soc/atmel/sam9g20_wm8731.c            |   51 +++++++++++++++++++++++++--
 3 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index b06c0db..056ff33 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -51,6 +51,10 @@
 				atmel,vbus-gpio = <&pioC 5 0>;
 				status = "okay";
 			};
+
+			ssc0: ssc at fffbc000 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
@@ -114,8 +118,8 @@
 			reg = <0x50>;
 		};
 
-		wm8731 at 1b {
-			compatible = "wm8731";
+		wm8731: wm8731 at 1b {
+			compatible = "wlf,wm8731";
 			reg = <0x1b>;
 		};
 	};
@@ -139,4 +143,21 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	dai: dai {
+		compatible = "atmel,atmel-ssc-dai";
+		atmel,dai-master = <&ssc0>;
+	};
+
+	sound {
+		compatible = "atmel,at91sam9g20-audio";
+		atmel,model = "wm8731 @ sam9g20ek";
+
+		atmel,audio-routing =
+			"Ext Spk", "LHPOUT",
+			"Int Mic", "MICIN";
+
+		atmel,audio-codec = <&wm8731>;
+		atmel,dai = <&dai>;
+	};
 };
diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 72b09cf..43a82f0 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -16,7 +16,7 @@ config SND_ATMEL_SOC_SSC
 
 config SND_AT91_SOC_SAM9G20_WM8731
 	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
-	depends on ATMEL_SSC && ARCH_AT91SAM9G20 && SND_ATMEL_SOC && \
+	depends on ATMEL_SSC && SND_ATMEL_SOC && \
                    AT91_PROGRAMMABLE_CLOCKS
 	select SND_ATMEL_SOC_SSC
 	select SND_SOC_WM8731
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index e5e27db..187dc65 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -197,13 +197,17 @@ static struct snd_soc_card snd_soc_at91sam9g20ek = {
 
 static int __devinit at91sam9g20ek_audio_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *codec_np, *cpu_np;
 	struct clk *pllb;
 	struct snd_soc_card *card =&snd_soc_at91sam9g20ek;
 	int ret;
 
-	if (!(machine_is_at91sam9g20ek() || machine_is_at91sam9g20ek_2mmc()))
+	if (!np) {
+		if (!(machine_is_at91sam9g20ek()
+			|| machine_is_at91sam9g20ek_2mmc()))
 		return -ENODEV;
-
+	}
 	/*
 	 * Codec MCLK is supplied by PCK0 - set it up.
 	 */
@@ -230,6 +234,40 @@ static int __devinit at91sam9g20ek_audio_probe(struct platform_device *pdev)
 	clk_set_rate(mclk, MCLK_RATE);
 
 	card->dev = &pdev->dev;
+
+	/* Parse device node info */
+	if (np) {
+		ret = snd_soc_of_parse_card_name(card, "atmel,model");
+		if (ret)
+			goto err;
+
+		ret = snd_soc_of_parse_audio_routing(card,
+						"atmel,audio-routing");
+		if (ret)
+			goto err;
+
+		/* Parse codec dai info */
+		at91sam9g20ek_dai.codec_name = NULL;
+		codec_np = of_parse_phandle(np, "atmel,audio-codec", 0);
+		if (!codec_np) {
+			dev_err(&pdev->dev, "codec info missing\n");
+			return -EINVAL;
+		}
+		at91sam9g20ek_dai.codec_of_node = codec_np;
+		at91sam9g20ek_dai.cpu_dai_name = NULL;
+		at91sam9g20ek_dai.platform_name = NULL;
+		cpu_np = of_parse_phandle(np, "atmel,dai", 0);
+		if (!cpu_np) {
+			dev_err(&pdev->dev, "dai info missing\n");
+			return -EINVAL;
+		}
+		at91sam9g20ek_dai.cpu_of_node = cpu_np;
+		at91sam9g20ek_dai.platform_of_node = cpu_np;
+
+		of_node_put(codec_np);
+		of_node_put(cpu_np);
+	}
+
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		printk(KERN_ERR "ASoC: snd_soc_register_card() failed\n");
@@ -255,10 +293,19 @@ static int __devexit at91sam9g20ek_audio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id atmel_wm8731_dt_ids[] = {
+	{ .compatible = "atmel,at91sam9g20-audio", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, atmel_wm8731_dt_ids);
+#endif
+
 static struct platform_driver at91sam9g20ek_audio_driver = {
 	.driver = {
 		.name	= "at91sam9g20ek-audio",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(atmel_wm8731_dt_ids),
 	},
 	.probe	= at91sam9g20ek_audio_probe,
 	.remove	= __devexit_p(at91sam9g20ek_audio_remove),
-- 
1.7.9.5
