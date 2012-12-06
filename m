From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 06 Dec 2012 09:20:37 +0530
Subject: [PATCH V3 2/2] ASoC: SMDK: WM8994: Add device tree support for machine
 file
In-Reply-To: <1354765837-3469-1-git-send-email-padma.v@samsung.com>
References: <1354765837-3469-1-git-send-email-padma.v@samsung.com>
Message-ID: <1354765837-3469-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the basic device tree based lookup.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 .../bindings/sound/samsung,smdk-wm8994.txt         |   14 ++++++++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   12 +++++++++
 sound/soc/samsung/smdk_wm8994.c                    |   26 ++++++++++++++++++++
 3 files changed, 52 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt

diff --git a/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt b/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt
new file mode 100644
index 0000000..13cb189
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt
@@ -0,0 +1,14 @@
+Samsung SMDK audio complex
+
+Required properties:
+- compatible : "samsung,smdk-wm8994"
+- samsung,i2s-controller: The phandle of the Samsung I2S0 controller
+- samsung,audio-codec: The phandle of the WM8994 audio codec
+Example:
+
+sound {
+		compatible = "samsung,smdk-wm8994";
+
+		samsung,i2s-controller = <&i2s_0>;
+		samsung,audio-codec = <&wm8994>;
+};
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 8d6e331..cf988fc 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -53,6 +53,11 @@
 			compatible = "samsung,s524ad0xd1";
 			reg = <0x51>;
 		};
+
+		wm8994: wm8994 at 1a {
+			 compatible = "wlf,wm8994";
+			 reg = <0x1a>;
+		};
 	};
 
 	i2c at 12C80000 {
@@ -180,4 +185,11 @@
 	i2s_2: i2s at 12D70000 {
 		status = "disabled";
 	};
+
+	sound {
+		compatible = "samsung,smdk-wm8994";
+
+		samsung,i2s-controller = <&i2s_0>;
+		samsung,audio-codec = <&wm8994>;
+	};
 };
diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index dd0aa8c..2f3e2b8 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -10,6 +10,7 @@
 #include "../codecs/wm8994.h"
 #include <sound/pcm_params.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
  /*
   * Default CFG switch settings to use this driver:
@@ -153,9 +154,25 @@ static struct snd_soc_card smdk = {
 static int __devinit smdk_audio_probe(struct platform_device *pdev)
 {
 	int ret;
+	struct device_node *np = pdev->dev.of_node;
 	struct snd_soc_card *card = &smdk;
 
 	card->dev = &pdev->dev;
+
+	if (np) {
+		smdk_dai[0].cpu_dai_name = NULL;
+		smdk_dai[0].cpu_of_node = of_parse_phandle(np,
+				"samsung,i2s-controller", 0);
+		if (!smdk_dai[0].cpu_of_node) {
+			dev_err(&pdev->dev,
+			   "Property 'samsung,i2s-controller' missing or invalid\n");
+			ret = -EINVAL;
+		}
+
+		smdk_dai[0].platform_name = NULL;
+		smdk_dai[0].platform_of_node = smdk_dai[0].cpu_of_node;
+	}
+
 	ret = snd_soc_register_card(card);
 
 	if (ret)
@@ -173,10 +190,19 @@ static int __devexit smdk_audio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id samsung_wm8994_of_match[] = {
+	{ .compatible = "samsung,smdk-wm8994", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, samsung_wm8994_of_match);
+#endif /* CONFIG_OF */
+
 static struct platform_driver smdk_audio_driver = {
 	.driver		= {
 		.name	= "smdk-audio",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(samsung_wm8994_of_match),
 	},
 	.probe		= smdk_audio_probe,
 	.remove		= __devexit_p(smdk_audio_remove),
-- 
1.7.4.4
