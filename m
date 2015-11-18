From: leoli@freescale.com (Li Yang)
Date: Tue, 17 Nov 2015 18:02:59 -0600
Subject: [PATCH] i2c: imx: make bus recovery through pinctrl optional
Message-ID: <1447804979-29550-1-git-send-email-leoli@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 1c4b6c3bcf30 ("i2c: imx: implement bus recovery") the driver
starts to use gpio/pinctrl to do i2c bus recovery.  But pinctrl is not
always available for platforms using this driver such as ls1021a and
ls1043a, and the device tree binding also mentioned this gpio based
recovery mechanism as optional.  The patch make it really optional that
the probe function won't bailout when pinctrl is not available and it
won't try to register recovery functions if pinctrl is NULL when the
PINCTRL is not enabled at all.

Signed-off-by: Li Yang <leoli@freescale.com>
Cc: Gao Pan <b54642@freescale.com>
---
 drivers/i2c/busses/i2c-imx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 1e4d99d..7813153 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1086,12 +1086,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
-	if (IS_ERR(i2c_imx->pinctrl)) {
-		ret = PTR_ERR(i2c_imx->pinctrl);
-		goto clk_disable;
-	}
-
 	/* Request IRQ */
 	ret = devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
 				pdev->name, i2c_imx);
@@ -1125,7 +1119,12 @@ static int i2c_imx_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
-	i2c_imx_init_recovery_info(i2c_imx, pdev);
+	/* optional bus recovery feature through pinctrl */
+	i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR_OR_NULL(i2c_imx->pinctrl))
+		dev_info(&pdev->dev, "can't get pinctrl, bus recovery feature disabled\n");
+	else
+		i2c_imx_init_recovery_info(i2c_imx, pdev);
 
 	/* Set up platform driver data */
 	platform_set_drvdata(pdev, i2c_imx);
-- 
2.3.3
