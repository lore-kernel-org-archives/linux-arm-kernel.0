From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 11 Aug 2011 14:43:23 -0600
Subject: [PATCH v2 3/4] arm/tegra: Delete custom gpio_to_irq, and irq_to_gpio
In-Reply-To: <1313095404-27858-1-git-send-email-swarren@nvidia.com>
References: <1313095404-27858-1-git-send-email-swarren@nvidia.com>
Message-ID: <1313095404-27858-3-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By not definining a custom gpio_to_irq, the default gpiolib version is
used, allowing platform consolidation.

irq_to_gpio is deprecated and in the process of being removed. Make that
happen now for ARM Tegra.

This also partially fixes the Tegra build; it was broken because gpio.h
referred to EINVAL, which wasn't always defined when <mach/gpio.h> was
included.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/gpio.h |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
index e353805..284a19e 100644
--- a/arch/arm/mach-tegra/include/mach/gpio.h
+++ b/arch/arm/mach-tegra/include/mach/gpio.h
@@ -26,22 +26,6 @@
 #define TEGRA_NR_GPIOS		INT_GPIO_NR
 
 #define TEGRA_GPIO_TO_IRQ(gpio) (INT_GPIO_BASE + (gpio))
-#define TEGRA_IRQ_TO_GPIO(irq) ((irq) - INT_GPIO_BASE)
-
-static inline int gpio_to_irq(unsigned int gpio)
-{
-	if (gpio < TEGRA_NR_GPIOS)
-		return INT_GPIO_BASE + gpio;
-	return -EINVAL;
-}
-#define gpio_to_irq gpio_to_irq
-
-static inline int irq_to_gpio(unsigned int irq)
-{
-	if ((irq >= INT_GPIO_BASE) && (irq < INT_GPIO_BASE + INT_GPIO_NR))
-		return irq - INT_GPIO_BASE;
-	return -EINVAL;
-}
 
 struct tegra_gpio_table {
 	int	gpio;	/* GPIO number */
-- 
1.7.0.4
