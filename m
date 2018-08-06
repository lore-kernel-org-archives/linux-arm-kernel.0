From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  6 Aug 2018 14:41:55 +0100
Subject: [PATCH 13/13] coreisght: tmc: Claim device before use
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1533562915-21558-14-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use CLAIM tags to make sure the device is available for use.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 22 +++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc-etr.c |  4 ++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index ceb4b30..59d862d6e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -36,6 +36,11 @@ static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 
 static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 {
+	int rc = coresight_claim_device(drvdata->base);
+
+	if (rc)
+		return rc;
+
 	__tmc_etb_enable_hw(drvdata);
 	return 0;
 }
@@ -66,7 +71,7 @@ static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 	return;
 }
 
-static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
+static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -82,6 +87,12 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
+{
+	coresight_disclaim_device(drvdata);
+	__tmc_etb_disable_hw(drvdata);
+}
+
 static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
@@ -100,6 +111,11 @@ static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 
 static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 {
+	int rc = coresight_claim_device(drvdata->base);
+
+	if (rc)
+		return rc;
+
 	__tmc_etf_enable_hw(drvdata);
 	return 0;
 }
@@ -110,7 +126,7 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 
 	tmc_flush_and_stop(drvdata);
 	tmc_disable_hw(drvdata);
-
+	coresight_disclaim_device_unlocked(drvdata->base);
 	CS_LOCK(drvdata->base);
 }
 
@@ -556,7 +572,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 
 	/* Disable the TMC if need be */
 	if (drvdata->mode == CS_MODE_SYSFS)
-		tmc_etb_disable_hw(drvdata);
+		__tmc_etb_disable_hw(drvdata);
 
 	drvdata->reading = true;
 out:
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index daad521..f684283 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -991,6 +991,9 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 	 * this on.
 	 */
 	rc = tmc_etr_enable_catu(drvdata, etr_buf);
+	if (rc)
+		return rc;
+	rc = coresight_claim_device(drvdata->base);
 	if (!rc) {
 		drvdata->etr_buf = etr_buf;
 		__tmc_etr_enable_hw(drvdata);
@@ -1077,6 +1080,7 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 	__tmc_etr_disable_hw(drvdata);
 	/* Disable CATU device if this ETR is connected to one */
 	tmc_etr_disable_catu(drvdata);
+	coresight_disclaim_device(drvdata->base);
 	/* Reset the ETR buf used by hardware */
 	drvdata->etr_buf = NULL;
 }
-- 
2.7.4
