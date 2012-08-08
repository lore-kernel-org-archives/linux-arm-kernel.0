From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed,  8 Aug 2012 12:11:35 +0300
Subject: [PATCH 05/11] ASoC: am3517evm: Do not configure McBSP1 CLKR/FSR
 signal muxing
In-Reply-To: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1344417101-5015-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The muxing is done at board level, no need to do it in the ASoC machine
driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/am3517evm.c |   20 ++------------------
 1 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
index 009533a..a997988 100644
--- a/sound/soc/omap/am3517evm.c
+++ b/sound/soc/omap/am3517evm.c
@@ -47,26 +47,10 @@ static int am3517evm_hw_params(struct snd_pcm_substream *substream,
 	/* Set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
 			CODEC_CLOCK, SND_SOC_CLOCK_IN);
-	if (ret < 0) {
+	if (ret < 0)
 		printk(KERN_ERR "can't set codec system clock\n");
-		return ret;
-	}
-
-	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_CLKR_SRC_CLKX, 0,
-				SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set CPU system clock OMAP_MCBSP_CLKR_SRC_CLKX\n");
-		return ret;
-	}
 
-	snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_FSR_SRC_FSX, 0,
-				SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set CPU system clock OMAP_MCBSP_FSR_SRC_FSX\n");
-		return ret;
-	}
-
-	return 0;
+	return ret;
 }
 
 static struct snd_soc_ops am3517evm_ops = {
-- 
1.7.8.6
