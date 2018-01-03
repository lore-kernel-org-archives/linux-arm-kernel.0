From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed,  3 Jan 2018 12:00:59 -0800
Subject: [PATCH v3 07/22] nvmem: snvs_lgpr: Convert to use
 devm_nvmem_register()
In-Reply-To: <20180103200114.23922-1-andrew.smirnov@gmail.com>
References: <20180103200114.23922-1-andrew.smirnov@gmail.com>
Message-ID: <20180103200114.23922-8-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
 drivers/nvmem/snvs_lpgpr.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
index e5c2a4a17f03..6a2fdd09e74a 100644
--- a/drivers/nvmem/snvs_lpgpr.c
+++ b/drivers/nvmem/snvs_lpgpr.c
@@ -117,22 +117,13 @@ static int snvs_lpgpr_probe(struct platform_device *pdev)
 	cfg->reg_read  = snvs_lpgpr_read,
 	cfg->reg_write = snvs_lpgpr_write,
 
-	nvmem = nvmem_register(cfg);
+	nvmem = devm_nvmem_register(dev, cfg);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
 
-	platform_set_drvdata(pdev, nvmem);
-
 	return 0;
 }
 
-static int snvs_lpgpr_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
-}
-
 static const struct of_device_id snvs_lpgpr_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-snvs-lpgpr", .data = &snvs_lpgpr_cfg_imx6q },
 	{ .compatible = "fsl,imx6ul-snvs-lpgpr",
@@ -143,7 +134,6 @@ MODULE_DEVICE_TABLE(of, snvs_lpgpr_dt_ids);
 
 static struct platform_driver snvs_lpgpr_driver = {
 	.probe	= snvs_lpgpr_probe,
-	.remove	= snvs_lpgpr_remove,
 	.driver = {
 		.name	= "snvs_lpgpr",
 		.of_match_table = snvs_lpgpr_dt_ids,
-- 
2.14.3
