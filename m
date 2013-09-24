From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Sep 2013 21:38:49 -0600
Subject: [PATCH] irq: bcm2835: Re-implement the hardware IRQ handler.
In-Reply-To: <1379755112-19446-1-git-send-email-slapdau@yahoo.com.au>
References: <1379751251-2799-1-git-send-email-slapdau@yahoo.com.au>
 <1379755112-19446-1-git-send-email-slapdau@yahoo.com.au>
Message-ID: <52410949.8070403@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2013 03:18 AM, Craig McGeachie wrote:
> The justification for doing this is:
>  * Simplify the decode and dispatch logic to make it easier to under-
>    stand and maintain.
>  * Re-arrange the hardware IRQ numbers to match the numbering scheme of
>    the FIQ register.

What's the benefit of that change? The bank numbers in the existing
driver match the register naming in the HW (base/pend1/pend2 for bank
0/1/2). Further on, one of your added comments says "This is the same
numbering scheme used in bits 0..6 of the FIQ register."; what about any
other bits in the FIQ register - do they still not match the renumbered
scheme, or are there just fewer bits in the FIQ register? Either way, I
don't understand why it's useful for the internal IRQ IDs to match the
FIQ register.

I guess the table of interrupt IDs in BCM2835_ARM_Peripherals.pdf

>  * Restore the flow of control that re-reads the base pending register
>    after handling any interrupt. The current version handles all
>    interrupts found in a GPU pending register before re-reading the
>    base pending register. In the original Broadcom assembly code, there
>    appear to be defect tracking numbers next to code inserted to create
>    this behaviour.

I assume you mean the assembly in BCM2835_ARM_Peripherals.pdf? I'm not
really sure that code implies that SW must work the way you've modified
it to work, although there's probably no harm making this change.

The "defect tracking numbers" in that code simply make sure that when
reading PEND1, any status bits there that also have shortcut bits in the
base pending register aren't handled. Presumably this is simply to avoid
having two IRQ numbers for the same physical IRQ, since any table
lookups for an IRQ handler would fail if using an IRQ ID derived from
PEND1 bank/bit ID rather than base bank/bit ID. IIRC, the existing Linux
driver already does this (ignores the bits in PEND1 that are
duplicates). This logic doesn't imply that one can't loop reading the
PEND1 register.

>  * DTS IRQ specifications can refer to either a shortcut bit in base or
>    the GPU bits.  E.g. UART can be either <0, 19> or <2, 25>.
>  * Add .irq_ack to the chip operations.

> diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c

>   * GNU General Public License for more details.
> - *
> - * Quirk 1: Shortcut interrupts don't set the bank 1/2 register pending bits
> - *
> - * If an interrupt fires on bank 1 that isn't in the shortcuts list, bit 8
...
> - * otherwise both handlers will fire at the same time!
>   */

That removes a bunch of useful description of the HW. I don't think it's
a good idea to remove it.

> -
> +#include <linux/bitops.h>

You should add a new line for the new header file, rather than replacing
the existing blank line.

>  #include <linux/io.h>
> -#include <linux/slab.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> -#include <linux/irqdomain.h>
> -
>  #include <asm/exception.h>
> -#include <asm/mach/irq.h>
> -
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
>  #include "irqchip.h"

Please keep the includes grouped by <linux/>, <asm/> then any local
includes.

> +#define BAD_IRQ_NUM	-1

That should be 0; Using -1 for invalid IRQ is deprecated.

> +static int bmc2835_domain_xlate(struct irq_domain *d, struct device_node *np,
>  	const u32 *intspec, unsigned int intsize,
>  	unsigned long *out_hwirq, unsigned int *out_type)
>  {
> -	if (WARN_ON(intsize != 2))
> +	unsigned int hwirq;
> +	if (WARN_ON(intsize != 2 || intspec[0] >= NR_BANKS || intspec[1] >= 32))
>  		return -EINVAL;

There should be a blank line between variable declarations and code.

> +	hwirq = ctrlr.hwirq_xlat[MAKE_HWIRQ((intspec[0] + 2) % 3, intspec[1])];
> +	if (WARN_ON(hwirq == BAD_IRQ_NUM))
>  		return -EINVAL;

I'd prefer to see "(intspec[0] + 2) % 3" be a macro or static inline
function so it can be given a name (e.g. dt_to_internal_bank()) so it's
obvious what that's doing. Otherwise, it seems rather confusing.

I'm not sure why a hwirq_xlat table lookup is needed; why not just
return the HW IRQ number directly like the existing code?

> +static void bmc2835_mask_irq(struct irq_data *d)
>  {
> +	void __iomem *ioreg = ctrlr.iobase + 0x1c + (HWIRQ_BANK(d->hwirq) << 2);
> +	u32 bit = HWIRQ_BIT(d->hwirq);
> +	writel_relaxed(bit, ioreg);
> +}

The old code seems a lot simpler here, since there aren't any magic
constants in the code, but rather simply a table of register addresses
that's indexed by bank number:

> static int reg_disable[] __initconst = { 0x24, 0x1c, 0x20 };
...
> static void armctrl_mask_irq(struct irq_data *d)
> {
>         writel_relaxed(HWIRQ_BIT(d->hwirq), intc.disable[HWIRQ_BANK(d->hwirq)]);
> }

What's the benefit of this change? A similar comment for
bmc2835_unmask_irq().

> +static struct irq_chip bmc2835_chip = {
> +	.name = "bmc2835-level",
> +	.irq_mask = bmc2835_mask_irq,
> +	.irq_unmask = bmc2835_unmask_irq,
> +	.irq_ack =  bmc2835_mask_irq,
> +};

Why should an IRQ be masked by the ack operation?

> +/**
> + * bmc2835_dispatch_irq() - translate bank/bit to kernel IRQ and dispatch
> + * @bank:	Register bank (BASE, GPU1, or GPU2).
> + * @bits:	Pending interrupt status bits.
> + * @regs:	register pointer passed on to the handler.
> + *
> + * The bits passed are the full set of bits read from register.  Only the lowest
> + * order bit is translated and dispatched. Dispatching the other IRQs requires
> + * re-reading the register and calling this function again.

I'm not actually sure that's a good change. If we read e.g. PEND1 and
saw 4 bits asserted, why wouldn't we optimize by handling each of those
4 bits. Re-reading the PEND1 register for each bit, and presumably
seeing the exact same set of remaining bits still set (or even more),
just seems like a waste. We know we're going to have to process all the
interrupts, so why not just process them?

> +static int __init bmc2835_of_init(struct device_node *node,

> +	for (i = 0; i != NR_CHIP_IRQS; i++) {
> +		int irq;
> +		BUG_ON((irq = irq_create_mapping(ctrlr.domain, i)) <= 0);

I rather dislike statements with assignment side-effects. That was a
separate assignment and test statement in the original code, which seems
much clearer.

Overall, I'm not sure what bug/issue in the original code this patch is
meant to solve, nor why the new IRQ ID scheme is better. Sorry.
