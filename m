From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  6 Aug 2018 14:41:54 +0100
Subject: [PATCH 12/13] coresight: dynamic-replicator: Claim device for use
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1533562915-21558-13-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use CLAIM protocol to make sure the device is available for use.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-dynamic-replicator.c       | 23 +++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index 97f4673..299667b 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -41,8 +41,11 @@ static void replicator_reset(struct replicator_state *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
-	writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
-	writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
+	if (!coresight_claim_device_unlocked(drvdata->base)) {
+		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
+		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
+		coresight_disclaim_device_unlocked(drvdata->base);
+	}
 
 	CS_LOCK(drvdata->base);
 }
@@ -50,6 +53,7 @@ static void replicator_reset(struct replicator_state *drvdata)
 static int replicator_enable(struct coresight_device *csdev, int inport,
 			      int outport)
 {
+	int rc = 0;
 	u32 reg;
 	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -67,13 +71,19 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 
 	CS_UNLOCK(drvdata->base);
 
+	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
+	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
+		rc = coresight_claim_device_unlocked(drvdata->base);
 
 	/* Ensure that the outport is enabled. */
-	writel_relaxed(0x00, drvdata->base + reg);
+	if (!rc) {
+		writel_relaxed(0x00, drvdata->base + reg);
+		dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
+	}
+
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
-	return 0;
+	return rc;
 }
 
 static void replicator_disable(struct coresight_device *csdev, int inport,
@@ -99,6 +109,9 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 	/* disable the flow of ATB data through port */
 	writel_relaxed(0xff, drvdata->base + reg);
 
+	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
+	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
+		coresight_disclaim_device_unlocked(drvdata->base);
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
-- 
2.7.4
