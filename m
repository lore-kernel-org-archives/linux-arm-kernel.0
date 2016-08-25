From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 25 Aug 2016 15:18:54 -0600
Subject: [PATCH 04/28] coresight: Remove erroneous dma_free_coherent in
 tmc_probe
In-Reply-To: <1472159958-5981-1-git-send-email-mathieu.poirier@linaro.org>
References: <1472159958-5981-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1472159958-5981-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit de5461970b3e9e194 ("coresight: tmc: allocating memory when needed")
removed the static allocation of buffer for the trace data in ETR mode in
tmc_probe. However it failed to remove the "devm_free_coherent" in
tmc_probe when the probe fails due to other reasons. This patch gets
rid of the incorrect dma_free_coherent() call.

Fixes: commit de5461970b3e9e194 ("coresight: tmc: allocating memory when needed")
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 9e02ac963cd0..3978cbb6b038 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -388,9 +388,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 err_misc_register:
 	coresight_unregister(drvdata->csdev);
 err_devm_kzalloc:
-	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
-		dma_free_coherent(dev, drvdata->size,
-				drvdata->vaddr, drvdata->paddr);
 	return ret;
 }
 
-- 
2.7.4
