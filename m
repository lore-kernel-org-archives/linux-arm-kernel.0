From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 03 Mar 2015 19:38:05 +0100
Subject: [PATCH v2 3/7] irqchip: armada-370-xp: Enable the PMU interrupts
In-Reply-To: <1425379400-4346-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1425379400-4346-1-git-send-email-maxime.ripard@free-electrons.com>
 <1425379400-4346-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <54F5FF8D.6010001@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 03/03/2015 11:43, Maxime Ripard wrote:
> In order to let the Performance Monitoring Unit interrupts flowing in the MPIC,
> we need to unmask these interrupts in the Coherency Fabric Local Interrupt Mask
> Register.
> 
> Since this register is a CPU-local register, unmasking this interrupt needs to
> be done on the boot CPU when the driver initializes, but also on the secondary
> CPU when they are brought up.
> 

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/irqchip/irq-armada-370-xp.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
> index ea57fba263cf..b36373c019ba 100644
> --- a/drivers/irqchip/irq-armada-370-xp.c
> +++ b/drivers/irqchip/irq-armada-370-xp.c
> @@ -38,6 +38,8 @@
>  /* Interrupt Controller Registers Map */
>  #define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
>  #define ARMADA_370_XP_INT_CLEAR_MASK_OFFS	(0x4C)
> +#define ARMADA_370_XP_INT_FABRIC_MASK_OFFS	(0x54)
> +#define ARMADA_370_XP_INT_CAUSE_PERF(cpu)	(1 << cpu)
>  
>  #define ARMADA_370_XP_INT_CONTROL		(0x00)
>  #define ARMADA_370_XP_INT_SET_ENABLE_OFFS	(0x30)
> @@ -56,6 +58,7 @@
>  #define ARMADA_370_XP_MAX_PER_CPU_IRQS		(28)
>  
>  #define ARMADA_370_XP_TIMER0_PER_CPU_IRQ	(5)
> +#define ARMADA_370_XP_FABRIC_IRQ		(3)
>  
>  #define IPI_DOORBELL_START                      (0)
>  #define IPI_DOORBELL_END                        (8)
> @@ -81,6 +84,7 @@ static inline bool is_percpu_irq(irq_hw_number_t irq)
>  {
>  	switch (irq) {
>  	case ARMADA_370_XP_TIMER0_PER_CPU_IRQ:
> +	case ARMADA_370_XP_FABRIC_IRQ:
>  		return true;
>  	default:
>  		return false;
> @@ -340,6 +344,15 @@ static void armada_xp_mpic_smp_cpu_init(void)
>  	writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
>  }
>  
> +static void armada_xp_mpic_perf_init(void)
> +{
> +	unsigned long cpuid = cpu_logical_map(smp_processor_id());
> +
> +	/* Enable Performance Counter Overflow interrupts */
> +	writel(ARMADA_370_XP_INT_CAUSE_PERF(cpuid),
> +	       per_cpu_int_base + ARMADA_370_XP_INT_FABRIC_MASK_OFFS);
> +}
> +
>  #ifdef CONFIG_SMP
>  static void armada_mpic_send_doorbell(const struct cpumask *mask,
>  				      unsigned int irq)
> @@ -365,8 +378,10 @@ static void armada_mpic_send_doorbell(const struct cpumask *mask,
>  static int armada_xp_mpic_secondary_init(struct notifier_block *nfb,
>  					 unsigned long action, void *hcpu)
>  {
> -	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
> +	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN) {
> +		armada_xp_mpic_perf_init();
>  		armada_xp_mpic_smp_cpu_init();
> +	}
>  
>  	return NOTIFY_OK;
>  }
> @@ -379,8 +394,10 @@ static struct notifier_block armada_370_xp_mpic_cpu_notifier = {
>  static int mpic_cascaded_secondary_init(struct notifier_block *nfb,
>  					unsigned long action, void *hcpu)
>  {
> -	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
> +	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN) {
> +		armada_xp_mpic_perf_init();
>  		enable_percpu_irq(parent_irq, IRQ_TYPE_NONE);
> +	}
>  
>  	return NOTIFY_OK;
>  }
> @@ -389,7 +406,6 @@ static struct notifier_block mpic_cascaded_cpu_notifier = {
>  	.notifier_call = mpic_cascaded_secondary_init,
>  	.priority = 100,
>  };
> -
>  #endif /* CONFIG_SMP */
>  
>  static struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
> @@ -599,6 +615,7 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
>  	BUG_ON(!armada_370_xp_mpic_domain);
>  
>  	/* Setup for the boot CPU */
> +	armada_xp_mpic_perf_init();
>  	armada_xp_mpic_smp_cpu_init();
>  
>  	armada_370_xp_msi_init(node, main_int_res.start);
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
