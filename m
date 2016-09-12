From: leoyang.li@nxp.com (Li Yang)
Date: Mon, 12 Sep 2016 17:22:30 -0500
Subject: [PATCH v7] i2c: imx: make bus recovery through pinctrl optional
Message-ID: <1473718950-6667-1-git-send-email-leoyang.li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 1c4b6c3bcf30 ("i2c: imx: implement bus recovery") the
driver starts to use gpio/pinctrl to support optional bus recovery
feature.  But pinctrl is not always usable.  There are platforms such
as ls1021a and ls1043a that don't support pinctrl, and it could just
be broken due to old/broken device tree.  The patch makes it really
optional that the probe function won't bailout on pinctrl problems
instead it just disables bus recovery and prints out notification when
there is problem with pinctrl.  Since pinctrl is only used by bus
recovery in this driver, move pinctrl initialization into bus recovery
init function to prevent confusion.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
Cc: Gao Pan <pandy.gao@nxp.com>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
v7:
Move pinctrl init into the i2c_imx_init_recovery_info()
Update commit message and code comment

v6:
Update code comment

v5:
Revert the last minute change of recovery info initialization timing, it
will cause problem if initialized after i2c_add_numbered_adapter()

v4:
Remove the use of IS_ERR_OR_NULL
Move the condition judgement to i2c_imx_init_recovery_info()
Change the timing of recovery initialization to be after bus registration

v3:
Rebased to Wolfram's for-next branch
Added acked-by from Linus Walleij
Update to use new nxp email addresses due to company merge

 drivers/i2c/busses/i2c-imx.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 1844bc9..54ce9c1 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -984,11 +984,24 @@ static void i2c_imx_unprepare_recovery(struct i2c_adapter *adap)
 	pinctrl_select_state(i2c_imx->pinctrl, i2c_imx->pinctrl_pins_default);
 }
 
-static void i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
+/*
+ * We switch SCL and SDA to their GPIO function and do some bitbanging
+ * for bus recovery. These alternative pinmux settings can be
+ * described in the device tree by a separate pinctrl state "gpio". If
+ * this is missing this is not a big problem, the only implication is
+ * that we can't do bus recovery.
+ */
+static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 		struct platform_device *pdev)
 {
 	struct i2c_bus_recovery_info *rinfo = &i2c_imx->rinfo;
 
+	i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!i2c_imx->pinctrl || IS_ERR(i2c_imx->pinctrl)) {
+		dev_info(&pdev->dev, "can't get pinctrl, bus recovery not supported\n");
+		return PTR_ERR(i2c_imx->pinctrl);
+	}
+
 	i2c_imx->pinctrl_pins_default = pinctrl_lookup_state(i2c_imx->pinctrl,
 			PINCTRL_STATE_DEFAULT);
 	i2c_imx->pinctrl_pins_gpio = pinctrl_lookup_state(i2c_imx->pinctrl,
@@ -1001,7 +1014,7 @@ static void i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 	    IS_ERR(i2c_imx->pinctrl_pins_default) ||
 	    IS_ERR(i2c_imx->pinctrl_pins_gpio)) {
 		dev_dbg(&pdev->dev, "recovery information incomplete\n");
-		return;
+		return 0;
 	}
 
 	dev_dbg(&pdev->dev, "using scl-gpio %d and sda-gpio %d for recovery\n",
@@ -1011,6 +1024,8 @@ static void i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 	rinfo->unprepare_recovery = i2c_imx_unprepare_recovery;
 	rinfo->recover_bus = i2c_generic_gpio_recovery;
 	i2c_imx->adapter.bus_recovery_info = rinfo;
+
+	return 0;
 }
 
 static u32 i2c_imx_func(struct i2c_adapter *adapter)
@@ -1081,12 +1096,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
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
@@ -1125,7 +1134,11 @@ static int i2c_imx_probe(struct platform_device *pdev)
 			i2c_imx, IMX_I2C_I2CR);
 	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_I2SR);
 
-	i2c_imx_init_recovery_info(i2c_imx, pdev);
+	/* Init optional bus recovery function */
+	ret = i2c_imx_init_recovery_info(i2c_imx, pdev);
+	/* Give it another chance if pinctrl used is not ready yet */
+	if (ret == -EPROBE_DEFER)
+		goto rpm_disable;
 
 	/* Add I2C adapter */
 	ret = i2c_add_numbered_adapter(&i2c_imx->adapter);
-- 
1.9.0
