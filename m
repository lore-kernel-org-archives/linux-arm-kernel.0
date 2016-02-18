From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 17 Feb 2016 17:51:53 -0700
Subject: [PATCH 11/21] coresight: etm3x: set progbit to stop trace collection
In-Reply-To: <1455756723-8456-1-git-send-email-mathieu.poirier@linaro.org>
References: <1455756723-8456-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1455756723-8456-12-git-send-email-mathieu.poirier@linaro.org>
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
index e16501b41ed8..447459969cb5 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -398,9 +398,6 @@ static void etm_disable_hw(void *info)
 	CS_UNLOCK(drvdata->base);
 	etm_set_prog(drvdata);
 
-	/* Program trace enable to low by using always false event */
-	etm_writel(drvdata, ETM_HARD_WIRE_RES_A | ETM_EVENT_NOT_A, ETMTEEVR);
-
 	/* Read back sequencer and counters for post trace analysis */
 	config->seq_curr_state = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
 
-- 
2.1.4
