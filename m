From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Nov 2011 18:21:22 -0700
Subject: [PATCH 14/17] ASoC: Implement "auto nc pins" feature
In-Reply-To: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
Message-ID: <1322011285-4002-15-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Codecs often have a large number of external pins, and not all of these pins
will be connected on all board designs. Some machine drivers therefore call
snd_soc_dapm_nc_pin() for all the unused pins, in order to tell the ASoC core
never to activate them.

However, the information needed to derive the set of unused pins may be
present in card->dapm_routes. Hence, the ASoC core could automatically
disable unconnected pins. This patch implements such a feature.

This feature is optional; it could cause problems on machines with incomplete
dapm routes. To request the feature, set a card's auto_nc_codec_pins field to
true.

This has been tested with soc/tegra/tegra_wm8903.c and soc/tegra/trimslice.c.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/sound/soc-dapm.h |    1 +
 include/sound/soc.h      |    1 +
 sound/soc/soc-core.c     |    4 ++
 sound/soc/soc-dapm.c     |   73 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 17a4c17..0c159a7 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -380,6 +380,7 @@ int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
 				  const char *pin);
 int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 				const char *pin);
+void snd_soc_dapm_auto_nc_codec_pins(struct snd_soc_codec *codec);
 
 /* Mostly internal - should not normally be used */
 void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index b21b304..3728533 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -815,6 +815,7 @@ struct snd_soc_card {
 	int num_dapm_widgets;
 	const struct snd_soc_dapm_route *dapm_routes;
 	int num_dapm_routes;
+	bool auto_nc_codec_pins;
 
 	struct work_struct deferred_resume_work;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a5d3685..47e919b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1482,6 +1482,10 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	snd_soc_dapm_new_widgets(&card->dapm);
 
+	if (card->auto_nc_codec_pins)
+		list_for_each_entry(codec, &codec_list, list)
+			snd_soc_dapm_auto_nc_codec_pins(codec);
+
 	ret = snd_card_register(card->snd_card);
 	if (ret < 0) {
 		printk(KERN_ERR "asoc: failed to register soundcard for %s\n", card->name);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f42e8b9..1ecd1b4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2947,6 +2947,79 @@ int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_ignore_suspend);
 
+static bool snd_soc_dapm_widget_in_card_paths(struct snd_soc_card *card,
+					      struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_path *p;
+
+	list_for_each_entry(p, &card->paths, list) {
+		if ((p->source == w) || (p->sink == w)) {
+			dev_dbg(card->dev,
+			    "... Path %s(id:%d dapm:%p) - %s(id:%d dapm:%p)\n",
+			    p->source->name, p->source->id, p->source->dapm,
+			    p->sink->name, p->sink->id, p->sink->dapm);
+
+			/* Connected to something other than the codec */
+			if (p->source->dapm != p->sink->dapm)
+				return true;
+			/*
+			 * Loopback connection from codec external pin to
+			 * codec external pin
+			 */
+			if (p->sink->id == snd_soc_dapm_input) {
+				switch (p->source->id) {
+				case snd_soc_dapm_output:
+				case snd_soc_dapm_micbias:
+					return true;
+				default:
+					break;
+				}
+			}
+		}
+	}
+
+	return false;
+}
+
+/**
+ * snd_soc_dapm_auto_nc_codec_pins - call snd_soc_dapm_nc_pin for unused pins
+ * @codec: The codec whose pins should be processed
+ *
+ * Automatically call snd_soc_dapm_nc_pin() for any external pins in the codec
+ * which are unused. Pins are used if they are connected externally to the
+ * codec, whether that be to some other device, or a loop-back connection to
+ * the codec itself.
+ */
+void snd_soc_dapm_auto_nc_codec_pins(struct snd_soc_codec *codec)
+{
+	struct snd_soc_card *card = codec->card;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_widget *w;
+
+	dev_dbg(card->dev, "Auto NC: DAPMs: card:%p codec:%p\n",
+		&card->dapm, &codec->dapm);
+
+	list_for_each_entry(w, &card->widgets, list) {
+		if (w->dapm != dapm)
+			continue;
+		switch (w->id) {
+		case snd_soc_dapm_input:
+		case snd_soc_dapm_output:
+		case snd_soc_dapm_micbias:
+			dev_dbg(card->dev, "Auto NC: Checking widget %s\n",
+				w->name);
+			if (!snd_soc_dapm_widget_in_card_paths(card, w)) {
+				dev_dbg(card->dev,
+					"... Not in map; disabling\n");
+				snd_soc_dapm_nc_pin(dapm, w->name);
+			}
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 /**
  * snd_soc_dapm_free - free dapm resources
  * @dapm: DAPM context
-- 
1.7.0.4
