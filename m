From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 07 Feb 2011 07:55:03 +0000
Subject: [PATCH] RFC: ux500: add PMU resources
In-Reply-To: <AANLkTi=atjR8-gDU-9=3o5GLjj+S50-7k_myP199tp0G@mail.gmail.com>
References: <1295391579-9166-1-git-send-email-linus.walleij@stericsson.com>
	<-2131964397930844736@unknownmsgid>
	<AANLkTi=atjR8-gDU-9=3o5GLjj+S50-7k_myP199tp0G@mail.gmail.com>
Message-ID: <4D4FA557.9090805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus and I have already added our SoBs.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

On 07/02/11 05:56, Rabin Vincent wrote:
> On Wed, Jan 19, 2011 at 17:09, Will Deacon <will.deacon@arm.com> wrote:
>> 2.) Use IPI to cross-call the IRQ handler when the interrupted CPU doesn't
>>    have an interrupt asserted on its PMU. You'll need to sort out problems
>>    with re-enabling interrupts for the cross-call and also nesting of the
>>    PMU interrupt (because it could fire as a result of another PMU overflowing
>>    before you've completed the cross-call).
> Here's the IPI version as well, for comparison with the other
> approach.  The IRQ handling code will mask the interrupt before
> handling it, so it can't nest, can it?
>
> 8<----------
> From 84e5936f9285fb03845ac04801430762c1c9b60d Mon Sep 17 00:00:00 2001
> From: Rabin Vincent <rabin.vincent@stericsson.com>
> Date: Fri, 4 Feb 2011 11:59:26 +0530
> Subject: [PATCH] ARM: perf_event: support dual-core with single PMU IRQ
>
> DB8500 (dual-core) has the PMU interrupts of both cores ORed into one.  Support
> this by keeping the interrupt directed at Core0 and IPIing Core1 when Core0
> receives the interrupt and finds that its counter has not overflowed.
>
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> ---
>  arch/arm/kernel/perf_event.c |   48 +++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 47 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 5efa264..a97e50f 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -19,6 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/uaccess.h>
> +#include <linux/smp.h>
>
>  #include <asm/cputype.h>
>  #include <asm/irq.h>
> @@ -377,9 +378,40 @@ validate_group(struct perf_event *event)
>  	return 0;
>  }
>
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
> +
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
> +
> +	if (err)
> +		return irqret;
> +
> +	smp_rmb();
> +	return armpmu_core2_irqret;
> +}
> +
>  static int
>  armpmu_reserve_hardware(void)
>  {
> +	irq_handler_t irq_handler = armpmu->handle_irq;
>  	int i, err = -ENODEV, irq;
>
>  	pmu_device = reserve_pmu(ARM_PMU_DEVICE_CPU);
> @@ -395,12 +427,26 @@ armpmu_reserve_hardware(void)
>  		return -ENODEV;
>  	}
>
> +	/*
> +	 * Some SoCs have the PMU IRQ lines of two cores wired together into a
> +	 * single interrupt.  Support these by poking the second core with an
> +	 * IPI when its counters overflow.
> +	 */
> +	if (pmu_device->num_resources < num_online_cpus()) {
> +		if (num_online_cpus() > 2) {
> +			pr_err(">2 cpus not supported for single-irq workaround");
> +			return -ENODEV;
> +		}
> +
> +		irq_handler = armpmu_single_interrupt;
> +	}
> +
>  	for (i = 0; i < pmu_device->num_resources; ++i) {
>  		irq = platform_get_irq(pmu_device, i);
>  		if (irq < 0)
>  			continue;
>
> -		err = request_irq(irq, armpmu->handle_irq,
> +		err = request_irq(irq, irq_handler,
>  				  IRQF_DISABLED | IRQF_NOBALANCING,
>  				  "armpmu", NULL);
>  		if (err) {
