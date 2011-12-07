From: holger.brunck@keymile.com (Holger Brunck)
Date: Wed,  7 Dec 2011 15:34:43 +0100
Subject: [PATCH] arm/orion: use set_bit and clear_bit in gpio implementation
Message-ID: <1323268483-25612-1-git-send-email-holger.brunck@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_bit and clear_bit are already atomic operations. So use this
functions to set or unset gpio configurations. This makes the
additional spinlock unneeded.

Signed-off-by: Stefan Bigler <stefan.bigler@keymile.com>
Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
cc: Lennert Buytenhek <kernel@wantstofly.org>
cc: Nicolas Pitre <nico@fluxnic.net>
cc: Russell King <linux@arm.linux.org.uk>
cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/plat-orion/gpio.c |   38 ++++++--------------------------------
 1 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index 41ab97e..d9d5577 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -31,7 +31,6 @@
 
 struct orion_gpio_chip {
 	struct gpio_chip	chip;
-	spinlock_t		lock;
 	void __iomem		*base;
 	unsigned long		valid_input;
 	unsigned long		valid_output;
@@ -86,39 +85,27 @@ static int orion_gpio_chip_count;
 static inline void
 __set_direction(struct orion_gpio_chip *ochip, unsigned pin, int input)
 {
-	u32 u;
-
-	u = readl(GPIO_IO_CONF(ochip));
 	if (input)
-		u |= 1 << pin;
+		set_bit(pin, (void*)GPIO_IO_CONF(ochip));
 	else
-		u &= ~(1 << pin);
-	writel(u, GPIO_IO_CONF(ochip));
+		clear_bit(pin, (void*)GPIO_IO_CONF(ochip));
 }
 
 static void __set_level(struct orion_gpio_chip *ochip, unsigned pin, int high)
 {
-	u32 u;
-
-	u = readl(GPIO_OUT(ochip));
 	if (high)
-		u |= 1 << pin;
+		set_bit(pin, (void*)GPIO_OUT(ochip));
 	else
-		u &= ~(1 << pin);
-	writel(u, GPIO_OUT(ochip));
+		clear_bit(pin, (void*)GPIO_OUT(ochip));
 }
 
 static inline void
 __set_blinking(struct orion_gpio_chip *ochip, unsigned pin, int blink)
 {
-	u32 u;
-
-	u = readl(GPIO_BLINK_EN(ochip));
 	if (blink)
-		u |= 1 << pin;
+		set_bit(pin, (void*)GPIO_BLINK_EN(ochip));
 	else
-		u &= ~(1 << pin);
-	writel(u, GPIO_BLINK_EN(ochip));
+		clear_bit(pin, (void*)GPIO_BLINK_EN(ochip));
 }
 
 static inline int
@@ -159,14 +146,11 @@ static int orion_gpio_direction_input(struct gpio_chip *chip, unsigned pin)
 {
 	struct orion_gpio_chip *ochip =
 		container_of(chip, struct orion_gpio_chip, chip);
-	unsigned long flags;
 
 	if (!orion_gpio_is_valid(ochip, pin, GPIO_INPUT_OK))
 		return -EINVAL;
 
-	spin_lock_irqsave(&ochip->lock, flags);
 	__set_direction(ochip, pin, 1);
-	spin_unlock_irqrestore(&ochip->lock, flags);
 
 	return 0;
 }
@@ -191,16 +175,13 @@ orion_gpio_direction_output(struct gpio_chip *chip, unsigned pin, int value)
 {
 	struct orion_gpio_chip *ochip =
 		container_of(chip, struct orion_gpio_chip, chip);
-	unsigned long flags;
 
 	if (!orion_gpio_is_valid(ochip, pin, GPIO_OUTPUT_OK))
 		return -EINVAL;
 
-	spin_lock_irqsave(&ochip->lock, flags);
 	__set_blinking(ochip, pin, 0);
 	__set_level(ochip, pin, value);
 	__set_direction(ochip, pin, 0);
-	spin_unlock_irqrestore(&ochip->lock, flags);
 
 	return 0;
 }
@@ -209,11 +190,8 @@ static void orion_gpio_set(struct gpio_chip *chip, unsigned pin, int value)
 {
 	struct orion_gpio_chip *ochip =
 		container_of(chip, struct orion_gpio_chip, chip);
-	unsigned long flags;
 
-	spin_lock_irqsave(&ochip->lock, flags);
 	__set_level(ochip, pin, value);
-	spin_unlock_irqrestore(&ochip->lock, flags);
 }
 
 static int orion_gpio_to_irq(struct gpio_chip *chip, unsigned pin)
@@ -283,15 +261,12 @@ void __init orion_gpio_set_valid(unsigned pin, int mode)
 void orion_gpio_set_blink(unsigned pin, int blink)
 {
 	struct orion_gpio_chip *ochip = orion_gpio_chip_find(pin);
-	unsigned long flags;
 
 	if (ochip == NULL)
 		return;
 
-	spin_lock_irqsave(&ochip->lock, flags);
 	__set_level(ochip, pin, 0);
 	__set_blinking(ochip, pin, blink);
-	spin_unlock_irqrestore(&ochip->lock, flags);
 }
 EXPORT_SYMBOL(orion_gpio_set_blink);
 
@@ -399,7 +374,6 @@ void __init orion_gpio_init(int gpio_base, int ngpio,
 	ochip->chip.base = gpio_base;
 	ochip->chip.ngpio = ngpio;
 	ochip->chip.can_sleep = 0;
-	spin_lock_init(&ochip->lock);
 	ochip->base = (void __iomem *)base;
 	ochip->valid_input = 0;
 	ochip->valid_output = 0;
-- 
1.7.1
