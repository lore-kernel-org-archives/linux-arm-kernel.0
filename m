From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 19 Sep 2013 10:54:37 +0200
Subject: [PATCH] ASoC: generic: Add generic DT based simple codec
Message-ID: <20130919105437.75e0f0a3@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a simple sound codec which is described by the DT.
This codec may be used when no specific codec action is needed.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 .../devicetree/bindings/sound/simple-codec.txt | 103 +++++++++++++
 sound/soc/generic/Kconfig                      |   6 +
 sound/soc/generic/Makefile                     |   2 +
 sound/soc/generic/simple-codec.c               | 197 +++++++++++++++++++++++++
 4 files changed, 3088 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-codec.txt b/Documentation/devicetree/bindings/sound/simple-codec.txt
new file mode 100644
index 0000000..75be747
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/simple-codec.txt
@@ -0,0 +1,103 @@
+Device-Tree bindings for the simple codec
+
+Required properties:
+- compatible: should be "linux,simple-codec".
+- dai-name: name of the codec
+
+Optional properties:
+- capture: information about capture
+- playback: information about playback
+At least one of the 'capture' or 'playback' nodes must be present.
+
+Child 'capture' and 'playback' required properties:
+- stream-name: name of the stream
+- formats: list of the supported formats (see below)
+- rates: list of the supported rates (see below)
+- #channels: minimum and maximum numbers of channels
+
+Formats:
+	"s8"
+	"u8"
+	"s16_le"
+	"s16_be"
+	"u16_le"
+	"u16_be"
+	"s24_le"
+	"s24_be"
+	"u24_le"
+	"u24_be"
+	"s32_le"
+	"s32_be"
+	"u32_le"
+	"u32_be"
+	"float_le"
+	"float_be"
+	"float64_le"
+	"float64_be"
+	"iec958_subframe_le"
+	"iec958_subframe_be"
+	"mu_law"
+	"a_law"
+	"ima_adpcm"
+	"mpeg"
+	"gsm"
+	"special"
+	"s24_3l"
+	"s24_3be"
+	"u24_3le"
+	"u24_3be"
+	"s20_3le"
+	"s20_3be"
+	"u20_3le"
+	"u20_3be"
+	"s18_3le"
+	"s18_3b"
+	"u18_3le"
+	"u18_3be"
+	"g723_24"
+	"g723_24_1b"
+	"g723_40"
+	"g723_40_1b"
+	"dsd_u8"
+	"dsd_u16_le"
+
+Rates:
+	5512
+	8000
+	11025
+	16000
+	22050
+	32000
+	44100
+	48000
+	64000
+	88200
+	96000
+	176400
+	192000
+
+Examples:
+
+	spdifo: spdif-transmitter {
+		compatible = "linux,simple-codec";
+		dai-name = "dit-hifi";
+		playback {
+			stream-name = "S/PDIF Playback";
+			formats = "s16_le";
+			rates = <8000 11025 16000 22050 32000 44100
+				48000 64000 88200 96000>;
+			#channels = <1 384>;
+		};
+	};
+
+	hdmio: hdmi-transmitter {
+		compatible = "linux,simple-codec";
+		dai-name = "hdmi-hifi";
+		playback {
+			stream-name = "HDMI Playback";
+			formats = "s16_le", "s24_le";
+			rates = <32000 44100 48000 88200 96000
+				176400 192000>;
+			#channels = <2 8>;
+		};
+	};
diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
index 610f612..d9221539 100644
--- a/sound/soc/generic/Kconfig
+++ b/sound/soc/generic/Kconfig
@@ -2,3 +2,9 @@ config SND_SIMPLE_CARD
 	tristate "ASoC Simple sound card support"
 	help
 	  This option enables generic simple sound card support
+
+config SND_SIMPLE_CODEC
+	tristate "ASoC Simple sound codec support"
+	depends on OF
+	help
+	  This option enables generic simple sound codec support
diff --git a/sound/soc/generic/Makefile b/sound/soc/generic/Makefile
index 9c3b246..f94620e 100644
--- a/sound/soc/generic/Makefile
+++ b/sound/soc/generic/Makefile
@@ -1,3 +1,5 @@
 snd-soc-simple-card-objs	:= simple-card.o
+snd-soc-simple-codec-objs	:= simple-codec.o
 
 obj-$(CONFIG_SND_SIMPLE_CARD)	+= snd-soc-simple-card.o
