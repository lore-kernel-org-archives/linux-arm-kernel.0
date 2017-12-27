From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 27 Dec 2017 14:59:44 -0800
Subject: [PATCH 08/20] nvmem: qfprom: Convert to use devm_nvmem_register()
In-Reply-To: <20171227225956.14442-1-andrew.smirnov@gmail.com>
References: <20171227225956.14442-1-andrew.smirnov@gmail.com>
Message-ID: <20171227225956.14442-9-andrew.smirnov@gmail.com>
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
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: cphealy at gmail.com
Cc: linux-kernel at vger.kernel.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
Cc: linux-amlogic at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/nvmem/qfprom.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index cb3b48b47d64..13bf43c84bd4 100644
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
@@ -82,12 +75,10 @@ static int qfprom_probe(struct platform_device *pdev)
 	econfig.dev = dev;
 	econfig.priv = priv;
 
-	nvmem = nvmem_register(&econfig);
+	nvmem = devm_nvmem_register(dev, &econfig);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
 
-	platform_set_drvdata(pdev, nvmem);
-
 	return 0;
 }
 
@@ -99,7 +90,6 @@ MODULE_DEVICE_TABLE(of, qfprom_of_match);
 
 static struct platform_driver qfprom_driver = {
 	.probe = qfprom_probe,
-	.remove = qfprom_remove,
 	.driver = {
 		.name = "qcom,qfprom",
 		.of_match_table = qfprom_of_match,
-- 
2.14.3
