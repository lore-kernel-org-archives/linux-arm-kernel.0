From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Apr 2013 10:15:55 +0200
Subject: [PATCH v3] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <201304172223.43707.arnd@arndb.de>
References: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201304172223.43707.arnd@arndb.de>
Message-ID: <20130418081555.GV30416@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 10:23:43PM +0200, Arnd Bergmann wrote:
> On Wednesday 17 April 2013, Uwe Kleine-K?nig wrote:
> 
> > This patch triggers two checkpatch warnings:
> > 
> > 	WARNING: Avoid CamelCase: <nvic_do_IRQ>
> > 	WARNING: Avoid CamelCase: <handle_IRQ>
> > 
> > but I think they are OK for consistency?!
> 
> You obviously have no choice for handle_IRQ, but I think the common way to
> name the first-level interrupt handler would be "nvic_handle_irq" here.
The function I called before is asm_do_IRQ which is another instance of
this naming scheme. But I agree that nvic_handle_irq is nicer and will
change to nvic_handle_irq in the next iteration.
 
> > Moreover sparse tells me:
> > 
> > 	drivers/irqchip/irq-nvic.c:58:1: warning: symbol 'nvic_do_IRQ' was not declared. Should it be static?
> > 
> > nvic_do_IRQ is called from assembler only, so a declaration couldn't be
> > shared and I couldn't find a nice place for a declaration. Suggestions
> > welcome.
> 
> Can't you make it static and call set_handle_irq() on it from the
> probe function?
Yeah that works. Then nvic_handle_irq needs to determine the irq itself
which is currently done in the entry code.

> > + * Each bank handles 32 irqs. Only the 16th (= last) bank handles only
> > + * 16 irqs.
> > + */
> > +#define NVIC_MAX_IRQ		((NVIC_MAX_BANKS - 1) * 32 + 16)
> 
> Is this actually inherent to the hardware design, or is the number of irqs
> actually customizable? Also, why do you care about the maximum? You only
> use it to check against the device tree provided value, but I suppose
> you could just as well trust that property to be correct.
I don't provide a value for the number of irqs in the device tree. There
is only the value INTLINESNUM in the V7M_SCS_ICTR register that is used
to determine the number of interrupt banks.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
