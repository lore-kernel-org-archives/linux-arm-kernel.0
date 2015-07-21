From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:44 +0200
Subject: [RFC PATCH 02/16] add devm_acquire_resources()
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-3-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/base/dd.c      |  4 ++++
 drivers/base/devres.c  | 20 ++++++++++++++++++++
 include/linux/device.h | 14 ++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a638bbb1a27a..7f970ac11533 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -304,6 +304,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 			goto probe_failed;
 	}
 
+	ret = devm_acquire_resources(dev);
+	if (ret)
+		goto probe_failed;
+
 	if (dev->bus->probe) {
 		ret = dev->bus->probe(dev);
 		if (ret)
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index c8a53d1e019f..0c6252921fd1 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -984,3 +984,23 @@ void devm_free_pages(struct device *dev, unsigned long addr)
 			       &devres));
 }
 EXPORT_SYMBOL_GPL(devm_free_pages);
+
+int devm_acquire_resources(struct device *dev)
+{
+	const struct devm_resource *res;
+	int ret;
+
+	if (!dev->driver || !dev->driver->resources)
+		return 0;
+
+	for (res = dev->driver->resources; res->initfunc; res++) {
+		ret = res->initfunc(dev, res);
+		if (ret) {
+			dev_warn(dev, "%pf returned %d for resource '%s'/%d\n",
+				 res->initfunc, ret, res->name, res->index);
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/include/linux/device.h b/include/linux/device.h
index a2b4ea70a946..a1c3829152a1 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -223,6 +223,16 @@ enum probe_type {
 	PROBE_FORCE_SYNCHRONOUS,
 };
 
+struct devm_resource {
+        int (*initfunc)(struct device *dev,
+			const struct devm_resource *resource);
+        ptrdiff_t offset;
+        unsigned int index;
+        const char *name;
+        void *arg;
+        unsigned int flags;
+};
+
 /**
  * struct device_driver - The basic device driver structure
  * @name:	Name of the device driver.
@@ -278,6 +288,8 @@ struct device_driver {
 
 	const struct dev_pm_ops *pm;
 
+	const struct devm_resource *resources;
+
 	struct driver_private *p;
 };
 
@@ -667,6 +679,8 @@ extern unsigned long devm_get_free_pages(struct device *dev,
 					 gfp_t gfp_mask, unsigned int order);
 extern void devm_free_pages(struct device *dev, unsigned long addr);
 
+extern int devm_acquire_resources(struct device *dev);
+
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
 
 /* allows to add/remove a custom action to devres stack */
-- 
2.4.3