+obj-$(CONFIG_SND_SIMPLE_CODEC)	+= snd-soc-simple-codec.o
diff --git a/sound/soc/generic/simple-codec.c b/sound/soc/generic/simple-codec.c
new file mode 100644
index 0000000..217cd0e
--- /dev/null
+++ b/sound/soc/generic/simple-codec.c
@@ -0,0 +1,197 @@
+/*
+ * ALSA SoC simple codec driver
+ *
+ * This driver is used by controllers which do not need any codec
+ * (s/pdif, hdmi..).
+ * Its parameters are built from a DT description.
+ *
+ * Copyright: (C) 2013 Jean-Fran?ois Moine <moinejf@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <sound/soc.h>
+#include <linux/of.h>
+
+#define DRV_NAME "simple-codec"
+
+static struct snd_soc_codec_driver soc_codec_simple_codec;
+
+static char *format_tb[] = {
+	"s8", "u8", "s16_le", "s16_be",
+	"u16_le", "u16_be", "s24_le", "s24_be",
+	"u24_le", "u24_be", "s32_le", "s32_be",
+	"u32_le", "u32_be", "float_le", "float_be",
+
+	"float64_le", "float64_be", "iec958_subframe_le", "iec958_subframe_be",
+	"mu_law", "a_law", "ima_adpcm", "mpeg",
+	"gsm", "", "", "",
+	"", "", "", "special",
+
+	"s24_3l", "s24_3be", "u24_3le", "u24_3be",
+	"s20_3le", "s20_3be", "u20_3le", "u20_3be",
+	"s18_3le", "s18_3b", "u18_3le", "u18_3be",
+	"g723_24", "g723_24_1b", "g723_40", "g723_40_1b",
+
+	"dsd_u8", "dsd_u16_le",
+};
+
+#if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_192000 != 1 << 12
+#error "Change this table"
+#endif
+static u32 rate_tb[] = { 5512, 8000, 11025, 16000, 22050, 32000, 44100,
+			48000, 64000, 88200, 96000, 176400, 192000 };
+
+static int get_format(u64 *p_formats, char *p)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(format_tb); i++) {
+		if (strcmp(format_tb[i], p) == 0) {
+			*p_formats |= 1 << i;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static int get_rate(u32 *p_rates, u32 val)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rate_tb); i++) {
+		if (rate_tb[i] == val) {
+			*p_rates |= 1 << i;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static int stream_populate(struct device *dev,
+			struct snd_soc_pcm_stream *stream,
+			struct device_node *np)
+{
+	u64 formats;
+	u32 rates, val;
+	char *p;
+	int i, ret;
+
+	ret = of_property_read_string(np, "stream-name", &stream->stream_name);
+	if (ret) {
+		dev_err(dev, "Failed to parse stream-name string\n");
+		return ret;
+	}
+
+	i = 0;
+	formats = 0;
+	for (;;) {
+		ret = of_property_read_string_index(np, "formats", i,
+					(const char **) &p);
+		if (ret)
+			break;
+		ret = get_format(&formats, p);
+		if (ret) {
+			dev_err(dev, "Bad codec format\n");
+			return ret;
+		}
+		i++;
+	}
+	stream->formats = formats;
+
+	i = 0;
+	rates = 0;
+	for (;;) {
+		ret = of_property_read_u32_index(np, "rates", i, &val);
+		if (ret)
+			break;
+		ret = get_rate(&rates, val);
+		if (ret) {
+			dev_err(dev, "Bad rate\n");
+			return ret;
+		}
+		i++;
+	}
+	stream->rates = rates;
+
+	ret = of_property_read_u32_index(np, "#channels", 0, &val);
+	if (ret) {
+		dev_err(dev, "Bad min channel\n");
+		return ret;
+	}
+	stream->channels_min = val;
+	ret = of_property_read_u32_index(np, "#channels", 1, &val);
+	if (ret) {
+		dev_err(dev, "Bad max channel\n");
+		return ret;
+	}
+	stream->channels_max = val;
+
+	return 0;
+}
+
+static int simple_codec_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *np2;
+	struct snd_soc_dai_driver *dai;
+	int ret;
+
+	dai = devm_kzalloc(dev, sizeof *dai, GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	ret = of_property_read_string(np, "dai-name", &dai->name);
+	if (ret) {
+		dev_err(dev, "Failed to parse dai-name\n");
+		return ret;
+	}
+
+	np2 = of_find_node_by_name(np, "capture");
+	if (np2) {
+		ret = stream_populate(dev, &dai->capture, np2);
+		if (ret)
+			return ret;
+	}
+	np2 = of_find_node_by_name(np, "playback");
+	if (np2) {
+		ret = stream_populate(dev, &dai->playback, np2);
+		if (ret)
+			return ret;
+	}
+
+	return snd_soc_register_codec(dev, &soc_codec_simple_codec,
+					dai, 1);
+}
+
+static int simple_codec_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id simple_codec_of_match[] = {
+	{ .compatible = "linux,simple-codec", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, simple_codec_of_match);
+
+static struct platform_driver simple_codec_driver = {
+	.probe		= simple_codec_probe,
+	.remove		= simple_codec_remove,
+	.driver		= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table = simple_codec_of_match,
+	},
+};
+
+module_platform_driver(simple_codec_driver);
+
+MODULE_AUTHOR("Jean-Francois Moine <moinejf@free.fr>");
+MODULE_DESCRIPTION("simple codec driver");
+MODULE_LICENSE("GPL");


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
