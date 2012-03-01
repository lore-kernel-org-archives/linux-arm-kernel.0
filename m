From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu,  1 Mar 2012 14:10:24 +0800
Subject: [PATCH 4/8] i2c: pxa: add OF support
In-Reply-To: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
References: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1330582228-12424-5-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append these properties in below.
mrvl,i2c-polling
mrvl,i2c-mode

Still keep slave, slave_addr and class in platform data.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/i2c/busses/i2c-pxa.c |  101 ++++++++++++++++++++++++++++++++---------
 1 files changed, 79 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index d603646..883d14f 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -29,6 +29,8 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/i2c-pxa.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_i2c.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
@@ -1044,23 +1046,64 @@ static const struct i2c_algorithm i2c_pxa_pio_algorithm = {
 	.functionality	= i2c_pxa_functionality,
 };
 
-static int i2c_pxa_probe(struct platform_device *dev)
+static struct of_device_id i2c_pxa_dt_ids[] = {
+	{ .compatible = "mrvl,pxa-i2c", .data = &pxa_reg_layout[REGS_PXA2XX] },
+	{ .compatible = "mrvl,pwri2c", .data = &pxa_reg_layout[REGS_PXA3XX] },
+	{ .compatible = "mrvl,mmp-twsi", .data = &pxa_reg_layout[REGS_PXA2XX] },
+	{}
+};
+MODULE_DEVICE_TABLE(of, i2c_pxa_dt_ids);
+
+#ifdef CONFIG_OF
+static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
+			    enum pxa_i2c_types *i2c_types)
 {
-	struct pxa_i2c *i2c;
-	struct resource *res;
-	struct i2c_pxa_platform_data *plat = dev->dev.platform_data;
-	const struct platform_device_id *id = platform_get_device_id(dev);
-	enum pxa_i2c_types i2c_type = id->driver_data;
-	int ret;
-	int irq;
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id =
+			of_match_device(i2c_pxa_dt_ids, &pdev->dev);
+	const char *status;
+	int len;
+
+	if (of_get_property(np, "mrvl,i2c-polling", NULL))
+		i2c->use_pio = 1;
+	status = of_get_property(np, "mrvl,i2c-mode", &len);
+	if (status && len > 0)
+		if (!strcmp(status, "fast"))
+			i2c->fast_mode = 1;
+	*i2c_types = ((u32)(of_id->data) - (u32)&pxa_reg_layout[0])
+			/ sizeof(struct pxa_reg_layout);
+	return 0;
+}
+#else
+static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
+			    enum pxa_i2c_types *i2c_types)
+{
+	return 1;
+}
+#endif
 
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(dev, 0);
-	if (res == NULL || irq < 0)
-		return -ENODEV;
+static int i2c_pxa_probe_pdata(struct platform_device *pdev,
+			       struct pxa_i2c *i2c,
+			       enum pxa_i2c_types *i2c_types)
+{
+	struct i2c_pxa_platform_data *plat = pdev->dev.platform_data;
+	const struct platform_device_id *id = platform_get_device_id(pdev);
 
-	if (!request_mem_region(res->start, resource_size(res), res->name))
-		return -ENOMEM;
+	*i2c_types = id->driver_data;
+	if (plat) {
+		i2c->use_pio = plat->use_pio;
+		i2c->fast_mode = plat->fast_mode;
+	}
+	return 0;
+}
+
+static int i2c_pxa_probe(struct platform_device *dev)
+{
+	struct i2c_pxa_platform_data *plat = dev->dev.platform_data;
+	enum pxa_i2c_types i2c_type;
+	struct pxa_i2c *i2c;
+	struct resource *res = NULL;
+	int ret, irq;
 
 	i2c = kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
 	if (!i2c) {
@@ -1068,6 +1111,24 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		goto emalloc;
 	}
 
+	ret = i2c_pxa_probe_dt(dev, i2c, &i2c_type);
+	if (ret > 0)
+		ret = i2c_pxa_probe_pdata(dev, i2c, &i2c_type);
+	if (ret < 0)
+		goto eclk;
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(dev, 0);
+	if (res == NULL || irq < 0) {
+		ret = -ENODEV;
+		goto eclk;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res), res->name)) {
+		ret = -ENOMEM;
+		goto eclk;
+	}
+
 	i2c->adap.owner   = THIS_MODULE;
 	i2c->adap.retries = 5;
 
@@ -1109,21 +1170,16 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	i2c->slave_addr = I2C_PXA_SLAVE_ADDR;
 
-#ifdef CONFIG_I2C_PXA_SLAVE
 	if (plat) {
+#ifdef CONFIG_I2C_PXA_SLAVE
 		i2c->slave_addr = plat->slave_addr;
 		i2c->slave = plat->slave;
-	}
 #endif
-
-	clk_enable(i2c->clk);
-
-	if (plat) {
 		i2c->adap.class = plat->class;
-		i2c->use_pio = plat->use_pio;
-		i2c->fast_mode = plat->fast_mode;
 	}
 
+	clk_enable(i2c->clk);
+
 	if (i2c->use_pio) {
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
 	} else {
@@ -1234,6 +1290,7 @@ static struct platform_driver i2c_pxa_driver = {
 		.name	= "pxa2xx-i2c",
 		.owner	= THIS_MODULE,
 		.pm	= I2C_PXA_DEV_PM_OPS,
+		.of_match_table = i2c_pxa_dt_ids,
 	},
 	.id_table	= i2c_pxa_id_table,
 };
-- 
1.7.0.4
