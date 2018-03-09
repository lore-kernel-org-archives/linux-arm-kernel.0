From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Fri,  9 Mar 2018 14:47:09 +0000
Subject: [PATCH 15/25] nvmem: qfprom: Convert to use devm_nvmem_register()
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180309144719.29904-16-srinivas.kandagatla@linaro.org>
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
 drivers/nvmem/qfprom.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index cb3b48b47d64..4f650baad983 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -47,13 +47,6 @@ static int qfprom_reg_write(void *context,
 	return 0;
 }
 
-static int qfprom_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
-}
-
 static struct nvmem_config econfig = {
 	.name = "qfprom",
 	.stride = 1,
@@ -82,13 +75,9 @@ static int qfprom_probe(struct platform_device *pdev)
 	econfig.dev = dev;
 	econfig.priv = priv;
 
-	nvmem = nvmem_register(&econfig);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
-
-	platform_set_drvdata(pdev, nvmem);
+	nvmem = devm_nvmem_register(dev, &econfig);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static const struct of_device_id qfprom_of_match[] = {
@@ -99,7 +88,6 @@ MODULE_DEVICE_TABLE(of, qfprom_of_match);
 
 static struct platform_driver qfprom_driver = {
 	.probe = qfprom_probe,
-	.remove = qfprom_remove,
 	.driver = {
 		.name = "qcom,qfprom",
 		.of_match_table = qfprom_of_match,
-- 
2.15.1
