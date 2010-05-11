From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 11 May 2010 16:30:48 -0700
Subject: [PATCH 2/6] OMAP3: GPIO: Only enable WAKEUPEN for edge detection GPIOs
In-Reply-To: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
References: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273620652-15927-3-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chunqiu Wang <cqwang@motorola.com>

According to the GPIO 'Wakeup and Interrupt' section of the TRM[1],
wake-up requests can only be generated on edge transitions.

Also for OMAP3, only edge GPIOs may lose interrupts when PER enters
RET/OFF state, this is addressed by gpio prepare|resume idle functions

[1] Section 25.5.3.1 OMAP34xx_ES3.1_TRM_V_Q

Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/gpio.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 6216f4f..2f185ff 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -724,7 +724,11 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 							 OMAP4_GPIO_IRQWAKEN0);
 			}
 		} else {
-			if (trigger != 0)
+			/*
+			 * GPIO wakeup request can only be generated on edge
+			 * transitions
+			 */
+			if (trigger & IRQ_TYPE_EDGE_BOTH)
 				__raw_writel(1 << gpio, bank->base
 					+ OMAP24XX_GPIO_SETWKUENA);
 			else
@@ -734,7 +738,13 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 	}
 	/* This part needs to be executed always for OMAP34xx */
 	if (cpu_is_omap34xx() || (bank->non_wakeup_gpios & gpio_bit)) {
-		if (trigger != 0)
+		/*
+		 * Log the edge gpio and manually trigger the IRQ
+		 * after resume if the input level changes
+		 * to avoid irq lost during PER RET/OFF mode
+		 * Applies for omap2 non-wakeup gpio and all omap3 gpios
+		 */
+		if (trigger & IRQ_TYPE_EDGE_BOTH)
 			bank->enabled_non_wakeup_gpios |= gpio_bit;
 		else
 			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
-- 
1.7.0.2
