From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 19 Oct 2009 22:19:28 +0200
Subject: [PATCH] imx/gpio: Use handle_level_irq
Message-ID: <1255983568-20958-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Russell King handle_edge_irq is only useful for "edge-based
inputs where the controller does not remember transitions with the input
masked."

So using handle_edge_irq unconditionally for both edge and level irqs is
wrong.  Testing showed that the controller does remember transitions
while the interrupt is masked.  So use handle_level_irq unconditionally.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index cfc4a8b..d65ebe3 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -282,7 +282,7 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 		for (j = port[i].virtual_irq_start;
 			j < port[i].virtual_irq_start + 32; j++) {
 			set_irq_chip(j, &gpio_irq_chip);
-			set_irq_handler(j, handle_edge_irq);
+			set_irq_handler(j, handle_level_irq);
 			set_irq_flags(j, IRQF_VALID);
 		}
 
-- 
1.6.5
