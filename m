From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Apr 2011 20:26:02 +0200
Subject: [PATCH 5/6] ARM: nmk: update GPIO chained IRQ handler to
	entry/exit functions
In-Reply-To: <1302633340-4795-6-git-send-email-will.deacon@arm.com>
References: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
	<1302633340-4795-6-git-send-email-will.deacon@arm.com>
Message-ID: <BANLkTikNANiZm+K3-9SdDb9MOWGxgpEGNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/12 Will Deacon <will.deacon@arm.com>:

> This patch updates the Nomadik gpio chained IRQ handler to use the
> chained IRQ enter/exit functions in order to function correctly on
> primary controllers with different methods of flow control.
>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

BUT I want it to go through Grants gpio tree. The reason is that
I plan to consolidate this driver into drivers/gpio/* and I don't want
collisions in merges.

And wait:

> +#include <asm/mach/irq.h>

> - ? ? ? if (host_chip->irq_mask_ack)
> - ? ? ? ? ? ? ? host_chip->irq_mask_ack(&desc->irq_data);
> - ? ? ? else {
> - ? ? ? ? ? ? ? host_chip->irq_mask(&desc->irq_data);
> - ? ? ? ? ? ? ? if (host_chip->irq_ack)
> - ? ? ? ? ? ? ? ? ? ? ? host_chip->irq_ack(&desc->irq_data);
> - ? ? ? }
> + ? ? ? chained_irq_enter(host_chip, desc);

(...)

> - ? ? ? host_chip->irq_unmask(&desc->irq_data);
> + ? ? ? chained_irq_exit(host_chip, desc);

This looks an awful lot like this from drivers/gpio/pl061.c:

desc->irq_data.chip->irq_ack(&desc->irq_data);
(...)
desc->irq_data.chip->irq_unmask(&desc->irq_data);

It gets me wondering what the proper way is to do this.
Isn't the proper place for chained_irq_[enter|exit]* in
include/linux/irq.h rather? It does not really look machine
or arch specific, is it, really?

I.e. this:

#ifndef __ASSEMBLY__
/*
 * Entry/exit functions for chained handlers where the primary IRQ chip
 * may implement either fasteoi or level-trigger flow control.
 */
static inline void chained_irq_enter(struct irq_chip *chip,
                                     struct irq_desc *desc)
{
        /* FastEOI controllers require no action on entry. */
        if (chip->irq_eoi)
                return;

        if (chip->irq_mask_ack) {
                chip->irq_mask_ack(&desc->irq_data);
        } else {
                chip->irq_mask(&desc->irq_data);
                if (chip->irq_ack)
                        chip->irq_ack(&desc->irq_data);
        }
}

static inline void chained_irq_exit(struct irq_chip *chip,
                                    struct irq_desc *desc)
{
        if (chip->irq_eoi)
                chip->irq_eoi(&desc->irq_data);
        else
                chip->irq_unmask(&desc->irq_data);
}
#endif

Excuse me if this was discussed before...

Yours,
Linus Walleij
