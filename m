From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 23 Nov 2015 11:32:58 -0700
Subject: [RESEND PATCH V4 06/26] coresight: associating path with session
 rather than tracer
In-Reply-To: <1448303598-11249-1-git-send-email-mathieu.poirier@linaro.org>
References: <1448303598-11249-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1448303598-11249-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using the Coresight framework from the sysFS interface a
tracer is always handling a single session and as such, a path
can be associated with a tracer.  But when supporting multiple
session per tracer there is no guarantee that sessions will always
have the same path from source to sink.

This patch is removing the automatic association between path and
tracers.  The building of a path and enablement of the components
in the path are decoupled, allowing for the association of a path
with a session rather than a tracer.

To keep backward functionality with the current sysFS access methods
a per-cpu place holder is used to keep a handle on the path built when
tracers are enabled.  Lastly APIs to build paths and enable tracers are
made public so that other subsystem can interact with the Coresight
framework.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-priv.h |   5 +
 drivers/hwtracing/coresight/coresight.c      | 300 ++++++++++++++++++---------
 include/linux/coresight.h                    |   2 -
 3 files changed, 208 insertions(+), 99 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 62fcd98cc7cf..7b193a34d709 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -52,6 +52,11 @@ static inline void CS_UNLOCK(void __iomem *addr)
 	} while (0);
 }
 
+void coresight_disable_path(struct list_head *path);
+int coresight_enable_path(struct list_head *path);
+struct list_head *coresight_build_path(struct coresight_device *csdev);
+void coresight_release_path(struct list_head *path);
+
 #ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
 extern int etm_readl_cp14(u32 off, unsigned int *val);
 extern int etm_writel_cp14(u32 off, u32 val);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index e25492137d8b..4beea67fd5a1 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -29,6 +29,22 @@
 
 static DEFINE_MUTEX(coresight_mutex);
 
+/**
+ * struct coresight_node - elements of a path, from source to sink
+ * @csdev:	Address of an element.
+ * @link:	hook to the list.
+ */
+struct coresight_node {
+	struct coresight_device *csdev;
+	struct list_head link;
+};
+
+/*
+ * When operating Coresight drivers from the sysFS interface, only a single
+ * path can exist from a tracer (associated to a CPU) to a sink.
+ */
+static DEFINE_PER_CPU(struct list_head *, sysfs_path);
+
 static int coresight_id_match(struct device *dev, void *data)
 {
 	int trace_id, i_trace_id;
@@ -68,15 +84,12 @@ static int coresight_source_is_unique(struct coresight_device *csdev)
 				 csdev, coresight_id_match);
 }
 
-static int coresight_find_link_inport(struct coresight_device *csdev)
+static int coresight_find_link_inport(struct coresight_device *csdev,
+				      struct coresight_device *parent)
 {
 	int i;
-	struct coresight_device *parent;
 	struct coresight_connection *conn;
 
-	parent = container_of(csdev->path_link.next,
-			      struct coresight_device, path_link);
-
 	for (i = 0; i < parent->nr_outport; i++) {
 		conn = &parent->conns[i];
 		if (conn->child_dev == csdev)
@@ -89,15 +102,12 @@ static int coresight_find_link_inport(struct coresight_device *csdev)
 	return 0;
 }
 
-static int coresight_find_link_outport(struct coresight_device *csdev)
+static int coresight_find_link_outport(struct coresight_device *csdev,
+				       struct coresight_device *child)
 {
 	int i;
-	struct coresight_device *child;
 	struct coresight_connection *conn;
 
-	child = container_of(csdev->path_link.prev,
-			     struct coresight_device, path_link);
-
 	for (i = 0; i < csdev->nr_outport; i++) {
 		conn = &csdev->conns[i];
 		if (conn->child_dev == child)
@@ -138,14 +148,19 @@ static void coresight_disable_sink(struct coresight_device *csdev)
 	}
 }
 
-static int coresight_enable_link(struct coresight_device *csdev)
+static int coresight_enable_link(struct coresight_device *csdev,
+				 struct coresight_device *parent,
+				 struct coresight_device *child)
 {
 	int ret;
 	int link_subtype;
 	int refport, inport, outport;
 
-	inport = coresight_find_link_inport(csdev);
-	outport = coresight_find_link_outport(csdev);
+	if (!parent || !child)
+		return -EINVAL;
+
+	inport = coresight_find_link_inport(csdev, parent);
+	outport = coresight_find_link_outport(csdev, child);
 	link_subtype = csdev->subtype.link_subtype;
 
 	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG)
@@ -168,14 +183,19 @@ static int coresight_enable_link(struct coresight_device *csdev)
 	return 0;
 }
 
