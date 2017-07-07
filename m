From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Fri, 7 Jul 2017 01:51:31 -0500
Subject: [PATCH] iio: adc: rockchip_saradc: add NULL check on
 of_match_device() return value
Message-ID: <20170707065131.GA23382@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check return value from call to of_match_device()
in order to prevent a NULL pointer dereference.

In case of NULL print error message and return -ENODEV

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/iio/adc/rockchip_saradc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index ae6d332..2bf2ed1 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -224,6 +224,11 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	info = iio_priv(indio_dev);
 
 	match = of_match_device(rockchip_saradc_match, &pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "failed to match device\n");
+		return -ENODEV;
+	}
+
 	info->data = match->data;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.5.0
