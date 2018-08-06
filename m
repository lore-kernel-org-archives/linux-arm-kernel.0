From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  6 Aug 2018 14:41:43 +0100
Subject: [PATCH 01/13] coresight: tmc-etr: Refactor for handling errors
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1533562915-21558-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refactor the tmc-etr enable operation to make it easier to
handle errors in enabling the hardware. We need to make
sure that the buffer is compatible with the ETR. This
patch re-arranges to make the error handling easier, by
deferring the hardware enablement until all the errors
are checked. This also avoids turning the CATU on/off
during a sysfs read session.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 67 ++++++++++++++++---------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 56fea4f..c426935 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -918,21 +918,10 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
 		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
 }
 
-static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
-			      struct etr_buf *etr_buf)
+static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 {
 	u32 axictl, sts;
-
-	/* Callers should provide an appropriate buffer for use */
-	if (WARN_ON(!etr_buf || drvdata->etr_buf))
-		return;
-	drvdata->etr_buf = etr_buf;
-
-	/*
-	 * If this ETR is connected to a CATU, enable it before we turn
-	 * this on
-	 */
-	tmc_etr_enable_catu(drvdata);
+	struct etr_buf *etr_buf = drvdata->etr_buf;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -952,11 +941,8 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 		axictl |= TMC_AXICTL_ARCACHE_OS;
 	}
 
-	if (etr_buf->mode == ETR_MODE_ETR_SG) {
-		if (WARN_ON(!tmc_etr_has_cap(drvdata, TMC_ETR_SG)))
-			return;
+	if (etr_buf->mode == ETR_MODE_ETR_SG)
 		axictl |= TMC_AXICTL_SCT_GAT_MODE;
-	}
 
 	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
 	tmc_write_dba(drvdata, etr_buf->hwaddr);
@@ -982,6 +968,32 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 	CS_LOCK(drvdata->base);
 }
 
+static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
+			     struct etr_buf *etr_buf)
+{
+	/* Callers should provide an appropriate buffer for use */
+	if (WARN_ON(!etr_buf))
+		return -EINVAL;
+
+	if ((etr_buf->mode == ETR_MODE_ETR_SG) &&
+	    WARN_ON(!tmc_etr_has_cap(drvdata, TMC_ETR_SG)))
+		return -EINVAL;
+
+	if (WARN_ON(drvdata->etr_buf))
+		return -EBUSY;
+
+	/* Set the buffer for the session */
+	drvdata->etr_buf = etr_buf;
+	/*
+	 * If this ETR is connected to a CATU, enable it before we turn
+	 * this on.
+	 */
+	tmc_etr_enable_catu(drvdata);
+
+	__tmc_etr_enable_hw(drvdata);
+	return 0;
+}
+
 /*
  * Return the available trace data in the buffer (starts at etr_buf->offset,
  * limited by etr_buf->len) from @pos, with a maximum limit of @len,
@@ -1037,7 +1049,7 @@ static void tmc_etr_sync_sysfs_buf(struct tmc_drvdata *drvdata)
 	}
 }
 
-static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
+static void __tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -1053,6 +1065,11 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 
 	CS_LOCK(drvdata->base);
 
+}
+
+static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
+{
+	__tmc_etr_disable_hw(drvdata);
 	/* Disable CATU device if this ETR is connected to one */
 	tmc_etr_disable_catu(drvdata);
 	/* Reset the ETR buf used by hardware */
@@ -1111,8 +1128,9 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 		drvdata->sysfs_buf = new_buf;
 	}
 
-	drvdata->mode = CS_MODE_SYSFS;
-	tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
+	ret = tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
+	if (!ret)
+		drvdata->mode = CS_MODE_SYSFS;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -1342,8 +1360,9 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 
 	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
 	drvdata->perf_data = etr_perf;
-	drvdata->mode = CS_MODE_PERF;
-	tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
+	rc = tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
+	if (!rc)
+		drvdata->mode = CS_MODE_PERF;
 
 unlock_out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -1425,7 +1444,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 
 	/* Disable the TMC if we are trying to read from a running session. */
 	if (drvdata->mode == CS_MODE_SYSFS)
-		tmc_etr_disable_hw(drvdata);
+		__tmc_etr_disable_hw(drvdata);
 
 	drvdata->reading = true;
 out:
@@ -1452,7 +1471,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 		 * buffer. Since the tracer is still enabled drvdata::buf can't
 		 * be NULL.
 		 */
-		tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
+		__tmc_etr_enable_hw(drvdata);
 	} else {
 		/*
 		 * The ETR is not tracing and the buffer was just read.
-- 
2.7.4
