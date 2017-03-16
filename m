From: eric.auger@redhat.com (Auger Eric)
Date: Thu, 16 Mar 2017 09:57:34 +0100
Subject: [RFC PATCH 11/33] irqchip/gic-v3-its: Split out pending table
 allocation
In-Reply-To: <1484648454-21216-12-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-12-git-send-email-marc.zyngier@arm.com>
Message-ID: <29671afa-60a3-d099-0fd5-78229724d8da@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 17/01/2017 11:20, Marc Zyngier wrote:
> Just as for the property table, let's move the pending table
> allocation to a separate function.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  drivers/irqchip/irq-gic-v3-its.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 14305db1..dce8f8c 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1188,6 +1188,24 @@ static int its_alloc_collections(struct its_node *its)
>  	return 0;
>  }
>  
> +static struct page *its_allocate_pending_table(gfp_t gfp_flags)
> +{
> +	struct page *pend_page;
> +	/*
> +	 * The pending pages have to be at least 64kB aligned,
> +	 * hence the 'max(LPI_PENDBASE_SZ, SZ_64K)' below.
> +	 */
> +	pend_page = alloc_pages(gfp_flags | __GFP_ZERO,
> +				get_order(max(LPI_PENDBASE_SZ, SZ_64K)));
> +	if (!pend_page)
> +		return NULL;
> +
> +	/* Make sure the GIC will observe the zero-ed page */
> +	gic_flush_dcache_to_poc(page_address(pend_page), LPI_PENDBASE_SZ);
> +
> +	return pend_page;
> +}
> +
>  static void its_cpu_init_lpis(void)
>  {
>  	void __iomem *rbase = gic_data_rdist_rd_base();
> @@ -1198,21 +1216,14 @@ static void its_cpu_init_lpis(void)
>  	pend_page = gic_data_rdist()->pend_page;
>  	if (!pend_page) {
>  		phys_addr_t paddr;
> -		/*
> -		 * The pending pages have to be at least 64kB aligned,
> -		 * hence the 'max(LPI_PENDBASE_SZ, SZ_64K)' below.
> -		 */
> -		pend_page = alloc_pages(GFP_NOWAIT | __GFP_ZERO,
> -					get_order(max(LPI_PENDBASE_SZ, SZ_64K)));
> +
> +		pend_page = its_allocate_pending_table(GFP_NOWAIT);
>  		if (!pend_page) {
>  			pr_err("Failed to allocate PENDBASE for CPU%d\n",
>  			       smp_processor_id());
>  			return;
>  		}
>  
> -		/* Make sure the GIC will observe the zero-ed page */
> -		gic_flush_dcache_to_poc(page_address(pend_page), LPI_PENDBASE_SZ);
> -
>  		paddr = page_to_phys(pend_page);
>  		pr_info("CPU%d: using LPI pending table @%pa\n",
>  			smp_processor_id(), &paddr);
> 
