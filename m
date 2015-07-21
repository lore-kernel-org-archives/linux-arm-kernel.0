From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:45 +0200
Subject: [RFC PATCH 03/16] Add DEVM_ALLOC()
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-4-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/base/devres.c  | 30 ++++++++++++++++++++++++++++++
 include/linux/device.h |  6 ++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 0c6252921fd1..5198ccd28123 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -1004,3 +1004,33 @@ int devm_acquire_resources(struct device *dev)
 
 	return ret;
 }
+
+/*
+ * this must be the called before any of the others, or not at
+ * all, if dev_set_drvdata() has already been called.
+ */
+static void devm_resource_alloc_release(struct device *dev, void *res)
+{
+        dev_set_drvdata(dev, NULL);
+}
+
+int devm_resource_alloc(struct device *dev,
+			const struct devm_resource *resource)
+{
+	struct devres *dr;
+
+        if (dev_get_drvdata(dev))
+                return -EBUSY;
+
+	dr = alloc_dr(devm_resource_alloc_release, resource->offset,
+		      GFP_KERNEL | __GFP_ZERO);
+        if (unlikely(!dr))
+                return -ENOMEM;
+
+        dev_set_drvdata(dev, dr->data);
+        set_node_dbginfo(&dr->node, "devm_resource_alloc", resource->offset);
+        devres_add(dev, dr->data);
+
+        return 0;
+}
+EXPORT_SYMBOL_GPL(devm_resource_alloc);
diff --git a/include/linux/device.h b/include/linux/device.h
index a1c3829152a1..c2bbee6b60ad 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -681,6 +681,12 @@ extern void devm_free_pages(struct device *dev, unsigned long addr);
 
 extern int devm_acquire_resources(struct device *dev);
 
+extern int devm_resource_alloc(struct device *dev,
+			       const struct devm_resource *resource);
+
+#define DEVM_ALLOC(_struct) \
+        { .initfunc = devm_resource_alloc, .offset = sizeof(struct _struct), }
+
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
 
 /* allows to add/remove a custom action to devres stack */
-- 
2.4.3
