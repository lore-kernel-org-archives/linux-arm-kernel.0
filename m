From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Apr 2012 13:34:19 -0600
Subject: [PATCH] ASoC: tegra: add device tree support for TrimSlice
Message-ID: <1335555259-9263-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This binding doesn't include the nvidia,model or nvidia,audio-routing
properties the other Tegra audio DT bindings have, because this binding
is targetted at a single machine, rather than for any machine using the
tlv320aic23 codec.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Ideally, the binding would be more generic, but that would require
representing the board's jacks in the binding, and there's no way to do
that yet. That problem actually affects the other two Tegra audio
bindings too:-(

The next step would be to define a binding for the board jacks, and
unify the 3 Tegra bindings/machin-drivers into e.g. tegra_of_simple.
However, I can't promise when that will happen right now.
---
 .../bindings/sound/tegra-audio-trimslice.txt       |   14 ++++++++
 sound/soc/tegra/trimslice.c                        |   34 ++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tegra-audio-trimslice.txt

diff --git a/Documentation/devicetree/bindings/sound/tegra-audio-trimslice.txt b/Documentation/devicetree/bindings/sound/tegra-audio-trimslice.txt
new file mode 100644
index 0000000..04b14cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tegra-audio-trimslice.txt
@@ -0,0 +1,14 @@
+NVIDIA Tegra audio complex for TrimSlice
+
+Required properties:
+- compatible : "nvidia,tegra-audio-trimslice"
+- nvidia,i2s-controller : The phandle of the Tegra I2S1 controller
+- nvidia,audio-codec : The phandle of the WM8903 audio codec
+
+Example:
+
+sound {
+	compatible = "nvidia,tegra-audio-trimslice";
+	nvidia,i2s-controller = <&tegra_i2s1>;
+	nvidia,audio-codec = <&codec>;
+};
diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
index 0fd115e..4a8d5b6 100644
--- a/sound/soc/tegra/trimslice.c
+++ b/sound/soc/tegra/trimslice.c
@@ -27,6 +27,7 @@
 #include <asm/mach-types.h>
 
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -149,6 +150,32 @@ static __devinit int tegra_snd_trimslice_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	if (pdev->dev.of_node) {
+		trimslice_tlv320aic23_dai.codec_name = NULL;
+		trimslice_tlv320aic23_dai.codec_of_node = of_parse_phandle(
+				pdev->dev.of_node, "nvidia,audio-codec", 0);
+		if (!trimslice_tlv320aic23_dai.codec_of_node) {
+			dev_err(&pdev->dev,
+				"Property 'nvidia,audio-codec' missing or invalid\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
+		trimslice_tlv320aic23_dai.cpu_dai_name = NULL;
+		trimslice_tlv320aic23_dai.cpu_dai_of_node = of_parse_phandle(
+				pdev->dev.of_node, "nvidia,i2s-controller", 0);
+		if (!trimslice_tlv320aic23_dai.cpu_dai_of_node) {
+			dev_err(&pdev->dev,
+				"Property 'nvidia,i2s-controller' missing or invalid\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
+		trimslice_tlv320aic23_dai.platform_name = NULL;
+		trimslice_tlv320aic23_dai.platform_of_node =
+				trimslice_tlv320aic23_dai.cpu_dai_of_node;
+	}
+
 	ret = tegra_asoc_utils_init(&trimslice->util_data, &pdev->dev);
 	if (ret)
 		goto err;
@@ -184,10 +211,17 @@ static int __devexit tegra_snd_trimslice_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id trimslice_of_match[] __devinitconst = {
+	{ .compatible = "nvidia,tegra-audio-trimslice", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, trimslice_of_match);
+
 static struct platform_driver tegra_snd_trimslice_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
+		.of_match_table = trimslice_of_match,
 	},
 	.probe = tegra_snd_trimslice_probe,
 	.remove = __devexit_p(tegra_snd_trimslice_remove),
-- 
1.7.0.4
