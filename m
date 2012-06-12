From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jun 2012 09:52:39 +0100
Subject: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C
 driver
In-Reply-To: <20120611190550.GK3887@pengutronix.de>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <20120611190550.GK3887@pengutronix.de>
Message-ID: <4FD70357.9060905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 17 Apr 2012 16:04:13 +0100
Subject: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C driver

Here we move the i2c-nomadik's default settings into the driver
rather than specifying them from platform code. At the time of
this writing we only have one user, the u8500. As new users are
added, it is expected that they will be Device Tree compliant.
If this is the case, we will look up their initialisation values
by compatible entry, then apply them forthwith.

Cc: linux-i2c at vger.kernel.org
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index a92440d..23fde19 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/of_device.h>
 
 #include <plat/i2c.h>
 
@@ -899,15 +900,44 @@ static const struct i2c_algorithm nmk_i2c_algo = {
 	.functionality	= nmk_i2c_functionality
 };
 
+static struct nmk_i2c_controller u8500_i2c = {
+	/*
+	 * Slave data setup time; 250ns, 100ns, and 10ns, which
+	 * is 14, 6 and 2 respectively for a 48Mhz i2c clock.
+	 */
+	.slsu           = 0xe,
+	.tft            = 1, 	  /* Tx FIFO threshold */
+	.rft            = 8, 	  /* Rx FIFO threshold */
+	.clk_freq       = 100000, /* std. mode operation */
+	.timeout        = 200, 	  /* Slave response timeout(ms) */
+	.sm             = I2C_FREQ_MODE_FAST,
+};
+
+static const struct of_device_id nmk_gpio_match[] = {
+	{ .compatible = "st,nomadik-i2c", .data = &u8500_i2c, },
+	{}
+};
+
 static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	struct resource *res;
-	struct nmk_i2c_controller *pdata =
+	const struct nmk_i2c_controller *pdata =
 			pdev->dev.platform_data;
+        const struct of_device_id *of_id =
+                        of_match_device(nmk_gpio_match, &pdev->dev);
 	struct nmk_i2c_dev	*dev;
 	struct i2c_adapter *adap;
 
+	if (!pdata) {
+		if (of_id && of_id->data)
+			/* Looks like we're booting via Device Tree. */
+			pdata = of_id->data;
+		else
+			/* No i2c configuration found, using the default. */
+			pdata = &u8500_i2c;
+	}
+
 	dev = kzalloc(sizeof(struct nmk_i2c_dev), GFP_KERNEL);
 	if (!dev) {
 		dev_err(&pdev->dev, "cannot allocate memory\n");
@@ -1043,6 +1073,7 @@ static struct platform_driver nmk_i2c_driver = {
 		.owner = THIS_MODULE,
 		.name = DRIVER_NAME,
 		.pm = &nmk_i2c_pm,
+		.of_match_table = nmk_gpio_match,
 	},
 	.probe = nmk_i2c_probe,
 	.remove = __devexit_p(nmk_i2c_remove),
-- 
1.7.9.5
