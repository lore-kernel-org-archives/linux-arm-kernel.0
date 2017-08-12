From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 12 Aug 2017 13:00:49 +0200
Subject: [PATCH v3 01/11] ASoC: sun4i-i2s: Add clkdiv offsets to quirks
In-Reply-To: <20170812110059.5115-1-codekipper@gmail.com>
References: <20170812110059.5115-1-codekipper@gmail.com>
Message-ID: <20170812110059.5115-2-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The BCLKDIV and MCLKDIV found on newer SoCs start from an offset of 1.
Add the functionality to adjust the division values according to the
needs to the device being used.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d7ee7a443e4e..9a35313c4f9b 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -94,9 +94,13 @@
  * struct sun4i_i2s_quirks - Differences between SoC variants.
  *
  * @has_reset: SoC needs reset deasserted.
+ * @mclk_offset: Value by which mclkdiv needs to be adjusted.
+ * @bclk_offset: Value by which bclkdiv needs to be adjusted.
  */
 struct sun4i_i2s_quirks {
 	bool				has_reset;
+	unsigned int			mclk_offset;
+	unsigned int			bclk_offset;
 };
 
 struct sun4i_i2s {
@@ -237,6 +241,10 @@ static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
 	if (mclk_div < 0)
 		return -EINVAL;
 
+	/* Adjust the clock division values if needed */
+	bclk_div += i2s->variant->bclk_offset;
+	mclk_div += i2s->variant->mclk_offset;
+
 	regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
 		     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
 		     SUN4I_I2S_CLK_DIV_MCLK(mclk_div) |
-- 
2.14.1
