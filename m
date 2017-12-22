From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Fri, 22 Dec 2017 17:07:18 +0200
Subject: [PATCH 11/14] iio: adc: at91-sama5d2_adc: optimize scan index for
 diff channels
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <1513955241-10985-12-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Optimize the scan index for the differential channels. Before, it
was single channel count + index of the first single channel
number of the differential pair. (e.g. 11+0, +2, +4, etc.)
Divide that number by two (since it's always even), and add it up
as a scan index to have consecutive numbered channels in the
index.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 7b9febc..9610393 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -209,7 +209,7 @@
 		.channel = num,						\
 		.channel2 = num2,					\
 		.address = addr,					\
-		.scan_index = num + AT91_SAMA5D2_SINGLE_CHAN_CNT,	\
+		.scan_index = (num >> 1) + AT91_SAMA5D2_SINGLE_CHAN_CNT,\
 		.scan_type = {						\
 			.sign = 's',					\
 			.realbits = 12,					\
-- 
2.7.4
