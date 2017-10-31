From: preid@electromag.com.au (Phil Reid)
Date: Tue, 31 Oct 2017 15:33:57 +0800
Subject: [PATCH v4 5/7] i2c: imx: switch to using gpiod for bus recovery gpios
In-Reply-To: <1509435239-64848-1-git-send-email-preid@electromag.com.au>
References: <1509435239-64848-1-git-send-email-preid@electromag.com.au>
Message-ID: <1509435239-64848-6-git-send-email-preid@electromag.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the driver to use the gpio descriptors for the bus recovery
information instead of the deprecated integer interface.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/busses/i2c-imx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index f96830f..c4cf265 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1006,26 +1006,26 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 			PINCTRL_STATE_DEFAULT);
 	i2c_imx->pinctrl_pins_gpio = pinctrl_lookup_state(i2c_imx->pinctrl,
 			"gpio");
-	rinfo->sda_gpio = of_get_named_gpio(pdev->dev.of_node, "sda-gpios", 0);
-	rinfo->scl_gpio = of_get_named_gpio(pdev->dev.of_node, "scl-gpios", 0);
+	rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_OUT_HIGH);
+	rinfo->scl_gpiod = devm_gpiod_get(&pdev->dev, "scl", GPIOD_IN);
 
-	if (rinfo->sda_gpio == -EPROBE_DEFER ||
-	    rinfo->scl_gpio == -EPROBE_DEFER) {
+	if (PTR_ERR(rinfo->sda_gpiod) == -EPROBE_DEFER ||
+	    PTR_ERR(rinfo->scl_gpiod) == -EPROBE_DEFER) {
 		return -EPROBE_DEFER;
-	} else if (!gpio_is_valid(rinfo->sda_gpio) ||
-		   !gpio_is_valid(rinfo->scl_gpio) ||
+	} else if (IS_ERR(rinfo->sda_gpiod) ||
+		   IS_ERR(rinfo->scl_gpiod) ||
 		   IS_ERR(i2c_imx->pinctrl_pins_default) ||
 		   IS_ERR(i2c_imx->pinctrl_pins_gpio)) {
 		dev_dbg(&pdev->dev, "recovery information incomplete\n");
 		return 0;
 	}
 
-	dev_dbg(&pdev->dev, "using scl-gpio %d and sda-gpio %d for recovery\n",
-			rinfo->scl_gpio, rinfo->sda_gpio);
+	dev_dbg(&pdev->dev, "using scl%s for recovery\n",
+		rinfo->sda_gpiod ? ",sda" : "");
 
 	rinfo->prepare_recovery = i2c_imx_prepare_recovery;
 	rinfo->unprepare_recovery = i2c_imx_unprepare_recovery;
-	rinfo->recover_bus = i2c_generic_gpio_recovery;
+	rinfo->recover_bus = i2c_generic_scl_recovery;
 	i2c_imx->adapter.bus_recovery_info = rinfo;
 
 	return 0;
-- 
1.8.3.1
