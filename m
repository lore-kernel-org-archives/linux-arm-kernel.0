From: will.deacon@arm.com (Will Deacon)
Date: Tue,  8 Mar 2011 17:13:21 +0000
Subject: [PATCH 3/7] ARM: tegra: update GPIO chained IRQ handler to use
	entry/exit functions
In-Reply-To: <1299604405-12960-1-git-send-email-will.deacon@arm.com>
References: <1299604405-12960-1-git-send-email-will.deacon@arm.com>
Message-ID: <1299604405-12960-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the Tegra gpio chained IRQ handler to use the chained
IRQ enter/exit functions in order to function correctly on primary
controllers with different methods of flow control.

This is required for the GIC to move to fasteoi interrupt handling.

Cc: Colin Cross <ccross@android.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-tegra/gpio.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
index ad80488..406b687 100644
--- a/arch/arm/mach-tegra/gpio.c
+++ b/arch/arm/mach-tegra/gpio.c
@@ -220,8 +220,9 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	int port;
 	int pin;
 	int unmasked = 0;
+	struct irq_chip chip = get_irq_desc_chip(desc);
 
-	desc->irq_data.chip->irq_ack(&desc->irq_data);
+	chained_irq_enter(chip, desc);
 
 	bank = get_irq_data(irq);
 
@@ -240,7 +241,7 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			 */
 			if (lvl & (0x100 << pin)) {
 				unmasked = 1;
-				desc->irq_data.chip->irq_unmask(&desc->irq_data);
+				chained_irq_exit(chip, desc);
 			}
 
 			generic_handle_irq(gpio_to_irq(gpio + pin));
@@ -248,7 +249,7 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	}
 
 	if (!unmasked)
-		desc->irq_data.chip->irq_unmask(&desc->irq_data);
+		chained_irq_exit(chip, desc);
 
 }
 
-- 
1.7.0.4
