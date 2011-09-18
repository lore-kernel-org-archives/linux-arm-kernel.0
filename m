From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 18 Sep 2011 22:49:26 +0200
Subject: [PATCH v2 7/7] s3c-adc: Add support for S3C2416/S3C2450
In-Reply-To: <201109182241.48858.heiko@sntech.de>
References: <201109182241.48858.heiko@sntech.de>
Message-ID: <201109182249.26493.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ADC of the S3C2416/2450 SoC is 10 or 12 bit wide, has its
source selection in the register base+0x18 and its width
selection in bit 03 of the ADCCON register.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes since v1:
move setname call
 arch/arm/mach-s3c2416/s3c2416.c |    3 +++
 arch/arm/plat-samsung/adc.c     |   24 +++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c2416/s3c2416.c
index 494ce91..4261bdc 100644
--- a/arch/arm/mach-s3c2416/s3c2416.c
+++ b/arch/arm/mach-s3c2416/s3c2416.c
@@ -60,6 +60,7 @@
 #include <plat/iic-core.h>
 #include <plat/fb-core.h>
 #include <plat/nand-core.h>
+#include <plat/adc-core.h>
 
 static struct map_desc s3c2416_iodesc[] __initdata = {
 	IODESC_ENT(WATCHDOG),
@@ -97,6 +98,8 @@ int __init s3c2416_init(void)
 
 	s3c_fb_setname("s3c2443-fb");
 
+	s3c_adc_setname("s3c2416-adc");
+
 	register_syscore_ops(&s3c2416_pm_syscore_ops);
 	register_syscore_ops(&s3c24xx_irq_syscore_ops);
 
diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index af16957..c53c509 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -358,6 +358,7 @@ static int s3c_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct adc_device *adc;
+	int cpu = platform_get_device_id(pdev)->driver_data;
 	struct resource *regs;
 	int ret;
 	unsigned tmp;
@@ -421,9 +422,12 @@ static int s3c_adc_probe(struct platform_device *pdev)
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
 
@@ -491,6 +495,7 @@ static int s3c_adc_resume(struct device *dev)
 	struct platform_device *pdev = container_of(dev,
 			struct platform_device, dev);
 	struct adc_device *adc = platform_get_drvdata(pdev);
+	int cpu = platform_get_device_id(pdev)->driver_data;
 	int ret;
 	unsigned long tmp;
 
@@ -502,8 +507,12 @@ static int s3c_adc_resume(struct device *dev)
 
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
@@ -524,6 +533,11 @@ static struct platform_device_id s3c_adc_driver_ids[] = {
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
