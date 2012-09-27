From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 27 Sep 2012 15:13:35 +0200
Subject: [PATCH 1/4] pinctrl/nomadik: use irq_find_mapping()
Message-ID: <1348751615-17379-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The code was using a homegrown method of looking up the offset
from the irq domain, not to be encouraged. Use the proper
irq_find_mapping() call instead.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 3dde653..e031c84 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -826,16 +826,14 @@ static void __nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc,
 {
 	struct nmk_gpio_chip *nmk_chip;
 	struct irq_chip *host_chip = irq_get_chip(irq);
-	unsigned int first_irq;
 
 	chained_irq_enter(host_chip, desc);
 
 	nmk_chip = irq_get_handler_data(irq);
-	first_irq = nmk_chip->domain->revmap_data.legacy.first_irq;
 	while (status) {
 		int bit = __ffs(status);
 
-		generic_handle_irq(first_irq + bit);
+		generic_handle_irq(irq_find_mapping(nmk_chip->domain, bit));
 		status &= ~BIT(bit);
 	}
 
-- 
1.7.11.3
