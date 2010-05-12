From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 13 May 2010 09:20:01 +1200
Subject: Unnecessary double check of PIO_ISR in gpio_irq_handler?
In-Reply-To: <w2p30e5226d1005120129g829eb39ei581d1ae3248f4fa5@mail.gmail.com>
References: <w2p30e5226d1005120129g829eb39ei581d1ae3248f4fa5@mail.gmail.com>
Message-ID: <4BEB1B81.9030903@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dballman wrote:
> Hi all,
>
> In the following function of the file arch/arm/mach-at91/gpio.c it can
> be seen that when PIO_ISR is read to check pending interrupts, if no
> interrupts are pending the PIO_ISR of the next bank is read by doing a
> at91_gpio = at91_gpio->next; and then a continue. But if interrupts
> are pending, the code inside while(isr) is executed and when it
> finishes it doesn't do the at91_gpio = at91_gpio->next, reading the
> same PIO_ISR again in the next iteration.
>
> Since the PIO_ISR register is cleared when it's read, does this
> behavior make sense? Maybe it should have to be done the same
> at91_gpio = at91_gpio->next whenever possible at the end of the while
> loop?
>   
The code will work correctly. If there are interrupts pending then they
will be acked by the read of PIO_ISR, then internal while loop will
process them, and then the second time around the loop PIO_ISR will read
as zero and it will move to the next gpio bank.

You are however correct that the code is slightly less than optimal. The
following (completely untested) patch simplifies the code and only reads
the PIO_ISR register once for each gpio bank:

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index ae4772e..cd122fe 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -389,24 +389,16 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 	void __iomem	*pio;
 	u32		isr;
 
-	at91_gpio = get_irq_chip_data(irq);
-	pio = at91_gpio->regbase;
-
 	/* temporarily mask (level sensitive) parent IRQ */
 	desc->chip->ack(irq);
-	for (;;) {
+	for (at91_gpio = get_irq_chip_data(irq); at91_gpio; 
+	     at91_gpio = at91_gpio->next) {
 		/* Reading ISR acks pending (edge triggered) GPIO interrupts.
 		 * When there none are pending, we're finished unless we need
 		 * to process multiple banks (like ID_PIOCDE on sam9263).
 		 */
+		pio = at91_gpio->regbase;
 		isr = __raw_readl(pio + PIO_ISR) & __raw_readl(pio + PIO_IMR);
-		if (!isr) {
-			if (!at91_gpio->next)
-				break;
-			at91_gpio = at91_gpio->next;
-			pio = at91_gpio->regbase;
-			continue;
-		}
 
 		pin = at91_gpio->chip.base;
 		gpio = &irq_desc[pin];
