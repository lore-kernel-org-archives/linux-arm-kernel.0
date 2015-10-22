From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 22 Oct 2015 11:42:01 +0200
Subject: [PATCH v2 5/6] vfio: platform: use list of registered reset function
In-Reply-To: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
References: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1445506922-6005-6-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the static lookup table and use the dynamic list of registered
reset functions instead. Also load the reset module through its alias.
The reset struct module pointer is stored in vfio_platform_device.

We also remove the useless struct device pointer parameter in
vfio_platform_get_reset.

This patch fixes the issue related to the usage of __symbol_get, which
besides from being moot, prevented compilation with CONFIG_MODULES
disabled.

Also usage of MODULE_ALIAS makes possible to add a new reset module
without needing to update the framework. This was suggested by Arnd.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>

---

v1 -> v2:
- use reset_lock in vfio_platform_lookup_reset
- remove vfio_platform_reset_combo declaration
- remove struct device *dev parameter in vfio_platform_get_reset
- set reset_module and reset to NULL in put function
---
 drivers/vfio/platform/vfio_platform_common.c  | 57 ++++++++++++++++-----------
 drivers/vfio/platform/vfio_platform_private.h |  7 +---
 2 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index e7d615f..95b8294 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -34,37 +34,46 @@ static LIST_HEAD(reset_list);
 static DEFINE_MUTEX(reset_lock);
 static DEFINE_MUTEX(driver_lock);
 
-static const struct vfio_platform_reset_combo reset_lookup_table[] = {
-	{
-		.compat = "calxeda,hb-xgmac",
-		.reset_function_name = "vfio_platform_calxedaxgmac_reset",
-		.module_name = "vfio-platform-calxedaxgmac",
-	},
-};
-
-static void vfio_platform_get_reset(struct vfio_platform_device *vdev,
-				    struct device *dev)
+static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
+					struct module **module)
 {
-	int (*reset)(struct vfio_platform_device *);
-	int i;
+	struct vfio_platform_reset_node *iter;
 
-	for (i = 0 ; i < ARRAY_SIZE(reset_lookup_table); i++) {
-		if (!strcmp(reset_lookup_table[i].compat, vdev->compat)) {
-			request_module(reset_lookup_table[i].module_name);
-			reset = __symbol_get(
-				reset_lookup_table[i].reset_function_name);
-			if (reset) {
-				vdev->reset = reset;
-				return;
-			}
+	mutex_lock(&reset_lock);
+	list_for_each_entry(iter, &reset_list, link) {
+		if (!strcmp(iter->compat, compat) &&
+			try_module_get(iter->owner)) {
+			*module = iter->owner;
+			mutex_unlock(&reset_lock);
+			return iter->reset;
 		}
 	}
+
+	mutex_unlock(&reset_lock);
+	return NULL;
+}
+
+static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
+{
+	char modname[256];
+
+	vdev->reset = vfio_platform_lookup_reset(vdev->compat,
+						&vdev->reset_module);
+	if (!vdev->reset) {
+		snprintf(modname, 256, "vfio-reset:%s", vdev->compat);
+		request_module(modname);
+		vdev->reset = vfio_platform_lookup_reset(vdev->compat,
+							 &vdev->reset_module);
+	}
 }
 
 static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
 {
-	if (vdev->reset)
-		symbol_put_addr(vdev->reset);
+	if (vdev->reset) {
+		module_put(vdev->reset_module);
+		vdev->reset_module = NULL;
+		vdev->reset = NULL;
+	}
 }
 
 static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
@@ -561,7 +570,7 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 		return ret;
 	}
 
-	vfio_platform_get_reset(vdev, dev);
+	vfio_platform_get_reset(vdev);
 
 	mutex_init(&vdev->igate);
 
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 620ee40..e968454 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -57,6 +57,7 @@ struct vfio_platform_device {
 	int				refcnt;
 	struct mutex			igate;
 	const char			*compat;
+	struct module			*reset_module;
 
 	/*
 	 * These fields should be filled by the bus specific binder
@@ -71,12 +72,6 @@ struct vfio_platform_device {
 	int	(*reset)(struct vfio_platform_device *vdev);
 };
 
-struct vfio_platform_reset_combo {
-	const char *compat;
-	const char *reset_function_name;
-	const char *module_name;
-};
-
 extern int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 				      struct device *dev);
 extern struct vfio_platform_device *vfio_platform_remove_common
-- 
1.9.1
