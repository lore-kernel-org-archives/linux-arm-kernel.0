From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 12 Apr 2016 11:54:47 -0600
Subject: [PATCH V2 10/15] coresight: tmc: dump system memory content only when
 needed
In-Reply-To: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1460483692-25061-11-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calling tmc_etf/etr_dump_hw() is required only when operating from
sysFS.  When working from Perf, the system memory is harvested
from the AUX trace API.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 7 ++++++-
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 5908000e1ae0..9b4cdaed09f5 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -74,7 +74,12 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 	CS_UNLOCK(drvdata->base);
 
 	tmc_flush_and_stop(drvdata);
-	tmc_etb_dump_hw(drvdata);
+	/*
+	 * When operating in sysFS mode the content of the buffer needs to be
+	 * read before the TMC is disabled.
+	 */
+	if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
+		tmc_etb_dump_hw(drvdata);
 	tmc_disable_hw(drvdata);
 
 	CS_LOCK(drvdata->base);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 8e6fe267195a..de5cf0056802 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -76,7 +76,12 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 	CS_UNLOCK(drvdata->base);
 
 	tmc_flush_and_stop(drvdata);
-	tmc_etr_dump_hw(drvdata);
+	/*
+	 * When operating in sysFS mode the content of the buffer needs to be
+	 * read before the TMC is disabled.
+	 */
+	if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
+		tmc_etr_dump_hw(drvdata);
 	tmc_disable_hw(drvdata);
 
 	CS_LOCK(drvdata->base);
-- 
2.5.0
