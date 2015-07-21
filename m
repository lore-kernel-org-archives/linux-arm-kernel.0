From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:47 +0200
Subject: [RFC PATCH 05/16] Add DEVM_RESET()
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-6-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/reset/core.c  | 13 +++++++++++++
 include/linux/reset.h | 10 ++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 7955e00d04d4..a890c401dbf0 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -303,3 +303,16 @@ int device_reset(struct device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(device_reset);
+
+int devm_acquire_reset(struct device *dev,
+		       const struct devm_resource *resource)
+{
+	struct reset_control **rstp = dev_get_drvdata(dev) + resource->offset;
+
+	*rstp = devm_reset_control_get(dev, resource->name);
+	if (IS_ERR(*rstp))
+		return PTR_ERR(*rstp);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_acquire_reset);
diff --git a/include/linux/reset.h b/include/linux/reset.h
index da5602bd77d7..1771c5cbfeb1 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -3,6 +3,7 @@
 
 struct device;
 struct device_node;
+struct devm_resource;
 struct reset_control;
 
 #ifdef CONFIG_RESET_CONTROLLER
@@ -38,6 +39,15 @@ static inline struct reset_control *devm_reset_control_get_optional(
 struct reset_control *of_reset_control_get(struct device_node *node,
 					   const char *id);
 
+int devm_acquire_reset(struct device *dev,
+		       const struct devm_resource *resource);
+
+#define DEVM_RESET(_struct, _member, _name) {	 			\
+	.initfunc = devm_acquire_reset,				 	\
+	.offset = offsetof_t(struct _struct, _member, struct reset_control *),\
+	.name = _name,							\
+}
+
 #else
 
 static inline int reset_control_reset(struct reset_control *rstc)
-- 
2.4.3
