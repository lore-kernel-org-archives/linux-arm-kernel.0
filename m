From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Fri,  8 Nov 2013 12:15:55 +0530
Subject: [PATCH 1/2] gpio: davinci: Fix a check for unbanked gpio
In-Reply-To: <1383893156-28010-1-git-send-email-prabhakar.csengg@gmail.com>
References: <1383893156-28010-1-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <1383893156-28010-2-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

This patch fixes a check for offset in gpio_to_irq_unbanked()
and also assigns gpio_irq, gpio_unbanked of chips[0] to
appropriate values which is used in gpio_to_irq_unbanked()
function.

Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 drivers/gpio/gpio-davinci.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 8847adf..84be701 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -327,7 +327,7 @@ static int gpio_to_irq_unbanked(struct gpio_chip *chip, unsigned offset)
 	 * NOTE:  we assume for now that only irqs in the first gpio_chip
 	 * can provide direct-mapped IRQs to AINTC (up to 32 GPIOs).
 	 */
-	if (offset < d->irq_base)
+	if (offset < d->gpio_unbanked)
 		return d->gpio_irq + offset;
 	else
 		return -ENODEV;
@@ -419,6 +419,8 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 
 		/* pass "bank 0" GPIO IRQs to AINTC */
 		chips[0].chip.to_irq = gpio_to_irq_unbanked;
+		chips[0].gpio_irq = bank_irq;
+		chips[0].gpio_unbanked = pdata->gpio_unbanked;
 		binten = BIT(0);
 
 		/* AINTC handles mask/unmask; GPIO handles triggering */
-- 
1.7.9.5
