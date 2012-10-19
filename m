From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 19 Oct 2012 17:09:35 +0200
Subject: [PATCH] pinctrl/nomadik: use irq_create_mapping()
Message-ID: <1350659375-7335-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Since in the DT case, the linear domain path will not allocate
descriptors for the IRQs, we need to use irq_create_mapping()
for mapping hwirqs to Linux IRQs, so these descriptors get
created on-the-fly in this case.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 01aea1c..d1d3cb9 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -931,7 +931,7 @@ static void __nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc,
 	while (status) {
 		int bit = __ffs(status);
 
-		generic_handle_irq(irq_find_mapping(nmk_chip->domain, bit));
+		generic_handle_irq(irq_create_mapping(nmk_chip->domain, bit));
 		status &= ~BIT(bit);
 	}
 
@@ -1056,7 +1056,7 @@ static int nmk_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	struct nmk_gpio_chip *nmk_chip =
 		container_of(chip, struct nmk_gpio_chip, chip);
 
-	return irq_find_mapping(nmk_chip->domain, offset);
+	return irq_create_mapping(nmk_chip->domain, offset);
 }
 
 #ifdef CONFIG_DEBUG_FS
-- 
1.7.11.3
