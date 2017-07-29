From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 29 Jul 2017 16:17:43 +0200
Subject: [PATCH v3 02/12] ASoC: sun4i-i2s: Add clkdiv offsets to quirks
In-Reply-To: <20170729141753.20174-1-codekipper@gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
Message-ID: <20170729141753.20174-3-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The BCLKDIV and MCLKDIV found on newer SoCs start from an offset of 1.
Add the functionality to adjust the division values according to the
needs to the device being used.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d7ee7a443e4e..1d538de4e4d0 100644
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
@@ -149,7 +153,7 @@ static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
 		const struct sun4i_i2s_clk_div *bdiv = &sun4i_i2s_bclk_div[i];
 
 		if (bdiv->div == div)
-			return bdiv->val;
+			return bdiv->val + i2s->variant->bclk_offset;
 	}
 
 	return -EINVAL;
@@ -167,7 +171,7 @@ static int sun4i_i2s_get_mclk_div(struct sun4i_i2s *i2s,
 		const struct sun4i_i2s_clk_div *mdiv = &sun4i_i2s_mclk_div[i];
 
 		if (mdiv->div == div)
-			return mdiv->val;
+			return mdiv->val + i2s->variant->mclk_offset;
 	}
 
 	return -EINVAL;
-- 
2.13.3
