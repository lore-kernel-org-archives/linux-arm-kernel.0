From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed,  3 Jan 2018 12:01:05 -0800
Subject: [PATCH v3 13/22] nvmem: lpc18xx_otp: Convert to use
 devm_nvmem_register()
In-Reply-To: <20180103200114.23922-1-andrew.smirnov@gmail.com>
References: <20180103200114.23922-1-andrew.smirnov@gmail.com>
Message-ID: <20180103200114.23922-14-andrew.smirnov@gmail.com>
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
 drivers/nvmem/lpc18xx_otp.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/nvmem/lpc18xx_otp.c b/drivers/nvmem/lpc18xx_otp.c
index 95268db155e9..74777bfe2dcd 100644
--- a/drivers/nvmem/lpc18xx_otp.c
+++ b/drivers/nvmem/lpc18xx_otp.c
@@ -86,22 +86,13 @@ static int lpc18xx_otp_probe(struct platform_device *pdev)
 	lpc18xx_otp_nvmem_config.dev = &pdev->dev;
 	lpc18xx_otp_nvmem_config.priv = otp;
 
-	nvmem = nvmem_register(&lpc18xx_otp_nvmem_config);
+	nvmem = devm_nvmem_register(&pdev->dev, &lpc18xx_otp_nvmem_config);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
 
-	platform_set_drvdata(pdev, nvmem);
-
 	return 0;
 }
 
-static int lpc18xx_otp_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
-}
-
 static const struct of_device_id lpc18xx_otp_dt_ids[] = {
 	{ .compatible = "nxp,lpc1850-otp" },
 	{ },
@@ -110,7 +101,6 @@ MODULE_DEVICE_TABLE(of, lpc18xx_otp_dt_ids);
 
 static struct platform_driver lpc18xx_otp_driver = {
 	.probe	= lpc18xx_otp_probe,
-	.remove	= lpc18xx_otp_remove,
 	.driver = {
 		.name	= "lpc18xx_otp",
 		.of_match_table = lpc18xx_otp_dt_ids,
-- 
2.14.3
