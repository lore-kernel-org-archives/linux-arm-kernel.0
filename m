From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Apr 2013 22:23:43 +0200
Subject: [PATCH v3] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <201304172223.43707.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 April 2013, Uwe Kleine-K?nig wrote:

> This patch triggers two checkpatch warnings:
> 
> 	WARNING: Avoid CamelCase: <nvic_do_IRQ>
> 	WARNING: Avoid CamelCase: <handle_IRQ>
> 
> but I think they are OK for consistency?!

You obviously have no choice for handle_IRQ, but I think the common way to
name the first-level interrupt handler would be "nvic_handle_irq" here.

> Moreover sparse tells me:
> 
> 	drivers/irqchip/irq-nvic.c:58:1: warning: symbol 'nvic_do_IRQ' was not declared. Should it be static?
> 
> nvic_do_IRQ is called from assembler only, so a declaration couldn't be
> shared and I couldn't find a nice place for a declaration. Suggestions
> welcome.

Can't you make it static and call set_handle_irq() on it from the
probe function?

> + * Each bank handles 32 irqs. Only the 16th (= last) bank handles only
> + * 16 irqs.
> + */
> +#define NVIC_MAX_IRQ		((NVIC_MAX_BANKS - 1) * 32 + 16)

Is this actually inherent to the hardware design, or is the number of irqs
actually customizable? Also, why do you care about the maximum? You only
use it to check against the device tree provided value, but I suppose
you could just as well trust that property to be correct.


	Arnd