-static void coresight_disable_link(struct coresight_device *csdev)
+static void coresight_disable_link(struct coresight_device *csdev,
+				   struct coresight_device *parent,
+				   struct coresight_device *child)
 {
 	int i, nr_conns;
 	int link_subtype;
 	int refport, inport, outport;
 
-	inport = coresight_find_link_inport(csdev);
-	outport = coresight_find_link_outport(csdev);
+	if (!parent || !child)
+		return;
+
+	inport = coresight_find_link_inport(csdev, parent);
+	outport = coresight_find_link_outport(csdev, child);
 	link_subtype = csdev->subtype.link_subtype;
 
 	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
@@ -235,109 +255,167 @@ static void coresight_disable_source(struct coresight_device *csdev)
 	}
 }
 
-static int coresight_enable_path(struct list_head *path)
+void coresight_disable_path(struct list_head *path)
 {
-	int ret = 0;
-	struct coresight_device *cd;
-
-	/*
-	 * At this point we have a full @path, from source to sink.  The
-	 * sink is the first entry and the source the last one.  Go through
-	 * all the components and enable them one by one.
-	 */
-	list_for_each_entry(cd, path, path_link) {
-		if (cd == list_first_entry(path, struct coresight_device,
-					   path_link)) {
-			ret = coresight_enable_sink(cd);
-		} else if (list_is_last(&cd->path_link, path)) {
-			/*
-			 * Don't enable the source just yet - this needs to
-			 * happen at the very end when all links and sink
-			 * along the path have been configured properly.
-			 */
-			;
-		} else {
-			ret = coresight_enable_link(cd);
+	struct coresight_node *nd;
+	struct coresight_device *csdev, *parent, *child;
+
+	list_for_each_entry(nd, path, link) {
+		csdev = nd->csdev;
+
+		switch (csdev->type) {
+		case CORESIGHT_DEV_TYPE_SINK:
+		case CORESIGHT_DEV_TYPE_LINKSINK:
+			coresight_disable_sink(csdev);
+			break;
+		case CORESIGHT_DEV_TYPE_SOURCE:
+			/* sources are disabled from either sysFS or Perf */
+			break;
+		case CORESIGHT_DEV_TYPE_LINK:
+			parent = list_prev_entry(nd, link)->csdev;
+			child = list_next_entry(nd, link)->csdev;
+			coresight_disable_link(csdev, parent, child);
+			break;
+		default:
+			break;
 		}
-		if (ret)
-			goto err;
 	}
+}
 
-	return 0;
-err:
-	list_for_each_entry_continue_reverse(cd, path, path_link) {
-		if (cd == list_first_entry(path, struct coresight_device,
-					   path_link)) {
-			coresight_disable_sink(cd);
-		} else if (list_is_last(&cd->path_link, path)) {
-			;
-		} else {
-			coresight_disable_link(cd);
+int coresight_enable_path(struct list_head *path)
+{
+
+	int ret = 0;
+	struct coresight_node *nd;
+	struct coresight_device *csdev, *parent, *child;
+
+	list_for_each_entry_reverse(nd, path, link) {
+		csdev = nd->csdev;
+
+		switch (csdev->type) {
+		case CORESIGHT_DEV_TYPE_SINK:
+		case CORESIGHT_DEV_TYPE_LINKSINK:
+			ret = coresight_enable_sink(csdev);
+			if (ret)
+				goto err;
+			break;
+		case CORESIGHT_DEV_TYPE_SOURCE:
+			/* sources are enabled from either sysFS or Perf */
+			break;
+		case CORESIGHT_DEV_TYPE_LINK:
+			parent = list_prev_entry(nd, link)->csdev;
+			child = list_next_entry(nd, link)->csdev;
+			ret = coresight_enable_link(csdev, parent, child);
+			if (ret)
+				goto err;
+			break;
+		default:
+			goto err;
 		}
 	}
 
+out:
 	return ret;
+err:
+	coresight_disable_path(path);
+	goto out;
 }
 
-static int coresight_disable_path(struct list_head *path)
+/**
+ * _coresight_build_path - recursively build a path from a @csdev to a sink.
+ * @csdev:	The device to start from.
+ * @path:	The list to add devices to.
+ *
+ * The tree of Coresight device is traversed until an activated sink is
+ * found.  From there the sink is added to the list along with all the
+ * devices that led to that point - the end result is a list from source
+ * to sink. In that list the source is the first device and the sink the
+ * last one.
+ */
+static int _coresight_build_path(struct coresight_device *csdev,
+				 struct list_head *path)
 {
-	struct coresight_device *cd;
-
-	list_for_each_entry_reverse(cd, path, path_link) {
-		if (cd == list_first_entry(path, struct coresight_device,
-					   path_link)) {
-			coresight_disable_sink(cd);
-		} else if (list_is_last(&cd->path_link, path)) {
-			/*
-			 * The source has already been stopped, no need
-			 * to do it again here.
-			 */
-			;
-		} else {
-			coresight_disable_link(cd);
+	int i;
+	bool found = false;
+	struct coresight_node *node;
+	struct coresight_connection *conn;
+
+	/* An activated sink has been found.  Enqueue the element */
+	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) && csdev->activated)
+		goto out;
+
+	/* Not a sink - recursively explore each port found on this element */
+	for (i = 0; i < csdev->nr_outport; i++) {
+		conn = &csdev->conns[i];
+		if (_coresight_build_path(conn->child_dev, path) == 0) {
+			found = true;
+			break;
 		}
 	}
 
+	if (!found)
+		return -ENODEV;
+
+out:
+	/*
+	 * A path from this element to a sink has been found.  The elements
+	 * leading to the sink are already enqueued, all that is left to do
+	 * is add a node for this element.
+	 */
+	node = kzalloc(sizeof(struct coresight_node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->csdev = csdev;
+	list_add(&node->link, path);
+
 	return 0;
 }
 
-static int coresight_build_paths(struct coresight_device *csdev,
-				 struct list_head *path,
-				 bool enable)
+struct list_head *coresight_build_path(struct coresight_device *csdev)
 {
-	int i, ret = -EINVAL;
-	struct coresight_connection *conn;
+	struct list_head *path;
 
-	list_add(&csdev->path_link, path);
+	path = kzalloc(sizeof(struct list_head), GFP_KERNEL);
+	if (!path)
+		return NULL;
 
-	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
-	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
-	    csdev->activated) {
-		if (enable)
-			ret = coresight_enable_path(path);
-		else
-			ret = coresight_disable_path(path);
-	} else {
-		for (i = 0; i < csdev->nr_outport; i++) {
-			conn = &csdev->conns[i];
-			if (coresight_build_paths(conn->child_dev,
-						    path, enable) == 0)
-				ret = 0;
-		}
+	INIT_LIST_HEAD(path);
+
+	if (_coresight_build_path(csdev, path)) {
+		kfree(path);
+		path = NULL;
 	}
 
-	if (list_first_entry(path, struct coresight_device, path_link) != csdev)
-		dev_err(&csdev->dev, "wrong device in %s\n", __func__);
+	return path;
+}
 
-	list_del(&csdev->path_link);
+/**
+ * coresight_release_path - release a previously built path.
+ * @path:	the path to release.
+ *
+ * Go through all the elements of a path and 1) removed it from the list and
+ * 2) free the memory allocated for each node.
+ */
+void coresight_release_path(struct list_head *path)
+{
+	struct coresight_node *nd, *next;
 
-	return ret;
+	list_for_each_entry_safe(nd, next, path, link) {
+		list_del(&nd->link);
+		kfree(nd);
+	}
+
+	kfree(path);
+	path = NULL;
 }
 
 int coresight_enable(struct coresight_device *csdev)
 {
 	int ret = 0;
-	LIST_HEAD(path);
+	int cpu;
+	struct list_head *path;
 
 	mutex_lock(&coresight_mutex);
 	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE) {
@@ -348,22 +426,47 @@ int coresight_enable(struct coresight_device *csdev)
 	if (csdev->enable)
 		goto out;
 
-	if (coresight_build_paths(csdev, &path, true)) {
-		dev_err(&csdev->dev, "building path(s) failed\n");
+	path = coresight_build_path(csdev);
+	if (!path) {
+		pr_err("building path(s) failed\n");
 		goto out;
 	}
 
-	if (coresight_enable_source(csdev))
-		dev_err(&csdev->dev, "source enable failed\n");
+	ret = coresight_enable_path(path);
+	if (ret)
+		goto err_path;
+
+	ret = coresight_enable_source(csdev);
+	if (ret)
+		goto err_source;
+
+	/*
+	 * When working from sysFS it is important to keep track
+	 * of the paths that were created so that they can be
+	 * undone in 'coresight_disable()'.  Since there can only
+	 * be a single session per tracer (when working from sysFS)
+	 * a per-cpu variable will do just fine.
+	 */
+	cpu = source_ops(csdev)->cpu_id(csdev);
+	per_cpu(sysfs_path, cpu) = path;
+
 out:
 	mutex_unlock(&coresight_mutex);
 	return ret;
+
+err_source:
+	coresight_disable_path(path);
+
+err_path:
+	coresight_release_path(path);
+	goto out;
 }
 EXPORT_SYMBOL_GPL(coresight_enable);
 
 void coresight_disable(struct coresight_device *csdev)
 {
-	LIST_HEAD(path);
+	int cpu;
+	struct list_head *path;
 
 	mutex_lock(&coresight_mutex);
 	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE) {
@@ -373,9 +476,12 @@ void coresight_disable(struct coresight_device *csdev)
 	if (!csdev->enable)
 		goto out;
 
+	cpu = source_ops(csdev)->cpu_id(csdev);
+	path = per_cpu(sysfs_path, cpu);
 	coresight_disable_source(csdev);
-	if (coresight_build_paths(csdev, &path, false))
-		dev_err(&csdev->dev, "releasing path(s) failed\n");
+	coresight_disable_path(path);
+	coresight_release_path(path);
+	per_cpu(sysfs_path, cpu) = NULL;
 
 out:
 	mutex_unlock(&coresight_mutex);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index bf62b265bf52..851ecb22397e 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -152,7 +152,6 @@ struct coresight_connection {
 		by @coresight_ops.
  * @dev:	The device entity associated to this component.
  * @refcnt:	keep track of what is in use.
- * @path_link:	link of current component into the path being enabled.
  * @orphan:	true if the component has connections that haven't been linked.
  * @enable:	'true' if component is currently part of an active path.
  * @activated:	'true' only if a _sink_ has been activated.  A sink can be
@@ -168,7 +167,6 @@ struct coresight_device {
 	const struct coresight_ops *ops;
 	struct device dev;
 	atomic_t *refcnt;
-	struct list_head path_link;
 	bool orphan;
 	bool enable;	/* true only if configured as part of a path */
 	bool activated;	/* true only if a sink is part of a path */
-- 
1.9.1
