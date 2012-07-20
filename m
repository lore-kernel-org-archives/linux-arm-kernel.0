From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 20 Jul 2012 17:20:25 +0800
Subject: [PATCH 2/4] ASoC: mxs-saif: set a base clock rate for EXTMASTER mode
 work
In-Reply-To: <1342776027-31758-1-git-send-email-b29396@freescale.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
Message-ID: <1342776027-31758-3-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Set an initial clock rate for the saif internal logic to work
properly. This is important when working in EXTMASTER mode that
uses the other saif's BITCLK&LRCLK but it still needs a basic
clock which should be fast enough for the internal logic.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 sound/soc/mxs/mxs-saif.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index fdbb36a..b303071 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -427,8 +427,22 @@ static int mxs_saif_hw_params(struct snd_pcm_substream *substream,
 
 	/* prepare clk in hw_param, enable in trigger */
 	clk_prepare(saif->clk);
-	if (saif != master_saif)
+	if (saif != master_saif) {
+		/*
+		* Set an initial clock rate for the saif internal logic to work
+		* properly. This is important when working in EXTMASTER mode
+		* that uses the other saif's BITCLK&LRCLK but it still needs a
+		* basic clock which should be fast enough for the internal
+		* logic.
+		*/
+		clk_enable(saif->clk);
+		ret = clk_set_rate(saif->clk, 24000000);
+		clk_disable(saif->clk);
+		if (ret)
+			return ret;
+
 		clk_prepare(master_saif->clk);
+	}
 
 	scr = __raw_readl(saif->base + SAIF_CTRL);
 
-- 
1.7.0.4
