From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Jan 2015 19:42:33 +0100
Subject: [PATCH V3 06/15] ASoC: samsung: i2s: Add get_other_dai helper function
In-Reply-To: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
References: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1421260962-16892-7-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code to get pointer to the other DAI is repeated multiple
times. Add a helper function and use it instead.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index f75c19e..cab2a2a 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -130,10 +130,16 @@ static inline bool tx_active(struct i2s_dai *i2s)
 	return active ? true : false;
 }
 
+/* Return pointer to the other DAI */
+static inline struct i2s_dai *get_other_dai(struct i2s_dai *i2s)
+{
+	return i2s->pri_dai ? : i2s->sec_dai;
+}
+
 /* If the other interface of the controller is transmitting data */
 static inline bool other_tx_active(struct i2s_dai *i2s)
 {
-	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+	struct i2s_dai *other = get_other_dai(i2s);
 
 	return tx_active(other);
 }
@@ -160,7 +166,7 @@ static inline bool rx_active(struct i2s_dai *i2s)
 /* If the other interface of the controller is receiving data */
 static inline bool other_rx_active(struct i2s_dai *i2s)
 {
-	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+	struct i2s_dai *other = get_other_dai(i2s);
 
 	return rx_active(other);
 }
@@ -461,7 +467,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 	  int clk_id, unsigned int rfs, int dir)
 {
 	struct i2s_dai *i2s = to_info(dai);
-	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+	struct i2s_dai *other = get_other_dai(i2s);
 	u32 mod = readl(i2s->addr + I2SMOD);
 	const struct samsung_i2s_variant_regs *i2s_regs = i2s->variant_regs;
 	unsigned int cdcon_mask = 1 << i2s_regs->cdclkcon_off;
@@ -733,7 +739,7 @@ static int i2s_startup(struct snd_pcm_substream *substream,
 	  struct snd_soc_dai *dai)
 {
 	struct i2s_dai *i2s = to_info(dai);
-	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+	struct i2s_dai *other = get_other_dai(i2s);
 	unsigned long flags;
 
 	spin_lock_irqsave(&lock, flags);
@@ -760,7 +766,7 @@ static void i2s_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct i2s_dai *i2s = to_info(dai);
-	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+	struct i2s_dai *other = get_other_dai(i2s);
 	unsigned long flags;
 	const struct samsung_i2s_variant_regs *i2s_regs = i2s->variant_regs;
 
@@ -791,7 +797,7 @@ static void i2s_shutdown(struct snd_pcm_substream *substream,
 
 static int config_setup(struct i2s_dai *i2s)
 {
-	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+	struct i2s_dai *other = get_other_dai(i2s);
 	unsigned rfs, bfs, blc;
 	u32 psr;
 
@@ -899,7 +905,7 @@ static int i2s_set_clkdiv(struct snd_soc_dai *dai,
 	int div_id, int div)
 {
 	struct i2s_dai *i2s = to_info(dai);
-	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+	struct i2s_dai *other = get_other_dai(i2s);
 
 	switch (div_id) {
 	case SAMSUNG_I2S_DIV_BCLK:
@@ -968,7 +974,7 @@ static int i2s_resume(struct snd_soc_dai *dai)
 static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct i2s_dai *i2s = to_info(dai);
-	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+	struct i2s_dai *other = get_other_dai(i2s);
 
 	if (is_secondary(i2s)) { /* If this is probe on the secondary DAI */
 		samsung_asoc_init_dma_data(dai, &other->sec_dai->dma_playback,
@@ -1271,7 +1277,7 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	struct i2s_dai *i2s, *other;
 
 	i2s = dev_get_drvdata(&pdev->dev);
-	other = i2s->pri_dai ? : i2s->sec_dai;
+	other = get_other_dai(i2s);
 
 	if (other) {
 		other->pri_dai = NULL;
-- 
1.7.9.5
