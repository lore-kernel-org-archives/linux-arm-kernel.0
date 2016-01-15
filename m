From: leoyang.li@nxp.com (Li Yang)
Date: Fri, 15 Jan 2016 01:27:24 -0600
Subject: [PATCH v3] i2c: imx: make bus recovery through pinctrl optional
Message-ID: <1452842844-16256-1-git-send-email-leoyang.li@nxp.com>
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

Signed-off-by: Li Yang <leoyang.li@nxp.com>
Cc: Gao Pan <pandy.gao@nxp.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
v3:
Rebased to Wolfram's for-next branch
Added acked-by from Linus Walleij
Update to use new nxp email addresses due to company merge

 drivers/i2c/busses/i2c-imx.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a2b132c..1239bfa 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1081,8 +1081,11 @@ static int i2c_imx_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* optional bus recovery feature through pinctrl */
 	i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
-	if (IS_ERR(i2c_imx->pinctrl)) {
+	/* bailout on -ENOMEM or -EPROBE_DEFER, continue for other errors */
+	if (PTR_ERR(i2c_imx->pinctrl) == -ENOMEM ||
+			PTR_ERR(i2c_imx->pinctrl) == -EPROBE_DEFER) {
 		ret = PTR_ERR(i2c_imx->pinctrl);
 		goto clk_disable;
 	}
@@ -1125,7 +1128,10 @@ static int i2c_imx_probe(struct platform_device *pdev)
 			i2c_imx, IMX_I2C_I2CR);
 	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_I2SR);
 
-	i2c_imx_init_recovery_info(i2c_imx, pdev);
+	if (IS_ERR_OR_NULL(i2c_imx->pinctrl))
+		dev_info(&pdev->dev, "can't get pinctrl, bus recovery feature disabled\n");
+	else
+		i2c_imx_init_recovery_info(i2c_imx, pdev);
 
 	/* Add I2C adapter */
 	ret = i2c_add_numbered_adapter(&i2c_imx->adapter);
-- 
1.7.9.5
