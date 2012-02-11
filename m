From: hs1218.kang@samsung.com (Huisung Kang)
Date: Sat, 11 Feb 2012 11:50:00 +0900
Subject: [PATCH] ARM: SAMSUNG: Additional code with standby mode
Message-ID: <018001cce867$d93868d0$8ba93a70$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dongsoo Ha <dsfine.ha@samsung.com>

ADC device support standby mode that is activated
when TSSEL by '0' and STANBY by '1' bits are set in TSADCCON0
register. ADC operations are halt itself and hold TSDATXn(Yn)
values. It has been having power saving effect since it works.

Signed-off-by: Dongsoo Ha <dsfine.ha@samsung.com>
Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
---
 arch/arm/plat-samsung/adc.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index 10b32ea..e4e965c 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -104,6 +104,7 @@ static inline void s3c_adc_select(struct adc_device *adc,
 		con &= ~S3C2410_ADCCON_MUXMASK;
 	con &= ~S3C2410_ADCCON_STDBM;
 	con &= ~S3C2410_ADCCON_STARTMASK;
+	con |=  S3C2410_ADCCON_PRSCEN;
 
 	if (!client->is_ts) {
 		if (cpu == TYPE_ADCV3)
@@ -129,6 +130,7 @@ static void s3c_adc_dbgshow(struct adc_device *adc)
 static void s3c_adc_try(struct adc_device *adc)
 {
 	struct s3c_adc_client *next = adc->ts_pend;
+	unsigned int con = readl(adc->regs + S3C2410_ADCCON);
 
 	if (!next && !list_empty(&adc_pending)) {
 		next = list_first_entry(&adc_pending,
@@ -143,6 +145,10 @@ static void s3c_adc_try(struct adc_device *adc)
 		s3c_adc_select(adc, next);
 		s3c_adc_convert(adc);
 		s3c_adc_dbgshow(adc);
+	} else {
+		con &= ~S3C2410_ADCCON_PRSCEN;
+		con |=  S3C2410_ADCCON_STDBM;
+		writel(con, adc->regs + S3C2410_ADCCON);
 	}
 }
 
@@ -409,6 +415,7 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	if (cpu == TYPE_ADCV2 || cpu == TYPE_ADCV3)
 		tmp |= S3C64XX_ADCCON_RESSEL;
 
+	tmp |= S3C2410_ADCCON_STDBM;
 	writel(tmp, adc->regs + S3C2410_ADCCON);
 
 	dev_info(dev, "attached adc driver\n");
-- 
1.7.1
