From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 13 Jan 2012 10:56:04 +0000
Subject: DaVinci unbanked GPIO IRQs broken
In-Reply-To: <70E876B0EA86DD4BAF101844BC814DFE0BF3FFD2EF@Cloud.RL.local>
References: <70E876B0EA86DD4BAF101844BC814DFE0BF3FFD2EF@Cloud.RL.local>
Message-ID: <DF0F476B391FA8409C78302C7BA518B63178FB3F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, Jan 11, 2012 at 17:17:34, Jon Povey wrote:
> Unbanked GPIO IRQs (I am on DM365) seem to have been broken
> by commit aac4dd1dab8acfc244d697473d2a5f4424a5746c, conversion
> to generic irq chip, leading to an oops from request_irq().
> 
> Please note I am on kernel 3.0.0-rc7 not the latest, although
> I tried more recent gpio.c patches to no avail, I think this is
> probably still broken in 3.2.

Yes, I was able to reproduce it on my 3.2-rc6 based branch.

> 
> The problem seems to be with chip_data and chip getting overwritten
> in davinci_gpio_irq_setup(), this was fixed for banked IRQs but not
> unbanked. I had a go at fixing the overwrite of chip_data but it
> still oopses in the same function, irq_gc_mask_set_bit().

The root cause indeed seems to be chip_data getting
overwritten.

I made a patch for it and was able to test that requesting IRQ
number 44 doesn't oops. Yet to figure out if there is an easy way
to trigger an unbanked GPIO IRQ on the EVM, so a large part of
the patch is actually untested. Anyway, can you give this patch
a shot (hopefully not mailer mangled)? I don't like the fact that
it increases davinci_soc_info usage, but first lets see if it fixes
the issue.

Thanks,
Sekhar

------8<------------------------
From: Sekhar Nori <nsekhar@ti.com>
Date: Fri, 13 Jan 2012 15:55:35 +0530
Subject: [PATCH] gpio/davinci: fix unbanked gpio irq handling

Unbanked GPIO irq setup code was overwriting chip_data leading
to oops on request_irq()

Fix the issue.

Reported-by: Jon Povey <Jon.Povey@racelogic.co.uk>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/gpio/gpio-davinci.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index df0d595..a6777e5 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -313,10 +313,16 @@ static int gpio_to_irq_unbanked(struct gpio_chip *chip, unsigned offset)
 		return -ENODEV;
 }
 
-static int gpio_irq_type_unbanked(struct irq_data *d, unsigned trigger)
+static int gpio_irq_type_unbanked(struct irq_data *data, unsigned trigger)
 {
-	struct davinci_gpio_regs __iomem *g = irq2regs(d->irq);
-	u32 mask = (u32) irq_data_get_irq_handler_data(d);
+	struct davinci_gpio_controller *d;
+	struct davinci_gpio_regs __iomem *g;
+	struct davinci_soc_info *soc_info = &davinci_soc_info;
+	u32 mask;
+
+	d = (struct davinci_gpio_controller *)data->handler_data;
+	g = (struct davinci_gpio_regs __iomem *)d->regs;
+	mask = __gpio_mask(data->irq - soc_info->gpio_irq);
 
 	if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
 		return -EINVAL;
@@ -400,8 +406,7 @@ static int __init davinci_gpio_irq_setup(void)
 		/* set the direct IRQs up to use that irqchip */
 		for (gpio = 0; gpio < soc_info->gpio_unbanked; gpio++, irq++) {
 			irq_set_chip(irq, &gpio_irqchip_unbanked);
-			irq_set_handler_data(irq, (void *)__gpio_mask(gpio));
-			irq_set_chip_data(irq, (__force void *)g);
+			irq_set_handler_data(irq, &chips[gpio / 32]);
 			irq_set_status_flags(irq, IRQ_TYPE_EDGE_BOTH);
 		}
 
--
