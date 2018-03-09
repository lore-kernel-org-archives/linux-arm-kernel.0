From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Fri,  9 Mar 2018 14:47:04 +0000
Subject: [PATCH 10/25] nvmem: meson-mx-efuse: Convert to use
 devm_nvmem_register()
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180309144719.29904-11-srinivas.kandagatla@linaro.org>
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
 drivers/nvmem/meson-mx-efuse.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 41d3a3c1104e..a085563e39e3 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -233,25 +233,13 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 		return PTR_ERR(efuse->core_clk);
 	}
 
-	efuse->nvmem = nvmem_register(&efuse->config);
-	if (IS_ERR(efuse->nvmem))
-		return PTR_ERR(efuse->nvmem);
+	efuse->nvmem = devm_nvmem_register(&pdev->dev, &efuse->config);
 
-	platform_set_drvdata(pdev, efuse);
-
-	return 0;
-}
-
-static int meson_mx_efuse_remove(struct platform_device *pdev)
-{
-	struct meson_mx_efuse *efuse = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(efuse->nvmem);
+	return PTR_ERR_OR_ZERO(efuse->nvmem);
 }
 
 static struct platform_driver meson_mx_efuse_driver = {
 	.probe = meson_mx_efuse_probe,
-	.remove = meson_mx_efuse_remove,
 	.driver = {
 		.name = "meson-mx-efuse",
 		.of_match_table = meson_mx_efuse_match,
-- 
2.15.1
