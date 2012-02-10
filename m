From: hs1218.kang@samsung.com (Huisung Kang)
Date: Fri, 10 Feb 2012 21:22:58 +0900
Subject: [PATCH] ARM: SAMSUNG: Add over sampling preventing code
Message-ID: <017001cce7ee$b97cac50$2c7604f0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dongsoo Ha <dsfine.ha@samsung.com>

Multiple calling adc by other device have happend over sampling.
It can be TS(TouchScreen), in the issue, while the adc is approaching.
This commit is preventing code for over sampling.

Signed-off-by: Dongsoo Ha <dsfine.ha@samsung.com>
Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
---
 arch/arm/plat-samsung/adc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index 33ecd0c..10b32ea 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -297,7 +297,8 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 	data1 = readl(adc->regs + S3C2410_ADCDAT1);
 	adc_dbg(adc, "read %d: 0x%04x, 0x%04x\n", client->nr_samples, data0, data1);
 
-	client->nr_samples--;
+	if (client->nr_samples > 0)
+		client->nr_samples--;
 
 	if (cpu == TYPE_ADCV1 || cpu == TYPE_ADCV11) {
 		data0 &= 0x3ff;
-- 
1.7.1
