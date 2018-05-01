From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  1 May 2018 10:10:54 +0100
Subject: [PATCH v2 24/27] coresight: tmc-etr: Relax collection of trace from
 sysfs mode
In-Reply-To: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1525165857-11096-25-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the ETR now uses mode specific buffers, we can reliably
provide the trace data captured in sysfs mode, even when the ETR
is operating in PERF mode.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index a35a12f..7551272 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1439,19 +1439,17 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 		goto out;
 	}
 
-	/* Don't interfere if operated from Perf */
-	if (drvdata->mode == CS_MODE_PERF) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/* If sysfs_buf is NULL the trace data has been read already */
+	/*
+	 * We can safely allow reads even if the ETR is operating in PERF mode,
+	 * since the sysfs session is captured in mode specific data.
+	 * If drvdata::sysfs_data is NULL the trace data has been read already.
+	 */
 	if (!drvdata->sysfs_buf) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	/* Disable the TMC if we are trying to read from a running session */
+	/* Disable the TMC if we are trying to read from a running session. */
 	if (drvdata->mode == CS_MODE_SYSFS)
 		tmc_etr_disable_hw(drvdata);
 
-- 
2.7.4
