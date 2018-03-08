From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu,  8 Mar 2018 11:11:49 -0800
Subject: [PATCH v5 05/21] nvmem: imx-ocotp: Convert to use
 devm_nvmem_register()
In-Reply-To: <20180308191205.26943-1-andrew.smirnov@gmail.com>
References: <20180308191205.26943-1-andrew.smirnov@gmail.com>
Message-ID: <20180308191205.26943-6-andrew.smirnov@gmail.com>
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
 drivers/nvmem/imx-ocotp.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index d7ba351a70c9..f1482c664b19 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -466,26 +466,14 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 	imx_ocotp_nvmem_config.dev = dev;
 	imx_ocotp_nvmem_config.priv = priv;
 	priv->config = &imx_ocotp_nvmem_config;
-	nvmem = nvmem_register(&imx_ocotp_nvmem_config);
+	nvmem = devm_nvmem_register(dev, &imx_ocotp_nvmem_config);
 
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
 
-	platform_set_drvdata(pdev, nvmem);
-
-	return 0;
-}
-
-static int imx_ocotp_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static struct platform_driver imx_ocotp_driver = {
 	.probe	= imx_ocotp_probe,
-	.remove	= imx_ocotp_remove,
 	.driver = {
 		.name	= "imx_ocotp",
 		.of_match_table = imx_ocotp_dt_ids,
-- 
2.14.3
