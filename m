From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 8 Sep 2011 21:57:25 +0200
Subject: [PATCH 7/7] s3c-adc: Add support for S3C2416/S3C2450
In-Reply-To: <201109082151.29076.heiko@sntech.de>
References: <201109082151.29076.heiko@sntech.de>
Message-ID: <201109082157.25585.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ADC of the S3C2416/2450 SoC is 10 or 12 bit wide, has its
source selection in the register base+0x18 and its width
selection in bit 03 of the ADCCON register.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2416/mach-smdk2416.c |    3 +++
 arch/arm/plat-samsung/adc.c           |   24 +++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c2416/mach-smdk2416.c b/arch/arm/mach-s3c2416/mach-smdk2416.c
index a9eee53..deddeb3 100644
--- a/arch/arm/mach-s3c2416/mach-smdk2416.c
+++ b/arch/arm/mach-s3c2416/mach-smdk2416.c
@@ -50,6 +50,7 @@
 #include <plat/nand.h>
 #include <plat/sdhci.h>
 #include <plat/udc.h>
+#include <plat/adc-core.h>
 
 #include <plat/regs-fb-v4.h>
 #include <plat/fb.h>
@@ -225,6 +226,8 @@ static void __init smdk2416_machine_init(void)
 	s3c_i2c0_set_platdata(NULL);
 	s3c_fb_set_platdata(&smdk2416_fb_platdata);
 
+	s3c_adc_setname("s3c2416-adc");
+
 	s3c_sdhci0_set_platdata(&smdk2416_hsmmc0_pdata);
 	s3c_sdhci1_set_platdata(&smdk2416_hsmmc1_pdata);
 
diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index 4fb26c6..a5a73a4 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -357,6 +357,7 @@ static int s3c_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct adc_device *adc;
+	int cpu = platform_get_device_id(pdev)->driver_data;
 	struct resource *regs;
 	int ret;
 	unsigned tmp;
@@ -420,9 +421,12 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	clk_enable(adc->clk);
 
 	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
-	if (platform_get_device_id(pdev)->driver_data & S3C_ADC_QUIRK_12BIT) {
-		/* Enable 12-bit ADC resolution */
-		tmp |= S3C64XX_ADCCON_RESSEL;
+	/* Enable 12-bit ADC resolution */
+	if (cpu & S3C_ADC_QUIRK_12BIT) {
+		if (cpu & S3C_ADC_QUIRK_RESSEL03)
+			tmp |= S3C2416_ADCCON_RESSEL;
+		else
+			tmp |= S3C64XX_ADCCON_RESSEL;
 	}
 	writel(tmp, adc->regs + S3C2410_ADCCON);
 
@@ -490,6 +494,7 @@ static int s3c_adc_resume(struct device *dev)
 	struct platform_device *pdev = container_of(dev,
 			struct platform_device, dev);
 	struct adc_device *adc = platform_get_drvdata(pdev);
+	int cpu = platform_get_device_id(pdev)->driver_data;
 	int ret;
 	unsigned long tmp;
 
@@ -501,8 +506,12 @@ static int s3c_adc_resume(struct device *dev)
 
 	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
 	/* Enable 12-bit ADC resolution */
-	if (platform_get_device_id(pdev)->driver_data & S3C_ADC_QUIRK_12BIT)
-		tmp |= S3C64XX_ADCCON_RESSEL;
+	if (cpu & S3C_ADC_QUIRK_12BIT) {
+		if (cpu & S3C_ADC_QUIRK_RESSEL03)
+			tmp |= S3C2416_ADCCON_RESSEL;
+		else
+			tmp |= S3C64XX_ADCCON_RESSEL;
+	}
 	writel(tmp, adc->regs + S3C2410_ADCCON);
 
 	return 0;
@@ -523,6 +532,11 @@ static struct platform_device_id s3c_adc_driver_ids[] = {
 		.driver_data    = S3C_ADC_QUIRK_10BIT |
 					S3C_ADC_QUIRK_MUX18,
 	}, {
+		.name           = "s3c2416-adc",
+		.driver_data    = S3C_ADC_QUIRK_12BIT |
+					S3C_ADC_QUIRK_MUX18 |
+					S3C_ADC_QUIRK_RESSEL03,
+	}, {
 		.name           = "s3c64xx-adc",
 		.driver_data    = S3C_ADC_QUIRK_12BIT |
 					S3C_ADC_QUIRK_MUXADCCON |
-- 
1.7.2.3
