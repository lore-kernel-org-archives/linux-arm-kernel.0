From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 8 Sep 2011 21:54:16 +0200
Subject: [PATCH 3/7] s3c-adc: Replace TYPE_ADCVx conditionals with quirks
In-Reply-To: <201109082151.29076.heiko@sntech.de>
References: <201109082151.29076.heiko@sntech.de>
Message-ID: <201109082154.17113.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the static TYPE_ADCVs checks with checks for
specific features of an adc block. For this the s3c_cpu_type enum
in driver_data ist int containing containing the bit values
describing the indivial adc block.

This patch contains no functional changes, it merely replaces
the type checks with checks for indidual quirks.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-samsung/adc.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index ba21b6a..49769cb 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -39,12 +39,6 @@
  * action is required.
  */
 
-enum s3c_cpu_type {
-	TYPE_ADCV1, /* S3C24XX */
-	TYPE_ADCV2, /* S3C64XX, S5P64X0, S5PC100 */
-	TYPE_ADCV3, /* S5PV210, S5PC110, EXYNOS4210 */
-};
-
 /*
  * Resolution of the ADC - 10 or 12 bit
  */
@@ -123,7 +117,7 @@ static inline void s3c_adc_select(struct adc_device *adc,
 				  struct s3c_adc_client *client)
 {
 	unsigned con = readl(adc->regs + S3C2410_ADCCON);
-	enum s3c_cpu_type cpu = platform_get_device_id(adc->pdev)->driver_data;
+	int cpu = platform_get_device_id(adc->pdev)->driver_data;
 
 	client->select_cb(client, 1);
 
@@ -132,7 +126,7 @@ static inline void s3c_adc_select(struct adc_device *adc,
 	con &= ~S3C2410_ADCCON_STARTMASK;
 
 	if (!client->is_ts) {
-		if (cpu == TYPE_ADCV3)
+		if (cpu & S3C_ADC_QUIRK_MUX1C)
 			writel(client->channel & 0xf, adc->regs + S5P_ADCMUX);
 		else
 			con |= S3C2410_ADCCON_SELMUX(client->channel);
@@ -308,7 +302,7 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 {
 	struct adc_device *adc = pw;
 	struct s3c_adc_client *client = adc->cur;
-	enum s3c_cpu_type cpu = platform_get_device_id(adc->pdev)->driver_data;
+	int cpu = platform_get_device_id(adc->pdev)->driver_data;
 	unsigned data0, data1;
 
 	if (!client) {
@@ -322,7 +316,7 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 
 	client->nr_samples--;
 
-	if (cpu != TYPE_ADCV1) {
+	if (cpu & S3C_ADC_QUIRK_12BIT) {
 		/* S3C64XX/S5P ADC resolution is 12-bit */
 		data0 &= 0xfff;
 		data1 &= 0xfff;
@@ -349,7 +343,7 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 	}
 
 exit:
-	if (cpu != TYPE_ADCV1) {
+	if (cpu & S3C_ADC_QUIRK_CLRINT) {
 		/* Clear ADC interrupt */
 		writel(0, adc->regs + S3C64XX_ADCCLRINT);
 	}
@@ -423,7 +417,7 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	clk_enable(adc->clk);
 
 	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
-	if (platform_get_device_id(pdev)->driver_data != TYPE_ADCV1) {
+	if (platform_get_device_id(pdev)->driver_data & S3C_ADC_QUIRK_12BIT) {
 		/* Enable 12-bit ADC resolution */
 		tmp |= S3C64XX_ADCCON_RESSEL;
 	}
@@ -504,7 +498,7 @@ static int s3c_adc_resume(struct device *dev)
 
 	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
 	/* Enable 12-bit ADC resolution */
-	if (platform_get_device_id(pdev)->driver_data != TYPE_ADCV1)
+	if (platform_get_device_id(pdev)->driver_data & S3C_ADC_QUIRK_12BIT)
 		tmp |= S3C64XX_ADCCON_RESSEL;
 	writel(tmp, adc->regs + S3C2410_ADCCON);
 
@@ -519,13 +513,20 @@ static int s3c_adc_resume(struct device *dev)
 static struct platform_device_id s3c_adc_driver_ids[] = {
 	{
 		.name           = "s3c24xx-adc",
-		.driver_data    = TYPE_ADCV1,
+		.driver_data    = S3C_ADC_QUIRK_10BIT |
+					S3C_ADC_QUIRK_MUXADCCON,
 	}, {
 		.name           = "s3c64xx-adc",
-		.driver_data    = TYPE_ADCV2,
+		.driver_data    = S3C_ADC_QUIRK_12BIT |
+					S3C_ADC_QUIRK_MUXADCCON |
+					S3C_ADC_QUIRK_RESSEL16 |
+					S3C_ADC_QUIRK_CLRINT,
 	}, {
 		.name		= "samsung-adc-v3",
-		.driver_data	= TYPE_ADCV3,
+		.driver_data	= S3C_ADC_QUIRK_12BIT |
+					S3C_ADC_QUIRK_MUX1C |
+					S3C_ADC_QUIRK_RESSEL16 |
+					S3C_ADC_QUIRK_CLRINT,
 	},
 	{ }
 };
-- 
1.7.2.3
