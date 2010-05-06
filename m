From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:18 -0700
Subject: [PATCH 27/34] Davinci: gpio - fine grained locking
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-28-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

This patch eliminates the global gpio_lock, and implements a per-controller
lock instead.  This also switches to irqsave/irqrestore locks in case gpios
are manipulated in isr.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Tested-by: Sandeep Paulraj <s-paulraj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/gpio.c              |    9 +++++----
 arch/arm/mach-davinci/include/mach/gpio.h |    3 +++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index e422cd3..b62d5e2 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -33,8 +33,6 @@ struct davinci_gpio_regs {
 	u32	intstat;
 };
 
-static DEFINE_SPINLOCK(gpio_lock);
-
 #define chip2controller(chip)	\
 	container_of(chip, struct davinci_gpio_controller, chip)
 
@@ -83,10 +81,11 @@ static inline int __davinci_direction(struct gpio_chip *chip,
 {
 	struct davinci_gpio_controller *d = chip2controller(chip);
 	struct davinci_gpio_regs __iomem *g = d->regs;
+	unsigned long flags;
 	u32 temp;
 	u32 mask = 1 << offset;
 
-	spin_lock(&gpio_lock);
+	spin_lock_irqsave(&d->lock, flags);
 	temp = __raw_readl(&g->dir);
 	if (out) {
 		temp &= ~mask;
@@ -95,7 +94,7 @@ static inline int __davinci_direction(struct gpio_chip *chip,
 		temp |= mask;
 	}
 	__raw_writel(temp, &g->dir);
-	spin_unlock(&gpio_lock);
+	spin_unlock_irqrestore(&d->lock, flags);
 
 	return 0;
 }
@@ -175,6 +174,8 @@ static int __init davinci_gpio_setup(void)
 		if (chips[i].chip.ngpio > 32)
 			chips[i].chip.ngpio = 32;
 
+		spin_lock_init(&chips[i].lock);
+
 		regs = gpio2regs(base);
 		chips[i].regs = regs;
 		chips[i].set_data = &regs->set_data;
diff --git a/arch/arm/mach-davinci/include/mach/gpio.h b/arch/arm/mach-davinci/include/mach/gpio.h
index 9a71a26..504cc18 100644
--- a/arch/arm/mach-davinci/include/mach/gpio.h
+++ b/arch/arm/mach-davinci/include/mach/gpio.h
@@ -14,6 +14,8 @@
 #define	__DAVINCI_GPIO_H
 
 #include <linux/io.h>
+#include <linux/spinlock.h>
+
 #include <asm-generic/gpio.h>
 
 #include <mach/irqs.h>
@@ -52,6 +54,7 @@ enum davinci_gpio_type {
 struct davinci_gpio_controller {
 	struct gpio_chip	chip;
 	int			irq_base;
+	spinlock_t		lock;
 	void __iomem		*regs;
 	void __iomem		*set_data;
 	void __iomem		*clr_data;
-- 
1.7.0.2
