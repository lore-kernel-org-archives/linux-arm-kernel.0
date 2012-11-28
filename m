From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 28 Nov 2012 16:17:48 +0530
Subject: [PATCH V4 1/2] ASoC: Samsung: Get I2S src_clk from clock alias id.
In-Reply-To: <1354099669-1735-1-git-send-email-padma.v@samsung.com>
References: <1354099669-1735-1-git-send-email-padma.v@samsung.com>
Message-ID: <1354099669-1735-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the I2S src clks are registered with clkdev using generic
connection id, driver can get the clk name using generic id.
So the variable representing the array of rclk src clks is
deleted.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 include/linux/platform_data/asoc-s3c.h |    6 ------
 sound/soc/samsung/i2s.c                |   12 ++++++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/platform_data/asoc-s3c.h b/include/linux/platform_data/asoc-s3c.h
index aa9875f..8827259 100644
--- a/include/linux/platform_data/asoc-s3c.h
+++ b/include/linux/platform_data/asoc-s3c.h
@@ -38,12 +38,6 @@ struct samsung_i2s {
 #define QUIRK_NEED_RSTCLR	(1 << 3)
 	/* Quirks of the I2S controller */
 	u32 quirks;
-
-	/*
-	 * Array of clock names that can be used to generate I2S signals.
-	 * Also corresponds to clocks of I2SMOD[10]
-	 */
-	const char **src_clk;
 	dma_addr_t idma_addr;
 };
 
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 547b919..aaf57b7 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -49,8 +49,6 @@ struct i2s_dai {
 	struct clk *clk;
 	/* Clock for generating I2S signals */
 	struct clk *op_clk;
-	/* Array of clock names for op_clk */
-	const char **src_clk;
 	/* Pointer to the Primary_Fifo if this is Sec_Fifo, NULL otherwise */
 	struct i2s_dai *pri_dai;
 	/* Pointer to the Secondary_Fifo if it has one, NULL otherwise */
@@ -432,8 +430,12 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 				}
 			}
 
-			i2s->op_clk = clk_get(&i2s->pdev->dev,
-						i2s->src_clk[clk_id]);
+			if (clk_id)
+				i2s->op_clk = clk_get(&i2s->pdev->dev,
+						"i2s_opclk1");
+			else
+				i2s->op_clk = clk_get(&i2s->pdev->dev,
+						"i2s_opclk0");
 			clk_prepare_enable(i2s->op_clk);
 			i2s->rclk_srcrate = clk_get_rate(i2s->op_clk);
 
@@ -1067,7 +1069,6 @@ static __devinit int samsung_i2s_probe(struct platform_device *pdev)
 		(struct s3c2410_dma_client *)&pri_dai->dma_capture;
 	pri_dai->dma_playback.channel = dma_pl_chan;
 	pri_dai->dma_capture.channel = dma_cp_chan;
-	pri_dai->src_clk = i2s_cfg->src_clk;
 	pri_dai->dma_playback.dma_size = 4;
 	pri_dai->dma_capture.dma_size = 4;
 	pri_dai->base = regs_base;
@@ -1088,7 +1089,6 @@ static __devinit int samsung_i2s_probe(struct platform_device *pdev)
 			(struct s3c2410_dma_client *)&sec_dai->dma_playback;
 		/* Use iDMA always if SysDMA not provided */
 		sec_dai->dma_playback.channel = dma_pl_sec_chan ? : -1;
-		sec_dai->src_clk = i2s_cfg->src_clk;
 		sec_dai->dma_playback.dma_size = 4;
 		sec_dai->base = regs_base;
 		sec_dai->quirks = quirks;
-- 
1.7.4.4
