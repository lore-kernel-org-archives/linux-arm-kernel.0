From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 14 Nov 2012 18:09:11 +0800
Subject: [Patch v6 4/4] ASoC: at91sam9g20ek-wm8731: convert to dt support
In-Reply-To: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
References: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1352887751-21848-5-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

convert at91sam9g20ek with wm8731 to device tree support

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Change since v5:
  No change
Change since v4 RFC:
  Using the full name of the EK which make it more clear
Change since v3 RFC:
  Remove dai node, remap ssc in place
  without pinctrl added, so don't modify the dtsi file, will be added
  soon
Change since v2:
  No change
Change since v1:
  Add sam9g20-wm8731 binding document
---
 .../sound/atmel-at91sam9g20ek-wm8731-audio.txt     |   26 ++++++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |   32 +++++++++-
 sound/soc/atmel/Kconfig                            |    3 +-
 sound/soc/atmel/sam9g20_wm8731.c                   |   63 +++++++++++++++++++-
 4 files changed, 119 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-at91sam9g20ek-wm8731-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel-at91sam9g20ek-wm8731-audio.txt b/Documentation/devicetree/bindings/sound/atmel-at91sam9g20ek-wm8731-audio.txt
new file mode 100644
index 0000000..9c5a994
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel-at91sam9g20ek-wm8731-audio.txt
@@ -0,0 +1,26 @@
+* Atmel at91sam9g20ek wm8731 audio complex
+
+Required properties:
+  - compatible: "atmel,at91sam9g20ek-wm8731-audio"
+  - atmel,model: The user-visible name of this sound complex.
+  - atmel,audio-routing: A list of the connections between audio components.
+  - atmel,ssc-controller: The phandle of the SSC controller
+  - atmel,audio-codec: The phandle of the WM8731 audio codec
+Optional properties:
+  - pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
+
+Example:
+sound {
+	compatible = "atmel,at91sam9g20ek-wm8731-audio";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pck0_as_mck>;
+
+	atmel,model = "wm8731 @ AT91SAMG20EK";
+
+	atmel,audio-routing =
+		"Ext Spk", "LHPOUT",
+		"Int MIC", "MICIN";
+
+	atmel,ssc-controller = <&ssc0>;
+	atmel,audio-codec = <&wm8731>;
+};
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 689323d..679f783 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -30,6 +30,16 @@
 
 	ahb {
 		apb {
+			pinctrl at fffff400 {
+				board {
+					pinctrl_pck0_as_mck: pck0_as_mck {
+						atmel,pins =
+							<2 1 0x2 0x0>;	/* PC1 periph B */
+					};
+
+				};
+			};
+
 			dbgu: serial at fffff200 {
 				status = "okay";
 			};
@@ -57,6 +67,11 @@
 				atmel,vbus-gpio = <&pioC 5 0>;
 				status = "okay";
 			};
+
+			ssc0: ssc at fffbc000 {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_ssc0_tx>;
+			};
 		};
 
 		nand0: nand at 40000000 {
@@ -120,7 +135,7 @@
 			reg = <0x50>;
 		};
 
-		wm8731 at 1b {
+		wm8731: wm8731 at 1b {
 			compatible = "wm8731";
 			reg = <0x1b>;
 		};
@@ -145,4 +160,19 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	sound {
+		compatible = "atmel,at91sam9g20ek-wm8731-audio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pck0_as_mck>;
+
+		atmel,model = "wm8731 @ AT91SAMG20EK";
+
+		atmel,audio-routing =
+			"Ext Spk", "LHPOUT",
+			"Int Mic", "MICIN";
+
+		atmel,ssc-controller = <&ssc0>;
+		atmel,audio-codec = <&wm8731>;
+	};
 };
diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 72b09cf..397ec75 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -16,8 +16,7 @@ config SND_ATMEL_SOC_SSC
 
 config SND_AT91_SOC_SAM9G20_WM8731
 	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
-	depends on ATMEL_SSC && ARCH_AT91SAM9G20 && SND_ATMEL_SOC && \
-                   AT91_PROGRAMMABLE_CLOCKS
+	depends on ATMEL_SSC && SND_ATMEL_SOC && AT91_PROGRAMMABLE_CLOCKS
 	select SND_ATMEL_SOC_SSC
 	select SND_SOC_WM8731
 	help
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 4deba18..0744610 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -38,6 +38,8 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 
+#include <linux/pinctrl/consumer.h>
+
 #include <linux/atmel-ssc.h>
 
 #include <sound/core.h>
@@ -197,12 +199,24 @@ static struct snd_soc_card snd_soc_at91sam9g20ek = {
 
 static int __devinit at91sam9g20ek_audio_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *codec_np, *cpu_np;
 	struct clk *pllb;
 	struct snd_soc_card *card = &snd_soc_at91sam9g20ek;
+	struct pinctrl *pinctrl;
 	int ret;
 
-	if (!(machine_is_at91sam9g20ek() || machine_is_at91sam9g20ek_2mmc()))
-		return -ENODEV;
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		dev_err(&pdev->dev, "Failed to request pinctrl for mck\n");
+		return PTR_ERR(pinctrl);
+	}
+
+	if (!np) {
+		if (!(machine_is_at91sam9g20ek() ||
+			machine_is_at91sam9g20ek_2mmc()))
+			return -ENODEV;
+	}
 
 	ret = atmel_ssc_set_audio(0);
 	if (ret) {
@@ -236,6 +250,42 @@ static int __devinit at91sam9g20ek_audio_probe(struct platform_device *pdev)
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
+			"atmel,audio-routing");
+		if (ret)
+			goto err;
+
+		/* Parse codec info */
+		at91sam9g20ek_dai.codec_name = NULL;
+		codec_np = of_parse_phandle(np, "atmel,audio-codec", 0);
+		if (!codec_np) {
+			dev_err(&pdev->dev, "codec info missing\n");
+			return -EINVAL;
+		}
+		at91sam9g20ek_dai.codec_of_node = codec_np;
+
+		/* Parse dai and platform info */
+		at91sam9g20ek_dai.cpu_dai_name = NULL;
+		at91sam9g20ek_dai.platform_name = NULL;
+		cpu_np = of_parse_phandle(np, "atmel,ssc-controller", 0);
+		if (!cpu_np) {
+			dev_err(&pdev->dev, "dai and pcm info missing\n");
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
@@ -263,10 +313,19 @@ static int __devexit at91sam9g20ek_audio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id at91sam9g20ek_wm8731_dt_ids[] = {
+	{ .compatible = "atmel,at91sam9g20ek-wm8731-audio", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, at91sam9g20ek_wm8731_dt_ids);
+#endif
+
 static struct platform_driver at91sam9g20ek_audio_driver = {
 	.driver = {
 		.name	= "at91sam9g20ek-audio",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(at91sam9g20ek_wm8731_dt_ids),
 	},
 	.probe	= at91sam9g20ek_audio_probe,
 	.remove	= __devexit_p(at91sam9g20ek_audio_remove),
-- 
1.7.9.5
