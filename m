From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:25 +0000
Subject: [PATCH 12/19] mfd: asic3: Fix a plethora of Checkpatch errors and
 warnings
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ERROR: Macros with complex values should be enclosed in parentheses
+#define INIT_CDEX(_name, _rate)        \
+       [ASIC3_CLOCK_##_name] = {               \
+               .cdex = CLOCK_CDEX_##_name,     \
+               .rate = _rate,                  \
+       }

WARNING: line over 80 characters
+                                                           ASIC3_GPIO_INT_STATUS);

WARNING: void function return statements are not generally useful
+       return;
+}

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+       msleep(1);

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+       msleep(1);

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+       msleep(1);

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+       msleep(1);

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+       msleep(1);

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+       msleep(1);

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+               msleep(1);
WARNING: line over 80 characters
+               asic->tmio_cnf = ioremap((ASIC3_SD_CONFIG_BASE >> asic->bus_shift) +

WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then p
r_err(...  to printk(KERN_ERR ...
+               printk(KERN_ERR "kzalloc failed\n");

WARNING: Possible unnecessary 'out of memory' message
+       if (asic == NULL) {
+               printk(KERN_ERR "kzalloc failed\n");

WARNING: Missing a blank line after declarations
+       int retval = 0;
+       retval = platform_driver_probe(&asic3_device_driver, asic3_probe);

total: 1 errors, 13 warnings, 1081 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/asic3.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index a726f01..d09f805 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -167,7 +167,6 @@ static void asic3_irq_demux(struct irq_desc *desc)
 
 				base = ASIC3_GPIO_A_BASE
 				       + bank * ASIC3_GPIO_BASE_INCR;
-
 				spin_lock_irqsave(&asic->lock, flags);
 				istat = asic3_read_register(asic,
 							    base +
@@ -536,8 +535,6 @@ static void asic3_gpio_set(struct gpio_chip *chip,
 	asic3_write_register(asic, gpio_base + ASIC3_GPIO_OUT, out_reg);
 
 	spin_unlock_irqrestore(&asic->lock, flags);
-
-	return;
 }
 
 static int asic3_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
@@ -665,18 +662,18 @@ static int ds1wm_enable(struct platform_device *pdev)
 	asic3_clk_enable(asic, &asic->clocks[ASIC3_CLOCK_EX0]);
 	asic3_clk_enable(asic, &asic->clocks[ASIC3_CLOCK_EX1]);
 	asic3_clk_enable(asic, &asic->clocks[ASIC3_CLOCK_OWM]);
-	msleep(1);
+	usleep_range(1000, 5000);
 
 	/* Reset and enable DS1WM */
 	asic3_set_register(asic, ASIC3_OFFSET(EXTCF, RESET),
 			   ASIC3_EXTCF_OWM_RESET, 1);
-	msleep(1);
+	usleep_range(1000, 5000);
 	asic3_set_register(asic, ASIC3_OFFSET(EXTCF, RESET),
 			   ASIC3_EXTCF_OWM_RESET, 0);
-	msleep(1);
+	usleep_range(1000, 5000);
 	asic3_set_register(asic, ASIC3_OFFSET(EXTCF, SELECT),
 			   ASIC3_EXTCF_OWM_EN, 1);
-	msleep(1);
+	usleep_range(1000, 5000);
 
 	return 0;
 }
@@ -757,7 +754,7 @@ static int asic3_mmc_enable(struct platform_device *pdev)
 	 * when HCLK is stopped.
 	 */
 	asic3_clk_enable(asic, &asic->clocks[ASIC3_CLOCK_EX1]);
-	msleep(1);
+	usleep_range(1000, 5000);
 
 	/* HCLK 24.576 MHz, BCLK 12.288 MHz: */
 	asic3_write_register(asic, ASIC3_OFFSET(CLOCK, SEL),
@@ -765,7 +762,7 @@ static int asic3_mmc_enable(struct platform_device *pdev)
 
 	asic3_clk_enable(asic, &asic->clocks[ASIC3_CLOCK_SD_HOST]);
 	asic3_clk_enable(asic, &asic->clocks[ASIC3_CLOCK_SD_BUS]);
-	msleep(1);
+	usleep_range(1000, 5000);
 
 	asic3_set_register(asic, ASIC3_OFFSET(EXTCF, SELECT),
 			   ASIC3_EXTCF_SD_MEM_ENABLE, 1);
@@ -841,7 +838,7 @@ static int asic3_leds_suspend(struct platform_device *pdev)
 	struct asic3 *asic = dev_get_drvdata(pdev->dev.parent);
 
 	while (asic3_gpio_get(&asic->gpio, ASIC3_GPIO(C, cell->id)) != 0)
-		msleep(1);
+		usleep_range(1000, 5000);
 
 	asic3_clk_disable(asic, &asic->clocks[clock_ledn[cell->id]]);
 
@@ -900,8 +897,8 @@ static int __init asic3_mfd_probe(struct platform_device *pdev,
 
 	/* MMC */
 	if (mem_sdio) {
-		asic->tmio_cnf = ioremap((ASIC3_SD_CONFIG_BASE >> asic->bus_shift) +
-				 mem_sdio->start,
+		asic->tmio_cnf = ioremap((ASIC3_SD_CONFIG_BASE >>
+					  asic->bus_shift) + mem_sdio->start,
 				 ASIC3_SD_CONFIG_SIZE >> asic->bus_shift);
 		if (!asic->tmio_cnf) {
 			ret = -ENOMEM;
@@ -962,10 +959,8 @@ static int __init asic3_probe(struct platform_device *pdev)
 
 	asic = devm_kzalloc(&pdev->dev,
 			    sizeof(struct asic3), GFP_KERNEL);
-	if (asic == NULL) {
-		printk(KERN_ERR "kzalloc failed\n");
+	if (!asic)
 		return -ENOMEM;
-	}
 
 	spin_lock_init(&asic->lock);
 	platform_set_drvdata(pdev, asic);
@@ -1074,7 +1069,9 @@ static struct platform_driver asic3_device_driver = {
 static int __init asic3_init(void)
 {
 	int retval = 0;
+
 	retval = platform_driver_probe(&asic3_device_driver, asic3_probe);
+
 	return retval;
 }
 
-- 
1.9.1
