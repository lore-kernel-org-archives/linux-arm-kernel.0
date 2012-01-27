From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 27 Jan 2012 13:19:42 +0000
Subject: DaVinci unbanked GPIO IRQs broken
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B6317926BB@DBDE01.ent.ti.com>
References: <70E876B0EA86DD4BAF101844BC814DFE0BF403DA89@Cloud.RL.local>
 <DF0F476B391FA8409C78302C7BA518B6317926BB@DBDE01.ent.ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317A6E2B@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Jan 17, 2012 at 15:32:23, Nori, Sekhar wrote:

> I was able to reproduce this on the EVM using v2.6.38 (works)
> and v3.2 + my patch (doesn't work). I just started poking some
> registers to see what is happening. Will keep you updated
> on any progress.
> 

Following patch fixes the issue of interrupt handler not getting
called. I tested it using GPIO3 on DM365. On applying this, I
see a constant rate of 4-5 interrupts per second on that line.
Yet to figure out what is triggering those. Anyway I will wait for
you to test this after you are back before sending this to Grant.

Thanks,
Sekhar

------8<---------
From: Sekhar Nori <nsekhar@ti.com>
Date: Fri, 27 Jan 2012 00:31:54 +0530
Subject: [PATCH] gpio/davinci: fix enabling of unbanked GPIO IRQs

Unbanked GPIO IRQ handling code made a copy of just
the irq_chip structure for GPIO IRQ lines which caused
problems after the generic IRQ chip conversion because
there was no valid irq_chip_type structure with the
right "regs" populated. irq_gc_mask_set_bit() was
therefore accessing random addresses.

Fix it by making a copy of irq_chip_type structure
instead. This will ensure sane register offsets.

Reported-by: Jon Povey <Jon.Povey@racelogic.co.uk>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/gpio/gpio-davinci.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index a6777e5..3d00016 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -386,7 +386,7 @@ static int __init davinci_gpio_irq_setup(void)
 	 * IRQ mux conflicts; gpio_irq_type_unbanked() is only for GPIOs.
 	 */
 	if (soc_info->gpio_unbanked) {
-		static struct irq_chip gpio_irqchip_unbanked;
+		static struct irq_chip_type gpio_unbanked;
 
 		/* pass "bank 0" GPIO IRQs to AINTC */
 		chips[0].chip.to_irq = gpio_to_irq_unbanked;
@@ -394,9 +394,10 @@ static int __init davinci_gpio_irq_setup(void)
 
 		/* AINTC handles mask/unmask; GPIO handles triggering */
 		irq = bank_irq;
-		gpio_irqchip_unbanked = *irq_get_chip(irq);
-		gpio_irqchip_unbanked.name = "GPIO-AINTC";
-		gpio_irqchip_unbanked.irq_set_type = gpio_irq_type_unbanked;
+		gpio_unbanked = *container_of(irq_get_chip(irq),
+					      struct irq_chip_type, chip);
+		gpio_unbanked.chip.name = "GPIO-AINTC";
+		gpio_unbanked.chip.irq_set_type = gpio_irq_type_unbanked;
 
 		/* default trigger: both edges */
 		g = gpio2regs(0);
@@ -405,7 +406,7 @@ static int __init davinci_gpio_irq_setup(void)
 
 		/* set the direct IRQs up to use that irqchip */
 		for (gpio = 0; gpio < soc_info->gpio_unbanked; gpio++, irq++) {
-			irq_set_chip(irq, &gpio_irqchip_unbanked);
+			irq_set_chip(irq, &gpio_unbanked.chip);
 			irq_set_handler_data(irq, &chips[gpio / 32]);
 			irq_set_status_flags(irq, IRQ_TYPE_EDGE_BOTH);
 		}
