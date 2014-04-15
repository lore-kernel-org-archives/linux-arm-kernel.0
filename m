From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 15 Apr 2014 14:43:49 +0800
Subject: [PATCH 4/4] pinctrl: sirf: move to use irq_get_handler_data
In-Reply-To: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1397544229-20545-5-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

we set bank as handler_data, now we can get bank in ISR directly
instead of looking-up.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-sirf.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index c03dcc7..36cc678 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -568,18 +568,10 @@ static struct irq_chip sirfsoc_irq_chip = {
 
 static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 {
-	struct sirfsoc_gpio_bank *bank;
+	struct sirfsoc_gpio_bank *bank = irq_get_handler_data(irq);
 	u32 status, ctrl;
 	int idx = 0;
 	struct irq_chip *chip = irq_get_chip(irq);
-	int i;
-
-	for (i = 0; i < SIRFSOC_GPIO_BANK_SIZE; i++) {
-		bank = &sgpio_chip.sgpio_bank[i];
-		if (bank->parent_irq == irq)
-			break;
-	}
-	BUG_ON (i == SIRFSOC_GPIO_BANK_SIZE);
 
 	chained_irq_enter(chip, desc);
 
@@ -845,7 +837,7 @@ static int sirfsoc_gpio_probe(struct device_node *np)
 			goto out;
 		}
 
-		gpiochip_set_chained_irqchip(&sgpio_chip.chip.gc,
+		gpiochip_set_chained_irqchip(bank,
 			&sirfsoc_irq_chip,
 			bank->parent_irq,
 			sirfsoc_gpio_handle_irq);
-- 
1.7.5.4
