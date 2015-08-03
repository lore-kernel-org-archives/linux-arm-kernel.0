From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 03 Aug 2015 11:02:41 +0100
Subject: [PATCH V2 2/2] irqchip/gic: Ensure gic_cpu_if_up/down() programs
 correct GIC instance
In-Reply-To: <1438332252-25248-2-git-send-email-jonathanh@nvidia.com>
References: <1438332252-25248-1-git-send-email-jonathanh@nvidia.com>
 <1438332252-25248-2-git-send-email-jonathanh@nvidia.com>
Message-ID: <55BF3C41.7000000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/15 09:44, Jon Hunter wrote:
> Commit 3228950621d9 ("irqchip: gic: Preserve gic V2 bypass bits in cpu
> ctrl register") added a new function, gic_cpu_if_up(), to program the
> GIC CPU_CTRL register. This function assumes that there is only one GIC
> instance present and hence always uses the chip data for the primary GIC
> controller. Although it is not common for there to be a secondary, some
> devices do support a secondary. Therefore, fix this by passing
> gic_cpu_if_up() a pointer to the appropriate chip data structure.
> 
> Similarly, the function gic_cpu_if_down() only assumes that there is a
> single GIC instance present. Update this function so that an instance
> number is passed for the appropriate GIC and return an error code on
> failure. The vexpress TC2 (which has a single GIC) is currently the only
> user of this function and so update it accordingly. Note that because the
> TC2 only has a single GIC, the call to gic_cpu_if_down() should always
> be successful.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

I also gave both patches a test run on Realview EB11MP and PB1176, and
both seem happy enough.

Thanks,

	M.

> ---
> V2 changes:
> - Rebased on v4.2-rc4
> - Added test to ensure GIC instance is valid to gic_cpu_if_down() and
>   updated gic_cpu_if_down() to return an error code on failure.
> 
>  arch/arm/mach-vexpress/tc2_pm.c |  2 +-
>  drivers/irqchip/irq-gic.c       | 18 ++++++++++++------
>  include/linux/irqchip/arm-gic.h |  2 +-
>  3 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
> index b3328cd46c33..1aa4ccece69f 100644
> --- a/arch/arm/mach-vexpress/tc2_pm.c
> +++ b/arch/arm/mach-vexpress/tc2_pm.c
> @@ -80,7 +80,7 @@ static void tc2_pm_cpu_powerdown_prepare(unsigned int cpu, unsigned int cluster)
>  	 * to the CPU by disabling the GIC CPU IF to prevent wfi
>  	 * from completing execution behind power controller back
>  	 */
> -	gic_cpu_if_down();
> +	gic_cpu_if_down(0);
>  }
>  
>  static void tc2_pm_cluster_powerdown_prepare(unsigned int cluster)
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index dc5090543eca..fdd1b0e6e5c3 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -355,9 +355,9 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
>  	return mask;
>  }
>  
> -static void gic_cpu_if_up(void)
> +static void gic_cpu_if_up(struct gic_chip_data *gic)
>  {
> -	void __iomem *cpu_base = gic_data_cpu_base(&gic_data[0]);
> +	void __iomem *cpu_base = gic_data_cpu_base(gic);
>  	u32 bypass = 0;
>  
>  	/*
> @@ -425,17 +425,23 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>  	gic_cpu_config(dist_base, NULL);
>  
>  	writel_relaxed(GICC_INT_PRI_THRESHOLD, base + GIC_CPU_PRIMASK);
> -	gic_cpu_if_up();
> +	gic_cpu_if_up(gic);
>  }
>  
> -void gic_cpu_if_down(void)
> +int gic_cpu_if_down(unsigned int gic_nr)
>  {
> -	void __iomem *cpu_base = gic_data_cpu_base(&gic_data[0]);
> +	void __iomem *cpu_base;
>  	u32 val = 0;
>  
> +	if (gic_nr >= MAX_GIC_NR)
> +		return -EINVAL;
> +
> +	cpu_base = gic_data_cpu_base(&gic_data[gic_nr]);
>  	val = readl(cpu_base + GIC_CPU_CTRL);
>  	val &= ~GICC_ENABLE;
>  	writel_relaxed(val, cpu_base + GIC_CPU_CTRL);
> +
> +	return 0;
>  }
>  
>  #ifdef CONFIG_CPU_PM
> @@ -571,7 +577,7 @@ static void gic_cpu_restore(unsigned int gic_nr)
>  					dist_base + GIC_DIST_PRI + i * 4);
>  
>  	writel_relaxed(GICC_INT_PRI_THRESHOLD, cpu_base + GIC_CPU_PRIMASK);
> -	gic_cpu_if_up();
> +	gic_cpu_if_up(&gic_data[gic_nr]);
>  }
>  
>  static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
> index 9de976b4f9a7..da6aced1105e 100644
> --- a/include/linux/irqchip/arm-gic.h
> +++ b/include/linux/irqchip/arm-gic.h
> @@ -99,7 +99,7 @@ void gic_set_irqchip_flags(unsigned long flags);
>  void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
>  		    u32 offset, struct device_node *);
>  void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
> -void gic_cpu_if_down(void);
> +int gic_cpu_if_down(unsigned int gic_nr);
>  
>  static inline void gic_init(unsigned int nr, int start,
>  			    void __iomem *dist , void __iomem *cpu)
> 


-- 
Jazz is not dead. It just smells funny...
