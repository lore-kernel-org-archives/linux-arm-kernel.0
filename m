From: voice.shen@atmel.com (Bo Shen)
Date: Tue,  6 Nov 2012 13:57:54 +0800
Subject: [RFC patch v3 4/4] ASoC: sam9g20-wm8731: convert dt support
In-Reply-To: <1352181474-19597-1-git-send-email-voice.shen@atmel.com>
References: <1352181474-19597-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1352181474-19597-4-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

convert sam9g20-wm8731 to device tree support

Signed-off-by: Bo Shen <voice.shen@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Change since v2:
  No change
Change since v1:
  Add sam9g20-wm8731 binding document
---
 .../bindings/sound/atmel-sam9g20-audio-wm8731.txt  |   21 ++++++++
 arch/arm/boot/dts/at91sam9260.dtsi                 |    2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |   20 +++++++-
 sound/soc/atmel/sam9g20_wm8731.c                   |   51 +++++++++++++++++++-
 4 files changed, 89 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-sam9g20-audio-wm8731.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel-sam9g20-audio-wm8731.txt b/Documentation/devicetree/bindings/sound/atmel-sam9g20-audio-wm8731.txt
new file mode 100644
index 0000000..ad77fb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel-sam9g20-audio-wm8731.txt
@@ -0,0 +1,21 @@
+* Atmel sam9g20ek audio complex
+
+Required properties:
+  - compatible: "atmel,at91sam9g20-audio"
+  - atmel,model: The user-visible name of this sound complex.
+  - atmel,audio-routing: A list of the connections between audio components.
+  - atmel,ssc-controller: The phandle of the SSC controller
+  - atmel,audio-codec: The phandle of the WM8731 audio codec
+
+Example:
+sound {
+	compatible = "atmel,at91sam9g20-audio";
+	atmel,model = "wm8731 @ sam9g20ek";
+
+	atmel,audio-routing =
+		"Ext Spk", "LHPOUT",
+		"Int MIC", "MICIN";
+
+	atmel,ssc-controller = <&ssc0>;
+	atmel,audio-codec = <&wm8731>;
+};
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index aaa42d8..d322dae 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -214,7 +214,7 @@
 			};
 
 			ssc0: ssc at fffbc000 {
-				compatible = "atmel,at91rm9200-ssc";
+				compatible = "atmel,at91rm9200-ssc-dai";
 				reg = <0xfffbc000 0x4000>;
 				interrupts = <14 4 5>;
 				status = "disable";
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index b06c0db..05706a3 100644
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
@@ -139,4 +143,16 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	sound {
+		compatible = "atmel,at91sam9g20-audio";
+		atmel,model = "wm8731 @ sam9g20ek";
+
+		atmel,audio-routing =
+			"Ext Spk", "LHPOUT",
+			"Int Mic", "MICIN";
+
+		atmel,ssc-controller = <&ssc0>;
+		atmel,audio-codec = <&wm8731>;
+	};
 };
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 862cbcc..36f0fb3 100644
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
+		cpu_np = of_parse_phandle(np, "atmel,ssc-controller", 0);
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
+static const struct of_device_id sam9g20ek_wm8731_dt_ids[] = {
+	{ .compatible = "atmel,at91sam9g20-audio", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sam9g20ek_wm8731_dt_ids);
+#endif
+
 static struct platform_driver at91sam9g20ek_audio_driver = {
 	.driver = {
 		.name	= "at91sam9g20ek-audio",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(sam9g20ek_wm8731_dt_ids),
 	},
 	.probe	= at91sam9g20ek_audio_probe,
 	.remove	= __devexit_p(at91sam9g20ek_audio_remove),
-- 
1.7.9.5
