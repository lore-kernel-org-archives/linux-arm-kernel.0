From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  6 Aug 2018 14:41:53 +0100
Subject: [PATCH 11/13] coresight: catu: Claim device before use
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1533562915-21558-12-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the CLAIM protocol to grab the ownership of the component when
in use.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index ff94e58..170fbb6 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -406,6 +406,7 @@ static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
 
 static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 {
+	int rc;
 	u32 control, mode;
 	struct etr_buf *etr_buf = data;
 
@@ -418,6 +419,10 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 		return -EBUSY;
 	}
 
+	rc = coresight_claim_device_unlocked(drvdata->base);
+	if (rc)
+		return rc;
+
 	control |= BIT(CATU_CONTROL_ENABLE);
 
 	if (etr_buf && etr_buf->mode == ETR_MODE_CATU) {
@@ -459,6 +464,7 @@ static int catu_disable_hw(struct catu_drvdata *drvdata)
 	int rc = 0;
 
 	catu_write_control(drvdata, 0);
+	coresight_disclaim_device_unlocked(drvdata->base);
 	if (catu_wait_for_ready(drvdata)) {
 		dev_info(drvdata->dev, "Timeout while waiting for READY\n");
 		rc = -EAGAIN;
-- 
2.7.4
