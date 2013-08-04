From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 04 Aug 2013 20:32:04 +0100
Subject: [PATCH RFC 11/13] ASoC: spdif_transceiver: add output pin widget
In-Reply-To: <20130804192136.GK23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
Message-ID: <E1V6428-0004lz-Gw@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Codecs without any outputs now remain powered down, which means any
paths to these codecs also remain powered down.

Add an always-enabled output pin widget to the spdif transceiver codec.
This enables DAPM to correctly identify that the spdif transceiver is
in use when playback is enabled, which will then allow DAPM to power up
any links from the CPU DAI to the SPDIF transceiver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/codecs/spdif_transciever.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/spdif_transciever.c b/sound/soc/codecs/spdif_transciever.c
index 112a49d..8df8d79 100644
--- a/sound/soc/codecs/spdif_transciever.c
+++ b/sound/soc/codecs/spdif_transciever.c
@@ -27,7 +27,20 @@
 #define STUB_FORMATS	SNDRV_PCM_FMTBIT_S16_LE
 
 
-static struct snd_soc_codec_driver soc_codec_spdif_dit;
+static const struct snd_soc_dapm_widget dit_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("spdif-out"),
+};
+
+static const const struct snd_soc_dapm_route dit_routes[] = {
+	{ "spdif-out", NULL, "Playback" },
+};
+
+static struct snd_soc_codec_driver soc_codec_spdif_dit = {
+	.dapm_widgets = dit_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(dit_widgets),
+	.dapm_routes = dit_routes,
+	.num_dapm_routes = ARRAY_SIZE(dit_routes),
+};
 
 static struct snd_soc_dai_driver dit_stub_dai = {
 	.name		= "dit-hifi",
-- 
1.7.4.4
