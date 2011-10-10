From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 10 Oct 2011 21:51:10 +0200
Subject: [PATCH 5/5] s3c-adc: Add support for S3C2416/S3C2450
In-Reply-To: <201110102146.51694.heiko@sntech.de>
References: <201110102146.51694.heiko@sntech.de>
Message-ID: <201110102151.10605.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ADC of the S3C2416/2450 SoC is 10 or 12 bit wide, has its
source selection in the register base+0x18 and its width
selection in bit 03 of the ADCCON register.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2416/s3c2416.c |    3 +++
 arch/arm/plat-samsung/adc.c     |   25 +++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

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
index 266544b..94cb793 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -42,6 +42,7 @@
 enum s3c_cpu_type {
 	TYPE_ADCV1, /* S3C24XX */
 	TYPE_ADCV11, /* S3C2443 */
+	TYPE_ADCV12, /* S3C2416, S3C2450 */
 	TYPE_ADCV2, /* S3C64XX, S5P64X0, S5PC100 */
 	TYPE_ADCV3, /* S5PV210, S5PC110, EXYNOS4210 */
 };
@@ -107,7 +108,7 @@ static inline void s3c_adc_select(struct adc_device *adc,
 	if (!client->is_ts) {
 		if (cpu == TYPE_ADCV3)
 			writel(client->channel & 0xf, adc->regs + S5P_ADCMUX);
-		else if (cpu == TYPE_ADCV11)
+		else if (cpu == TYPE_ADCV11 || cpu == TYPE_ADCV12)
 			writel(client->channel & 0xf,
 						adc->regs + S3C2443_ADCMUX);
 		else
@@ -302,7 +303,7 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 		data0 &= 0x3ff;
 		data1 &= 0x3ff;
 	} else {
-		/* S3C64XX/S5P ADC resolution is 12-bit */
+		/* S3C2416/S3C64XX/S5P ADC resolution is 12-bit */
 		data0 &= 0xfff;
 		data1 &= 0xfff;
 	}
@@ -337,6 +338,7 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct adc_device *adc;
 	struct resource *regs;
+	enum s3c_cpu_type cpu = platform_get_device_id(pdev)->driver_data;
 	int ret;
 	unsigned tmp;
 
@@ -399,10 +401,13 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	clk_enable(adc->clk);
 
 	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
-	if (platform_get_device_id(pdev)->driver_data != TYPE_ADCV1) {
-		/* Enable 12-bit ADC resolution */
+
+	/* Enable 12-bit ADC resolution */
+	if (cpu == TYPE_ADCV12)
+		tmp |= S3C2416_ADCCON_RESSEL;
+	if (cpu == TYPE_ADCV2 || cpu == TYPE_ADCV3)
 		tmp |= S3C64XX_ADCCON_RESSEL;
-	}
+
 	writel(tmp, adc->regs + S3C2410_ADCCON);
 
 	dev_info(dev, "attached adc driver\n");
@@ -469,6 +474,7 @@ static int s3c_adc_resume(struct device *dev)
 	struct platform_device *pdev = container_of(dev,
 			struct platform_device, dev);
 	struct adc_device *adc = platform_get_drvdata(pdev);
+	enum s3c_cpu_type cpu = platform_get_device_id(pdev)->driver_data;
 	int ret;
 	unsigned long tmp;
 
@@ -479,9 +485,13 @@ static int s3c_adc_resume(struct device *dev)
 	enable_irq(adc->irq);
 
 	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
+
 	/* Enable 12-bit ADC resolution */
-	if (platform_get_device_id(pdev)->driver_data != TYPE_ADCV1)
+	if (cpu == TYPE_ADCV12)
+		tmp |= S3C2416_ADCCON_RESSEL;
+	if (cpu == TYPE_ADCV2 || cpu == TYPE_ADCV3)
 		tmp |= S3C64XX_ADCCON_RESSEL;
+
 	writel(tmp, adc->regs + S3C2410_ADCCON);
 
 	return 0;
@@ -500,6 +510,9 @@ static struct platform_device_id s3c_adc_driver_ids[] = {
 		.name           = "s3c2443-adc",
 		.driver_data    = TYPE_ADCV11,
 	}, {
+		.name           = "s3c2416-adc",
+		.driver_data    = TYPE_ADCV12,
+	}, {
 		.name           = "s3c64xx-adc",
 		.driver_data    = TYPE_ADCV2,
 	}, {
-- 
1.7.2.3
