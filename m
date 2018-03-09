From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Fri,  9 Mar 2018 14:47:06 +0000
Subject: [PATCH 12/25] nvmem: lpc18xx_otp: Convert to use devm_nvmem_register()
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180309144719.29904-13-srinivas.kandagatla@linaro.org>
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
 drivers/nvmem/lpc18xx_otp.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/lpc18xx_otp.c b/drivers/nvmem/lpc18xx_otp.c
index 95268db155e9..549b5298ac4c 100644
--- a/drivers/nvmem/lpc18xx_otp.c
+++ b/drivers/nvmem/lpc18xx_otp.c
@@ -86,20 +86,9 @@ static int lpc18xx_otp_probe(struct platform_device *pdev)
 	lpc18xx_otp_nvmem_config.dev = &pdev->dev;
 	lpc18xx_otp_nvmem_config.priv = otp;
 
-	nvmem = nvmem_register(&lpc18xx_otp_nvmem_config);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
+	nvmem = devm_nvmem_register(&pdev->dev, &lpc18xx_otp_nvmem_config);
 
-	platform_set_drvdata(pdev, nvmem);
-
-	return 0;
-}
-
-static int lpc18xx_otp_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static const struct of_device_id lpc18xx_otp_dt_ids[] = {
@@ -110,7 +99,6 @@ MODULE_DEVICE_TABLE(of, lpc18xx_otp_dt_ids);
 
 static struct platform_driver lpc18xx_otp_driver = {
 	.probe	= lpc18xx_otp_probe,
-	.remove	= lpc18xx_otp_remove,
 	.driver = {
 		.name	= "lpc18xx_otp",
 		.of_match_table = lpc18xx_otp_dt_ids,
-- 
2.15.1
