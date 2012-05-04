From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  4 May 2012 19:23:11 +0100
Subject: [PATCH 01/15] i2c/busses: Add Device Tree support to the Nomadik I2C
 driver
In-Reply-To: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1336155805-18554-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we move the i2c-nomadik's default settings into the driver
rather than specifying them from platform code. At the time of
this writing we only have one user, the u8500. As new users are
added, it is expected that they will be Device Tree compliant.
If this is the case, we will look up their initialisation values
by compatible entry, then apply them forthwith.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   50 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 5267ab9..8803467 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -899,15 +899,57 @@ static const struct i2c_algorithm nmk_i2c_algo = {
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
+static const struct nmk_i2c_controller *
+nmk_i2c_find_pdata_from_compatible(struct device_node *np)
+{
+	/*
+	 * The u8500 is currently our only user. As more SoCs are added,
+	 * search for the correct value set using of_machine_is_compatible
+	 * and return a 'struct nmk_i2c_controller *' which contains the
+	 * correct information for the given SoC, whilst leaving u8500_i2c
+	 * as the default/fall-back value set.
+	 */
+	return &u8500_i2c;
+}
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
+		pdata = nmk_i2c_find_pdata_from_compatible(np);
+	}
+
 	dev = kzalloc(sizeof(struct nmk_i2c_dev), GFP_KERNEL);
 	if (!dev) {
 		dev_err(&pdev->dev, "cannot allocate memory\n");
@@ -1039,11 +1081,17 @@ static int __devexit nmk_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id nmk_gpio_match[] = {
+	{ .compatible = "st,nomadik-i2c", },
+	{}
+};
+
 static struct platform_driver nmk_i2c_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = DRIVER_NAME,
 		.pm = &nmk_i2c_pm,
+		.of_match_table = nmk_gpio_match,
 	},
 	.probe = nmk_i2c_probe,
 	.remove = __devexit_p(nmk_i2c_remove),
-- 
1.7.9.5
