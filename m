From: olivier.moysan@st.com (Olivier Moysan)
Date: Fri, 19 Oct 2018 17:56:35 +0200
Subject: [PATCH 1/1] ASoC: cs42l51: fix mclk support
Message-ID: <1539964595-23758-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes: 5e8d63a726f8 ("ASoC: cs42l51: add mclk support")

The MCLK clock is made optional for cs42l51 codec.
However, ASoC DAPM clock supply widget, expects the clock to be defined
unconditionally.
Register MCLK DAPM conditionally in codec driver,
depending on clock presence in DT.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/cs42l51.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index eb40bff54cec..fd2bd74024c1 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -21,6 +21,7 @@
  *  - master mode *NOT* supported
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -41,6 +42,7 @@ enum master_slave_mode {
 
 struct cs42l51_private {
 	unsigned int mclk;
+	struct clk *mclk_handle;
 	unsigned int audio_mode;	/* The mode (I2S or left-justified) */
 	enum master_slave_mode func;
 };
@@ -492,9 +494,13 @@ static int cs42l51_component_probe(struct snd_soc_component *component)
 {
 	int ret, reg;
 	struct snd_soc_dapm_context *dapm;
+	struct cs42l51_private *cs42l51;
 
+	cs42l51 = snd_soc_component_get_drvdata(component);
 	dapm = snd_soc_component_get_dapm(component);
-	snd_soc_dapm_new_controls(dapm, cs42l51_dapm_mclk_widgets, 1);
+
+	if (cs42l51->mclk_handle)
+		snd_soc_dapm_new_controls(dapm, cs42l51_dapm_mclk_widgets, 1);
 
 	/*
 	 * DAC configuration
@@ -548,6 +554,13 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 
 	dev_set_drvdata(dev, cs42l51);
 
+	cs42l51->mclk_handle = devm_clk_get(dev, "MCLK");
+	if (IS_ERR(cs42l51->mclk_handle)) {
+		if (PTR_ERR(cs42l51->mclk_handle) != -ENOENT)
+			return PTR_ERR(cs42l51->mclk_handle);
+		cs42l51->mclk_handle = NULL;
+	}
+
 	/* Verify that we have a CS42L51 */
 	ret = regmap_read(regmap, CS42L51_CHIP_REV_ID, &val);
 	if (ret < 0) {
-- 
2.7.4
