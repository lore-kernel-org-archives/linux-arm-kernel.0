From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  8 Jul 2011 18:20:23 +0800
Subject: [PATCH] i2c: pxa: create dynamic platform device from device tree
In-Reply-To: <1310120428-22700-6-git-send-email-haojian.zhuang@marvell.com>
References: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-3-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-4-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-5-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-6-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1310120428-22700-7-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create two probe function to support both current platform device and created
dynamic platform device from device tree. After moving to device tree,
original implementation of platform device will be removed.

Use property to present polling mode and frequency mode.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/i2c/busses/i2c-pxa.c |  163 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 163 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index d603646..7a6d774 100644
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
@@ -1044,6 +1045,162 @@ static const struct i2c_algorithm i2c_pxa_pio_algorithm = {
 	.functionality	= i2c_pxa_functionality,
 };
 
+static const struct of_device_id pxa_i2c_of_match[] = {
+	{ .compatible = "pxa2xx-i2c",	.data = (void *)REGS_PXA2XX, },
+	{ .compatible = "pxa3xx-pwri2c", .data = (void *)REGS_PXA3XX, },
+	{ .compatible = "ce4100-i2c",	.data = (void *)REGS_CE4100, },
+	{},
+};
+
+#ifdef CONFIG_OF
+static int i2c_pxa_of_probe(struct platform_device *of_dev)
+{
+	struct device_node *np = of_dev->dev.of_node;
+	const struct of_device_id *match;
+	struct i2c_pxa_platform_data *plat = NULL;
+	struct pxa_i2c *i2c;
+	struct resource *res;
+	const __be32 *p;
+	int i2c_type, irq, data, ret;
+	int id = 0, poll = 0, fast = 0;
+
+	match = of_match_device(pxa_i2c_of_match, &of_dev->dev);
+	if (match == NULL)
+		return -ENODEV;
+	i2c_type = (int)match->data;
+
+	p = of_get_property(np, "cell-index", &data);
+	if (p)
+		id = be32_to_cpu(*p);
+
+	p = of_get_property(np, "i2c-polling", &data);
+	if (p)
+		poll = be32_to_cpu(*p);
+
+	p = of_get_property(np, "i2c-frequency", &data);
+	if (p && !strncmp((char *)p, "fast", data))
+		fast = 1;
+
+	res = platform_get_resource(of_dev, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(of_dev, 0);
+	if (res == NULL || irq < 0)
+		return -ENODEV;
+
+	if (!request_mem_region(res->start, resource_size(res), res->name))
+		return -ENOMEM;
+
+	i2c = kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
+	if (!i2c) {
+		ret = -ENOMEM;
+		goto emalloc;
+	}
+
+	i2c->adap.owner   = THIS_MODULE;
+	i2c->adap.retries = 5;
+
+	spin_lock_init(&i2c->lock);
+	init_waitqueue_head(&i2c->wait);
+
+	/*
+	 * adap.nr comes from cell-index in dts file
+	 */
+	i2c->adap.nr = id;
+	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "pxa2xx-i2c.%u",
+		 i2c->adap.nr);
+
+	i2c->clk = clk_get_sys(i2c->adap.name, NULL);
+	if (IS_ERR(i2c->clk)) {
+		ret = PTR_ERR(i2c->clk);
+		goto eclk;
+	}
+
+	i2c->reg_base = ioremap(res->start, resource_size(res));
+	if (!i2c->reg_base) {
+		ret = -EIO;
+		goto eremap;
+	}
+
+	i2c->reg_ibmr = i2c->reg_base + pxa_reg_layout[i2c_type].ibmr;
+	i2c->reg_idbr = i2c->reg_base + pxa_reg_layout[i2c_type].idbr;
+	i2c->reg_icr = i2c->reg_base + pxa_reg_layout[i2c_type].icr;
+	i2c->reg_isr = i2c->reg_base + pxa_reg_layout[i2c_type].isr;
+	if (i2c_type != REGS_CE4100)
+		i2c->reg_isar = i2c->reg_base + pxa_reg_layout[i2c_type].isar;
+
+	i2c->iobase = res->start;
+	i2c->iosize = resource_size(res);
+
+	i2c->irq = irq;
+	i2c->use_pio = poll;
+	i2c->fast_mode = fast;
+
+	i2c->slave_addr = I2C_PXA_SLAVE_ADDR;
+
+#ifdef CONFIG_I2C_PXA_SLAVE
+	if (plat) {
+		i2c->slave_addr = plat->slave_addr;
+		i2c->slave = plat->slave;
+	}
+#endif
+
+	clk_enable(i2c->clk);
+
+	if (plat)
+		i2c->adap.class = plat->class;
+
+	if (i2c->use_pio) {
+		i2c->adap.algo = &i2c_pxa_pio_algorithm;
+	} else {
+		i2c->adap.algo = &i2c_pxa_algorithm;
+		ret = request_irq(irq, i2c_pxa_handler, IRQF_SHARED,
+				  i2c->adap.name, i2c);
+		if (ret)
+			goto ereqirq;
+	}
+
+	i2c_pxa_reset(i2c);
+
+	i2c->adap.algo_data = i2c;
+	i2c->adap.dev.parent = &of_dev->dev;
+	i2c->adap.dev.of_node = of_dev->dev.of_node;
+
+	if (i2c_type == REGS_CE4100)
+		ret = i2c_add_adapter(&i2c->adap);
+	else
+		ret = i2c_add_numbered_adapter(&i2c->adap);
+	if (ret < 0) {
+		printk(KERN_INFO "I2C: Failed to add bus\n");
+		goto eadapt;
+	}
+	of_i2c_register_devices(&i2c->adap);
+
+	platform_set_drvdata(of_dev, i2c);
+
+#ifdef CONFIG_I2C_PXA_SLAVE
+	printk(KERN_INFO "I2C: %s: PXA I2C adapter, slave address %d\n",
+	       dev_name(&i2c->adap.dev), i2c->slave_addr);
+#else
+	printk(KERN_INFO "I2C: %s: PXA I2C adapter\n",
+	       dev_name(&i2c->adap.dev));
+#endif
+	return 0;
+
+eadapt:
+	if (!i2c->use_pio)
+		free_irq(irq, i2c);
+ereqirq:
+	clk_disable(i2c->clk);
+	iounmap(i2c->reg_base);
+eremap:
+	clk_put(i2c->clk);
+eclk:
+	kfree(i2c);
+emalloc:
+	release_mem_region(res->start, resource_size(res));
+	return ret;
+}
+#else
+
 static int i2c_pxa_probe(struct platform_device *dev)
 {
 	struct pxa_i2c *i2c;
@@ -1174,6 +1331,7 @@ emalloc:
 	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
+#endif
 
 static int __exit i2c_pxa_remove(struct platform_device *dev)
 {
@@ -1228,12 +1386,17 @@ static const struct dev_pm_ops i2c_pxa_dev_pm_ops = {
 #endif
 
 static struct platform_driver i2c_pxa_driver = {
+#ifdef CONFIG_OF
+	.probe		= i2c_pxa_of_probe,
+#else
 	.probe		= i2c_pxa_probe,
+#endif
 	.remove		= __exit_p(i2c_pxa_remove),
 	.driver		= {
 		.name	= "pxa2xx-i2c",
 		.owner	= THIS_MODULE,
 		.pm	= I2C_PXA_DEV_PM_OPS,
+		.of_match_table	= pxa_i2c_of_match,
 	},
 	.id_table	= i2c_pxa_id_table,
 };
-- 
1.5.6.5
