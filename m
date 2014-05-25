From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 25 May 2014 16:54:23 +0800
Subject: [PATCH] pinctrl: sirf: fix typo for GPIO bank number
Message-ID: <1401008064-31819-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

The patch 7420d2d09b12: "pinctrl: sirf: switch driver to use gpiolib
irqchip helpers" from Apr 15, 2014, leads to the following static
checker warning:

      drivers/pinctrl/sirf/pinctrl-sirf.c:578 sirfsoc_gpio_handle_irq()
      warn: buffer overflow 'sgpio_chip.sgpio_bank' 5 <= 31

Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-sirf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index c03dcc7..a4ea3f7 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -574,12 +574,12 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 	struct irq_chip *chip = irq_get_chip(irq);
 	int i;
 
-	for (i = 0; i < SIRFSOC_GPIO_BANK_SIZE; i++) {
+	for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
 		bank = &sgpio_chip.sgpio_bank[i];
 		if (bank->parent_irq == irq)
 			break;
 	}
-	BUG_ON (i == SIRFSOC_GPIO_BANK_SIZE);
+	BUG_ON(i == SIRFSOC_GPIO_NO_OF_BANKS);
 
 	chained_irq_enter(chip, desc);
 
-- 
1.9.3
