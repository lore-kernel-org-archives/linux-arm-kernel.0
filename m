From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  1 May 2018 10:10:36 +0100
Subject: [PATCH v2 06/27] coresight: tmc etr: Disallow perf mode temporarily
In-Reply-To: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1525165857-11096-7-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't support ETR in perf mode yet. Temporarily fail the
operation until we add proper support.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 28 ++-----------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 9b0c620..bff46f2 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -218,32 +218,8 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 
 static int tmc_enable_etr_sink_perf(struct coresight_device *csdev)
 {
-	int ret = 0;
-	unsigned long flags;
-	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (drvdata->reading) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/*
-	 * In Perf mode there can be only one writer per sink.  There
-	 * is also no need to continue if the ETR is already operated
-	 * from sysFS.
-	 */
-	if (drvdata->mode != CS_MODE_DISABLED) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	drvdata->mode = CS_MODE_PERF;
-	tmc_etr_enable_hw(drvdata);
-out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-
-	return ret;
+	/* We don't support perf mode yet ! */
+	return -EINVAL;
 }
 
 static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
-- 
2.7.4
