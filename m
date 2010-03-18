From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 18 Mar 2010 12:20:10 +0000
Subject: [RFC PATCH 1/6] ARM: pmu: register IRQs at runtime
In-Reply-To: <1268842288-30960-1-git-send-email-will.deacon@arm.com>
References: <20100316114131.GC4116@wear.picochip.com>
	<1268842288-30960-1-git-send-email-will.deacon@arm.com>
Message-ID: <20100318122010.GC4177@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 04:11:27PM +0000, Will Deacon wrote:
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
Hi Will,

This seems like a nice approach to the problem. A couple of pedantic comments
inline!

Jamie
> Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/pmu.h   |   30 +++++-----
>  arch/arm/kernel/perf_event.c |   36 +++++++------
>  arch/arm/kernel/pmu.c        |  121 ++++++++++++++++++++++++++----------------
>  3 files changed, 110 insertions(+), 77 deletions(-)
[snip]
> +static int __devinit pmu_device_probe(struct platform_device *pdev)
> +{
> +
> +	if (pdev->id >= ARM_NUM_PMU_DEVICES) {
> +		pr_warning("PMU: Received registration request for unknown "
> +				"device %d\n", pdev->id);
> +		return -EINVAL;
> +	}
> +
> +	if (pmu_devices[pdev->id])
> +		pr_warning("PMU: Registering new PMU device type %d overwrites "
> +				"previous registration!\n", pdev->id);
> +	else
> +		pr_info("PMU: Registered new PMU device of type %d\n",
> +				pdev->id);
> +
> +	pmu_devices[pdev->id] = pdev;
struct pdev->id is a signed integer so we should check that it's not less than
0 so we don't overrun pmu_devices..
> @@ -79,7 +91,7 @@ set_irq_affinity(int irq,
>  #ifdef CONFIG_SMP
>  	int err = irq_set_affinity(irq, cpumask_of(cpu));
>  	if (err)
> -		pr_warning("unable to set irq affinity (irq=%d, cpu=%u)\n",
> +		pr_warning("PMU: Unable to set irq affinity (irq=%d, cpu=%u)\n",
>  			   irq, cpu);
How about we stick a '#define pr_fmt(fmt) "PMU: " fmt' before the includes so
we get consistent naming if we add more pr_*() statements?
>  	return err;
>  #else
> @@ -87,17 +99,36 @@ set_irq_affinity(int irq,
>  #endif
>  }
>  
> -int
> -init_pmu(void)
> +static int
> +init_cpu_pmu(void)
>  {
>  	int i, err = 0;
> +	struct platform_device *pdev = pmu_devices[ARM_PMU_DEVICE_CPU];
Just to be safe:

if (!pdev)
	return -ENODEV;
> -	for (i = 0; i < pmu_irqs.num_irqs; ++i) {
> -		err = set_irq_affinity(pmu_irqs.irqs[i], i);
> +	for (i = 0; i < pdev->num_resources; ++i) {
> +		err = set_irq_affinity(platform_get_irq(pdev, i), i);
>  		if (err)
>  			break;
>  	}
>  
>  	return err;
>  }
