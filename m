From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 15 Mar 2014 13:44:15 +0100
Subject: [PATCH v2 07/16] ASoC: fsl-ssi: baud clock error handling
In-Reply-To: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1394887464-969-8-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds error handling for baud clock. It checks for PROBE_DEFER
error codes and handles clk_prepare_enable() errors.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index fcc73d3..663ac8b 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -984,11 +984,19 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	 * and, instead, abandon MASTER mode that needs baud clock.
 	 */
 	ssi_private->baudclk = devm_clk_get(&pdev->dev, "baud");
-	if (IS_ERR(ssi_private->baudclk))
+	if (IS_ERR(ssi_private->baudclk)) {
+		ret = PTR_ERR(ssi_private->baudclk);
+		if (ret == -EPROBE_DEFER)
+			goto error_baud_clk;
 		dev_dbg(&pdev->dev, "could not get baud clock: %ld\n",
-			 PTR_ERR(ssi_private->baudclk));
-	else
-		clk_prepare_enable(ssi_private->baudclk);
+				PTR_ERR(ssi_private->baudclk));
+	} else {
+		ret = clk_prepare_enable(ssi_private->baudclk);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to enable baud clock\n");
+			goto error_baud_clk;
+		}
+	}
 
 	/*
 	 * We have burstsize be "fifo_depth - 2" to match the SSI
@@ -1012,6 +1020,11 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	}
 
 	return 0;
+
+error_baud_clk:
+	clk_disable_unprepare(ssi_private->clk);
+
+	return ret;
 }
 
 static void fsl_ssi_imx_clean(struct platform_device *pdev,
-- 
1.9.0
