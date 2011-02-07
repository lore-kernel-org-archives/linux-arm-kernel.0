From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Feb 2011 10:08:18 -0000
Subject: [PATCH] RFC: ux500: add PMU resources
In-Reply-To: <AANLkTimYwi4P=nGTQsibvxe9e1weYS9TLCCUg2BidbRx@mail.gmail.com>
References: <1295391579-9166-1-git-send-email-linus.walleij@stericsson.com>
	<-2131964397930844736@unknownmsgid>
	<AANLkTimYwi4P=nGTQsibvxe9e1weYS9TLCCUg2BidbRx@mail.gmail.com>
Message-ID: <000201cbc6ae$f14aee60$d3e0cb20$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rabin,

Thanks for looking at this.

> Here's the implementation of a different approach which bounces the
> IRQ to the other CPU by setting the affinity when the current CPU
> would return IRQ_NONE.

I considered this, but I think it has some issues.

> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 5efa264..d07990e 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -377,9 +377,27 @@ validate_group(struct perf_event *event)
>  	return 0;
>  }
> 
> +static irqreturn_t armpmu_bounce_interrupt(int irq, void *dev)
> +{
> +	irqreturn_t ret = armpmu->handle_irq(irq, dev);
> +
> +	if (ret == IRQ_NONE) {
> +		int other = !smp_processor_id();
> +		irq_set_affinity(irq, cpumask_of(other));
> +	}

Will this work for edge-triggered IRQs? I don't think it will and I'd
rather this code lived in some SoC-specific place than in the general
ARM code. Maybe you could pass an IRQ callback in the platform data?

> +	/*
> +	 * We should be able to get away with the amount of IRQ_NONEs we give,
> +	 * while still having the spurious IRQ detection code kick in if the
> +	 * interrupt really starts hitting spuriously.
> +	 */
> +	return ret;
> +}

It looks like you have to have less than 1:1000 IRQ_HANDLED:IRQ_NONE for the
IRQ to be disabled so you should be safe.

> +	/*
> +	 * Some SoCs have the PMU IRQ lines of two cores wired together into a
> +	 * single interrupt.
> +	 */

Well, it's only one SoC as far as I know :) A more common problem that I
anticipate is lack of an IRQ altogether, which this solution doesn't help us
with unfortunately.

Will
