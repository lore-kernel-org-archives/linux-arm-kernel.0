From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu,  3 Dec 2015 14:04:46 -0700
Subject: [PATCH V6 10/26] coresight: etm3x: set progbit to stop trace
 collection
In-Reply-To: <1449176702-13213-1-git-send-email-mathieu.poirier@linaro.org>
References: <1449176702-13213-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1449176702-13213-11-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to use the event enable's "always false" event to
stop trace collection.  For that purpose setting the programming bit
(ETMCR:10) is enough.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 0035953a1102..a0252ffb4ba7 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -422,9 +422,6 @@ static void etm_disable_hw(void *info)
 	CS_UNLOCK(drvdata->base);
 	etm_set_prog(drvdata);
 
-	/* Program trace enable to low by using always false event */
-	etm_writel(drvdata, ETM_HARD_WIRE_RES_A | ETM_EVENT_NOT_A, ETMTEEVR);
-
 	/* Read back sequencer and counters for post trace analysis */
 	config->seq_curr_state = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
 
-- 
2.1.4
