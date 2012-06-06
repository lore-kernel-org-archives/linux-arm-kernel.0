From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  6 Jun 2012 12:33:13 +0200
Subject: [PATCH 1/4] mtd nand mxc_nand: Use managed resources
In-Reply-To: <1338978796-26129-1-git-send-email-s.hauer@pengutronix.de>
References: <1338978796-26129-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1338978796-26129-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To make the error path simpler and to make subsequent patches
easier.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   70 ++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 47 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index c58e6a9..a1136f3 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1323,8 +1323,8 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	int err = 0;
 
 	/* Allocate memory for MTD device structure and private data */
-	host = kzalloc(sizeof(struct mxc_nand_host) + NAND_MAX_PAGESIZE +
-			NAND_MAX_OOBSIZE, GFP_KERNEL);
+	host = devm_kzalloc(&pdev->dev, sizeof(struct mxc_nand_host) +
+			NAND_MAX_PAGESIZE + NAND_MAX_OOBSIZE, GFP_KERNEL);
 	if (!host)
 		return -ENOMEM;
 
@@ -1351,26 +1351,17 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	this->read_buf = mxc_nand_read_buf;
 	this->verify_buf = mxc_nand_verify_buf;
 
-	host->clk = clk_get(&pdev->dev, "nfc");
-	if (IS_ERR(host->clk)) {
-		err = PTR_ERR(host->clk);
-		goto eclk;
-	}
-
-	clk_prepare_enable(host->clk);
-	host->clk_act = 1;
+	host->clk = devm_clk_get(&pdev->dev, "nfc");
+	if (IS_ERR(host->clk))
+		return PTR_ERR(host->clk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		err = -ENODEV;
-		goto eres;
-	}
+	if (!res)
+		return -ENODEV;
 
-	host->base = ioremap(res->start, resource_size(res));
-	if (!host->base) {
-		err = -ENOMEM;
-		goto eres;
-	}
+	host->base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!host->base)
+		return -ENOMEM;
 
 	host->main_area0 = host->base;
 
@@ -1378,7 +1369,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	if (err > 0)
 		err = mxcnd_probe_pdata(host);
 	if (err < 0)
-		goto eirq;
+		return err;
 
 	if (host->devtype_data->regs_offset)
 		host->regs = host->base + host->devtype_data->regs_offset;
@@ -1395,15 +1386,11 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 
 	if (host->devtype_data->needs_ip) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		if (!res) {
-			err = -ENODEV;
-			goto eirq;
-		}
-		host->regs_ip = ioremap(res->start, resource_size(res));
-		if (!host->regs_ip) {
-			err = -ENOMEM;
-			goto eirq;
-		}
+		if (!res)
+			return -ENODEV;
+		host->regs_ip = devm_request_and_ioremap(&pdev->dev, res);
+		if (!host->regs_ip)
+			return -ENOMEM;
 	}
 
 	if (host->pdata.hw_ecc) {
@@ -1437,9 +1424,13 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	 */
 	host->devtype_data->irq_control(host, 0);
 
-	err = request_irq(host->irq, mxc_nfc_irq, IRQF_DISABLED, DRIVER_NAME, host);
+	err = devm_request_irq(&pdev->dev, host->irq, mxc_nfc_irq,
+			IRQF_DISABLED, DRIVER_NAME, host);
 	if (err)
-		goto eirq;
+		return err;
+
+	clk_prepare_enable(host->clk);
+	host->clk_act = 1;
 
 	/*
 	 * Now that we "own" the interrupt make sure the interrupt mask bit is
@@ -1491,15 +1482,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	return 0;
 
 escan:
-	free_irq(host->irq, host);
-eirq:
-	if (host->regs_ip)
-		iounmap(host->regs_ip);
-	iounmap(host->base);
-eres:
-	clk_put(host->clk);
-eclk:
-	kfree(host);
+	clk_disable_unprepare(host->clk);
 
 	return err;
 }
@@ -1508,16 +1491,9 @@ static int __devexit mxcnd_remove(struct platform_device *pdev)
 {
 	struct mxc_nand_host *host = platform_get_drvdata(pdev);
 
-	clk_put(host->clk);
-
 	platform_set_drvdata(pdev, NULL);
 
 	nand_release(&host->mtd);
-	free_irq(host->irq, host);
-	if (host->regs_ip)
-		iounmap(host->regs_ip);
-	iounmap(host->base);
-	kfree(host);
 
 	return 0;
 }
-- 
1.7.10
