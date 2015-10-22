From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 22 Oct 2015 11:41:57 +0200
Subject: [PATCH v2 1/6] vfio: platform: add capability to register a reset
 function
In-Reply-To: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
References: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1445506922-6005-2-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for subsequent changes in reset function lookup,
lets introduce a dynamic list of reset combos (compat string,
reset module, reset function). The list can be populated/voided with
two new functions, vfio_platform_register/unregister_reset. Those are
not yet used in this patch.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v1 -> v2:
- reset_list becomes static
- vfio_platform_register/unregister_reset take a const char * as compat
- fix node leak
- add reset_lock to protect the reset list manipulation
- move vfio_platform_reset_node declaration in vfio_platform_common.c
---
 drivers/vfio/platform/vfio_platform_common.c  | 77 +++++++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_private.h |  7 +++
 2 files changed, 84 insertions(+)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index e43efb5..52a4c7b 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -23,6 +23,15 @@
 
 #include "vfio_platform_private.h"
 
+struct vfio_platform_reset_node {
+	struct list_head link;
+	char *compat;
+	struct module *owner;
+	vfio_platform_reset_fn_t reset;
+};
+
+static LIST_HEAD(reset_list);
+static DEFINE_MUTEX(reset_lock);
 static DEFINE_MUTEX(driver_lock);
 
 static const struct vfio_platform_reset_combo reset_lookup_table[] = {
@@ -573,3 +582,71 @@ struct vfio_platform_device *vfio_platform_remove_common(struct device *dev)
 	return vdev;
 }
 EXPORT_SYMBOL_GPL(vfio_platform_remove_common);
+
+int vfio_platform_register_reset(struct module *reset_owner,
+				 const char *compat,
+				 vfio_platform_reset_fn_t reset)
+{
+	struct vfio_platform_reset_node *node, *iter;
+	bool found = false;
+
+	mutex_lock(&reset_lock);
+	list_for_each_entry(iter, &reset_list, link) {
+		if (!strcmp(iter->compat, compat)) {
+			found = true;
+			break;
+		}
+	}
+	if (found) {
+		mutex_unlock(&reset_lock);
+		return -EINVAL;
+	}
+
+	node = kmalloc(sizeof(*node), GFP_KERNEL);
+	if (!node) {
+		mutex_unlock(&reset_lock);
+		return -ENOMEM;
+	}
+
+	node->compat = kstrdup(compat, GFP_KERNEL);
+	if (!node->compat) {
+		kfree(node);
+		mutex_unlock(&reset_lock);
+		return -ENOMEM;
+	}
+
+	node->owner = reset_owner;
+	node->reset = reset;
+
+	list_add(&node->link, &reset_list);
+	mutex_unlock(&reset_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vfio_platform_register_reset);
+
+int vfio_platform_unregister_reset(const char *compat)
+{
+	struct vfio_platform_reset_node *iter;
+	bool found = false;
+
+	mutex_lock(&reset_lock);
+	list_for_each_entry(iter, &reset_list, link) {
+		if (!strcmp(iter->compat, compat)) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		mutex_unlock(&reset_lock);
+		return -EINVAL;
+	}
+
+	list_del(&iter->link);
+	kfree(iter->compat);
+	kfree(iter);
+	mutex_unlock(&reset_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vfio_platform_unregister_reset);
+
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 1c9b3d5..1fb1410 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -89,4 +89,11 @@ extern int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
 					unsigned start, unsigned count,
 					void *data);
 
+typedef int (*vfio_platform_reset_fn_t)(struct vfio_platform_device *vdev);
+
+extern int vfio_platform_register_reset(struct module *owner,
+					const char *compat,
+					vfio_platform_reset_fn_t reset);
+extern int vfio_platform_unregister_reset(const char *compat);
+
 #endif /* VFIO_PLATFORM_PRIVATE_H */
-- 
1.9.1
