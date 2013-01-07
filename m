From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 7 Jan 2013 15:23:57 +0100
Subject: [PATCH 2/2] pinctrl/nomadik: make independent of <mach/irqs.h>
Message-ID: <1357568637-6054-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Some leftovers in the driver were using NOMADIK_* macros to
translate the irq numbers to offsets, while the first base IRQ
was already being passed from platform data, and the function
setting the disable mask could just as well use the irqdomain.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 66cce5f..f1e5ba2 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -33,7 +33,6 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_data/pinctrl-nomadik.h>
 #include <asm/mach/irq.h>
-#include <mach/irqs.h>
 #include "pinctrl-nomadik.h"
 #include "core.h"
 
@@ -218,7 +217,7 @@ nmk_gpio_disable_lazy_irq(struct nmk_gpio_chip *nmk_chip, unsigned offset)
 	u32 falling = nmk_chip->fimsc & BIT(offset);
 	u32 rising = nmk_chip->rimsc & BIT(offset);
 	int gpio = nmk_chip->chip.base + offset;
-	int irq = NOMADIK_GPIO_TO_IRQ(gpio);
+	int irq = irq_find_mapping(nmk_chip->domain, offset);
 	struct irq_data *d = irq_get_irq_data(irq);
 
 	if (!rising && !falling)
@@ -1416,7 +1415,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 	platform_set_drvdata(dev, nmk_chip);
 
 	if (!np)
-		irq_start = NOMADIK_GPIO_TO_IRQ(pdata->first_gpio);
+		irq_start = pdata->first_irq;
 	nmk_chip->domain = irq_domain_add_simple(np,
 				NMK_GPIO_PER_CHIP, irq_start,
 				&nmk_gpio_irq_simple_ops, nmk_chip);
-- 
1.7.11.3
