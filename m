From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 6 Jun 2011 17:25:36 +0200 (CEST)
Subject: TI-Davinci 6446 oops on interrupts
In-Reply-To: <4DECEDF9.4010202@selfish.org>
References: <4DECCADE.6080100@selfish.org> <4DECD8C0.6010908@freyther.de>
	<alpine.LFD.2.02.1106061650210.13964@ionos>
	<4DECEDF9.4010202@selfish.org>
Message-ID: <alpine.LFD.2.02.1106061719290.13964@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Jun 2011, Holger Freyther wrote:
> On 06/06/2011 04:54 PM, Thomas Gleixner wrote:
> 
> and both interrupts should be on REG1.. so for IRQ56 it looks like this method
> is entered with bogus data. Again, I have no idea about the underlying code,
> but could there be an issue with chained irq and the GC IRC code?

Crap, yes. The code which does the chained handler setup overwrites
chip_data.

Subject: arm: davinci: Fix fallout from generic irq chip conversion
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 06 Jun 2011 11:51:43 +0200

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/mach-davinci/gpio.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/arm/mach-davinci/gpio.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-davinci/gpio.c
+++ linux-2.6/arch/arm/mach-davinci/gpio.c
@@ -252,9 +252,11 @@ static struct irq_chip gpio_irqchip = {
 static void
 gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
-	struct davinci_gpio_regs __iomem *g = irq2regs(irq);
+	struct davinci_gpio_regs __iomem *g;
 	u32 mask = 0xffff;
 
+	g = (__force struct davinci_gpio_regs __iomem *) irq_desc_get_handler_data(desc);
+
 	/* we only care about one bank */
 	if (irq & 1)
 		mask <<= 16;
@@ -422,8 +424,7 @@ static int __init davinci_gpio_irq_setup
 
 		/* set up all irqs in this bank */
 		irq_set_chained_handler(bank_irq, gpio_irq_handler);
-		irq_set_chip_data(bank_irq, (__force void *)g);
-		irq_set_handler_data(bank_irq, (void *)irq);
+		irq_set_handler_data(bank_irq, (__force void *)g);
 
 		for (i = 0; i < 16 && gpio < ngpio; i++, irq++, gpio++) {
 			irq_set_chip(irq, &gpio_irqchip);
