From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Feb 2014 18:20:57 +0100
Subject: [PATCH v2 2/7] sound: ASoC: add S/PDIF support to Armada 370 DB ASoC
 driver
In-Reply-To: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392225662-20431-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 DB board not only has analog audio input/output, but
also S/PDIF input/output. This commit adds support for S/PDIF in the
ASoC machine driver of the Armada 370 DB platform, and adjusts the
Device Tree bindings documentation accordingly.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/sound/armada-370db-audio.txt          |  9 ++++---
 sound/soc/kirkwood/Kconfig                         |  1 +
 sound/soc/kirkwood/armada-370-db.c                 | 28 ++++++++++++++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/armada-370db-audio.txt b/Documentation/devicetree/bindings/sound/armada-370db-audio.txt
index 3893b4d..bf984d2 100644
--- a/Documentation/devicetree/bindings/sound/armada-370db-audio.txt
+++ b/Documentation/devicetree/bindings/sound/armada-370db-audio.txt
@@ -11,14 +11,17 @@ Mandatory properties:
  * marvell,audio-controller: a phandle that points to the audio
    controller of the Armada 370 SoC.
 
- * marvell,audio-codec: a phandle that points to the analog audio
-   codec connected to the Armada 370 SoC.
+ * marvell,audio-codec: a set of three phandles that points to:
+
+    1/ the analog audio codec connected to the Armada 370 SoC
+    2/ the S/PDIF transceiver
+    3/ the S/PDIF receiver
 
 Example:
 
 	sound {
 	      compatible = "marvell,a370db-audio";
 	      marvell,audio-controller = <&audio_controller>;
-	      marvell,audio-codec = <&audio_codec>;
+	      marvell,audio-codec = <&audio_codec &spdif_out &spdif_in>;
 	      status = "okay";
 	};
diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index 2dc3ecf..49f8437 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -10,6 +10,7 @@ config SND_KIRKWOOD_SOC_ARMADA370_DB
 	tristate "SoC Audio support for Armada 370 DB"
 	depends on SND_KIRKWOOD_SOC && (ARCH_MVEBU || COMPILE_TEST) && I2C
 	select SND_SOC_CS42L51
+	select SND_SOC_SPDIF
 	help
 	  Say Y if you want to add support for SoC audio on
 	  the Armada 370 Development Board.
diff --git a/sound/soc/kirkwood/armada-370-db.c b/sound/soc/kirkwood/armada-370-db.c
index 977639b..c443338 100644
--- a/sound/soc/kirkwood/armada-370-db.c
+++ b/sound/soc/kirkwood/armada-370-db.c
@@ -67,6 +67,20 @@ static struct snd_soc_dai_link a370db_dai[] = {
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &a370db_ops,
 },
+{
+	.name = "S/PDIF out",
+	.stream_name = "spdif-out",
+	.cpu_dai_name = "spdif",
+	.codec_dai_name = "dit-hifi",
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
+},
+{
+	.name = "S/PDIF in",
+	.stream_name = "spdif-in",
+	.cpu_dai_name = "spdif",
+	.codec_dai_name = "dir-hifi",
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
+},
 };
 
 static struct snd_soc_card a370db = {
@@ -95,6 +109,20 @@ static int a370db_probe(struct platform_device *pdev)
 		of_parse_phandle(pdev->dev.of_node,
 				 "marvell,audio-codec", 0);
 
+	a370db_dai[1].cpu_of_node = a370db_dai[0].cpu_of_node;
+	a370db_dai[1].platform_of_node = a370db_dai[0].cpu_of_node;
+
+	a370db_dai[1].codec_of_node =
+		of_parse_phandle(pdev->dev.of_node,
+				 "marvell,audio-codec", 1);
+
+	a370db_dai[2].cpu_of_node = a370db_dai[0].cpu_of_node;
+	a370db_dai[2].platform_of_node = a370db_dai[0].cpu_of_node;
+
+	a370db_dai[2].codec_of_node =
+		of_parse_phandle(pdev->dev.of_node,
+				 "marvell,audio-codec", 2);
+
 	return devm_snd_soc_register_card(card->dev, card);
 }
 
-- 
1.8.3.2
