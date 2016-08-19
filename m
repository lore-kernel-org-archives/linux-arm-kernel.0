From: leoyang.li@nxp.com (Li Yang)
Date: Fri, 19 Aug 2016 15:49:25 -0500
Subject: [PATCH v4] i2c: imx: make bus recovery through pinctrl optional
Message-ID: <1471639765-4461-1-git-send-email-leoyang.li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 1c4b6c3bcf30 ("i2c: imx: implement bus recovery") the
driver starts to use gpio/pinctrl to do i2c bus recovery.  But pinctrl
is not always available for platforms using this driver such as ls1021a
and ls1043a, and the device tree binding also mentioned this gpio based
recovery mechanism as optional.  The patch make it really optional that
the probe function won't bailout when pinctrl is not available and it
won't try to register recovery functions if pinctrl is NULL when the
PINCTRL is not enabled at all.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
Cc: Gao Pan <pandy.gao@nxp.com>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
I lost track of the origin patch, but problem really shows up
in testing when PINCTRL is enabled in kernel config.  So here is
the updated patch.

v4:
Remove the use of IS_ERR_OR_NULL
Move the condition judgement to i2c_imx_init_recovery_info()
Change the timing of recovery initialization to be after bus registration

v3:
Rebased to Wolfram's for-next branch
Added acked-by from Linus Walleij
Update to use new nxp email addresses due to company merge

 drivers/i2c/busses/i2c-imx.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 1844bc9..00ac4c2 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -989,6 +989,15 @@ static void i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 {
 	struct i2c_bus_recovery_info *rinfo = &i2c_imx->rinfo;
 
+	/* if pinctrl is not supported on the system */
+	if (IS_ERR(i2c_imx->pinctrl))
+		i2c_imx->pinctrl = NULL;
+
+	if (!i2c_imx->pinctrl) {
+		dev_info(&i2c_imx->adapter.dev, "can't get pinctrl, bus recovery not supported\n");
+		return;
+	}
+
 	i2c_imx->pinctrl_pins_default = pinctrl_lookup_state(i2c_imx->pinctrl,
 			PINCTRL_STATE_DEFAULT);
 	i2c_imx->pinctrl_pins_gpio = pinctrl_lookup_state(i2c_imx->pinctrl,
@@ -1081,8 +1090,11 @@ static int i2c_imx_probe(struct platform_device *pdev)
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
@@ -1125,8 +1137,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
 			i2c_imx, IMX_I2C_I2CR);
 	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_I2SR);
 
-	i2c_imx_init_recovery_info(i2c_imx, pdev);
-
 	/* Add I2C adapter */
 	ret = i2c_add_numbered_adapter(&i2c_imx->adapter);
 	if (ret < 0) {
@@ -1146,6 +1156,9 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	/* Init DMA config if supported */
 	i2c_imx_dma_request(i2c_imx, phy_addr);
 
+	/* Init bus recovery if supported */
+	i2c_imx_init_recovery_info(i2c_imx, pdev);
+
 	return 0;   /* Return OK */
 
 rpm_disable:
-- 
1.9.0
