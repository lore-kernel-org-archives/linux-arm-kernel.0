From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue,  6 Jun 2017 21:22:06 +0200
Subject: [PATCH 01/16] arm: ecard: use dev_groups and not dev_attrs for
 bus_type
In-Reply-To: <20170606192221.1617-1-gregkh@linuxfoundation.org>
References: <20170606192221.1617-1-gregkh@linuxfoundation.org>
Message-ID: <20170606192221.1617-2-gregkh@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dev_attrs field has long been "depreciated" and is finally being
removed, so move the driver to use the "correct" dev_groups field
instead for struct bus_type.

Cc: Russell King <linux@armlinux.org.uk>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-rpc/ecard.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 6b279d037774..f75b8b562d57 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -761,19 +761,21 @@ static struct expansion_card *__init ecard_alloc_card(int type, int slot)
 	return ec;
 }
 
-static ssize_t ecard_show_irq(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t irq_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->irq);
 }
+static DEVICE_ATTR_RO(irq);
 
-static ssize_t ecard_show_dma(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t dma_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->dma);
 }
+static DEVICE_ATTR_RO(dma);
 
-static ssize_t ecard_show_resources(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t resource_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	char *str = buf;
@@ -787,35 +789,39 @@ static ssize_t ecard_show_resources(struct device *dev, struct device_attribute
 
 	return str - buf;
 }
+static DEVICE_ATTR_RO(resource_show)
 
-static ssize_t ecard_show_vendor(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t vendor_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->cid.manufacturer);
 }
+static DEVICE_ATTR_RO(vendor);
 
-static ssize_t ecard_show_device(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t device_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->cid.product);
 }
+static DEVICE_ATTR_RO(device);
 
-static ssize_t ecard_show_type(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%s\n", ec->easi ? "EASI" : "IOC");
 }
-
-static struct device_attribute ecard_dev_attrs[] = {
-	__ATTR(device,   S_IRUGO, ecard_show_device,    NULL),
-	__ATTR(dma,      S_IRUGO, ecard_show_dma,       NULL),
-	__ATTR(irq,      S_IRUGO, ecard_show_irq,       NULL),
-	__ATTR(resource, S_IRUGO, ecard_show_resources, NULL),
-	__ATTR(type,     S_IRUGO, ecard_show_type,      NULL),
-	__ATTR(vendor,   S_IRUGO, ecard_show_vendor,    NULL),
-	__ATTR_NULL,
+static DEVICE_ATTR_RO(type);
+
+static struct attribute *ecard_dev_attrs[] = {
+	&dev_attr_device.attr,
+	&dev_attr_dma.attr,
+	&dev_attr_irq.attr,
+	&dev_attr_resource.attr,
+	&dev_attr_type.attr,
+	&dev_attr_vendor.attr,
+	NULL,
 };
-
+ATTRIBUTE_GROUPS(ecard_dev);
 
 int ecard_request_resources(struct expansion_card *ec)
 {
@@ -1120,7 +1126,7 @@ static int ecard_match(struct device *_dev, struct device_driver *_drv)
 
 struct bus_type ecard_bus_type = {
 	.name		= "ecard",
-	.dev_attrs	= ecard_dev_attrs,
+	.dev_groups	= ecard_dev_groups,
 	.match		= ecard_match,
 	.probe		= ecard_drv_probe,
 	.remove		= ecard_drv_remove,
-- 
2.13.0
