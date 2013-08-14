From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 14 Aug 2013 12:27:33 +0200
Subject: [PATCH v5 1/1] ASoc: kirkwood: add DT support to the mvebu audio
 subsystem
Message-ID: <20130814122733.5c0fd2cb@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT support to the audio subsystem of the mvebu family
(Kirkwood, Dove, Armada 370).

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
This patch does not add any new function as S/PDIF or DPCM support.
---
 .../devicetree/bindings/sound/mvebu-audio.txt      | 29 ++++++++++++++++++++++
 sound/soc/kirkwood/kirkwood-i2s.c                  | 26 +++++++++++++++++-----
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mvebu-audio.txt b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
new file mode 100644
index 0000000..7e5fd37
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
@@ -0,0 +1,29 @@
+* mvebu (Kirkwood, Dove, Armada 370) audio controller
+
+Required properties:
+
+- compatible: "marvell,mvebu-audio"
+
+- reg: physical base address of the controller and length of memory mapped
+  region.
+
+- interrupts: list of two irq numbers.
+  The first irq is used for data flow and the second one is used for errors.
+
+- clocks: one or two phandles.
+  The first one is mandatory and defines the internal clock.
+  The second one is optional and defines an external clock.
+
+- clock-names: names associated to the clocks:
+	"internal" for the internal clock
+	"extclk" for the external clock
+
+Example:
+
+i2s1: audio-controller at b4000 {
+	compatible = "marvell,mvebu-audio";
+	reg = <0xb4000 0x2210>;
+	interrupts = <21>, <22>;
+	clocks = <&gate_clk 13>;
+	clock-names = "internal";
+};
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c.next b/sound/soc/kirkwood/kirkwood-i2s.c
index e5f3f7a..a4170b4 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c.next
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -22,6 +22,8 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <linux/platform_data/asoc-kirkwood.h>
+#include <linux/of.h>
+
 #include "kirkwood.h"
 
 #define DRV_NAME	"mvebu-audio"
@@ -453,6 +455,7 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	struct snd_soc_dai_driver *soc_dai = &kirkwood_i2s_dai;
 	struct kirkwood_dma_data *priv;
 	struct resource *mem;
+	struct device_node *np = pdev->dev.of_node;
 	int err;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -473,14 +476,16 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	if (!data) {
-		dev_err(&pdev->dev, "no platform data ?!\n");
+	if (np) {
+		priv->burst = 128;		/* might be 32 or 128 */
+	} else if (data) {
+		priv->burst = data->burst;
+	} else {
+		dev_err(&pdev->dev, "no DT nor platform data ?!\n");
 		return -EINVAL;
 	}
 
-	priv->burst = data->burst;
-
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	priv->clk = devm_clk_get(&pdev->dev, np ? "internal" : NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev, "no clock\n");
 		return PTR_ERR(priv->clk);
@@ -507,7 +512,7 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	priv->ctl_rec = KIRKWOOD_RECCTL_SIZE_24;
 
 	/* Select the burst size */
-	if (data->burst == 32) {
+	if (priv->burst == 32) {
 		priv->ctl_play |= KIRKWOOD_PLAYCTL_BURST_32;
 		priv->ctl_rec |= KIRKWOOD_RECCTL_BURST_32;
 	} else {
@@ -552,12 +557,21 @@ static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id mvebu_audio_of_match[] = {
+	{ .compatible = "marvell,mvebu-audio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mvebu_audio_of_match);
+#endif
+
 static struct platform_driver kirkwood_i2s_driver = {
 	.probe  = kirkwood_i2s_dev_probe,
 	.remove = kirkwood_i2s_dev_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(mvebu_audio_of_match),
 	},
 };
 

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
