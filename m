From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  6 Aug 2018 14:41:44 +0100
Subject: [PATCH 02/13] coresight: tmc-etr: Handle errors enabling CATU
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1533562915-21558-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure we honor the errors in CATU device and abort the operation.
While at it, delay setting the etr_buf for the session until we are
sure that we are indeed enabling the ETR.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index c426935..daad521 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -751,12 +751,14 @@ tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
 	return NULL;
 }
 
-static inline void tmc_etr_enable_catu(struct tmc_drvdata *drvdata)
+static inline int tmc_etr_enable_catu(struct tmc_drvdata *drvdata,
+				      struct etr_buf *etr_buf)
 {
 	struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
 
 	if (catu && helper_ops(catu)->enable)
-		helper_ops(catu)->enable(catu, drvdata->etr_buf);
+		return helper_ops(catu)->enable(catu, etr_buf);
+	return 0;
 }
 
 static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
@@ -971,6 +973,8 @@ static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 			     struct etr_buf *etr_buf)
 {
+	int rc;
+
 	/* Callers should provide an appropriate buffer for use */
 	if (WARN_ON(!etr_buf))
 		return -EINVAL;
@@ -982,16 +986,17 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 	if (WARN_ON(drvdata->etr_buf))
 		return -EBUSY;
 
-	/* Set the buffer for the session */
-	drvdata->etr_buf = etr_buf;
 	/*
 	 * If this ETR is connected to a CATU, enable it before we turn
 	 * this on.
 	 */
-	tmc_etr_enable_catu(drvdata);
+	rc = tmc_etr_enable_catu(drvdata, etr_buf);
+	if (!rc) {
+		drvdata->etr_buf = etr_buf;
+		__tmc_etr_enable_hw(drvdata);
+	}
 
-	__tmc_etr_enable_hw(drvdata);
-	return 0;
+	return rc;
 }
 
 /*
-- 
2.7.4
