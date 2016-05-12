From: chunkeey@googlemail.com (Christian Lamparter)
Date: Thu, 12 May 2016 21:28:09 +0200
Subject: [PATCH v9.1] gpio: mmio: add DT support for memory-mapped GPIOs
In-Reply-To: <0a1ab2b6-b4c5-44d7-abb4-ce1e9da7e477@gmail.com>
References: <0a1ab2b6-b4c5-44d7-abb4-ce1e9da7e477@gmail.com>
Message-ID: <3e75e8316ceac62f61f3ffc839faaac8789ca936.1463078228.git.chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ?lvaro Fern?ndez Rojas <noltari@gmail.com>

This patch adds support for defining memory-mapped GPIOs which
are compatible with the existing gpio-mmio interface. The generic
library provides support for many memory-mapped GPIO controllers
that are found in various on-board FPGA and ASIC solutions that
are used to control board's switches, LEDs, chip-selects,
Ethernet/USB PHY power, etc.

For setting GPIOs there are three configurations:
	1. single input/output register resource (named "dat"),
	2. set/clear pair (named "set" and "clr"),
	3. single output register resource and single input resource
	   ("set" and dat").

The configuration is detected by which resources are present.
For the single output register, this drives a 1 by setting a bit
and a zero by clearing a bit.  For the set clr pair, this drives
a 1 by setting a bit in the set register and clears it by setting
a bit in the clear register.

For setting the GPIO direction, there are three configurations:
	a. simple bidirectional GPIOs that requires no configuration.
	b. an output direction register (named "dirout")
	   where a 1 bit indicates the GPIO is an output.
	c. an input direction register (named "dirin")
	   where a 1 bit indicates the GPIO is an input.

The first user for this binding is "wd,mbl-gpio".

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 drivers/gpio/gpio-mmio.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index 6c1cb3b..f72e40e 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -61,6 +61,8 @@ o        `                     ~~~~\___/~~~~    ` controller in FPGA is ,.`
 #include <linux/bitops.h>
 #include <linux/platform_device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 static void bgpio_write8(void __iomem *reg, unsigned long data)
 {
@@ -569,6 +571,58 @@ static void __iomem *bgpio_map(struct platform_device *pdev,
 	return devm_ioremap_resource(&pdev->dev, r);
 }
 
+#ifdef CONFIG_OF
+static int bgpio_basic_mmio_parse_dt(struct platform_device *pdev,
+				     struct bgpio_pdata *pdata,
+				     unsigned long *flags)
+{
+	struct device *dev = &pdev->dev;
+
+	pdata->base = -1;
+
+	if (of_property_read_bool(dev->of_node, "no-output"))
+		*flags |= BGPIOF_NO_OUTPUT;
+
+	return 0;
+}
+
+static const struct of_device_id bgpio_of_match[] = {
+	{ .compatible = "wd,mbl-gpio", .data = bgpio_basic_mmio_parse_dt },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bgpio_of_match);
+
+static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
+					  unsigned long *flags)
+{
+	const int (*parse_dt)(struct platform_device *,
+			      struct bgpio_pdata *, unsigned long *);
+	struct bgpio_pdata *pdata;
+	int err;
+
+	parse_dt = of_device_get_match_data(&pdev->dev);
+	if (!parse_dt)
+		return NULL;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bgpio_pdata),
+			     GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	err = parse_dt(pdev, pdata, flags);
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
@@ -579,10 +633,19 @@ static int bgpio_pdev_probe(struct platform_device *pdev)
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
@@ -646,6 +709,7 @@ MODULE_DEVICE_TABLE(platform, bgpio_id_table);
 static struct platform_driver bgpio_driver = {
 	.driver = {
 		.name = "basic-mmio-gpio",
+		.of_match_table = of_match_ptr(bgpio_of_match),
 	},
 	.id_table = bgpio_id_table,
 	.probe = bgpio_pdev_probe,
-- 
2.8.1
