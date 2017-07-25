From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue, 25 Jul 2017 15:46:09 +0530
Subject: [PATCH 10/11] ASoC: pxa: Handle return value of clk_prepare_enable.
Message-ID: <1500977770-28142-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/pxa/pxa2xx-i2s.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 3fb60ba..2312c22 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -164,10 +164,14 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
+	int ret;
 
 	if (WARN_ON(IS_ERR(clk_i2s)))
 		return -EINVAL;
-	clk_prepare_enable(clk_i2s);
+	ret = clk_prepare_enable(clk_i2s);
+	if (ret)
+		return ret;
+
 	clk_ena = 1;
 	pxa_i2s_wait();
 
-- 
1.9.1
