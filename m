From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  7 Nov 2018 16:08:50 -0700
Subject: [PATCH v2 2/4] coresight: etf: Release CLAIM tag after disabling the
 HW
In-Reply-To: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
References: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1541632132-1252-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch rectifies the sequence of events in function
tmc_etb_disable_hw() by disabling the HW first and then releasing the
CLAIM tag.  Otherwise we could be corrupting the configuration done by an
external agent that would have claimed the device after we have released
it.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 5864ac55e275..a5f053f2db2c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -86,8 +86,8 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 
 static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 {
-	coresight_disclaim_device(drvdata->base);
 	__tmc_etb_disable_hw(drvdata);
+	coresight_disclaim_device(drvdata->base);
 }
 
 static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
-- 
2.7.4
