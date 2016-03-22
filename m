From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 22 Mar 2016 14:23:15 -0600
Subject: [PATCH 07/14] coresight: tmc: making disable function reusable
In-Reply-To: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
References: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1458678202-3447-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When disabling a TMC in any mode it may not be automatically
desirable to read the content of the trace buffer.  It is
the case when operating in Perf mode where the content of the
trace buffer is dealt with prior to the TMC being disabled.

As such moving the tmc_etb/etr_dump() functions out of the
disable_hw callback and into the current sysFS interface.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 789384be81b6..f9749924a055 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -76,7 +76,6 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 	CS_UNLOCK(drvdata->base);
 
 	tmc_flush_and_stop(drvdata);
-	tmc_etb_dump_hw(drvdata);
 	tmc_disable_hw(drvdata);
 
 	CS_LOCK(drvdata->base);
@@ -139,6 +138,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
 	}
 
 	tmc_etb_disable_hw(drvdata);
+	tmc_etb_dump_hw(drvdata);
 	drvdata->enable = false;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index e1b43e0bd1dd..67e7d5dd891f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -75,7 +75,6 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 	CS_UNLOCK(drvdata->base);
 
 	tmc_flush_and_stop(drvdata);
-	tmc_etr_dump_hw(drvdata);
 	tmc_disable_hw(drvdata);
 
 	CS_LOCK(drvdata->base);
@@ -112,6 +111,7 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
 	}
 
 	tmc_etr_disable_hw(drvdata);
+	tmc_etr_dump_hw(drvdata);
 	drvdata->enable = false;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-- 
2.1.4
