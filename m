From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Apr 2013 11:25:04 +0200
Subject: [PATCH 1/6] ata: i.MX PATA: Use devm_clk_get
In-Reply-To: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
References: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1365067509-10186-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To make the error path a bit simpler.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/ata/pata_imx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 4084944..af893dd 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -112,7 +112,7 @@ static int pata_imx_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->clk = clk_get(&pdev->dev, NULL);
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev, "Failed to get clock\n");
 		return PTR_ERR(priv->clk);
@@ -163,7 +163,7 @@ static int pata_imx_probe(struct platform_device *pdev)
 
 free_priv:
 	clk_disable_unprepare(priv->clk);
-	clk_put(priv->clk);
+
 	return -ENOMEM;
 }
 
@@ -177,7 +177,6 @@ static int pata_imx_remove(struct platform_device *pdev)
 	__raw_writel(0, priv->host_regs + PATA_IMX_ATA_INT_EN);
 
 	clk_disable_unprepare(priv->clk);
-	clk_put(priv->clk);
 
 	return 0;
 }
-- 
1.8.2.rc2
