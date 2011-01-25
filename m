From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 25 Jan 2011 16:54:22 +0100
Subject: [PATCH] ARM: mxs: acknowledge gpio irq
Message-ID: <1295970862-23679-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a machine hang after a gpio irq triggered.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxs/gpio.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/gpio.c b/arch/arm/mach-mxs/gpio.c
index d7ad7a6..cb0c0e8 100644
--- a/arch/arm/mach-mxs/gpio.c
+++ b/arch/arm/mach-mxs/gpio.c
@@ -139,6 +139,8 @@ static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
 	struct mxs_gpio_port *port = (struct mxs_gpio_port *)get_irq_data(irq);
 	u32 gpio_irq_no_base = port->virtual_irq_start;
 
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
+
 	irq_stat = __raw_readl(port->base + PINCTRL_IRQSTAT(port->id)) &
 			__raw_readl(port->base + PINCTRL_IRQEN(port->id));
 
-- 
1.7.2.3
