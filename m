From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Fri,  9 Mar 2018 14:47:08 +0000
Subject: [PATCH 14/25] nvmem: bcm-ocotp: Convert to use devm_nvmem_register()
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180309144719.29904-15-srinivas.kandagatla@linaro.org>
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
 drivers/nvmem/bcm-ocotp.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index 5e9e324427f9..24c30fa475cc 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -302,27 +302,17 @@ static int bcm_otpc_probe(struct platform_device *pdev)
 
 	priv->config = &bcm_otpc_nvmem_config;
 
-	nvmem = nvmem_register(&bcm_otpc_nvmem_config);
+	nvmem = devm_nvmem_register(dev, &bcm_otpc_nvmem_config);
 	if (IS_ERR(nvmem)) {
 		dev_err(dev, "error registering nvmem config\n");
 		return PTR_ERR(nvmem);
 	}
 
-	platform_set_drvdata(pdev, nvmem);
-
 	return 0;
 }
 
-static int bcm_otpc_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
-}
-
 static struct platform_driver bcm_otpc_driver = {
 	.probe	= bcm_otpc_probe,
-	.remove	= bcm_otpc_remove,
 	.driver = {
 		.name	= "brcm-otpc",
 		.of_match_table = bcm_otpc_dt_ids,
-- 
2.15.1
