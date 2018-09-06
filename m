From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu,  6 Sep 2018 10:08:22 +0100
Subject: [PATCH v2 01/14] coresight: Handle failures in enabling a trace path
In-Reply-To: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
References: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1536224915-31766-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

coresight_enable_path() enables the components in a trace
path from a given source to a sink, excluding the source.
The operation is performed in the reverse order; the sink
first and then backwards in the list. However, if we encounter
an error in enabling any of the component, we simply disable
all the components in the given path irrespective of whether
we enabled some of the components in the enable iteration.
This could interfere with another trace session if one of the
link devices is turned off (e.g, TMC-ETF). So, we need to
make sure that we only disable those components which were
actually enabled from the iteration.

This patch achieves the same by refactoring the coresight_disable_path
to accept a "node" to start from in the forward order, which can
then be used from the error path of coresight_enable_path().
With this change, we don't issue a disable call back for a component
which didn't get enabled. This change of behavior triggers
a bug in coresight_enable_link(), where we leave the refcount
on the device and will prevent the device from being enabled
forever. So, we also drop the refcount in the coresight_enable_link()
if the operation failed.

Also, with the refactoring, we always start after the first node (which
is the "SOURCE" device) for disabling the entire path. This implies,
we must not find a "SOURCE" in the middle of the path. Hence, added
a WARN_ON() to make sure the paths we get are sane, rather than
simply ignoring them.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index e73ca6a..f4f5075 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -187,8 +187,10 @@ static int coresight_enable_link(struct coresight_device *csdev,
 	if (atomic_inc_return(&csdev->refcnt[refport]) == 1) {
 		if (link_ops(csdev)->enable) {
 			ret = link_ops(csdev)->enable(csdev, inport, outport);
-			if (ret)
+			if (ret) {
+				atomic_dec(&csdev->refcnt[refport]);
 				return ret;
+			}
 		}
 	}
 
@@ -277,13 +279,21 @@ static bool coresight_disable_source(struct coresight_device *csdev)
 	return !csdev->enable;
 }
 
-void coresight_disable_path(struct list_head *path)
+/*
+ * coresight_disable_path_from : Disable components in the given path beyond
+ * @nd in the list. If @nd is NULL, all the components, except the SOURCE are
+ * disabled.
+ */
+static void coresight_disable_path_from(struct list_head *path,
+					struct coresight_node *nd)
 {
 	u32 type;
-	struct coresight_node *nd;
 	struct coresight_device *csdev, *parent, *child;
 
-	list_for_each_entry(nd, path, link) {
+	if (!nd)
+		nd = list_first_entry(path, struct coresight_node, link);
+
+	list_for_each_entry_continue(nd, path, link) {
 		csdev = nd->csdev;
 		type = csdev->type;
 
@@ -303,7 +313,12 @@ void coresight_disable_path(struct list_head *path)
 			coresight_disable_sink(csdev);
 			break;
 		case CORESIGHT_DEV_TYPE_SOURCE:
-			/* sources are disabled from either sysFS or Perf */
+			/*
+			 * We skip the first node in the path assuming that it
+			 * is the source. So we don't expect a source device in
+			 * the middle of a path.
+			 */
+			WARN_ON(1);
 			break;
 		case CORESIGHT_DEV_TYPE_LINK:
 			parent = list_prev_entry(nd, link)->csdev;
@@ -316,6 +331,11 @@ void coresight_disable_path(struct list_head *path)
 	}
 }
 
+void coresight_disable_path(struct list_head *path)
+{
+	coresight_disable_path_from(path, NULL);
+}
+
 int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 {
 
@@ -369,7 +389,7 @@ int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 out:
 	return ret;
 err:
-	coresight_disable_path(path);
+	coresight_disable_path_from(path, nd);
 	goto out;
 }
 
-- 
2.7.4
