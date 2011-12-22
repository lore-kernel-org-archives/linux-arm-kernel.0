From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 22 Dec 2011 18:38:20 +0200
Subject: [PATCH v2 7/9] ASoC: omap-abe-twl6040: Configure card according to
 platform data
In-Reply-To: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
References: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1324571902-16918-8-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable the not connected pins on the board based on the
received platform data.
DO not register the jack function on boards, which does not have
means to detect it (jack is always connected).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-abe-twl6040.c |   41 ++++++++++++++++++++++++++----------
 1 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 9e6e4c2..7a8fbe2 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -157,10 +157,29 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"AFMR", NULL, "Line In"},
 };
 
+#define twl6040_disconnect_pin(dapm, connected, pin)	\
+	if (!connected)					\
+		snd_soc_dapm_disable_pin(dapm, pin);
+
 static int omapabe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	int ret, hs_trim;
+	struct snd_soc_card *card = codec->card;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct omap_abe_twl6040_data *pdata = dev_get_platdata(card->dev);
+	int hs_trim;
+	int ret = 0;
+
+	/* Disable not connected paths if not used */
+	twl6040_disconnect_pin(dapm, pdata->has_hs, "Headset Stereophone");
+	twl6040_disconnect_pin(dapm, pdata->has_hf, "Ext Spk");
+	twl6040_disconnect_pin(dapm, pdata->has_ep, "Earphone Spk");
+	twl6040_disconnect_pin(dapm, pdata->has_aux, "Line Out");
+	twl6040_disconnect_pin(dapm, pdata->has_vibra, "Vinrator");
+	twl6040_disconnect_pin(dapm, pdata->has_hsmic, "Headset Mic");
+	twl6040_disconnect_pin(dapm, pdata->has_mainmic, "Main Handset Mic");
+	twl6040_disconnect_pin(dapm, pdata->has_submic, "Sub Handset Mic");
+	twl6040_disconnect_pin(dapm, pdata->has_afm, "Line In");
 
 	/*
 	 * Configure McPDM offset cancellation based on the HSOTRIM value from
@@ -170,19 +189,17 @@ static int omapabe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 	omap_mcpdm_configure_dn_offsets(rtd, TWL6040_HSF_TRIM_LEFT(hs_trim),
 					TWL6040_HSF_TRIM_RIGHT(hs_trim));
 
-	/* Headset jack detection */
-	ret = snd_soc_jack_new(codec, "Headset Jack",
-				SND_JACK_HEADSET, &hs_jack);
-	if (ret)
-		return ret;
-
-	ret = snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins),
-				hs_jack_pins);
+	/* Headset jack detection only if it is supported */
+	if (pdata->jack_detection) {
+		ret = snd_soc_jack_new(codec, "Headset Jack",
+					SND_JACK_HEADSET, &hs_jack);
+		if (ret)
+			return ret;
 
-	if (machine_is_omap_4430sdp())
+		ret = snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins),
+					hs_jack_pins);
 		twl6040_hs_jack_detect(codec, &hs_jack, SND_JACK_HEADSET);
-	else
-		snd_soc_jack_report(&hs_jack, SND_JACK_HEADSET, SND_JACK_HEADSET);
+	}
 
 	return ret;
 }
-- 
1.7.8.1
