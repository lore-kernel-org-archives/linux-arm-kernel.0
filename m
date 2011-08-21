From: b29396@freescale.com (Dong Aisheng)
Date: Sun, 21 Aug 2011 23:45:40 +0800
Subject: [PATCH 1/1] ASoC: mxs-saif: clear clk gate first before register
	setting
Message-ID: <1313941540-20393-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Saif needs clear clk gate first before writing registers or the write
will not success.

The original xx_get_mclk function clear clk gate after mclk setting
that may cause the former mclk setting unwork, then the real output
mclk maybe inaccurate.
Placing the clear before setting mclk to avoid such an issue.

We also have to clear clk gate in startup instead of in prepare function.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 sound/soc/mxs/mxs-saif.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 0b3adae..530017f 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -187,16 +187,20 @@ int mxs_saif_get_mclk(unsigned int saif_id, unsigned int mclk,
 	if (!saif)
 		return -EINVAL;
 
+	/* Clear Reset */
+	__raw_writel(BM_SAIF_CTRL_SFTRST,
+		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
+
+	/* FIXME: need clear clk gate for register r/w */
+	__raw_writel(BM_SAIF_CTRL_CLKGATE,
+		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
+
 	stat = __raw_readl(saif->base + SAIF_STAT);
 	if (stat & BM_SAIF_STAT_BUSY) {
 		dev_err(saif->dev, "error: busy\n");
 		return -EBUSY;
 	}
 
-	/* Clear Reset */
-	__raw_writel(BM_SAIF_CTRL_SFTRST,
-		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
-
 	saif->mclk_in_use = 1;
 	ret = mxs_saif_set_clk(saif, mclk, rate);
 	if (ret)
@@ -207,8 +211,6 @@ int mxs_saif_get_mclk(unsigned int saif_id, unsigned int mclk,
 		return ret;
 
 	/* enable MCLK output */
-	__raw_writel(BM_SAIF_CTRL_CLKGATE,
-		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
 	__raw_writel(BM_SAIF_CTRL_RUN,
 		saif->base + SAIF_CTRL + MXS_SET_ADDR);
 
@@ -303,6 +305,10 @@ static int mxs_saif_startup(struct snd_pcm_substream *substream,
 	__raw_writel(BM_SAIF_CTRL_SFTRST,
 		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
 
+	/* clear clock gate */
+	__raw_writel(BM_SAIF_CTRL_CLKGATE,
+		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
+
 	return 0;
 }
 
@@ -379,10 +385,6 @@ static int mxs_saif_prepare(struct snd_pcm_substream *substream,
 {
 	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
 
-	/* clear clock gate */
-	__raw_writel(BM_SAIF_CTRL_CLKGATE,
-		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
-
 	/* enable FIFO error irqs */
 	__raw_writel(BM_SAIF_CTRL_FIFO_ERROR_IRQ_EN,
 		saif->base + SAIF_CTRL + MXS_SET_ADDR);
-- 
1.7.0.4
