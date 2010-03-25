From: jamie.iles@picochip.com (Jamie Iles)
Date: Thu, 25 Mar 2010 15:36:52 +0000
Subject: [PATCH 1/6] ARM: pmu: register IRQs at runtime
In-Reply-To: <1269530198-19572-2-git-send-email-will.deacon@arm.com>
References: <1269530198-19572-1-git-send-email-will.deacon@arm.com>
	<1269530198-19572-2-git-send-email-will.deacon@arm.com>
Message-ID: <20100325153652.GL8118@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 03:16:33PM +0000, Will Deacon wrote:
> The current PMU infrastructure for ARM requires that the IRQs for the PMU
> device are fixed at compile time and are selected based on the ARCH_ or MACH_
> flags. This has the disadvantage of tying the Kernel down to a particular board
> as far as profiling is concerned.
> 
> This patch replaces the compile-time IRQ registration with a runtime mechanism
> which allows the IRQs to be registered with the framework as a platform_device.
> 
> A further advantage of this change is that there is scope for registering
> different types of performance counters in the future by changing the id of
> the platform_device and attaching different resources to it.
> 
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Jamie Iles <jamie.iles@picochip.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
[snip]
> -	for (i = 0; i < pmu_irqs->num_irqs; ++i) {
> -		err = request_irq(pmu_irqs->irqs[i], armpmu->handle_irq,
> +	for (i = 0; i < pmu_device->num_resources; ++i) {
> +		err = request_irq(platform_get_irq(pmu_device, i),
> +				  armpmu->handle_irq,
>  				  IRQF_DISABLED | IRQF_NOBALANCING,
>  				  "armpmu", NULL);
[snip]
> @@ -356,12 +358,12 @@ armpmu_release_hardware(void)
>  {
>  	int i;
>  
> -	for (i = pmu_irqs->num_irqs - 1; i >= 0; --i)
> -		free_irq(pmu_irqs->irqs[i], NULL);
> +	for (i = pmu_device->num_resources - 1; i >= 0; --i)
> +		free_irq(platform_get_irq(pmu_device, i), NULL);
Hi Will,

This looks fine at the moment as all PMU's only have IRQ resources but if we
ever have any with memory resources then we'll need to check the return value
of platform_get_irq() to make sure that the resource is a valid IRQ. Apologies
for not spotting it before! If we had:

	int irq = platform_get_irq(pmu_device, i);
	if (irq < 0)
		continue;

or something similar to be a bit future proof then I'm happy with that and:

Acked-by: Jamie Iles <jamie.iles@picochip.com>

Jamie
