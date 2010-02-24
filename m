From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:09 +0100
Subject: [PATCH 14/39] arm/imx/gpio: use fls to find set bits in the irq
	status register
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-14-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As in most cases only few irqs are pending using fls is more effective
than looping over all bits.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/gpio.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index bee100b..0b11554 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -154,24 +154,22 @@ static void mxc_flip_edge(struct mxc_gpio_port *port, u32 gpio)
 	__raw_writel(val | (edge << (bit << 1)), reg);
 }
 
-/* handle n interrupts in one status register */
+/* handle 32 interrupts in one status register */
 static void mxc_gpio_irq_handler(struct mxc_gpio_port *port, u32 irq_stat)
 {
-	u32 gpio_irq_no;
+	u32 gpio_irq_no_base = port->virtual_irq_start;
 
-	gpio_irq_no = port->virtual_irq_start;
-	for (; irq_stat != 0; irq_stat >>= 1, gpio_irq_no++) {
-		u32 gpio = irq_to_gpio(gpio_irq_no);
+	while (irq_stat != 0) {
+		int irqoffset = fls(irq_stat) - 1;
 
-		if ((irq_stat & 1) == 0)
-			continue;
+		BUG_ON(!(irq_desc[gpio_irq_no_base + irqoffset].handle_irq));
 
-		BUG_ON(!(irq_desc[gpio_irq_no].handle_irq));
+		if (port->both_edges & (1 << irqoffset))
+			mxc_flip_edge(port, irqoffset);
 
-		if (port->both_edges & (1 << (gpio & 31)))
-			mxc_flip_edge(port, gpio);
+		generic_handle_irq(gpio_irq_no_base + irqoffset);
 
-		generic_handle_irq(gpio_irq_no);
+		irq_stat &= ~(1 << irqoffset);
 	}
 }
 
-- 
1.6.6.2
