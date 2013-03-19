From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 19 Mar 2013 18:03:22 +0100
Subject: [PATCH] Sound: sgtl5000 Allow codec clock frequency to be set.
Message-ID: <20130319170322.27828.7691.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If both clocks and clock-frequency DT properties are given set
the clock frequency.

This is useful when a programmable clock is used as the codec clock.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 .../devicetree/bindings/sound/sgtl5000.txt         |   14 ++++++++++++++
 sound/soc/fsl/imx-sgtl5000.c                       |   20 ++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 9cc4444..31e82f0 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -5,9 +5,23 @@ Required properties:
 
 - reg : the I2C address of the device
 
+Optional properties:
+- clocks:		phandle to of codec clock
+- clock-frequency:	clock frequency to set or use (see below)
+
+If a clock is provided, clock-frequency is optional
+
+If no clock is provided clock-frequency is required (this represents the codec
+being clocked by an external signal not present in the clock tree)
+
+If both a clock and clock-frequency are provided the clock's rate will be set.
+
+
 Example:
 
 codec: sgtl5000 at 0a {
 	compatible = "fsl,sgtl5000";
 	reg = <0x0a>;
+	clock-frequency = <20000000>;
+	clocks = <&clks 162>; /* cko1 */
 };
diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 424347e..71ce1f6 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -128,18 +128,30 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
+	ret = of_property_read_u32(codec_np, "clock-frequency",
+					&data->clk_frequency);
 	data->codec_clk = clk_get(&codec_dev->dev, NULL);
+
 	if (IS_ERR(data->codec_clk)) {
-		/* assuming clock enabled by default */
+		/* assuming clock enabled by default (frequency required) */
 		data->codec_clk = NULL;
-		ret = of_property_read_u32(codec_np, "clock-frequency",
-					&data->clk_frequency);
-		if (ret) {
+		if (!data->clk_frequency) {
 			dev_err(&codec_dev->dev,
 				"clock-frequency missing or invalid\n");
 			goto fail;
 		}
 	} else {
+		if (data->clk_frequency) {
+			ret = clk_set_rate(
+					data->codec_clk, data->clk_frequency);
+			if (ret) {
+				dev_err(&codec_dev->dev,
+					"failed to set clock-frequency to %u\n",
+					data->clk_frequency);
+				goto fail;
+			}
+		}
+
 		data->clk_frequency = clk_get_rate(data->codec_clk);
 		clk_prepare_enable(data->codec_clk);
 	}
