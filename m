From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 1 Mar 2016 10:54:29 +0100
Subject: [RESEND PATCH] ASoC: atmel_ssc_dai: distinguish the different SSC
Message-ID: <1456826069-30955-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Songjun Wu <songjun.wu@atmel.com>

Cpu_dai id always equals 0, can't distinguish the
different SSC. Use platform_device id to record
and distinguish the different SSC.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/misc/atmel-ssc.c        |  1 +
 sound/soc/atmel/atmel_ssc_dai.c | 27 ++++++++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index e11a0bd6c66e..0516ecda54d3 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -34,6 +34,7 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
 		if (ssc->pdev->dev.of_node) {
 			if (of_alias_get_id(ssc->pdev->dev.of_node, "ssc")
 				== ssc_num) {
+				ssc->pdev->id = ssc_num;
 				ssc_valid = 1;
 				break;
 			}
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index ba8def5665c4..276897033639 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -285,7 +285,8 @@ static int atmel_ssc_hw_rule_rate(struct snd_pcm_hw_params *params,
 static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
+	struct platform_device *pdev = to_platform_device(dai->dev);
+	struct atmel_ssc_info *ssc_p = &ssc_info[pdev->id];
 	struct atmel_pcm_dma_params *dma_params;
 	int dir, dir_mask;
 	int ret;
@@ -346,7 +347,8 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
+	struct platform_device *pdev = to_platform_device(dai->dev);
+	struct atmel_ssc_info *ssc_p = &ssc_info[pdev->id];
 	struct atmel_pcm_dma_params *dma_params;
 	int dir, dir_mask;
 
@@ -392,7 +394,8 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 static int atmel_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+	struct platform_device *pdev = to_platform_device(cpu_dai->dev);
+	struct atmel_ssc_info *ssc_p = &ssc_info[pdev->id];
 
 	ssc_p->daifmt = fmt;
 	return 0;
@@ -404,7 +407,8 @@ static int atmel_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 	int div_id, int div)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+	struct platform_device *pdev = to_platform_device(cpu_dai->dev);
+	struct atmel_ssc_info *ssc_p = &ssc_info[pdev->id];
 
 	switch (div_id) {
 	case ATMEL_SSC_CMR_DIV:
@@ -445,7 +449,8 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	int id = dai->id;
+	struct platform_device *pdev = to_platform_device(dai->dev);
+	int id = pdev->id;
 	struct atmel_ssc_info *ssc_p = &ssc_info[id];
 	struct ssc_device *ssc = ssc_p->ssc;
 	struct atmel_pcm_dma_params *dma_params;
@@ -772,7 +777,8 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
+	struct platform_device *pdev = to_platform_device(dai->dev);
+	struct atmel_ssc_info *ssc_p = &ssc_info[pdev->id];
 	struct atmel_pcm_dma_params *dma_params;
 	int dir;
 
@@ -795,7 +801,8 @@ static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
 static int atmel_ssc_trigger(struct snd_pcm_substream *substream,
 			     int cmd, struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
+	struct platform_device *pdev = to_platform_device(dai->dev);
+	struct atmel_ssc_info *ssc_p = &ssc_info[pdev->id];
 	struct atmel_pcm_dma_params *dma_params;
 	int dir;
 
@@ -824,11 +831,12 @@ static int atmel_ssc_trigger(struct snd_pcm_substream *substream,
 static int atmel_ssc_suspend(struct snd_soc_dai *cpu_dai)
 {
 	struct atmel_ssc_info *ssc_p;
+	struct platform_device *pdev = to_platform_device(cpu_dai->dev);
 
 	if (!cpu_dai->active)
 		return 0;
 
-	ssc_p = &ssc_info[cpu_dai->id];
+	ssc_p = &ssc_info[pdev->id];
 
 	/* Save the status register before disabling transmit and receive */
 	ssc_p->ssc_state.ssc_sr = ssc_readl(ssc_p->ssc->regs, SR);
@@ -852,12 +860,13 @@ static int atmel_ssc_suspend(struct snd_soc_dai *cpu_dai)
 static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
 {
 	struct atmel_ssc_info *ssc_p;
+	struct platform_device *pdev = to_platform_device(cpu_dai->dev);
 	u32 cr;
 
 	if (!cpu_dai->active)
 		return 0;
 
-	ssc_p = &ssc_info[cpu_dai->id];
+	ssc_p = &ssc_info[pdev->id];
 
 	/* restore SSC register settings */
 	ssc_writel(ssc_p->ssc->regs, TFMR, ssc_p->ssc_state.ssc_tfmr);
-- 
2.1.3
