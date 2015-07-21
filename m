From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:46 +0200
Subject: [RFC PATCH 04/16] Add DEVM_IOMAP()
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-5-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/base/devres.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h | 19 +++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 5198ccd28123..6af1ca9fa804 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -8,7 +8,10 @@
  */
 
 #include <linux/device.h>
+#include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include "base.h"
@@ -1034,3 +1037,56 @@ int devm_resource_alloc(struct device *dev,
         return 0;
 }
 EXPORT_SYMBOL_GPL(devm_resource_alloc);
+
+int devm_acquire_iomap(struct device *dev,
+		       const struct devm_resource *resource)
+{
+	struct resource res, *resp = NULL;
+	void __iomem *vaddr;
+	void * __iomem *vaddrp;
+	int index, ret;
+
+	/* find mem resource from platform device */
+	if (dev->bus == &platform_bus_type) {
+		struct platform_device *pdev = to_platform_device(dev);
+
+		if (resource->name)
+			resp = platform_get_resource_byname(pdev,
+					IORESOURCE_MEM, resource->name);
+		else
+			resp = platform_get_resource(pdev,
+					IORESOURCE_MEM, resource->index);
+	}
+
+	/* try getting resource from device tree if that failed */
+	if (!resp && dev->of_node) {
+		if (resource->name)
+			index = of_property_match_string(dev->of_node,
+							 "reg-names",
+							 resource->name);
+		else
+			index = resource->index;
+
+		ret = of_address_to_resource(dev->of_node, index, &res);
+		if (ret)
+			return ret;
+		resp = &res;
+	}
+
+
+	if (resource->flags & DEVM_IOMAP_NOREQUEST) {
+		vaddr = devm_ioremap(dev, resp->start, resource_size(resp));
+		if (!vaddr)
+			return -EINVAL;
+	} else {
+		vaddr = devm_ioremap_resource(dev, resp);
+		if (IS_ERR(vaddr))
+			return PTR_ERR(vaddr);
+	}
+
+	vaddrp = dev_get_drvdata(dev) + resource->offset;
+	*vaddrp = vaddr;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_acquire_iomap);
diff --git a/include/linux/device.h b/include/linux/device.h
index c2bbee6b60ad..edcdc7a30114 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -687,6 +687,25 @@ extern int devm_resource_alloc(struct device *dev,
 #define DEVM_ALLOC(_struct) \
         { .initfunc = devm_resource_alloc, .offset = sizeof(struct _struct), }
 
+extern int devm_acquire_iomap(struct device *dev,
+			      const struct devm_resource *resource);
+
+#define DEVM_IOMAP_NOREQUEST 1
+
+#define DEVM_IOMAP(_struct, _member, _index, _flags) {		  \
+	.initfunc = devm_acquire_iomap,				   \
+	.offset = offsetof_t(struct _struct, _member, void __iomem *),  \
+	.index = _index,						\
+	.flags = _flags,						\
+}
+
+#define DEVM_IOMAP_NAMED(_struct, _member, _name, _flags) {	     \
+	.initfunc = devm_acquire_iomap,				   \
+	.offset = offsetof_t(struct _struct, _member, void __iomem *),  \
+	.name = _name,						  \
+	.flags = _flags,						\
+}
+
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
 
 /* allows to add/remove a custom action to devres stack */
-- 
2.4.3
