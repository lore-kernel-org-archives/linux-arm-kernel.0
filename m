From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Mon, 11 Jun 2018 17:32:12 +0900
Subject: [PATCH v3 1/3] ASoC: simple-card-utils: move hp and mic detect gpios
 from simple-card
Message-ID: <20180611083214.16858-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves headphone and microphone jack detection gpios from
simple-card driver. It is preparing for using this feature from other
drivers.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes from v2:
  - Nothing

Changes from v1:
  - Move changes of audio-graph-card to other patch
---
 include/sound/simple_card_utils.h     | 15 +++++++
 sound/soc/generic/simple-card-utils.c | 59 ++++++++++++++++++++++++
 sound/soc/generic/simple-card.c       | 64 ---------------------------
 3 files changed, 74 insertions(+), 64 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 7e25afce6566..f82acef3b992 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -12,6 +12,11 @@
 
 #include <sound/soc.h>
 
+#define asoc_simple_card_init_hp(card, sjack, prefix) \
+	asoc_simple_card_init_jack(card, sjack, 1, prefix)
+#define asoc_simple_card_init_mic(card, sjack, prefix) \
+	asoc_simple_card_init_jack(card, sjack, 0, prefix)
+
 struct asoc_simple_dai {
 	const char *name;
 	unsigned int sysclk;
@@ -28,6 +33,12 @@ struct asoc_simple_card_data {
 	u32 convert_channels;
 };
 
+struct asoc_simple_jack {
+	struct snd_soc_jack jack;
+	struct snd_soc_jack_pin pin;
+	struct snd_soc_jack_gpio gpio;
+};
+
 int asoc_simple_card_parse_daifmt(struct device *dev,
 				  struct device_node *node,
 				  struct device_node *codec,
@@ -107,4 +118,8 @@ int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
 int asoc_simple_card_of_parse_widgets(struct snd_soc_card *card,
 				      char *prefix);
 
+int asoc_simple_card_init_jack(struct snd_soc_card *card,
+			       struct asoc_simple_jack *sjack,
+			       int is_hp, char *prefix);
+
 #endif /* __SIMPLE_CARD_UTILS_H */
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 3751a07de6aa..4398c9580929 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -8,9 +8,13 @@
  * published by the Free Software Foundation.
  */
 #include <linux/clk.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/of_graph.h>
+#include <sound/jack.h>
 #include <sound/simple_card_utils.h>
 
 void asoc_simple_card_convert_fixup(struct asoc_simple_card_data *data,
@@ -419,6 +423,61 @@ int asoc_simple_card_of_parse_widgets(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_of_parse_widgets);
 
+int asoc_simple_card_init_jack(struct snd_soc_card *card,
+			       struct asoc_simple_jack *sjack,
+			       int is_hp, char *prefix)
+{
+	struct device *dev = card->dev;
+	enum of_gpio_flags flags;
+	char prop[128];
+	char *pin_name;
+	char *gpio_name;
+	int mask;
+	int det;
+
+	if (!prefix)
+		prefix = "";
+
+	sjack->gpio.gpio = -ENOENT;
+
+	if (is_hp) {
+		snprintf(prop, sizeof(prop), "%shp-det-gpio", prefix);
+		pin_name	= "Headphones";
+		gpio_name	= "Headphone detection";
+		mask		= SND_JACK_HEADPHONE;
+	} else {
+		snprintf(prop, sizeof(prop), "%smic-det-gpio", prefix);
+		pin_name	= "Mic Jack";
+		gpio_name	= "Mic detection";
+		mask		= SND_JACK_MICROPHONE;
+	}
+
+	det = of_get_named_gpio_flags(dev->of_node, prop, 0, &flags);
+	if (det == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	if (gpio_is_valid(det)) {
+		sjack->pin.pin		= pin_name;
+		sjack->pin.mask		= mask;
+
+		sjack->gpio.name	= gpio_name;
+		sjack->gpio.report	= mask;
+		sjack->gpio.gpio	= det;
+		sjack->gpio.invert	= !!(flags & OF_GPIO_ACTIVE_LOW);
+		sjack->gpio.debounce_time = 150;
+
+		snd_soc_card_jack_new(card, pin_name, mask,
+				      &sjack->jack,
+				      &sjack->pin, 1);
+
+		snd_soc_jack_add_gpios(&sjack->jack, 1,
+				       &sjack->gpio);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_card_init_jack);
+
 /* Module information */
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
 MODULE_DESCRIPTION("ALSA SoC Simple Card Utils");
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 4a516c428b3d..1bbd9e46bf2a 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -10,23 +10,14 @@
  */
 #include <linux/clk.h>
 #include <linux/device.h>
-#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
-#include <sound/jack.h>
 #include <sound/simple_card.h>
 #include <sound/soc-dai.h>
 #include <sound/soc.h>
 
-struct asoc_simple_jack {
-	struct snd_soc_jack jack;
-	struct snd_soc_jack_pin pin;
-	struct snd_soc_jack_gpio gpio;
-};
-
 struct simple_card_data {
 	struct snd_soc_card snd_card;
 	struct simple_dai_props {
@@ -49,61 +40,6 @@ struct simple_card_data {
 #define CELL	"#sound-dai-cells"
 #define PREFIX	"simple-audio-card,"
 
-#define asoc_simple_card_init_hp(card, sjack, prefix)\
-	asoc_simple_card_init_jack(card, sjack, 1, prefix)
-#define asoc_simple_card_init_mic(card, sjack, prefix)\
-	asoc_simple_card_init_jack(card, sjack, 0, prefix)
-static int asoc_simple_card_init_jack(struct snd_soc_card *card,
-				      struct asoc_simple_jack *sjack,
-				      int is_hp, char *prefix)
-{
-	struct device *dev = card->dev;
-	enum of_gpio_flags flags;
-	char prop[128];
-	char *pin_name;
-	char *gpio_name;
-	int mask;
-	int det;
-
-	sjack->gpio.gpio = -ENOENT;
-
-	if (is_hp) {
-		snprintf(prop, sizeof(prop), "%shp-det-gpio", prefix);
-		pin_name	= "Headphones";
-		gpio_name	= "Headphone detection";
-		mask		= SND_JACK_HEADPHONE;
-	} else {
-		snprintf(prop, sizeof(prop), "%smic-det-gpio", prefix);
-		pin_name	= "Mic Jack";
-		gpio_name	= "Mic detection";
-		mask		= SND_JACK_MICROPHONE;
-	}
-
-	det = of_get_named_gpio_flags(dev->of_node, prop, 0, &flags);
-	if (det == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-
-	if (gpio_is_valid(det)) {
-		sjack->pin.pin		= pin_name;
-		sjack->pin.mask		= mask;
-
-		sjack->gpio.name	= gpio_name;
-		sjack->gpio.report	= mask;
-		sjack->gpio.gpio	= det;
-		sjack->gpio.invert	= !!(flags & OF_GPIO_ACTIVE_LOW);
-		sjack->gpio.debounce_time = 150;
-
-		snd_soc_card_jack_new(card, pin_name, mask,
-				      &sjack->jack,
-				      &sjack->pin, 1);
-
-		snd_soc_jack_add_gpios(&sjack->jack, 1,
-				       &sjack->gpio);
-	}
-
-	return 0;
-}
-
 static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-- 
2.17.1
