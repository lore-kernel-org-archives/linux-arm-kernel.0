From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 Feb 2011 10:20:46 +0100
Subject: [PATCH 1/9] plat-nomadik: support varying number of GPIOs per block
In-Reply-To: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
References: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1297156854-32295-2-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
[Added constant 32-pin assignment in platform data]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/devices-common.c      |    1 +
 arch/arm/plat-nomadik/gpio.c              |    5 ++---
 arch/arm/plat-nomadik/include/plat/gpio.h |    1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index fe69f5f..13a4ce0 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -139,6 +139,7 @@ void dbx500_add_gpios(resource_size_t *base, int num, int irq,
 	for (i = 0; i < num; i++, first += 32, irq++) {
 		pdata->first_gpio = first;
 		pdata->first_irq = NOMADIK_GPIO_TO_IRQ(first);
+		pdata->num_gpio = 32;
 
 		dbx500_add_gpio(i, base[i], irq, pdata);
 	}
diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 1e88ecb..30bb92a 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -35,7 +35,6 @@
  * Symbols in this file are called "nmk_gpio" for "nomadik gpio"
  */
 
-#define NMK_GPIO_PER_CHIP 32
 struct nmk_gpio_chip {
 	struct gpio_chip chip;
 	void __iomem *addr;
@@ -546,7 +545,7 @@ static int nmk_gpio_init_irq(struct nmk_gpio_chip *nmk_chip)
 	int i;
 
 	first_irq = NOMADIK_GPIO_TO_IRQ(nmk_chip->chip.base);
-	for (i = first_irq; i < first_irq + NMK_GPIO_PER_CHIP; i++) {
+	for (i = first_irq; i < first_irq + nmk_chip->chip.ngpio; i++) {
 		set_irq_chip(i, &nmk_gpio_irq_chip);
 		set_irq_handler(i, handle_edge_irq);
 		set_irq_flags(i, IRQF_VALID);
@@ -612,7 +611,6 @@ static struct gpio_chip nmk_gpio_template = {
 	.direction_output	= nmk_gpio_make_output,
 	.set			= nmk_gpio_set_output,
 	.to_irq			= nmk_gpio_to_irq,
-	.ngpio			= NMK_GPIO_PER_CHIP,
 	.can_sleep		= 0,
 };
 
@@ -672,6 +670,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 
 	chip = &nmk_chip->chip;
 	chip->base = pdata->first_gpio;
+	chip->ngpio = pdata->num_gpio;
 	chip->label = pdata->name ?: dev_name(&dev->dev);
 	chip->dev = &dev->dev;
 	chip->owner = THIS_MODULE;
diff --git a/arch/arm/plat-nomadik/include/plat/gpio.h b/arch/arm/plat-nomadik/include/plat/gpio.h
index 67b113d..d745f3a 100644
--- a/arch/arm/plat-nomadik/include/plat/gpio.h
+++ b/arch/arm/plat-nomadik/include/plat/gpio.h
@@ -82,6 +82,7 @@ struct nmk_gpio_platform_data {
 	char *name;
 	int first_gpio;
 	int first_irq;
+	int num_gpio;
 };
 
 #endif /* __ASM_PLAT_GPIO_H */
-- 
1.7.3.2
