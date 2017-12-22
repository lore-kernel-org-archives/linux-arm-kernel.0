From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Fri, 22 Dec 2017 17:07:17 +0200
Subject: [PATCH 10/14] iio: adc: at91-sama5d2_adc: force trigger removal on
 module remove
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <1513955241-10985-11-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On module remove, if we do not call trigger remove, the trigger
stays in the subsystem, and on further module insert, we will have
multiple triggers, and the old one is not usable.
Have to call the remove function on module remove to solve this.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 4eff835..7b9febc 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1180,6 +1180,9 @@ static int at91_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
+	if (st->selected_trig->hw_trig)
+		devm_iio_trigger_unregister(&indio_dev->dev, st->trig);
+
 	iio_device_unregister(indio_dev);
 
 	at91_adc_dma_disable(pdev);
-- 
2.7.4
