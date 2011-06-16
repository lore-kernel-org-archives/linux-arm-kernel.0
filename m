From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 16 Jun 2011 17:30:03 +0900
Subject: [PATCH 2/2] Samsung SoC ADC: Channel selection for S5PV210, S5PC110,
	and Exynos4
In-Reply-To: <1308213003-6526-1-git-send-email-myungjoo.ham@samsung.com>
References: <1308213003-6526-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1308213003-6526-2-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In S5PV210/S5PC110/Exynos4, ADCMUX channel selection uses ADCMUX
register, not ADCCON register. This patch corrects the behavior of
Samsung-ADC for such cpus.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/adc.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index a8499d8..7895819 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -41,8 +41,10 @@
 
 enum s3c_cpu_type {
 	TYPE_S3C24XX,
-	TYPE_S3C64XX
+	TYPE_S3C64XX,
+	TYPE_S5P,
 };
+#define S3C64XX_OR_LATER(type)	((type) == TYPE_S3C64XX || (type) == TYPE_S5P)
 
 struct s3c_adc_client {
 	struct platform_device	*pdev;
@@ -95,6 +97,7 @@ static inline void s3c_adc_select(struct adc_device *adc,
 				  struct s3c_adc_client *client)
 {
 	unsigned con = readl(adc->regs + S3C2410_ADCCON);
+	enum s3c_cpu_type cpu = platform_get_device_id(adc->pdev)->driver_data;
 
 	client->select_cb(client, 1);
 
@@ -102,8 +105,12 @@ static inline void s3c_adc_select(struct adc_device *adc,
 	con &= ~S3C2410_ADCCON_STDBM;
 	con &= ~S3C2410_ADCCON_STARTMASK;
 
-	if (!client->is_ts)
-		con |= S3C2410_ADCCON_SELMUX(client->channel);
+	if (!client->is_ts) {
+		if (cpu == TYPE_S5P)
+			writel(client->channel & 0xf, adc->regs + S5P_ADCMUX);
+		else
+			con |= S3C2410_ADCCON_SELMUX(client->channel);
+	}
 
 	writel(con, adc->regs + S3C2410_ADCCON);
 }
@@ -289,8 +296,8 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 
 	client->nr_samples--;
 
-	if (cpu == TYPE_S3C64XX) {
-		/* S3C64XX ADC resolution is 12-bit */
+	if (S3C64XX_OR_LATER(cpu)) {
+		/* S3C64XX/S5P ADC resolution is 12-bit */
 		data0 &= 0xfff;
 		data1 &= 0xfff;
 	} else {
@@ -316,7 +323,7 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 	}
 
 exit:
-	if (cpu == TYPE_S3C64XX) {
+	if (S3C64XX_OR_LATER(cpu)) {
 		/* Clear ADC interrupt */
 		writel(0, adc->regs + S3C64XX_ADCCLRINT);
 	}
@@ -387,7 +394,7 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	clk_enable(adc->clk);
 
 	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
-	if (platform_get_device_id(pdev)->driver_data == TYPE_S3C64XX) {
+	if (S3C64XX_OR_LATER(platform_get_device_id(pdev)->driver_data)) {
 		/* Enable 12-bit ADC resolution */
 		tmp |= S3C64XX_ADCCON_RESSEL;
 	}
@@ -475,6 +482,9 @@ static struct platform_device_id s3c_adc_driver_ids[] = {
 	}, {
 		.name           = "s3c64xx-adc",
 		.driver_data    = TYPE_S3C64XX,
+	}, {
+		.name		= "s5p-adc",
+		.driver_data	= TYPE_S5P,
 	},
 	{ }
 };
-- 
1.7.4.1
