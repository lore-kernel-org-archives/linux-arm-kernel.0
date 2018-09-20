From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Thu, 20 Sep 2018 15:40:38 +0300
Subject: [PATCH 2/2] iio: adc: at91: fix wrong channel number in triggered
 buffer mode
In-Reply-To: <1537447238-18674-1-git-send-email-eugen.hristev@microchip.com>
References: <1537447238-18674-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <1537447238-18674-2-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When channels are registered, the hardware channel number is not the
actual iio channel number.
This is because the driver is probed with a certain number of accessible
channels. Some pins are routed and some not, depending on the description of
the board in the DT.
Because of that, channels 0,1,2,3 can correspond to hardware channels
2,3,4,5 for example.
In the buffered triggered case, we need to do the translation accordingly.
Fixed the channel number to stop reading the wrong channel.

Fixes 0e589d5fb "ARM: AT91: IIO: Add AT91 ADC driver."
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index e85f859..6698804 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -248,12 +248,14 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *idev = pf->indio_dev;
 	struct at91_adc_state *st = iio_priv(idev);
+	struct iio_chan_spec *chan;
 	int i, j = 0;
 
 	for (i = 0; i < idev->masklength; i++) {
 		if (!test_bit(i, idev->active_scan_mask))
 			continue;
-		st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, i));
+		chan = idev->channels + i;
+		st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, chan->channel));
 		j++;
 	}
 
-- 
2.7.4
