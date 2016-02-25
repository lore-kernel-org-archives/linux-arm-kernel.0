From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Feb 2016 12:37:40 +0100
Subject: [PATCH] spi: lp-8841: return correct error code from probe
Message-ID: <1456400265-3068525-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spi_lp8841_rtc_probe() function misses an initialization of the
return code when it fails to get its memory resource, as gcc notices:

drivers/spi/spi-lp8841-rtc.c: In function 'spi_lp8841_rtc_probe':
drivers/spi/spi-lp8841-rtc.c:239:9: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This changes the code to propagate the error from devm_ioremap_resource().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 7ecbfff6711f ("spi: master driver to enable RTC on ICPDAS LP-8841")
---
 drivers/spi/spi-lp8841-rtc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-lp8841-rtc.c b/drivers/spi/spi-lp8841-rtc.c
index 44bb69c3f1d6..faa577d282c0 100644
--- a/drivers/spi/spi-lp8841-rtc.c
+++ b/drivers/spi/spi-lp8841-rtc.c
@@ -217,8 +217,9 @@ spi_lp8841_rtc_probe(struct platform_device *pdev)
 	data = spi_master_get_devdata(master);
 
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->iomem =  devm_ioremap_resource(&pdev->dev, iomem);
-	if (IS_ERR(data->iomem)) {
+	data->iomem = devm_ioremap_resource(&pdev->dev, iomem);
+	ret = PTR_ERR_OR_ZERO(data->iomem);
+	if (ret) {
 		dev_err(&pdev->dev, "failed to get IO address\n");
 		goto err_put_master;
 	}
-- 
2.7.0
