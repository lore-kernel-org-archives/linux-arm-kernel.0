From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 13 Aug 2013 12:08:06 +0100
Subject: [PATCH] irqchip: gic: fix boot for chained gics
In-Reply-To: <1371227097-3326-1-git-send-email-mark.rutland@arm.com>
References: <1371227097-3326-1-git-send-email-mark.rutland@arm.com>
Message-ID: <520A1396.6070400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/13 17:24, Mark Rutland wrote:
> As of c0114709ed: "irqchip: gic: Perform the gic_secondary_init() call
> via CPU notifier", booting on a platform with chained gics (e.g.
> Realview EB ARM11MPCore) will result in the gic_cpu_notifier being
> registered twice, corrupting the cpu notifier list and rendering the
> platform unbootable.

Hi Mark,

This patch is still not in the mainline. I am unable to boot my Realview
EB ARM11MPCore without this patch.

Regards,
Sudeep

> 
> This patch ensures that we only register the notifier for the first gic,
> allowing platforms with chained gics to boot. At the same time we limit
> the pointlessly duplicated calls to set_smp_cross_call and
> set_handle_irq to the first gic registered.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/irqchip/irq-gic.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 1760ceb..1a12bdf 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -808,12 +808,13 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>  	if (WARN_ON(!gic->domain))
>  		return;
>  
> +	if (gic_nr == 0) {
>  #ifdef CONFIG_SMP
> -	set_smp_cross_call(gic_raise_softirq);
> -	register_cpu_notifier(&gic_cpu_notifier);
> +		set_smp_cross_call(gic_raise_softirq);
> +		register_cpu_notifier(&gic_cpu_notifier);
>  #endif
> -
> -	set_handle_irq(gic_handle_irq);
> +		set_handle_irq(gic_handle_irq);
> +	}
>  
>  	gic_chip.flags |= gic_arch_extn.flags;
>  	gic_dist_init(gic);
> 
