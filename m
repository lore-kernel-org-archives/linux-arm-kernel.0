From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 28 Jul 2011 14:41:32 +0800
Subject: [PATCH v2 6/7] i2c: pxa: support i2c controller from DT
In-Reply-To: <1311835293-18125-6-git-send-email-haojian.zhuang@marvell.com>
References: <1311835293-18125-1-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-2-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-3-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-4-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-5-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-6-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1311835293-18125-7-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

support i2c-pxa controller from DT.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/i2c/busses/i2c-pxa.c |   51 +++++++++++++++++++++++++++++++----------
 1 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index d603646..8c27733 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -29,6 +29,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/i2c-pxa.h>
+#include <linux/of_device.h>
 #include <linux/of_i2c.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
@@ -1044,15 +1045,31 @@ static const struct i2c_algorithm i2c_pxa_pio_algorithm = {
 	.functionality	= i2c_pxa_functionality,
 };
 
+static const struct of_device_id pxa_i2c_of_match[] = {
+	{ .compatible = "mrvl,pxa255-i2c",    .data = (void *)REGS_PXA2XX, },
+	{ .compatible = "mrvl,pxa300-pwri2c", .data = (void *)REGS_PXA3XX, },
+	{},
+};
+
 static int i2c_pxa_probe(struct platform_device *dev)
 {
+	struct device_node *np = dev->dev.of_node;
+	const struct of_device_id *match;
 	struct pxa_i2c *i2c;
-	struct resource *res;
 	struct i2c_pxa_platform_data *plat = dev->dev.platform_data;
 	const struct platform_device_id *id = platform_get_device_id(dev);
-	enum pxa_i2c_types i2c_type = id->driver_data;
-	int ret;
-	int irq;
+	enum pxa_i2c_types i2c_type;
+	struct resource *res;
+	int irq, ret;
+	static int idx = 0;
+
+	if (np) {
+		match = of_match_device(pxa_i2c_of_match, &dev->dev);
+		if (match == NULL)
+			return -ENODEV;
+		i2c_type = (int)match->data;
+	} else
+		i2c_type = id->driver_data;
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(dev, 0);
@@ -1074,16 +1091,23 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	spin_lock_init(&i2c->lock);
 	init_waitqueue_head(&i2c->wait);
 
-	/*
-	 * If "dev->id" is negative we consider it as zero.
-	 * The reason to do so is to avoid sysfs names that only make
-	 * sense when there are multiple adapters.
-	 */
-	i2c->adap.nr = dev->id;
-	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "pxa_i2c-i2c.%u",
-		 i2c->adap.nr);
 
-	i2c->clk = clk_get(&dev->dev, NULL);
+	if (np) {
+		i2c->adap.nr = idx++;
+		snprintf(i2c->adap.name, sizeof(i2c->adap.name),
+			"pxa2xx-i2c.%u", i2c->adap.nr);
+		i2c->clk = clk_get_sys(i2c->adap.name, NULL);
+	} else {
+		/*
+		 * If "dev->id" is negative we consider it as zero.
+		 * The reason to do so is to avoid sysfs names that only make
+		 * sense when there are multiple adapters.
+		 */
+		i2c->adap.nr = dev->id;
+		snprintf(i2c->adap.name, sizeof(i2c->adap.name),
+			"pxa_i2c-i2c.%u", i2c->adap.nr);
+		i2c->clk = clk_get(&dev->dev, NULL);
+	}
 	if (IS_ERR(i2c->clk)) {
 		ret = PTR_ERR(i2c->clk);
 		goto eclk;
@@ -1234,6 +1258,7 @@ static struct platform_driver i2c_pxa_driver = {
 		.name	= "pxa2xx-i2c",
 		.owner	= THIS_MODULE,
 		.pm	= I2C_PXA_DEV_PM_OPS,
+		.of_match_table	= pxa_i2c_of_match,
 	},
 	.id_table	= i2c_pxa_id_table,
 };
-- 
1.5.6.5
