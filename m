From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu,  8 Mar 2018 11:11:53 -0800
Subject: [PATCH v5 09/21] nvmem: mtk-efuse: Convert to use
 devm_nvmem_register()
In-Reply-To: <20180308191205.26943-1-andrew.smirnov@gmail.com>
References: <20180308191205.26943-1-andrew.smirnov@gmail.com>
Message-ID: <20180308191205.26943-10-andrew.smirnov@gmail.com>
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
 drivers/nvmem/mtk-efuse.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 9ee3479cfc7b..e66adf17a747 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -72,20 +72,9 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	econfig.size = resource_size(res);
 	econfig.priv = priv;
 	econfig.dev = dev;
-	nvmem = nvmem_register(&econfig);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
+	nvmem = devm_nvmem_register(dev, &econfig);
 
-	platform_set_drvdata(pdev, nvmem);
-
-	return 0;
-}
-
-static int mtk_efuse_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static const struct of_device_id mtk_efuse_of_match[] = {
@@ -97,7 +86,6 @@ MODULE_DEVICE_TABLE(of, mtk_efuse_of_match);
 
 static struct platform_driver mtk_efuse_driver = {
 	.probe = mtk_efuse_probe,
-	.remove = mtk_efuse_remove,
 	.driver = {
 		.name = "mediatek,efuse",
 		.of_match_table = mtk_efuse_of_match,
-- 
2.14.3
