From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:50 +0200
Subject: [RFC PATCH 08/16] Add DEVM_IRQ()
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-9-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 include/linux/interrupt.h | 24 ++++++++++++++++++++++
 kernel/irq/devres.c       | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index be7e75c945e9..d0075aee3197 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -19,6 +19,8 @@
 #include <asm/ptrace.h>
 #include <asm/irq.h>
 
+struct devm_resource;
+
 /*
  * These correspond to the IORESOURCE_IRQ_* defines in
  * linux/ioport.h to select the interrupt line behaviour.  When
@@ -670,4 +672,26 @@ extern int early_irq_init(void);
 extern int arch_probe_nr_irqs(void);
 extern int arch_early_irq_init(void);
 
+int devm_acquire_irq(struct device *dev, const struct devm_resource *resource);
+
+/* cause a build warning if 'ptr' isn't of 'type' */
+#define typecheck_ptr(ptr, type) \
+        (void *)(ptr - (type)NULL)
+
+#define DEVM_IRQ(_struct, _member, _index, _handler, _flags) {  \
+        .initfunc = devm_acquire_irq,                             \
+        .offset = offsetof_t(struct _struct, _member, int),     \
+        .index = _index,                                        \
+        .arg = typecheck_ptr((_handler), irq_handler_t),        \
+        .flags = _flags,                                        \
+}
+
+#define DEVM_IRQ_NAMED(_struct, _member, _name, _handler, _flags) { \
+        .initfunc = devm_acquire_irq,                             \
+        .offset = offsetof_t(struct _struct, _member, int),     \
+        .name = _name,                                          \
+        .arg = typecheck_ptr((_handler), irq_handler_t),        \
+        .flags = _flags,                                        \
+}
+
 #endif
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index 74d90a754268..36b38625a101 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -1,6 +1,9 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/gfp.h>
 
 /*
@@ -137,3 +140,52 @@ void devm_free_irq(struct device *dev, unsigned int irq, void *dev_id)
 	free_irq(irq, dev_id);
 }
 EXPORT_SYMBOL(devm_free_irq);
+
+int devm_acquire_irq(struct device *dev, const struct devm_resource *resource)
+{
+        int irq;
+        int *irqp;
+        int index;
+        char *name;
+
+        /* come up with a reasonable string for the irq name,
+           maybe create devm_kasprintf() to allow arbitrary length? */
+        name = devm_kmalloc(dev, 32, GFP_KERNEL);
+        if (!name)
+                return -ENOMEM;
+        if (resource->name)
+                snprintf(name, 32 - 1, "%s:%s", dev_name(dev), resource->name);
+        else
+                snprintf(name, 32 - 1, "%s:%d", dev_name(dev), resource->index);
+
+        /* find IRQ number from resource if platform device */
+        irq = 0;
+        if (dev->bus == &platform_bus_type) {
+                struct platform_device *pdev = to_platform_device(dev);
+
+                if (resource->name)
+                        irq = platform_get_irq_byname(pdev, resource->name);
+                else
+                        irq = platform_get_irq(pdev, resource->index);
+        }
+
+        /* try getting irq number from device tree if that failed */
+        if (!irq && dev->of_node) {
+                if (resource->name)
+                        index = of_property_match_string(dev->of_node,
+                                                         "interrupt-names",
+                                                         resource->name);
+                else
+                        index = resource->index;
+
+                irq = irq_of_parse_and_map(dev->of_node, index);
+        }
+
+        /* copy irq number to driver data */
+        irqp = dev_get_drvdata(dev) + resource->offset;
+        *irqp = irq;
+
+        return devm_request_irq(dev, irq, resource->arg, resource->flags,
+				name, dev);
+}
+EXPORT_SYMBOL_GPL(devm_acquire_irq);
-- 
2.4.3
