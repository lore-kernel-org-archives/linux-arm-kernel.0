From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Apr 2011 19:35:35 +0100
Subject: [PATCH 1/6] ARM: omap: update GPIO chained IRQ handler to use
	entry/exit functions
In-Reply-To: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
References: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
Message-ID: <1302633340-4795-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the OMAP gpio chained IRQ handler to use the chained
IRQ enter/exit functions in order to function correctly on primary
controllers with different methods of flow control.

Cc: Colin Cross <ccross@google.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/plat-omap/gpio.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index d2adcdd..a2478eb 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1137,8 +1137,9 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	struct gpio_bank *bank;
 	u32 retrigger = 0;
 	int unmasked = 0;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	desc->irq_data.chip->irq_ack(&desc->irq_data);
+	chained_irq_enter(chip, desc);
 
 	bank = irq_get_handler_data(irq);
 #ifdef CONFIG_ARCH_OMAP1
@@ -1195,7 +1196,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		configured, we could unmask GPIO bank interrupt immediately */
 		if (!level_mask && !unmasked) {
 			unmasked = 1;
-			desc->irq_data.chip->irq_unmask(&desc->irq_data);
+			chained_irq_exit(chip, desc);
 		}
 
 		isr |= retrigger;
@@ -1231,7 +1232,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	interrupt */
 exit:
 	if (!unmasked)
-		desc->irq_data.chip->irq_unmask(&desc->irq_data);
+		chained_irq_exit(chip, desc);
 }
 
 static void gpio_irq_shutdown(struct irq_data *d)
-- 
1.7.0.4
