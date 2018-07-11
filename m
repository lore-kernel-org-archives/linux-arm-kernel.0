From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 11 Jul 2018 15:16:34 +0100
Subject: [PATCH 1/6] coresight: Fix handling of sinks
In-Reply-To: <1531318599-8840-1-git-send-email-suzuki.poulose@arm.com>
References: <1531318599-8840-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1531318599-8840-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The coresight components could be operated either in sysfs mode or in perf
mode. For some of the components, the mode of operation doesn't matter as
they simply relay the data to the next component in the trace path. But for
sinks, they need to be able to provide the trace data back to the user.
Thus we need to make sure that "mode" is handled appropriately. e.g,
the sysfs mode could have multiple sources driving the trace data, while
perf mode doesn't allow sharing the sink.

The coresight_enable_sink() however doesn't really allow this check to
trigger as it skips the "enable_sink" callback if the component is
already enabled, irrespective of the mode. This could cause mixing
of data from different modes or even same mode (in perf), if the
sources are different. Also, if we fail to enable the sink while
enabling a path (where sink is the first component enabled),
we could end up in disabling the components in the "entire"
path which were not enabled in this trial, causing disruptions
in the existing trace paths.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 3e07fd3..c0dabbd 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -132,12 +132,14 @@ static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
 {
 	int ret;
 
-	if (!csdev->enable) {
-		if (sink_ops(csdev)->enable) {
-			ret = sink_ops(csdev)->enable(csdev, mode);
-			if (ret)
-				return ret;
-		}
+	/*
+	 * We need to make sure the "new" session is compatible with the
+	 * existing "mode" of operation.
+	 */
+	if (sink_ops(csdev)->enable) {
+		ret = sink_ops(csdev)->enable(csdev, mode);
+		if (ret)
+			return ret;
 		csdev->enable = true;
 	}
 
@@ -339,8 +341,14 @@ int coresight_enable_path(struct list_head *path, u32 mode)
 		switch (type) {
 		case CORESIGHT_DEV_TYPE_SINK:
 			ret = coresight_enable_sink(csdev, mode);
+			/*
+			 * Sink is the first component turned on. If we
+			 * failed to enable the sink, there are no components
+			 * that need disabling. Disabling the path here
+			 * would mean we could disrupt an existing session.
+			 */
 			if (ret)
-				goto err;
+				goto out;
 			break;
 		case CORESIGHT_DEV_TYPE_SOURCE:
 			/* sources are enabled from either sysFS or Perf */
-- 
2.7.4
