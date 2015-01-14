From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Jan 2015 19:42:34 +0100
Subject: [PATCH V3 07/15] ASoC: samsung: i2s: Remove an unneeded goto usage
In-Reply-To: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
References: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1421260962-16892-8-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usage of this goto seems unjustified, use if/else statement instead.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index cab2a2a..2bac719 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -979,19 +979,18 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 	if (is_secondary(i2s)) { /* If this is probe on the secondary DAI */
 		samsung_asoc_init_dma_data(dai, &other->sec_dai->dma_playback,
 					   NULL);
-		goto probe_exit;
-	}
-
-	samsung_asoc_init_dma_data(dai, &i2s->dma_playback, &i2s->dma_capture);
+	} else {
+		samsung_asoc_init_dma_data(dai, &i2s->dma_playback,
+					   &i2s->dma_capture);
 
-	if (i2s->quirks & QUIRK_NEED_RSTCLR)
-		writel(CON_RSTCLR, i2s->addr + I2SCON);
+		if (i2s->quirks & QUIRK_NEED_RSTCLR)
+			writel(CON_RSTCLR, i2s->addr + I2SCON);
 
-	if (i2s->quirks & QUIRK_SUPPORTS_IDMA)
-		idma_reg_addr_init(i2s->addr,
+		if (i2s->quirks & QUIRK_SUPPORTS_IDMA)
+			idma_reg_addr_init(i2s->addr,
 					i2s->sec_dai->idma_playback.dma_addr);
+	}
 
-probe_exit:
 	/* Reset any constraint on RFS and BFS */
 	i2s->rfs = 0;
 	i2s->bfs = 0;
-- 
1.7.9.5
