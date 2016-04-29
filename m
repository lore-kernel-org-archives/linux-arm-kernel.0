From: chunkeey@googlemail.com (Christian Lamparter)
Date: Fri, 29 Apr 2016 02:53:15 +0200
Subject: [RFC v5 2/4] gpio: generic: add DT support for generic memory-mapped
 GPIOs
In-Reply-To: <cover.1461888822.git.chunkeey@googlemail.com>
References: <cover.1461888822.git.chunkeey@googlemail.com>
Message-ID: <240c85fbbedbe3fa3c4b23da9a804e4ece98786d.1461888822.git.chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ?lvaro Fern?ndez Rojas <noltari@gmail.com>

This patch adds support for defining memory-mapped GPIOs
which provide a compatible interface for the existing
generic-gpio driver.

Signed-off-by: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 drivers/gpio/gpio-generic.c | 98 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-generic.c
index 6c1cb3b..129c3ba 100644
--- a/drivers/gpio/gpio-generic.c
+++ b/drivers/gpio/gpio-generic.c
@@ -61,6 +61,8 @@ o        `                     ~~~~\___/~~~~    ` controller in FPGA is ,.`
 #include <linux/bitops.h>
 #include <linux/platform_device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 static void bgpio_write8(void __iomem *reg, unsigned long data)
 {
@@ -569,6 +571,88 @@ static void __iomem *bgpio_map(struct platform_device *pdev,
 	return devm_ioremap_resource(&pdev->dev, r);
 }
 
+#ifdef CONFIG_OF
+static int bgpio_basic_mmio_parse_dt(struct platform_device *pdev,
+				     struct bgpio_pdata *pdata,
+				     unsigned long *flags)
+{
+	struct device *dev = &pdev->dev;
+	int err;
+
+	/* If ngpio property is not specified, of_property_read_u32
+	 * will return -EINVAL. In this case the number of GPIOs is
+	 * automatically determined by the register width. Any
+	 * other error of of_property_read_u32 is due bad data and
+	 * needs to be dealt with.
+	 */
+	err = of_property_read_u32(dev->of_node, "ngpio", &pdata->ngpio);
+	if (err && err != -EINVAL)
+		return err;
+
+	if (of_device_is_big_endian(dev->of_node))
+		*flags |= BGPIOF_BIG_ENDIAN_BYTE_ORDER;
+
+	if (of_property_read_bool(dev->of_node, "unreadable-reg-set"))
+		*flags |= BGPIOF_UNREADABLE_REG_SET;
+
+	if (of_property_read_bool(dev->of_node, "unreadable-reg-dir"))
+		*flags |= BGPIOF_UNREADABLE_REG_DIR;
+
+	if (of_property_read_bool(dev->of_node, "big-endian-byte-order"))
+		*flags |= BGPIOF_BIG_ENDIAN;
+
+	if (of_property_read_bool(dev->of_node, "read-output-reg-set"))
+		*flags |= BGPIOF_READ_OUTPUT_REG_SET;
+
+	if (of_property_read_bool(dev->of_node, "no-output"))
+		*flags |= BGPIOF_NO_OUTPUT;
+	return 0;
+}
+
+#define ADD(_name, _func) { .compatible = _name, .data = _func }
+
+static const struct of_device_id bgpio_of_match[] = {
+	ADD("linux,gpio-mmio", bgpio_basic_mmio_parse_dt),
+	{ }
+};
+#undef ADD
+MODULE_DEVICE_TABLE(of, bgpio_of_match);
+
+static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
+					  unsigned long *flags)
+{
+	int (*parse_dt)(struct platform_device *,
+			struct bgpio_pdata *, unsigned long *);
+	const struct device_node *node = pdev->dev.of_node;
+	const struct of_device_id *of_id;
+	struct bgpio_pdata *pdata;
+	int err = -ENODEV;
+
+	of_id = of_match_node(bgpio_of_match, node);
+	if (!of_id)
+		return NULL;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bgpio_pdata),
+			     GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	parse_dt = of_id->data;
+	if (parse_dt)
+		err = parse_dt(pdev, pdata, flags);
+	if (err)
+		return ERR_PTR(err);
+
+	return pdata;
+}
+#else
+static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
+					  unsigned long *flags)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
 static int bgpio_pdev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -579,10 +663,19 @@ static int bgpio_pdev_probe(struct platform_device *pdev)
 	void __iomem *dirout;
 	void __iomem *dirin;
 	unsigned long sz;
-	unsigned long flags = pdev->id_entry->driver_data;
+	unsigned long flags = 0;
 	int err;
 	struct gpio_chip *gc;
-	struct bgpio_pdata *pdata = dev_get_platdata(dev);
+	struct bgpio_pdata *pdata;
+
+	pdata = bgpio_parse_dt(pdev, &flags);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+
+	if (!pdata) {
+		pdata = dev_get_platdata(dev);
+		flags = pdev->id_entry->driver_data;
+	}
 
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dat");
 	if (!r)
@@ -646,6 +739,7 @@ MODULE_DEVICE_TABLE(platform, bgpio_id_table);
 static struct platform_driver bgpio_driver = {
 	.driver = {
 		.name = "basic-mmio-gpio",
+		.of_match_table = of_match_ptr(bgpio_of_match),
 	},
 	.id_table = bgpio_id_table,
 	.probe = bgpio_pdev_probe,
-- 
2.8.1
