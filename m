From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 21 Jun 2011 10:58:43 +0900
Subject: [PATCH v2 1/5] Samsung SoC ADC: use regulator (VDD for ADC).
In-Reply-To: <1308621527-2457-1-git-send-email-myungjoo.ham@samsung.com>
References: <20110620101737.GA31864@opensource.wolfsonmicro.com>
	<1308621527-2457-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1308621527-2457-2-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows the Samsung ADC driver to enable VDD regulator at
probe and resume and to disable at exit and suspend.
In a platform where ADC's VDD regulator is not "always-on", this control
is required although this patch does not provide fine-grained power
control (turning on the regulator only when being accessed).

However, if VDD regulator ("vdd" for the adc device) is not provided,
the regulator control will not be activated because there are platforms
that do not provide regulator for ADC device.

arch_initcall has been modified to module_init in order to allow
regulators to be available at probe.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

--
changes from v1
- Removed macro defining the name of regulator.
- Handle error from regulator_enable.
- Do not allow not to have the regulator if CONFIG_REGULATOR.
- Seperate a patch dealing with "arch_initcall->module_init"
---
 arch/arm/plat-samsung/adc.c |   31 ++++++++++++++++++++++++++-----
 1 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index e8f2be2..938f6e9 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/regulator/consumer.h>
 
 #include <plat/regs-adc.h>
 #include <plat/adc.h>
@@ -71,6 +72,7 @@ struct adc_device {
 	unsigned int		 prescale;
 
 	int			 irq;
+	struct regulator	*vdd;
 };
 
 static struct adc_device *adc_dev;
@@ -338,17 +340,24 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	adc->pdev = pdev;
 	adc->prescale = S3C2410_ADCCON_PRSCVL(49);
 
+	adc->vdd = regulator_get(dev, "vdd");
+	if (IS_ERR(adc->vdd)) {
+		dev_err(dev, "operating without regulator \"vdd\" .\n");
+		ret = PTR_ERR(adc->vdd);
+		goto err_alloc;
+	}
+
 	adc->irq = platform_get_irq(pdev, 1);
 	if (adc->irq <= 0) {
 		dev_err(dev, "failed to get adc irq\n");
 		ret = -ENOENT;
-		goto err_alloc;
+		goto err_reg;
 	}
 
 	ret = request_irq(adc->irq, s3c_adc_irq, 0, dev_name(dev), adc);
 	if (ret < 0) {
 		dev_err(dev, "failed to attach adc irq\n");
-		goto err_alloc;
+		goto err_reg;
 	}
 
 	adc->clk = clk_get(dev, "adc");
@@ -372,6 +381,10 @@ static int s3c_adc_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
+	ret = regulator_enable(adc->vdd);
+	if (!ret)
+		goto err_ioremap;
+
 	clk_enable(adc->clk);
 
 	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
@@ -388,12 +401,15 @@ static int s3c_adc_probe(struct platform_device *pdev)
 
 	return 0;
 
+ err_ioremap:
+	iounmap(adc->regs);
  err_clk:
 	clk_put(adc->clk);
 
  err_irq:
 	free_irq(adc->irq, adc);
-
+ err_reg:
+	regulator_put(adc->vdd);
  err_alloc:
 	kfree(adc);
 	return ret;
@@ -406,6 +422,8 @@ static int __devexit s3c_adc_remove(struct platform_device *pdev)
 	iounmap(adc->regs);
 	free_irq(adc->irq, adc);
 	clk_disable(adc->clk);
+	regulator_disable(adc->vdd);
+	regulator_put(adc->vdd);
 	clk_put(adc->clk);
 	kfree(adc);
 
@@ -428,6 +446,7 @@ static int s3c_adc_suspend(struct platform_device *pdev, pm_message_t state)
 	disable_irq(adc->irq);
 	spin_unlock_irqrestore(&adc->lock, flags);
 	clk_disable(adc->clk);
+	regulator_disable(adc->vdd);
 
 	return 0;
 }
@@ -435,14 +454,16 @@ static int s3c_adc_suspend(struct platform_device *pdev, pm_message_t state)
 static int s3c_adc_resume(struct platform_device *pdev)
 {
 	struct adc_device *adc = platform_get_drvdata(pdev);
+	int ret;
 
+	ret = regulator_enable(adc->vdd);
 	clk_enable(adc->clk);
 	enable_irq(adc->irq);
 
 	writel(adc->prescale | S3C2410_ADCCON_PRSCEN,
 	       adc->regs + S3C2410_ADCCON);
 
-	return 0;
+	return ret;
 }
 
 #else
@@ -485,4 +506,4 @@ static int __init adc_init(void)
 	return ret;
 }
 
-arch_initcall(adc_init);
+module_init(adc_init);
-- 
1.7.4.1
