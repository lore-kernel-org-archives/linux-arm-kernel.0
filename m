From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  6 Aug 2018 14:41:49 +0100
Subject: [PATCH 07/13] coresight: dynamic-replicator: Handle multiple
 connections
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1533562915-21558-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a replicator port is enabled, we block the traffic
on the other port and route all traffic to the new enabled
port. If there are two active trace sessions each targeting
the two different paths from the replicator, the second session
will disable the first session and route all the data to the
second path.
                    ETR
                 /
e.g, replicator
                 \
                    ETB

If CPU0 is operated in sysfs mode to ETR and CPU1 is operated
in perf mode to ETB, depending on the order in which the
replicator is enabled one device is blocked.

Ideally we need trace-id for the session to make the
right choice. That implies we need a trace-id allocation
logic for the coresight subsystem and use that to route
the traffic. The short term solution is to only manage
the "target port" and leave the other port untouched.
That leaves both the paths unaffected, except that some
unwanted traffic may be pushed to the paths (if the Trace-IDs
are not far enough), which is still fine and can be filtered
out while processing rather than silently blocking the data.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-dynamic-replicator.c       | 66 ++++++++++++++++------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index ebb8043..97f4673 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -34,26 +34,42 @@ struct replicator_state {
 	struct coresight_device	*csdev;
 };
 
+/*
+ * replicator_reset : Reset the replicator configuration to sane values.
+ */
+static void replicator_reset(struct replicator_state *drvdata)
+{
+	CS_UNLOCK(drvdata->base);
+
+	writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
+	writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
+
+	CS_LOCK(drvdata->base);
+}
+
 static int replicator_enable(struct coresight_device *csdev, int inport,
 			      int outport)
 {
+	u32 reg;
 	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	CS_UNLOCK(drvdata->base);
-
-	/*
-	 * Ensure that the other port is disabled
-	 * 0x00 - passing through the replicator unimpeded
-	 * 0xff - disable (or impede) the flow of ATB data
-	 */
-	if (outport == 0) {
-		writel_relaxed(0x00, drvdata->base + REPLICATOR_IDFILTER0);
-		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
-	} else {
-		writel_relaxed(0x00, drvdata->base + REPLICATOR_IDFILTER1);
-		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
+	switch (outport) {
+	case 0:
+		reg = REPLICATOR_IDFILTER0;
+		break;
+	case 1:
+		reg = REPLICATOR_IDFILTER1;
+		break;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
 	}
 
+	CS_UNLOCK(drvdata->base);
+
+
+	/* Ensure that the outport is enabled. */
+	writel_relaxed(0x00, drvdata->base + reg);
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
@@ -63,15 +79,25 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 static void replicator_disable(struct coresight_device *csdev, int inport,
 				int outport)
 {
+	u32 reg;
 	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
+	switch (outport) {
+	case 0:
+		reg = REPLICATOR_IDFILTER0;
+		break;
+	case 1:
+		reg = REPLICATOR_IDFILTER1;
+		break;
+	default:
+		WARN_ON(1);
+		return;
+	}
+
 	CS_UNLOCK(drvdata->base);
 
 	/* disable the flow of ATB data through port */
-	if (outport == 0)
-		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
-	else
-		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
+	writel_relaxed(0xff, drvdata->base + reg);
 
 	CS_LOCK(drvdata->base);
 
@@ -156,7 +182,11 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.groups = replicator_groups;
 	drvdata->csdev = coresight_register(&desc);
 
-	return PTR_ERR_OR_ZERO(drvdata->csdev);
+	if (!IS_ERR(drvdata->csdev)) {
+		replicator_reset(drvdata);
+		return 0;
+	}
+	return PTR_ERR(drvdata->csdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.7.4
