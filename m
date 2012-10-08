From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 8 Oct 2012 16:34:00 -0300
Subject: [PATCH 2/2] ASoC: imx-ssi: Adopt 'per' and 'ipg' clocks
In-Reply-To: <1349724840-10466-1-git-send-email-fabio.estevam@freescale.com>
References: <1349724840-10466-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1349724840-10466-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently imx ssi driver has been using only the ipg clock as only slave mode
is supported.

For mx27 it is necessay to provide both 'ipg' and 'per' clocks in order to get
ssi functional.

This issue was found on mx27 by unselecting the mmc driver from the kernel
,which resulted on a system that could not play audio.

When the mmc driver is selected the required 'per2' clock is provided and it 
allows the ssi to work.

So make the driver request and handle both clocks.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-ssi.c |   25 ++++++++++++++++++-------
 sound/soc/fsl/imx-ssi.h |    2 +-
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 006f7d4..0742153 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -536,14 +536,23 @@ static int imx_ssi_probe(struct platform_device *pdev)
 
 	ssi->irq = platform_get_irq(pdev, 0);
 
-	ssi->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(ssi->clk)) {
-		ret = PTR_ERR(ssi->clk);
-		dev_err(&pdev->dev, "Cannot get the clock: %d\n",
+	ssi->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(ssi->clk_ipg)) {
+		ret = PTR_ERR(ssi->clk_ipg);
+		dev_err(&pdev->dev, "Cannot get the ipg clock: %d\n",
 			ret);
 		goto failed_clk;
 	}
-	clk_prepare_enable(ssi->clk);
+	clk_prepare_enable(ssi->clk_ipg);
+
+	ssi->clk_per = devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(ssi->clk_per)) {
+		ret = PTR_ERR(ssi->clk_per);
+		dev_err(&pdev->dev, "Cannot get the per clock: %d\n",
+			ret);
+		goto failed_clk;
+	}
+	clk_prepare_enable(ssi->clk_per);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -633,7 +642,8 @@ failed_pdev_fiq_alloc:
 failed_register:
 	release_mem_region(res->start, resource_size(res));
 failed_get_resource:
-	clk_disable_unprepare(ssi->clk);
+	clk_disable_unprepare(ssi->clk_ipg);
+	clk_disable_unprepare(ssi->clk_per);
 failed_clk:
 
 	return ret;
@@ -653,7 +663,8 @@ static int __devexit imx_ssi_remove(struct platform_device *pdev)
 		ac97_ssi = NULL;
 
 	release_mem_region(res->start, resource_size(res));
-	clk_disable_unprepare(ssi->clk);
+	clk_disable_unprepare(ssi->clk_ipg);
+	clk_disable_unprepare(ssi->clk_per);
 
 	return 0;
 }
diff --git a/sound/soc/fsl/imx-ssi.h b/sound/soc/fsl/imx-ssi.h
index dc114bd..1ac54c9 100644
--- a/sound/soc/fsl/imx-ssi.h
+++ b/sound/soc/fsl/imx-ssi.h
@@ -193,7 +193,7 @@ struct imx_ssi {
 	struct platform_device *ac97_dev;
 
 	struct snd_soc_dai *imx_ac97;
-	struct clk *clk;
+	struct clk *clk_ipg, *clk_per;
 	void __iomem *base;
 	int irq;
 	int fiq_enable;
-- 
1.7.9.5
