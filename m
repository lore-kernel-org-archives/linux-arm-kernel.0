From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 24 Sep 2018 12:58:09 +0100
Subject: [PATCH 04/10] irqchip/gic-v3-its: Move pending table allocation
 to init time
In-Reply-To: <20180921195954.21574-5-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
 <20180921195954.21574-5-marc.zyngier@arm.com>
Message-ID: <7cdac0d7-a256-5e75-5a19-8eb0fb1cf6a5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 21/09/18 20:59, Marc Zyngier wrote:
> Pending tables for the redistributors are currently allocated
> one at a time as each CPU boots. This is causing some grief
> for Linux/RT (allocation from within a CPU hotplug notifier is
> frown upon).
> 
> Let's more this allocation to take place at init time, when we
> only have a single CPU. It means we're allocating memory for CPUs
> that are not online yet, but most system will boot all of their
> CPUs anyway, so that's not completely wasted.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c   | 80 +++++++++++++++++++-----------
>   include/linux/irqchip/arm-gic-v3.h |  1 +
>   2 files changed, 53 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 7ef6baea2d78..462bba422189 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -173,6 +173,7 @@ static DEFINE_RAW_SPINLOCK(vmovp_lock);
>   static DEFINE_IDA(its_vpeid_ida);
>   
>   #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
> +#define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_rdists->rdist, cpu))
>   #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
>   #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
>   
> @@ -1625,7 +1626,7 @@ static void its_free_prop_table(struct page *prop_page)
>   		   get_order(LPI_PROPBASE_SZ));
>   }
>   
> -static int __init its_alloc_lpi_tables(void)
> +static int __init its_alloc_lpi_prop_table(void)

A bit of a nit, but there is already a function called 
"its_allocate_prop_table" which I find very easy to confuse with this one.

And patch 3 factored the initialization out of its_allocate_prop_table. 
So I was wondering whether it would not actually be better to open-code 
it here and get rid of that function. Otherwise I'd suggest having more 
distinct names.

Otherwise the patch looks good.

Thanks,

>   {
>   	phys_addr_t paddr;
>   
> @@ -1944,30 +1945,47 @@ static void its_free_pending_table(struct page *pt)
>   	free_pages((unsigned long)page_address(pt), get_order(LPI_PENDBASE_SZ));
>   }
>   
> -static void its_cpu_init_lpis(void)
> +static int __init allocate_lpi_tables(void)
>   {
> -	void __iomem *rbase = gic_data_rdist_rd_base();
> -	struct page *pend_page;
> -	u64 val, tmp;
> +	int err, cpu;
>   
> -	/* If we didn't allocate the pending table yet, do it now */
> -	pend_page = gic_data_rdist()->pend_page;
> -	if (!pend_page) {
> -		phys_addr_t paddr;
> +	err = its_alloc_lpi_prop_table();
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * We allocate all the pending tables anyway, as we may have a
> +	 * mix of RDs that have had LPIs enabled, and some that
> +	 * don't. We'll free the unused ones as each CPU comes online.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct page *pend_page;
>   
>   		pend_page = its_allocate_pending_table(GFP_NOWAIT);
>   		if (!pend_page) {
> -			pr_err("Failed to allocate PENDBASE for CPU%d\n",
> -			       smp_processor_id());
> -			return;
> +			pr_err("Failed to allocate PENDBASE for CPU%d\n", cpu);
> +			return -ENOMEM;
>   		}
>   
> -		paddr = page_to_phys(pend_page);
> -		pr_info("CPU%d: using LPI pending table @%pa\n",
> -			smp_processor_id(), &paddr);
> -		gic_data_rdist()->pend_page = pend_page;
> +		gic_data_rdist_cpu(cpu)->pend_page = pend_page;
>   	}
>   
> +	return 0;
> +}
> +
> +static void its_cpu_init_lpis(void)
> +{
> +	void __iomem *rbase = gic_data_rdist_rd_base();
> +	struct page *pend_page;
> +	phys_addr_t paddr;
> +	u64 val, tmp;
> +
> +	if (gic_data_rdist()->lpi_enabled)
> +		return;
> +
> +	pend_page = gic_data_rdist()->pend_page;
> +	paddr = page_to_phys(pend_page);
> +
>   	/* set PROPBASE */
>   	val = (page_to_phys(gic_rdists->prop_page) |
>   	       GICR_PROPBASER_InnerShareable |
> @@ -2019,6 +2037,10 @@ static void its_cpu_init_lpis(void)
>   
>   	/* Make sure the GIC has seen the above */
>   	dsb(sy);
> +	gic_data_rdist()->lpi_enabled = true;
> +	pr_info("GICv3: CPU%d: using LPI pending table @%pa\n",
> +		smp_processor_id(),
> +		&paddr);
>   }
>   
>   static void its_cpu_init_collection(struct its_node *its)
> @@ -3497,16 +3519,6 @@ static int redist_disable_lpis(void)
>   	u64 timeout = USEC_PER_SEC;
>   	u64 val;
>   
> -	/*
> -	 * If coming via a CPU hotplug event, we don't need to disable
> -	 * LPIs before trying to re-enable them. They are already
> -	 * configured and all is well in the world. Detect this case
> -	 * by checking the allocation of the pending table for the
> -	 * current CPU.
> -	 */
> -	if (gic_data_rdist()->pend_page)
> -		return 0;
> -
>   	if (!gic_rdists_supports_plpis()) {
>   		pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
>   		return -ENXIO;
> @@ -3516,7 +3528,18 @@ static int redist_disable_lpis(void)
>   	if (!(val & GICR_CTLR_ENABLE_LPIS))
>   		return 0;
>   
> -	pr_warn("CPU%d: Booted with LPIs enabled, memory probably corrupted\n",
> +	/*
> +	 * If coming via a CPU hotplug event, we don't need to disable
> +	 * LPIs before trying to re-enable them. They are already
> +	 * configured and all is well in the world.
> +	 */
> +	if (gic_data_rdist()->lpi_enabled)
> +		return 0;
> +
> +	/*
> +	 * From that point on, we only try to do some damage control.
> +	 */
> +	pr_warn("GICv3: CPU%d: Booted with LPIs enabled, memory probably corrupted\n",
>   		smp_processor_id());
>   	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
>   
> @@ -3772,7 +3795,8 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>   	}
>   
>   	gic_rdists = rdists;
> -	err = its_alloc_lpi_tables();
> +
> +	err = allocate_lpi_tables();
>   	if (err)
>   		return err;
>   
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index 8bdbb5f29494..266093e845bb 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -585,6 +585,7 @@ struct rdists {
>   		void __iomem	*rd_base;
>   		struct page	*pend_page;
>   		phys_addr_t	phys_base;
> +		bool		lpi_enabled;
>   	} __percpu		*rdist;
>   	struct page		*prop_page;
>   	u64			flags;
> 

-- 
Julien Thierry
