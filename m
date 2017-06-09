From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Fri,  9 Jun 2017 08:22:10 +0200
Subject: [PATCH v11 06/12] sun4i-codec: Add support for extra controls to
 struct sun4i_codec_quirks and use them.
In-Reply-To: <20170609062216.26807-1-dannym@scratchpost.org>
References: <20170609062216.26807-1-dannym@scratchpost.org>
Message-ID: <20170609062216.26807-7-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index f56a59ad..b1da14d1 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -897,9 +897,22 @@ struct sun4i_codec_quirks {
 	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
 	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
 	bool has_reset;
+	const struct snd_kcontrol_new *controls;
+	unsigned int num_controls;
 };
 
+static int sun4i_codec_codec_probe(struct snd_soc_codec *scodec)
+{
+	const struct sun4i_codec_quirks *quirks;
+
+	quirks = of_device_get_match_data(scodec->dev);
+	return snd_soc_add_codec_controls(scodec,
+					  quirks->controls,
+					  quirks->num_controls);
+}
+
 static struct snd_soc_codec_driver sun4i_codec_codec = {
+	.probe = sun4i_codec_codec_probe,
 	.component_driver = {
 		.controls		= sun4i_codec_controls,
 		.num_controls		= ARRAY_SIZE(sun4i_codec_controls),
