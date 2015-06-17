From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 17 Jun 2015 15:42:20 +0200
Subject: [PATCH 10/13] driver-core: add for_each_class()
In-Reply-To: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1434548543-22949-11-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The purpose of this function is to allow other parts of the driver core
to iterate over the currently registered classes.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/base/base.h  |  2 ++
 drivers/base/class.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 29c985e..be81c88 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -149,3 +149,5 @@ extern int devtmpfs_init(void);
 #else
 static inline int devtmpfs_init(void) { return 0; }
 #endif
+
+extern void for_each_class(void (*fn)(struct class *, void *), void *data);
diff --git a/drivers/base/class.c b/drivers/base/class.c
index 6e81088..f4114a4 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -583,6 +583,22 @@ void class_compat_remove_link(struct class_compat *cls, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(class_compat_remove_link);
 
+void for_each_class(void (*fn)(struct class *, void *), void *data)
+{
+	struct subsys_private *cp;
+	struct kobject *k;
+
+	if (!class_kset)
+		return;
+
+	list_for_each_entry(k, &class_kset->list, entry) {
+		cp = to_subsys_private(k);
+		class_get(cp->class);
+		fn(cp->class, data);
+		class_put(cp->class);
+	}
+}
+
 int __init classes_init(void)
 {
 	class_kset = kset_create_and_add("class", NULL, NULL);
-- 
2.4.1
