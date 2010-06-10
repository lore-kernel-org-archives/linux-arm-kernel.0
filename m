From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Thu, 10 Jun 2010 15:26:00 +0530
Subject: [PATCH 2/3] nomadik-gpio: implement to_irq
In-Reply-To: <1276163761-28342-1-git-send-email-rabin.vincent@stericsson.com>
References: <1276163761-28342-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1276163761-28342-2-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So that gpio_to_irq() works.

Acked-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index a98f618..b4aa299 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -515,12 +515,21 @@ static int nmk_gpio_make_output(struct gpio_chip *chip, unsigned offset,
 	return 0;
 }
 
+static int nmk_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct nmk_gpio_chip *nmk_chip =
+		container_of(chip, struct nmk_gpio_chip, chip);
+
+	return NOMADIK_GPIO_TO_IRQ(nmk_chip->chip.base) + offset;
+}
+
 /* This structure is replicated for each GPIO block allocated at probe time */
 static struct gpio_chip nmk_gpio_template = {
 	.direction_input	= nmk_gpio_make_input,
 	.get			= nmk_gpio_get_input,
 	.direction_output	= nmk_gpio_make_output,
 	.set			= nmk_gpio_set_output,
+	.to_irq			= nmk_gpio_to_irq,
 	.ngpio			= NMK_GPIO_PER_CHIP,
 	.can_sleep		= 0,
 };
-- 
1.7.0
