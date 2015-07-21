From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:49 +0200
Subject: [RFC PATCH 07/16] Add DEVM_FWNODE()
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-8-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/base/property.c  | 17 +++++++++++++++++
 include/linux/property.h | 10 ++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index d88539c31c67..cc823b283f49 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -580,3 +580,20 @@ bool fwnode_is_compatible(struct fwnode_handle *fwnode, const char *compatible)
 	return false;
 }
 EXPORT_SYMBOL_GPL(fwnode_is_compatible);
+
+int devm_acquire_fwnode(struct device *dev,
+			const struct devm_resource *resource)
+{
+	struct device_node *np;
+	struct fwnode_handle **nodep;
+
+	np = of_parse_phandle(dev->of_node, resource->name, 0);
+	if (IS_ERR(np))
+		return PTR_ERR(np);
+
+	nodep = dev_get_drvdata(dev) + resource->offset;
+	*nodep = &np->fwnode;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_acquire_fwnode);
\ No newline at end of file
diff --git a/include/linux/property.h b/include/linux/property.h
index 3fd5fd58ebe9..1c6d5eb65516 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 
 struct device;
+struct devm_resource;
 
 enum dev_prop_type {
 	DEV_PROP_U8,
@@ -172,4 +173,13 @@ void device_add_property_set(struct device *dev, struct property_set *pset);
 
 bool device_dma_is_coherent(struct device *dev);
 
+int devm_acquire_fwnode(struct device *dev,
+			const struct devm_resource *resource);
+
+#define DEVM_FWNODE(_struct, _member, _name) {				\
+	.initfunc = devm_acquire_fwnode,				\
+	.offset = offsetof_t(struct _struct, _member, struct fwnode_handle *),\
+	.name = _name,							\
+}
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.4.3
