From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Feb 2011 15:28:14 +0000
Subject: [PATCH 3/5] ARM: tegra: update GPIO chained IRQ handler to use EOI in
	parent chip
In-Reply-To: <1298302096-21275-1-git-send-email-will.deacon@arm.com>
References: <1298302096-21275-1-git-send-email-will.deacon@arm.com>
Message-ID: <1298302096-21275-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chained GPIO IRQ handler on Tegra calls ->irq_ack on the parent
chip prior to handling the interrupt.

This patch updates the code to use ->irq_eoi now that the GIC has moved
to using the fasteoi flow model.

Cc: Colin Cross <ccross@google.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-tegra/gpio.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
index ad80488..5019b01 100644
--- a/arch/arm/mach-tegra/gpio.c
+++ b/arch/arm/mach-tegra/gpio.c
@@ -219,9 +219,6 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	struct tegra_gpio_bank *bank;
 	int port;
 	int pin;
-	int unmasked = 0;
-
-	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	bank = get_irq_data(irq);
 
@@ -233,23 +230,11 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 		for_each_set_bit(pin, &sta, 8) {
 			__raw_writel(1 << pin, GPIO_INT_CLR(gpio));
-
-			/* if gpio is edge triggered, clear condition
-			 * before executing the hander so that we don't
-			 * miss edges
-			 */
-			if (lvl & (0x100 << pin)) {
-				unmasked = 1;
-				desc->irq_data.chip->irq_unmask(&desc->irq_data);
-			}
-
 			generic_handle_irq(gpio_to_irq(gpio + pin));
 		}
 	}
 
-	if (!unmasked)
-		desc->irq_data.chip->irq_unmask(&desc->irq_data);
-
+	desc->irq_data.chip->irq_eoi(&desc->irq_data);
 }
 
 #ifdef CONFIG_PM
-- 
1.7.0.4
