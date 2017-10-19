From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 19 Oct 2017 18:15:48 +0100
Subject: [PATCH 12/17] coresight etr: Relax collection of trace from sysfs mode
In-Reply-To: <20171019171553.24056-1-suzuki.poulose@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
Message-ID: <20171019171553.24056-13-suzuki.poulose@arm.com>
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
index ef7498f05b34..31353fc34b53 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1231,19 +1231,17 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
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
2.13.6
