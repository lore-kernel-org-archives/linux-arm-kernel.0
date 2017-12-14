From: olivier.moysan@st.com (Olivier Moysan)
Date: Thu, 14 Dec 2017 17:53:58 +0100
Subject: [RFC PATCH 2/2] ASoC: select sysclk clock from mlck clock provider in
 wm8994 driver
In-Reply-To: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
References: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1513270438-18523-3-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When defined in device tree, MCLK1 and MCLK2 are used
as sysclk for aif1 and aif2 interfaces respectively.
If clock rate is let 0, the frequency provided by
wm8994_set_dai_sysclk() is used instead.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/wm8994.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 21ffd64..7a84e37 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -2376,18 +2377,35 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994 *control = wm8994->wm8994;
+	struct wm8994_pdata *pdata = &control->pdata;
+	unsigned long rate;
 	int i;
 
 	switch (dai->id) {
 	case 1:
+		if (pdata->mclk1) {
+			rate = clk_get_rate(pdata->mclk1);
+			if (rate)
+				freq = (unsigned int)rate;
+			clk_id = WM8994_SYSCLK_MCLK1;
+		}
+		break;
 	case 2:
+		if (pdata->mclk2) {
+			rate = clk_get_rate(pdata->mclk2);
+			if (rate)
+				freq = (unsigned int)rate;
+			clk_id = WM8994_SYSCLK_MCLK2;
+		}
 		break;
-
 	default:
 		/* AIF3 shares clocking with AIF1/2 */
 		return -EINVAL;
 	}
 
+	dev_info(codec->dev, "%s:.clock id %d\n", __func__, clk_id);
+
 	switch (clk_id) {
 	case WM8994_SYSCLK_MCLK1:
 		wm8994->sysclk[dai->id - 1] = WM8994_SYSCLK_MCLK1;
-- 
1.9.1
