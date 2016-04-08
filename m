From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Apr 2016 22:43:52 +0200
Subject: [PATCH 2/4] irqchip: bcm2836: Drop smp_set_ops on arm64 builds
In-Reply-To: <1459827858-3871-3-git-send-email-eric@anholt.net>
References: <1459827858-3871-1-git-send-email-eric@anholt.net>
 <1459827858-3871-3-git-send-email-eric@anholt.net>
Message-ID: <201604082243.52300.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 April 2016, Eric Anholt wrote:
> For arm64, the bootloader will instead be implementing the spin-table
> enable method.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/irqchip/irq-bcm2836.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
> index 233ccdd..4ae9f76 100644
> --- a/drivers/irqchip/irq-bcm2836.c
> +++ b/drivers/irqchip/irq-bcm2836.c
> @@ -223,6 +223,7 @@ static struct notifier_block bcm2836_arm_irqchip_cpu_notifier = {
>  	.priority = 100,
>  };
>  
> +#ifdef ARM
>  int __init bcm2836_smp_boot_secondary(unsigned int cpu,
>  				      struct task_struct *idle)
>  {
> @@ -238,7 +239,7 @@ int __init bcm2836_smp_boot_secondary(unsigned int cpu,
>  static const struct smp_operations bcm2836_smp_ops __initconst = {
>  	.smp_boot_secondary	= bcm2836_smp_boot_secondary,
>  };
> -
> +#endif
>  #endif
>  
>  static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
> @@ -256,8 +257,11 @@ bcm2836_arm_irqchip_smp_init(void)
>  	register_cpu_notifier(&bcm2836_arm_irqchip_cpu_notifier);
>  
>  	set_smp_cross_call(bcm2836_arm_irqchip_send_ipi);
> +
> +#ifdef ARM
>  	smp_set_ops(&bcm2836_smp_ops);
>  #endif
> +#endif
>  }

I'd suggest instead using CPU_METHOD_OF_DECLARE and moving the SMP code
to arch/arm/mach-bcm/platsmp-bcm2835.c. It doesn't really belong in the
irqchip code.

	Arnd
