From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:21 +0200
Subject: [PATCH 08/40] mmc mxcmmc: do not depend on grouped clocks
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-9-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the current i.MX clock support groups together unrelated clocks
to a single clock which is then used by the driver. This can't
be accomplished with the generic clock framework so we instead
request the individual clocks in the driver. For i.MX there are
generally three different clocks:

ipg: bus clock (needed to access registers)
ahb: dma relevant clock, sometimes referred to as hclk in the datasheet
per: bit clock, pixel clock

This patch changes the driver to request the individual clocks.
Currently all clk_get will get the same clock until the SoCs
are converted to the generic clock framework

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/mxcmmc.c |   39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index b2058b4..28ed52d 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -136,7 +136,8 @@ struct mxcmci_host {
 	u16			rev_no;
 	unsigned int		cmdat;
 
-	struct clk		*clk;
+	struct clk		*clk_ipg;
+	struct clk		*clk_per;
 
 	int			clock;
 
@@ -672,7 +673,7 @@ static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios)
 {
 	unsigned int divider;
 	int prescaler = 0;
-	unsigned int clk_in = clk_get_rate(host->clk);
+	unsigned int clk_in = clk_get_rate(host->clk_per);
 
 	while (prescaler <= 0x800) {
 		for (divider = 1; divider <= 0xF; divider++) {
@@ -900,12 +901,20 @@ static int mxcmci_probe(struct platform_device *pdev)
 	host->res = r;
 	host->irq = irq;
 
-	host->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(host->clk)) {
-		ret = PTR_ERR(host->clk);
+	host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(host->clk_ipg)) {
+		ret = PTR_ERR(host->clk_ipg);
 		goto out_iounmap;
 	}
-	clk_enable(host->clk);
+
+	host->clk_per = devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(host->clk_per)) {
+		ret = PTR_ERR(host->clk_per);
+		goto out_iounmap;
+	}
+
+	clk_prepare_enable(host->clk_per);
+	clk_prepare_enable(host->clk_ipg);
 
 	mxcmci_softreset(host);
 
@@ -917,8 +926,8 @@ static int mxcmci_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
-	mmc->f_min = clk_get_rate(host->clk) >> 16;
-	mmc->f_max = clk_get_rate(host->clk) >> 1;
+	mmc->f_min = clk_get_rate(host->clk_per) >> 16;
+	mmc->f_max = clk_get_rate(host->clk_per) >> 1;
 
 	/* recommended in data sheet */
 	writew(0x2db4, host->base + MMC_REG_READ_TO);
@@ -967,8 +976,8 @@ out_free_dma:
 	if (host->dma)
 		dma_release_channel(host->dma);
 out_clk_put:
-	clk_disable(host->clk);
-	clk_put(host->clk);
+	clk_disable_unprepare(host->clk_per);
+	clk_disable_unprepare(host->clk_ipg);
 out_iounmap:
 	iounmap(host->base);
 out_free:
@@ -999,8 +1008,8 @@ static int mxcmci_remove(struct platform_device *pdev)
 	if (host->dma)
 		dma_release_channel(host->dma);
 
-	clk_disable(host->clk);
-	clk_put(host->clk);
+	clk_disable_unprepare(host->clk_per);
+	clk_disable_unprepare(host->clk_ipg);
 
 	release_mem_region(host->res->start, resource_size(host->res));
 
@@ -1018,7 +1027,8 @@ static int mxcmci_suspend(struct device *dev)
 
 	if (mmc)
 		ret = mmc_suspend_host(mmc);
-	clk_disable(host->clk);
+	clk_disable_unprepare(host->clk_per);
+	clk_disable_unprepare(host->clk_ipg);
 
 	return ret;
 }
@@ -1029,7 +1039,8 @@ static int mxcmci_resume(struct device *dev)
 	struct mxcmci_host *host = mmc_priv(mmc);
 	int ret = 0;
 
-	clk_enable(host->clk);
+	clk_prepare_enable(host->clk_per);
+	clk_prepare_enable(host->clk_ipg);
 	if (mmc)
 		ret = mmc_resume_host(mmc);
 
-- 
1.7.9.5
