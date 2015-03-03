From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 03 Mar 2015 19:29:29 +0100
Subject: [PATCH v2 1/7] irqchip: armada-370-xp: Initialize per cpu
 registers when CONFIG_SMP=N
In-Reply-To: <1425379400-4346-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1425379400-4346-1-git-send-email-maxime.ripard@free-electrons.com>
 <1425379400-4346-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <54F5FD89.4080905@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 03/03/2015 11:43, Maxime Ripard wrote:
> From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> The irqchip driver called armada_xp_mpic_smp_cpu_init() when CONFIG_SMP=Y
> to initialize some per cpu registers. The function is called on each
> CPU by calling it explicitly on the boot CPU and then using a CPU notifier
> for the non boot CPUs.
> 
> This commit removes the CONFIG_SMP constrain, so the per cpu registers are
> also initialized when CONFIG_SMP=N, which is the right thing to do.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

>  drivers/irqchip/irq-armada-370-xp.c | 47 ++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
> index 4387dae14e45..b455c876974e 100644
> --- a/drivers/irqchip/irq-armada-370-xp.c
> +++ b/drivers/irqchip/irq-armada-370-xp.c
> @@ -308,28 +308,6 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
>  	return 0;
>  }
>  
> -#ifdef CONFIG_SMP
> -static void armada_mpic_send_doorbell(const struct cpumask *mask,
> -				      unsigned int irq)
> -{
> -	int cpu;
> -	unsigned long map = 0;
> -
> -	/* Convert our logical CPU mask into a physical one. */
> -	for_each_cpu(cpu, mask)
> -		map |= 1 << cpu_logical_map(cpu);
> -
> -	/*
> -	 * Ensure that stores to Normal memory are visible to the
> -	 * other CPUs before issuing the IPI.
> -	 */
> -	dsb();
> -
> -	/* submit softirq */
> -	writel((map << 8) | irq, main_int_base +
> -		ARMADA_370_XP_SW_TRIG_INT_OFFS);
> -}
> -
>  static void armada_xp_mpic_smp_cpu_init(void)
>  {
>  	u32 control;
> @@ -352,6 +330,28 @@ static void armada_xp_mpic_smp_cpu_init(void)
>  	writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
>  }
>  
> +#ifdef CONFIG_SMP
> +static void armada_mpic_send_doorbell(const struct cpumask *mask,
> +				      unsigned int irq)
> +{
> +	int cpu;
> +	unsigned long map = 0;
> +
> +	/* Convert our logical CPU mask into a physical one. */
> +	for_each_cpu(cpu, mask)
> +		map |= 1 << cpu_logical_map(cpu);
> +
> +	/*
> +	 * Ensure that stores to Normal memory are visible to the
> +	 * other CPUs before issuing the IPI.
> +	 */
> +	dsb();
> +
> +	/* submit softirq */
> +	writel((map << 8) | irq, main_int_base +
> +		ARMADA_370_XP_SW_TRIG_INT_OFFS);
> +}
> +
>  static int armada_xp_mpic_secondary_init(struct notifier_block *nfb,
>  					 unsigned long action, void *hcpu)
>  {
> @@ -588,9 +588,8 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
>  
>  	BUG_ON(!armada_370_xp_mpic_domain);
>  
> -#ifdef CONFIG_SMP
> +	/* Setup for the boot CPU */
>  	armada_xp_mpic_smp_cpu_init();
> -#endif
>  
>  	armada_370_xp_msi_init(node, main_int_res.start);
>  
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
