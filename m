From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:34 +0200
Subject: [PATCH 02/26] sound/pxa-zylonite: use a valid device for dev_err()
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent conversion has introduced references to &pdev->dev, which does
not actually exist in all the contexts it's used in.

Replace this with card->dev where necessary, in order to let
the driver build again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/zylonite.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index b644575..2b8350b 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -196,20 +196,20 @@ static int zylonite_probe(struct snd_soc_card *card)
 	if (clk_pout) {
 		pout = clk_get(NULL, "CLK_POUT");
 		if (IS_ERR(pout)) {
-			dev_err(&pdev->dev, "Unable to obtain CLK_POUT: %ld\n",
+			dev_err(card->dev, "Unable to obtain CLK_POUT: %ld\n",
 				PTR_ERR(pout));
 			return PTR_ERR(pout);
 		}
 
 		ret = clk_enable(pout);
 		if (ret != 0) {
-			dev_err(&pdev->dev, "Unable to enable CLK_POUT: %d\n",
+			dev_err(card->dev, "Unable to enable CLK_POUT: %d\n",
 				ret);
 			clk_put(pout);
 			return ret;
 		}
 
-		dev_dbg(&pdev->dev, "MCLK enabled at %luHz\n",
+		dev_dbg(card->dev, "MCLK enabled at %luHz\n",
 			clk_get_rate(pout));
 	}
 
@@ -241,7 +241,7 @@ static int zylonite_resume_pre(struct snd_soc_card *card)
 	if (clk_pout) {
 		ret = clk_enable(pout);
 		if (ret != 0)
-			dev_err(&pdev->dev, "Unable to enable CLK_POUT: %d\n",
+			dev_err(card->dev, "Unable to enable CLK_POUT: %d\n",
 				ret);
 	}
 
-- 
1.7.5.4
