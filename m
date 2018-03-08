From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu,  8 Mar 2018 11:11:55 -0800
Subject: [PATCH v5 11/21] nvmem: meson-efuse: Convert to use
 devm_nvmem_register()
In-Reply-To: <20180308191205.26943-1-andrew.smirnov@gmail.com>
References: <20180308191205.26943-1-andrew.smirnov@gmail.com>
Message-ID: <20180308191205.26943-12-andrew.smirnov@gmail.com>
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
 drivers/nvmem/meson-efuse.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index a43c68f90937..71823d1403c5 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -60,25 +60,13 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	econfig.reg_read = meson_efuse_read;
 	econfig.size = size;
 
-	nvmem = nvmem_register(&econfig);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
+	nvmem = devm_nvmem_register(&pdev->dev, &econfig);
 
-	platform_set_drvdata(pdev, nvmem);
-
-	return 0;
-}
-
-static int meson_efuse_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static struct platform_driver meson_efuse_driver = {
 	.probe = meson_efuse_probe,
-	.remove = meson_efuse_remove,
 	.driver = {
 		.name = "meson-efuse",
 		.of_match_table = meson_efuse_match,
-- 
2.14.3
