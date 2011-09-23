From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 23 Sep 2011 17:23:41 +0530
Subject: [PATCH 1/7] SPI: S3C64XX: Use bus clocks created using clkdev
In-Reply-To: <1316778827-24694-1-git-send-email-padma.v@samsung.com>
References: <1316778827-24694-1-git-send-email-padma.v@samsung.com>
Message-ID: <1316778827-24694-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the driver to stop depending on the
clock names being passed from platform and switch over
to lookup clocks generic names using clkdev

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 drivers/spi/spi-s3c64xx.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 019a716..dcf7e10 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -971,6 +971,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	struct s3c64xx_spi_info *sci;
 	struct spi_master *master;
 	int ret;
+	char clk_name[16];
 
 	if (pdev->id < 0) {
 		dev_err(&pdev->dev,
@@ -984,11 +985,6 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	}
 
 	sci = pdev->dev.platform_data;
-	if (!sci->src_clk_name) {
-		dev_err(&pdev->dev,
-			"Board init must call s3c64xx_spi_set_info()\n");
-		return -EINVAL;
-	}
 
 	/* Check for availability of necessary resource */
 
@@ -1073,17 +1069,17 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err4;
 	}
 
-	sdd->src_clk = clk_get(&pdev->dev, sci->src_clk_name);
+	sprintf(clk_name, "spi_busclk%d", sci->src_clk_nr);
+	sdd->src_clk = clk_get(&pdev->dev, clk_name);
 	if (IS_ERR(sdd->src_clk)) {
 		dev_err(&pdev->dev,
-			"Unable to acquire clock '%s'\n", sci->src_clk_name);
+			"Unable to acquire clock '%s'\n", clk_name);
 		ret = PTR_ERR(sdd->src_clk);
 		goto err5;
 	}
 
 	if (clk_enable(sdd->src_clk)) {
-		dev_err(&pdev->dev, "Couldn't enable clock '%s'\n",
-							sci->src_clk_name);
+		dev_err(&pdev->dev, "Couldn't enable clock '%s'\n", clk_name);
 		ret = -EBUSY;
 		goto err6;
 	}
-- 
1.7.4.4
