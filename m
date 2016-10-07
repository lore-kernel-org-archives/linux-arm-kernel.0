From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri,  7 Oct 2016 15:10:43 -0600
Subject: [PATCH] coresight: reset "enable_sink" flag when need be
Message-ID: <1475874643-9464-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using coresight from the perf interface sinks are specified
as part of the perf command line.  As such the sink needs to be
disabled once it has been acknowledged by the coresight framework.
Otherwise the sink stays enabled, which may interfere with other
sessions.

This patch removes the sink selection check from the build path
process and make it a function on it's own.  The function is
then used when operating from sysFS or perf to determine what
sink has been selected.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 31 ++++++------
 drivers/hwtracing/coresight/coresight-priv.h     |  4 +-
 drivers/hwtracing/coresight/coresight.c          | 62 +++++++++++++++++++++---
 3 files changed, 75 insertions(+), 22 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 2cd7c718198a..1103073b2640 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -202,6 +202,21 @@ static void *etm_setup_aux(int event_cpu, void **pages,
 	if (!event_data)
 		return NULL;
 
+	/*
+	 * In theory nothing prevent tracers in a trace session from being
+	 * associated with different sinks, nor having a sink per tracer.  But
+	 * until we have HW with this kind of topolog we need to assume tracers
+	 * in a trace session are using the same sink.  Therefore go through
+	 * the coresight bus and pick the first enabled sink.
+	 *
+	 * When operated from sysFS users are responsible to enable the sink
+	 * while from perf, the perf tools will do it based on the choice made
+	 * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
+	 */
+	sink = coresight_get_enabled_sink(true);
+	if (!sink)
+		return NULL;
+
 	INIT_WORK(&event_data->work, free_event_data);
 
 	mask = &event_data->mask;
@@ -219,25 +234,11 @@ static void *etm_setup_aux(int event_cpu, void **pages,
 		 * list of devices from source to sink that can be
 		 * referenced later when the path is actually needed.
 		 */
-		event_data->path[cpu] = coresight_build_path(csdev);
+		event_data->path[cpu] = coresight_build_path(csdev, sink);
 		if (IS_ERR(event_data->path[cpu]))
 			goto err;
 	}
 
-	/*
-	 * In theory nothing prevent tracers in a trace session from being
-	 * associated with different sinks, nor having a sink per tracer.  But
-	 * until we have HW with this kind of topology and a way to convey
-	 * sink assignement from the perf cmd line we need to assume tracers
-	 * in a trace session are using the same sink.  Therefore pick the sink
-	 * found at the end of the first available path.
-	 */
-	cpu = cpumask_first(mask);
-	/* Grab the sink at the end of the path */
-	sink = coresight_get_sink(event_data->path[cpu]);
-	if (!sink)
-		goto err;
-
 	if (!sink_ops(sink)->alloc_buffer)
 		goto err;
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 196a14be4b3d..ef9d8e93e3b2 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -111,7 +111,9 @@ static inline void CS_UNLOCK(void __iomem *addr)
 void coresight_disable_path(struct list_head *path);
 int coresight_enable_path(struct list_head *path, u32 mode);
 struct coresight_device *coresight_get_sink(struct list_head *path);
-struct list_head *coresight_build_path(struct coresight_device *csdev);
+struct coresight_device *coresight_get_enabled_sink(bool reset);
+struct list_head *coresight_build_path(struct coresight_device *csdev,
+				       struct coresight_device *sink);
 void coresight_release_path(struct list_head *path);
 
 #ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 7bf00a0beb6f..40ede643d553 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -368,6 +368,40 @@ struct coresight_device *coresight_get_sink(struct list_head *path)
 	return csdev;
 }
 
+static int coresight_enabled_sink(struct device *dev, void *data)
+{
+	bool *reset = data;
+	struct coresight_device *csdev = to_coresight_device(dev);
+
+	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
+	     csdev->activated) {
+		/*
+		 * Now that we have a handle on the sink for this session,
+		 * disable the sysFS "enable_sink" flag so that possible
+		 * concurrent perf session that wish to use another sink don't
+		 * trip on it.  Doing so has no ramification for the current
+		 * session.
+		 */
+		if (*reset)
+			csdev->activated = false;
+
+		return 1;
+	}
+
+	return 0;
+}
+
+struct coresight_device *coresight_get_enabled_sink(bool reset)
+{
+	struct device *dev = NULL;
+
+	dev = bus_find_device(&coresight_bustype, NULL, &reset,
+			      coresight_enabled_sink);
+
+	return dev ? to_coresight_device(dev) : NULL;
+}
+
 /**
  * _coresight_build_path - recursively build a path from a @csdev to a sink.
  * @csdev:	The device to start from.
@@ -380,6 +414,7 @@ struct coresight_device *coresight_get_sink(struct list_head *path)
  * last one.
  */
 static int _coresight_build_path(struct coresight_device *csdev,
+				 struct coresight_device *sink,
 				 struct list_head *path)
 {
 	int i;
@@ -387,15 +422,15 @@ static int _coresight_build_path(struct coresight_device *csdev,
 	struct coresight_node *node;
 
 	/* An activated sink has been found.  Enqueue the element */
-	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
-	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) && csdev->activated)
+	if (csdev == sink)
 		goto out;
 
 	/* Not a sink - recursively explore each port found on this element */
 	for (i = 0; i < csdev->nr_outport; i++) {
 		struct coresight_device *child_dev = csdev->conns[i].child_dev;
 
-		if (child_dev && _coresight_build_path(child_dev, path) == 0) {
+		if (child_dev &&
+		    _coresight_build_path(child_dev, sink, path) == 0) {
 			found = true;
 			break;
 		}
@@ -422,18 +457,22 @@ out:
 	return 0;
 }
 
-struct list_head *coresight_build_path(struct coresight_device *csdev)
+struct list_head *coresight_build_path(struct coresight_device *source,
+				       struct coresight_device *sink)
 {
 	struct list_head *path;
 	int rc;
 
+	if (!sink)
+		return ERR_PTR(-EINVAL);
+
 	path = kzalloc(sizeof(struct list_head), GFP_KERNEL);
 	if (!path)
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(path);
 
-	rc = _coresight_build_path(csdev, path);
+	rc = _coresight_build_path(source, sink, path);
 	if (rc) {
 		kfree(path);
 		return ERR_PTR(rc);
@@ -497,6 +536,7 @@ static int coresight_validate_source(struct coresight_device *csdev,
 int coresight_enable(struct coresight_device *csdev)
 {
 	int cpu, ret = 0;
+	struct coresight_device *sink;
 	struct list_head *path;
 
 	mutex_lock(&coresight_mutex);
@@ -508,7 +548,17 @@ int coresight_enable(struct coresight_device *csdev)
 	if (csdev->enable)
 		goto out;
 
-	path = coresight_build_path(csdev);
+	/*
+	 * Search for a valid sink for this session but don't reset the
+	 * "enable_sink" flag in sysFS.  Users get to do that explicitly.
+	 */
+	sink = coresight_get_enabled_sink(false);
+	if (!sink) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	path = coresight_build_path(csdev, sink);
 	if (IS_ERR(path)) {
 		pr_err("building path(s) failed\n");
 		ret = PTR_ERR(path);
-- 
2.7.4
