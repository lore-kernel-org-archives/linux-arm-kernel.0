From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 29 Jul 2017 21:07:07 +0300
Subject: [PATCH] pinctrl-st: fix of_irq_to_resource() result check
Message-ID: <20170729180744.873303067@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_irq_to_resource() has recently been fixed to return negative error #'s
along with 0 in case of failure, however the ST driver still only regards
0 as failure indication -- fix it up.

Fixes: 7a4228bbff76 ("of: irq: use of_irq_get() in of_irq_to_resource()")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/pinctrl/pinctrl-st.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pinctrl/drivers/pinctrl/pinctrl-st.c
===================================================================
--- linux-pinctrl.orig/drivers/pinctrl/pinctrl-st.c
+++ linux-pinctrl/drivers/pinctrl/pinctrl-st.c
@@ -1521,7 +1521,7 @@ static int st_gpiolib_register_bank(stru
 	 *	[irqN]----> [gpio-bank (n)]
 	 */
 
-	if (of_irq_to_resource(np, 0, &irq_res)) {
+	if (of_irq_to_resource(np, 0, &irq_res) > 0) {
 		gpio_irq = irq_res.start;
 		gpiochip_set_chained_irqchip(&bank->gpio_chip, &st_gpio_irqchip,
 					     gpio_irq, st_gpio_irq_handler);
