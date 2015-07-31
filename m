From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 31 Jul 2015 08:50:49 +0100
Subject: [PATCH 2/2] irqchip/gic: Ensure gic_cpu_if_up/down() programs
 correct GIC instance
In-Reply-To: <1438273573-27958-2-git-send-email-jonathanh@nvidia.com>
References: <1438273573-27958-1-git-send-email-jonathanh@nvidia.com>
 <1438273573-27958-2-git-send-email-jonathanh@nvidia.com>
Message-ID: <55BB28D9.30303@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 30/07/15 17:26, Jon Hunter wrote:
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
> number is passed for the appropriate GIC. The vexpress TC2 (which has
> a single GIC) is currently the only user of this function and so update
> it accordingly.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> I was hoping to make the gic_cpu_if_up/down function more symmetric as we
> discussed but it is not possible to pass the gic_nr to gic_cpu_if_up()
> from all the places called without making more changes. However, given
> that gic_cpu_if_up() is a local function and gic_cpu_if_down() is public,
> may be it does not matter too much.
> 
>  arch/arm/mach-vexpress/tc2_pm.c |  2 +-
>  drivers/irqchip/irq-gic.c       | 14 +++++++-------
>  include/linux/irqchip/arm-gic.h |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
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
> index 7566fe259d27..cf9aca22120f 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -356,10 +356,10 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
>  	return mask;
>  }
>  
> -static void gic_cpu_if_up(void)
> +static void gic_cpu_if_up(struct gic_chip_data *gic)
>  {
> -	void __iomem *cpu_base = gic_data_cpu_base(&gic_data[0]);
> -	void __iomem *dist_base = gic_data_dist_base(&gic_data[0]);
> +	void __iomem *cpu_base = gic_data_cpu_base(gic);
> +	void __iomem *dist_base = gic_data_dist_base(gic);
>  	u32 bypass = 0;
>  
>  	/*
> @@ -451,12 +451,12 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>  	}
>  
>  	writel_relaxed(GICC_INT_PRI_THRESHOLD, base + GIC_CPU_PRIMASK);
> -	gic_cpu_if_up();
> +	gic_cpu_if_up(gic);
>  }
>  
> -void gic_cpu_if_down(void)
> +void gic_cpu_if_down(unsigned int gic_nr)
>  {
> -	void __iomem *cpu_base = gic_data_cpu_base(&gic_data[0]);
> +	void __iomem *cpu_base = gic_data_cpu_base(&gic_data[gic_nr]);
>  	u32 val = 0;

Well, this is rubbish. I need to check the gic_nr is valid. Will update ...

Jon
