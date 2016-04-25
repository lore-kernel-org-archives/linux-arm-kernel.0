From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 25 Apr 2016 13:39:39 +0000
Subject: [PATCH 2/3] ASoC: bcm2835: setup clock only if CPU is clock master
In-Reply-To: <1461591580-7565-1-git-send-email-kernel@martin.sperl.org>
References: <1461591580-7565-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1461591580-7565-2-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Reichl <hias@horus.com>

We only need to enable the clock if we are a clock master.

Code ported from bcm2708-i2s driver in Raspberry Pi tree.
Original work by Zoltan Szenczi.

Signed-off-by: Matthias Reichl <hias@horus.com>
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index d2663e7..a0026e2 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -276,8 +276,15 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 		/* otherwise calculate a fitting block ratio */
 		bclk_ratio = 2 * data_length;

-	/* set target clock rate*/
-	clk_set_rate(dev->clk, sampling_rate * bclk_ratio);
+	/* Clock should only be set up here if CPU is clock master */
+	switch (dev->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_CBS_CFM:
+		clk_set_rate(dev->clk, sampling_rate * bclk_ratio);
+		break;
+	default:
+		break;
+	}

 	/* Setup the frame format */
 	format = BCM2835_I2S_CHEN;
--
2.1.4
