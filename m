From: lee.jones@linaro.org (Lee Jones)
Date: Sat, 05 May 2012 07:17:14 +0100
Subject: [PATCH 01/15] i2c/busses: Add Device Tree support to the Nomadik
 I2C driver
In-Reply-To: <201205042002.20943.arnd@arndb.de>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-2-git-send-email-lee.jones@linaro.org>
 <201205042002.20943.arnd@arndb.de>
Message-ID: <4FA4C5EA.7030006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I haven't tested it yet (it builds with no warnings/errors, but I
haven't booted it), as I don't have my board immediately to hand,
but does this kind of thing better suit what you're looking for?

From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 17 Apr 2012 16:04:13 +0100
Subject: [PATCH 01/15] i2c/busses: Add Device Tree support to the Nomadik I2C
 driver

Here we move the i2c-nomadik's default settings into the driver
rather than specifying them from platform code. At the time of
this writing we only have one user, the u8500. As new users are
added, it is expected that they will be Device Tree compliant.
If this is the case, we will look up their initialisation values
by compatible entry, then apply them forthwith.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   42 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 5267ab9..3478a13 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/of_device.h>
 
 #include <plat/i2c.h>
 
@@ -899,15 +900,53 @@ static const struct i2c_algorithm nmk_i2c_algo = {
 	.functionality	= nmk_i2c_functionality
 };
 
+static const struct nmk_i2c_controller u8500_i2c = {
+       /*
+        * slave data setup time, which is
+        * 250 ns,100ns,10ns which is 14,6,2
+        * respectively for a 48 Mhz
+        * i2c clock
+        */
+       .slsu           = 0xe,
+       /* Tx FIFO threshold */
+       .tft            = 1,
+       /* Rx FIFO threshold */
+       .rft            = 8,
+       /* std. mode operation */
+       .clk_freq       = 100000,
+       /* Slave response timeout(ms) */
+       .timeout        = 200,
+       .sm             = I2C_FREQ_MODE_FAST,
+};
+
+static const struct of_device_id nmk_gpio_match[] = {
+	{ .compatible = "stericsson,db8500-i2c", .data = (void *)&u8500_i2c, },
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
+	struct device_node *np = pdev->dev.of_node;
 	struct nmk_i2c_dev	*dev;
 	struct i2c_adapter *adap;
 
+	if (!pdata) {
+		if (!np) {
+			dev_err(&pdev->dev,
+				"Neither platform_data nor Device Tree not found\n");
+			return -EINVAL;
+		}
+		/* Try to fetch supplied i2c configuration from the match table. */
+		pdata = of_match_device(nmk_gpio_match, &pdev->dev)->data;
+		/* If no configuration was supplied, use the default. */
+		if (!pdata)
+			pdata = &u8500_i2c;
+	}
+
 	dev = kzalloc(sizeof(struct nmk_i2c_dev), GFP_KERNEL);
 	if (!dev) {
 		dev_err(&pdev->dev, "cannot allocate memory\n");
@@ -1044,6 +1083,7 @@ static struct platform_driver nmk_i2c_driver = {
 		.owner = THIS_MODULE,
 		.name = DRIVER_NAME,
 		.pm = &nmk_i2c_pm,
+		.of_match_table = nmk_gpio_match,
 	},
 	.probe = nmk_i2c_probe,
 	.remove = __devexit_p(nmk_i2c_remove),
-- 
1.7.9.5
