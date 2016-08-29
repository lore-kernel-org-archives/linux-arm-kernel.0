From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:24:10 +0100
Subject: [PATCH 01/33] gpio: sa1100: fix irq probing for ucb1x00
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJje-0000lm-Ei@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ucb1x00 has used IRQ probing since it's dawn to find the GPIO interrupt
that it's connected to.  However, commit 23393d49fb75 ("gpio: kill off
set_irq_flags usage") broke this by disabling IRQ probing on GPIO
interrupts.  Fix this.

Fixes: 23393d49fb75 ("gpio: kill off set_irq_flags usage")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpio/gpio-sa1100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index 0c99e8fb9af3..8d8ee0ebf14c 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -155,7 +155,7 @@ static int sa1100_gpio_irqdomain_map(struct irq_domain *d,
 {
 	irq_set_chip_and_handler(irq, &sa1100_gpio_irq_chip,
 				 handle_edge_irq);
-	irq_set_noprobe(irq);
+	irq_set_probe(irq);
 
 	return 0;
 }
-- 
2.1.0
