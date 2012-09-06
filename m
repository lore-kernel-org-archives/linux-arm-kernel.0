From: robherring2@gmail.com (Rob Herring)
Date: Thu,  6 Sep 2012 14:42:40 -0500
Subject: [PATCH v2 3/6] ARM: pxa: use gpio_to_irq for sharppm_sl
In-Reply-To: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
References: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346960563-18689-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Replace custom PXA_GPIO_TO_IRQ macro with standard gpio_to_irq.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-pxa/sharpsl_pm.c |   30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index bdf4cb8..9a154ba 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -879,7 +879,7 @@ static const struct platform_suspend_ops sharpsl_pm_ops = {
 
 static int __devinit sharpsl_pm_probe(struct platform_device *pdev)
 {
-	int ret;
+	int ret, irq;
 
 	if (!pdev->dev.platform_data)
 		return -EINVAL;
@@ -907,24 +907,28 @@ static int __devinit sharpsl_pm_probe(struct platform_device *pdev)
 	gpio_direction_input(sharpsl_pm.machinfo->gpio_batlock);
 
 	/* Register interrupt handlers */
-	if (request_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr, IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING, "AC Input Detect", sharpsl_ac_isr)) {
-		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_acin));
+	irq = gpio_to_irq(sharpsl_pm.machinfo->gpio_acin);
+	if (request_irq(irq, sharpsl_ac_isr, IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING, "AC Input Detect", sharpsl_ac_isr)) {
+		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", irq);
 	}
 
-	if (request_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr, IRQF_DISABLED | IRQF_TRIGGER_FALLING, "Battery Cover", sharpsl_fatal_isr)) {
-		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_batlock));
+	irq = gpio_to_irq(sharpsl_pm.machinfo->gpio_batlock);
+	if (request_irq(irq, sharpsl_fatal_isr, IRQF_DISABLED | IRQF_TRIGGER_FALLING, "Battery Cover", sharpsl_fatal_isr)) {
+		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", irq);
 	}
 
 	if (sharpsl_pm.machinfo->gpio_fatal) {
-		if (request_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr, IRQF_DISABLED | IRQF_TRIGGER_FALLING, "Fatal Battery", sharpsl_fatal_isr)) {
-			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_fatal));
+		irq = gpio_to_irq(sharpsl_pm.machinfo->gpio_fatal);
+		if (request_irq(irq, sharpsl_fatal_isr, IRQF_DISABLED | IRQF_TRIGGER_FALLING, "Fatal Battery", sharpsl_fatal_isr)) {
+			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", irq);
 		}
 	}
 
 	if (sharpsl_pm.machinfo->batfull_irq) {
 		/* Register interrupt handler. */
-		if (request_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr, IRQF_DISABLED | IRQF_TRIGGER_RISING, "CO", sharpsl_chrg_full_isr)) {
-			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_batfull));
+		irq = gpio_to_irq(sharpsl_pm.machinfo->gpio_batfull);
+		if (request_irq(irq, sharpsl_chrg_full_isr, IRQF_DISABLED | IRQF_TRIGGER_RISING, "CO", sharpsl_chrg_full_isr)) {
+			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", irq);
 		}
 	}
 
@@ -953,14 +957,14 @@ static int sharpsl_pm_remove(struct platform_device *pdev)
 
 	led_trigger_unregister_simple(sharpsl_charge_led_trigger);
 
-	free_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr);
-	free_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr);
+	free_irq(gpio_to_irq(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr);
+	free_irq(gpio_to_irq(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr);
 
 	if (sharpsl_pm.machinfo->gpio_fatal)
-		free_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr);
+		free_irq(gpio_to_irq(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr);
 
 	if (sharpsl_pm.machinfo->batfull_irq)
-		free_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr);
+		free_irq(gpio_to_irq(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr);
 
 	gpio_free(sharpsl_pm.machinfo->gpio_batlock);
 	gpio_free(sharpsl_pm.machinfo->gpio_batfull);
-- 
1.7.9.5
