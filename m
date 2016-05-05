From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  5 May 2016 14:29:40 +0100
Subject: [PATCH 2/5] remoteproc: core: Add rproc OF look-up functions
In-Reply-To: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1462454983-13168-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- of_rproc_byindex(): look-up and obtain a reference to a rproc
  		      using the DT phandle "rprocs" and a index.

- of_rproc_byname():  lookup and obtain a reference to a rproc
  		      using the DT phandle "rprocs" and "rproc-names".

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 96 +++++++++++++++++++++++++++++++++++-
 include/linux/remoteproc.h           |  3 ++
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 7db2818..85e5fd8 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -41,12 +41,19 @@
 #include <linux/virtio_ids.h>
 #include <linux/virtio_ring.h>
 #include <asm/byteorder.h>
+#include <linux/klist.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 
 #include "remoteproc_internal.h"
 
 static DEFINE_MUTEX(rproc_list_mutex);
 static LIST_HEAD(rproc_list);
 
+static void klist_rproc_get(struct klist_node *n);
+static void klist_rproc_put(struct klist_node *n);
+static DEFINE_KLIST(rprocs, klist_rproc_get, klist_rproc_put);
+
 typedef int (*rproc_handle_resources_t)(struct rproc *rproc,
 				struct resource_table *table, int len);
 typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
@@ -1196,6 +1203,87 @@ out:
 }
 EXPORT_SYMBOL(rproc_shutdown);
 
+/* will be called when an rproc is added to the rprocs klist */
+static void klist_rproc_get(struct klist_node *n)
+{
+	struct rproc *rproc = container_of(n, struct rproc, klist);
+
+	get_device(&rproc->dev);
+}
+
+/* will be called when an rproc is removed from the rprocs klist */
+static void klist_rproc_put(struct klist_node *n)
+{
+	struct rproc *rproc = container_of(n, struct rproc, klist);
+
+	put_device(&rproc->dev);
+}
+
+static struct rproc *next_rproc(struct klist_iter *i)
+{
+	struct klist_node *n;
+
+	n = klist_next(i);
+	if (!n)
+		return NULL;
+
+	return container_of(n, struct rproc, klist);
+}
+
+/**
+ * of_rproc_by_index() - lookup and obtain a reference to an rproc
+ * @np: node to search for rproc
+ * @index: index into the phandle list
+ *
+ * Returns the rproc driver on success and an appropriate error code otherwise.
+ */
+struct rproc *of_rproc_byindex(struct device_node *np, int index)
+{
+	struct rproc *rproc;
+	struct device_node *rproc_node;
+	struct platform_device *pdev;
+	struct klist_iter i;
+
+	if (index < 0)
+		return ERR_PTR(-EINVAL);
+
+	rproc_node = of_parse_phandle(np, "rprocs", index);
+	if (!rproc_node)
+		return ERR_PTR(-ENODEV);
+
+	pdev = of_find_device_by_node(rproc_node);
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
+
+	klist_iter_init(&rprocs, &i);
+	while ((rproc = next_rproc(&i)) != NULL)
+		if (rproc->dev.parent == &pdev->dev)
+			break;
+	klist_iter_exit(&i);
+
+	return rproc;
+}
+EXPORT_SYMBOL(of_rproc_byindex);
+
+/**
+ * of_rproc_byname() - lookup and obtain a reference to an rproc
+ * @np: node to search for rproc
+ * @name: name of the remoteproc from device's point of view
+ *
+ * Returns the rproc driver on success and an appropriate error code otherwise.
+ */
+struct rproc *of_rproc_byname(struct device_node *np, const char *name)
+{
+	int index;
+
+	if (unlikely(!name))
+		return ERR_PTR(-EINVAL);
+
+	index = of_property_match_string(np, "rproc-names", name);
+	return of_rproc_byindex(np, index);
+}
+EXPORT_SYMBOL(of_rproc_byname);
+
 /**
  * rproc_get_by_phandle() - find a remote processor by phandle
  * @phandle: phandle to the rproc
@@ -1282,7 +1370,13 @@ int rproc_add(struct rproc *rproc)
 	/* create debugfs entries */
 	rproc_create_debug_dir(rproc);
 
-	return rproc_add_virtio_devices(rproc);
+	ret = rproc_add_virtio_devices(rproc);
+	if (ret < 0)
+		klist_remove(&rproc->klist);
+	else
+		klist_add_tail(&rproc->klist, &rprocs);
+
+	return ret;
 }
 EXPORT_SYMBOL(rproc_add);
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 9c4e138..4c96e78 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -410,6 +410,7 @@ enum rproc_crash_type {
  */
 struct rproc {
 	struct list_head node;
+	struct klist_node klist;
 	struct iommu_domain *domain;
 	const char *name;
 	const char *firmware;
@@ -494,6 +495,8 @@ int rproc_del(struct rproc *rproc);
 int rproc_boot(struct rproc *rproc);
 void rproc_shutdown(struct rproc *rproc);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
+struct rproc *of_rproc_byindex(struct device_node *np, int index);
+struct rproc *of_rproc_byname(struct device_node *np, const char *name);
 
 static inline struct rproc_vdev *vdev_to_rvdev(struct virtio_device *vdev)
 {
-- 
2.8.0
