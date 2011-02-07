From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Feb 2011 11:39:18 -0000
Subject: [PATCH] RFC: ux500: add PMU resources
In-Reply-To: <AANLkTi=atjR8-gDU-9=3o5GLjj+S50-7k_myP199tp0G@mail.gmail.com>
References: <1295391579-9166-1-git-send-email-linus.walleij@stericsson.com>
	<-2131964397930844736@unknownmsgid>
	<AANLkTi=atjR8-gDU-9=3o5GLjj+S50-7k_myP199tp0G@mail.gmail.com>
Message-ID: <000601cbc6bb$a7cf8450$f76e8cf0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Here's the IPI version as well, for comparison with the other
> approach.  The IRQ handling code will mask the interrupt before
> handling it, so it can't nest, can it?

It's not safe to cross-call from an IRQ handler with interrupts disabled
though as you're asking for deadlock. I think you'll need to schedule the
IPI for later, which is why you end up being nested.
 
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 5efa264..a97e50f 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -19,6 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/uaccess.h>
> +#include <linux/smp.h>

[...]

> +static irqreturn_t armpmu_core2_irqret;
> +
> +/* Called via IPI on the second core */
> +static void armpmu_kick(void *data)
> +{
> +	int irq = (int) data;
> +
> +	armpmu_core2_irqret = armpmu->handle_irq(irq, NULL);
> +	smp_wmb();
> +}

That barrier isn't going to do much. If you want to make the value
visible, you'll need a dsb().

> +static irqreturn_t armpmu_single_interrupt(int irq, void *dev)
> +{
> +	irqreturn_t irqret = armpmu->handle_irq(irq, dev);
> +	int err;
> +
> +	if (irqret != IRQ_NONE)
> +		return irqret;
> +
> +	local_irq_enable();
> +	err = smp_call_function_single(1, armpmu_kick, (void *) irq, true);
> +	local_irq_disable();

Ah, I'd not considered re-enabling interrupts from the handler. I think that will
work, but this code doesn't belong in the main perf stuff as it's too platform
dependent.

> +	if (err)
> +		return irqret;
> +
> +	smp_rmb();
> +	return armpmu_core2_irqret;
> +}

This read barrier won't help either because there's only one shared variable.
The visibility of the return value should be guaranteed by the cross-call code
(see csd_{un}lock) so you can probably lose the barriers altogether.

Will
