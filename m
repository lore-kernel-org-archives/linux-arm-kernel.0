From: yegorslists@googlemail.com (yegorslists at googlemail.com)
Date: Tue, 22 Apr 2014 11:23:55 +0200
Subject: [PATCH] gpio: omap: implement get_direction
Message-ID: <1398158635-18415-1-git-send-email-yegorslists@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yegor Yefremov <yegorslists@googlemail.com>

This patch implements gpio_chip's get_direction() routine, that
lets other drivers get particular GPIOs direction using
struct gpio_desc.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/gpio/gpio-omap.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 19b886c..b55bf7b 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -102,6 +102,20 @@ static int omap_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	return irq_find_mapping(bank->domain, offset);
 }
 
+static int _get_gpio_direction(struct gpio_bank *bank, int gpio)
+{
+	void __iomem *reg = bank->base;
+	u32 l;
+	u32 mask = 1 << gpio;
+
+	reg += bank->regs->direction;
+	l = readl_relaxed(reg);
+	if (l & mask)
+		return 1;
+
+	return 0;
+}
+
 static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 {
 	void __iomem *reg = bank->base;
@@ -936,6 +950,19 @@ static inline void mpuio_init(struct gpio_bank *bank)
 
 /*---------------------------------------------------------------------*/
 
+static int gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	struct gpio_bank *bank;
+	unsigned long flags;
+	int dir;
+
+	bank = container_of(chip, struct gpio_bank, chip);
+	spin_lock_irqsave(&bank->lock, flags);
+	dir = _get_gpio_direction(bank, offset);
+	spin_unlock_irqrestore(&bank->lock, flags);
+	return dir;
+}
+
 static int gpio_input(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank;
@@ -1092,6 +1119,7 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 	 */
 	bank->chip.request = omap_gpio_request;
 	bank->chip.free = omap_gpio_free;
+	bank->chip.get_direction = gpio_get_direction;
 	bank->chip.direction_input = gpio_input;
 	bank->chip.get = gpio_get;
 	bank->chip.direction_output = gpio_output;
-- 
1.7.7
