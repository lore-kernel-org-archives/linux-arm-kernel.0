From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  5 Nov 2018 15:26:30 -0700
Subject: [PATCH 3/3] coresight: etm3x: Release CLAIM tag when operated from
 perf
In-Reply-To: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
References: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1541456790-28282-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch deals with the release of the CLAIM tag when the ETM is
operated from perf.  Otherwise the tag is left asserted and subsequent
requests to use the device fail.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index fd5c4cca7db5..000796394662 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -603,6 +603,8 @@ static void etm_disable_perf(struct coresight_device *csdev)
 	 */
 	etm_set_pwrdwn(drvdata);
 
+	coresight_disclaim_device_unlocked(drvdata->base);
+
 	CS_LOCK(drvdata->base);
 }
 
-- 
2.7.4
