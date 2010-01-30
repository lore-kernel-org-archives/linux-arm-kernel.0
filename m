From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sat, 30 Jan 2010 18:01:48 +0100
Subject: [PATCH] ARM: SAMSUNG: Add support for 12bit ADC
Message-ID: <b2e8f9f71001300901v2969c41bx7be6c052ad424a00@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C64XX SoC series support 12bit ADC data, enable this and
mask the data accordingly.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/plat-samsung/adc.c                   |   24 +++++++++++++++++++-----
 arch/arm/plat-samsung/include/plat/regs-adc.h |    1 +
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index c7659b7..81caf21 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -262,6 +262,7 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 {
 	struct adc_device *adc = pw;
 	struct s3c_adc_client *client = adc->cur;
+	enum s3c_cpu_type cpu = platform_get_device_id(adc->pdev)->driver_data;
 	unsigned long flags;
 	unsigned data0, data1;

@@ -276,9 +277,17 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)

 	client->nr_samples--;

+	if (cpu == TYPE_S3C64XX) {
+		/* S3C64XX ADC resolution is 12-bit */
+		data0 &= 0xfff;
+		data1 &= 0xfff;
+	} else {
+		data0 &= 0x3ff;
+		data1 &= 0x3ff;
+	}
+
 	if (client->convert_cb)
-		(client->convert_cb)(client, data0 & 0x3ff, data1 & 0x3ff,
-				     &client->nr_samples);
+		(client->convert_cb)(client, data0, data1, &client->nr_samples);

 	if (client->nr_samples > 0) {
 		/* fire another conversion for this */
@@ -295,7 +304,7 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 	}

 exit:
-	if (platform_get_device_id(adc->pdev)->driver_data == TYPE_S3C64XX) {
+	if (cpu == TYPE_S3C64XX) {
 		/* Clear ADC interrupt */
 		writel(0, adc->regs + S3C64XX_ADCCLRINT);
 	}
@@ -308,6 +317,7 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	struct adc_device *adc;
 	struct resource *regs;
 	int ret;
+	unsigned tmp;

 	adc = kzalloc(sizeof(struct adc_device), GFP_KERNEL);
 	if (adc == NULL) {
@@ -354,8 +364,12 @@ static int s3c_adc_probe(struct platform_device *pdev)

 	clk_enable(adc->clk);

-	writel(adc->prescale | S3C2410_ADCCON_PRSCEN,
-	       adc->regs + S3C2410_ADCCON);
+	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
+	if (platform_get_device_id(pdev)->driver_data == TYPE_S3C64XX) {
+		/* Enable 12-bit ADC resolution */
+		tmp |= S3C64XX_ADCCON_RESSEL;
+	}
+	writel(tmp, adc->regs + S3C2410_ADCCON);

 	dev_info(dev, "attached adc driver\n");

diff --git a/arch/arm/plat-samsung/include/plat/regs-adc.h
b/arch/arm/plat-samsung/include/plat/regs-adc.h
index f43c8da..7554c4f 100644
--- a/arch/arm/plat-samsung/include/plat/regs-adc.h
+++ b/arch/arm/plat-samsung/include/plat/regs-adc.h
@@ -25,6 +25,7 @@


 /* ADCCON Register Bits */
+#define S3C64XX_ADCCON_RESSEL		(1<<16)
 #define S3C2410_ADCCON_ECFLG		(1<<15)
 #define S3C2410_ADCCON_PRSCEN		(1<<14)
 #define S3C2410_ADCCON_PRSCVL(x)	(((x)&0xFF)<<6)
-- 
1.6.6.1
