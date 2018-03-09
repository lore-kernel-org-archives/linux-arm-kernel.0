From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Fri,  9 Mar 2018 14:47:01 +0000
Subject: [PATCH 07/25] nvmem: snvs_lgpr: Convert to use devm_nvmem_register()
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180309144719.29904-8-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Drop all of the code related to .remove hook and make use of
devm_nvmem_register() instead.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: cphealy at gmail.com
Cc: linux-kernel at vger.kernel.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
Cc: linux-amlogic at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/snvs_lpgpr.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
index e5c2a4a17f03..cb471d5e8e86 100644
--- a/drivers/nvmem/snvs_lpgpr.c
+++ b/drivers/nvmem/snvs_lpgpr.c
@@ -117,20 +117,9 @@ static int snvs_lpgpr_probe(struct platform_device *pdev)
 	cfg->reg_read  = snvs_lpgpr_read,
 	cfg->reg_write = snvs_lpgpr_write,
 
-	nvmem = nvmem_register(cfg);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
+	nvmem = devm_nvmem_register(dev, cfg);
 
-	platform_set_drvdata(pdev, nvmem);
-
-	return 0;
-}
-
-static int snvs_lpgpr_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static const struct of_device_id snvs_lpgpr_dt_ids[] = {
@@ -143,7 +132,6 @@ MODULE_DEVICE_TABLE(of, snvs_lpgpr_dt_ids);
 
 static struct platform_driver snvs_lpgpr_driver = {
 	.probe	= snvs_lpgpr_probe,
-	.remove	= snvs_lpgpr_remove,
 	.driver = {
 		.name	= "snvs_lpgpr",
 		.of_match_table = snvs_lpgpr_dt_ids,
-- 
2.15.1
