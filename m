From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 18 Jul 2013 14:58:06 +0200
Subject: [PATCH] gpio/mxc: add chained_irq_enter/exit() to mx2_gpio_irq_handler
Message-ID: <1374152286-12955-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to commit

	0e44b6e (gpio/mxc: add chained_irq_enter/exit() to mx3_gpio_irq_handler())

. It doesn't seem to be critical to make the irqs work, but still it is
more correct.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

note this is completely untested.

Uwe

 drivers/gpio/gpio-mxc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 7176743..832881c 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -291,6 +291,9 @@ static void mx2_gpio_irq_handler(u32 irq, struct irq_desc *desc)
 {
 	u32 irq_msk, irq_stat;
 	struct mxc_gpio_port *port;
+	struct irq_chip *chip = irq_get_chip(irq);
+
+	chained_irq_enter(chip, desc);
 
 	/* walk through all interrupt status registers */
 	list_for_each_entry(port, &mxc_gpio_ports, node) {
@@ -302,6 +305,7 @@ static void mx2_gpio_irq_handler(u32 irq, struct irq_desc *desc)
 		if (irq_stat)
 			mxc_gpio_irq_handler(port, irq_stat);
 	}
+	chained_irq_exit(chip, desc);
 }
 
 /*
-- 
1.8.3.2
