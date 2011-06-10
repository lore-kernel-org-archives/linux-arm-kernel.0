From: robherring2@gmail.com (Rob Herring)
Date: Fri, 10 Jun 2011 15:48:42 -0500
Subject: [PATCH v4 3/4] drivers/amba: create devices from device tree
In-Reply-To: <1307738923-7564-1-git-send-email-robherring2@gmail.com>
References: <1307738923-7564-1-git-send-email-robherring2@gmail.com>
Message-ID: <1307738923-7564-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add a function to create amba bus devices (i.e. primecell peripherals) from
device tree nodes. The device tree scanning is done by
of_platform_probe/populate functions which can call of_amba_device_create
based on a match table entry.

Nodes with a "arm,amba-deviceid" property can override the h/w peripheral id
value.

Based on the original work by Jeremy Kerr.

Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: linux at arm.linux.org.uk
Cc: arnd at arndb.de
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 Documentation/devicetree/bindings/arm/amba.txt |   21 ++++++++++
 drivers/amba/bus.c                             |   51 ++++++++++++++++++++++++
 include/linux/amba/bus.h                       |   18 ++++++++
 3 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amba.txt

diff --git a/Documentation/devicetree/bindings/arm/amba.txt b/Documentation/devicetree/bindings/arm/amba.txt
new file mode 100644
index 0000000..23fde7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amba.txt
@@ -0,0 +1,21 @@
+* ARM Primecell Peripherals
+
+ARM, Ltd. Primecell peripherals have a standard id register that can be used to
+identify the peripheral type, vendor, and revision. This value can be used for
+driver matching. 
+
+Required properties:
+
+- compatible : should be a specific value for peripheral and "arm,amba-device"
+
+Optional properties:
+
+- arm,amba-deviceid : Value to override the h/w value with
+
+Example:
+
+serial at fff36000 {
+	compatible = "arm,pl011", "arm,amba-device";
+	arm,amba-deviceid = <0x00341011>;
+};
+
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index d74926e..19f712b 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -13,6 +13,11 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/amba/bus.h>
@@ -785,3 +790,49 @@ EXPORT_SYMBOL(amba_device_unregister);
 EXPORT_SYMBOL(amba_find_device);
 EXPORT_SYMBOL(amba_request_regions);
 EXPORT_SYMBOL(amba_release_regions);
+
+#ifdef CONFIG_OF
+int of_amba_device_create(struct device_node *node, struct device *parent)
+{
+	struct amba_device *dev;
+	const void *prop;
+	int i, ret;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	/* setup generic device info */
+	dev->dev.coherent_dma_mask = ~0;
+	dev->dev.of_node = node;
+	dev->dev.parent = parent;
+	of_device_make_bus_id(&dev->dev);
+
+	/* setup amba-specific device info */
+	dev->dma_mask = ~0;
+
+	/* Allow the arm,amba-deviceid value to override the h/w value */
+	prop = of_get_property(node, "arm,amba-deviceid", NULL);
+	if (prop)
+		dev->periphid = of_read_ulong(prop, 1);
+
+	/* Decode the IRQs and address ranges */
+	for (i = 0; i < AMBA_NR_IRQS; i++)
+		dev->irq[i] = irq_of_parse_and_map(node, i);
+
+	ret = of_address_to_resource(node, 0, &dev->res);
+	if (ret)
+		goto err_free;
+
+	ret = amba_device_register(dev, &iomem_resource);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	kfree(dev);
+	return ret;
+}
+
+#endif /* CONFIG_OF */
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index fcbbe71..0177274 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -24,6 +24,7 @@
 #define AMBA_CID	0xb105f00d
 
 struct clk;
+struct device_node;
 
 struct amba_device {
 	struct device		dev;
@@ -63,6 +64,7 @@ extern struct bus_type amba_bustype;
 #define amba_get_drvdata(d)	dev_get_drvdata(&d->dev)
 #define amba_set_drvdata(d,p)	dev_set_drvdata(&d->dev, p)
 
+#ifdef CONFIG_ARM_AMBA
 int amba_driver_register(struct amba_driver *);
 void amba_driver_unregister(struct amba_driver *);
 int amba_device_register(struct amba_device *, struct resource *);
@@ -94,4 +96,20 @@ void amba_release_regions(struct amba_device *);
 #define amba_manf(d)	AMBA_MANF_BITS((d)->periphid)
 #define amba_part(d)	AMBA_PART_BITS((d)->periphid)
 
+#ifdef CONFIG_OF
+int of_amba_device_create(struct device_node *node, struct device *parent);
+#endif
+
+#else
+
+#ifdef CONFIG_OF
+static inline int of_amba_device_create(struct device_node *node, 
+					struct device *parent)
+{
+	return 0;
+}
+#endif
+
+#endif /* CONFIG_ARM_AMBA */
+
 #endif
-- 
1.7.4.1
