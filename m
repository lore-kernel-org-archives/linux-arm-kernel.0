From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Thu, 20 Sep 2018 15:40:37 +0300
Subject: [PATCH 1/2] iio: adc: at91: fix acking DRDY irq on simple conversions
Message-ID: <1537447238-18674-1-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When doing simple conversions, the driver did not acknowledge the DRDY irq.
If this irq is not acked, it will be left pending, and as soon as a trigger
is enabled, the irq handler will be called, it doesn't know why this irq
has occurred because no channel is pending, and then we will have irq loop
and board will hang.

Fixes 0e589d5fb ("ARM: AT91: IIO: Add AT91 ADC driver.")
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91_adc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 44b5168..e85f859 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -712,6 +712,11 @@ static int at91_adc_read_raw(struct iio_dev *idev,
 		at91_adc_writel(st, AT91_ADC_CHDR,
 				AT91_ADC_CH(chan->channel));
 		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
+		/*
+		 * we need to ack the DRDY irq, otherwise it will be
+		 * left pending and irq handler will be confused
+		 */
+		at91_adc_readl(st, AT91_ADC_LCDR);
 
 		st->last_value = 0;
 		st->done = false;
-- 
2.7.4
