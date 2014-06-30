From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 30 Jun 2014 22:08:08 +0300
Subject: [PATCH] ARM: Samsung: ADC: Move to
 clk_prepare_enable/clk_disable_unprepare
Message-ID: <1404155288-2787-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use clk_prepare_enable/clk_disable_unprepare to make the driver
work properly with common clock framework.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/plat-samsung/adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index 79690f2..c5831b49 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -389,7 +389,7 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	clk_enable(adc->clk);
+	clk_prepare_enable(adc->clk);
 
 	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
 
@@ -413,7 +413,7 @@ static int s3c_adc_remove(struct platform_device *pdev)
 {
 	struct adc_device *adc = platform_get_drvdata(pdev);
 
-	clk_disable(adc->clk);
+	clk_disable_unprepare(adc->clk);
 	regulator_disable(adc->vdd);
 
 	return 0;
@@ -436,7 +436,7 @@ static int s3c_adc_suspend(struct device *dev)
 
 	disable_irq(adc->irq);
 	spin_unlock_irqrestore(&adc->lock, flags);
-	clk_disable(adc->clk);
+	clk_disable_unprepare(adc->clk);
 	regulator_disable(adc->vdd);
 
 	return 0;
@@ -454,7 +454,7 @@ static int s3c_adc_resume(struct device *dev)
 	ret = regulator_enable(adc->vdd);
 	if (ret)
 		return ret;
-	clk_enable(adc->clk);
+	clk_prepare_enable(adc->clk);
 	enable_irq(adc->irq);
 
 	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
-- 
2.0.0
