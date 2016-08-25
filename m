From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 25 Aug 2016 15:18:55 -0600
Subject: [PATCH 05/28] coresight: Consolidate error handling path for tmc_probe
In-Reply-To: <1472159958-5981-1-git-send-email-mathieu.poirier@linaro.org>
References: <1472159958-5981-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1472159958-5981-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

This patch cleans up the error handling path for tmc_probe
as a side effect of the removal of the spurious dma_free_coherent().

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 36 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 3978cbb6b038..1b47258e01c9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -309,22 +309,31 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 
 	if (np) {
 		pdata = of_get_coresight_platform_data(dev, np);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
+		if (IS_ERR(pdata)) {
+			ret = PTR_ERR(pdata);
+			goto out;
+		}
 		adev->dev.platform_data = pdata;
 	}
 
+	ret = -ENOMEM;
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
-		return -ENOMEM;
+		goto out;
+
+	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		goto out;
 
 	drvdata->dev = &adev->dev;
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
 	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto out;
+	}
 
 	drvdata->base = base;
 
@@ -347,12 +356,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 
 	pm_runtime_put(&adev->dev);
 
-	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
-	if (!desc) {
-		ret = -ENOMEM;
-		goto err_devm_kzalloc;
-	}
-
 	desc->pdata = pdata;
 	desc->dev = dev;
 	desc->subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
@@ -373,7 +376,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->csdev = coresight_register(desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
-		goto err_devm_kzalloc;
+		goto out;
 	}
 
 	drvdata->miscdev.name = pdata->name;
@@ -381,13 +384,8 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->miscdev.fops = &tmc_fops;
 	ret = misc_register(&drvdata->miscdev);
 	if (ret)
-		goto err_misc_register;
-
-	return 0;
-
-err_misc_register:
-	coresight_unregister(drvdata->csdev);
-err_devm_kzalloc:
+		coresight_unregister(drvdata->csdev);
+out:
 	return ret;
 }
 
-- 
2.7.4
