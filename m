From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 4 Jun 2016 12:45:07 +0100
Subject: [PATCH V3 1/2] irqchip/gicv3-its: split its_alloc_tables() into
 two functions
In-Reply-To: <1462827506-23570-2-git-send-email-shankerd@codeaurora.org>
References: <1462827506-23570-1-git-send-email-shankerd@codeaurora.org>
 <1462827506-23570-2-git-send-email-shankerd@codeaurora.org>
Message-ID: <20160604124507.436e5f7e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 May 2016 15:58:25 -0500
Shanker Donthineni <shankerd@codeaurora.org> wrote:

> The function is getting out of control, it has too many goto
> statements and would be too complicated for adding a feature
> two-level device table. So, it is time for us to cleanup and
> move some of the logic to a separate function without affecting
> the existing functionality.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c   | 256 ++++++++++++++++++++-----------------
>  include/linux/irqchip/arm-gic-v3.h |   3 +
>  2 files changed, 144 insertions(+), 115 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 6bd881b..b23e00c 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -55,13 +55,15 @@ struct its_collection {
>  };
>  
>  /*
> - * The ITS_BASER structure - contains memory information and cached
> - * value of BASER register configuration.
> + * The ITS_BASER structure - contains memory information, cached value
> + * of BASER register configuration, ioremaped address and page size.
>   */
>  struct its_baser {
> +	void __iomem	*hwreg;
>  	void		*base;
>  	u64		val;
>  	u32		order;
> +	u32		psz;
>  };
>  
>  /*
> @@ -823,27 +825,135 @@ static void its_free_tables(struct its_node *its)
>  	}
>  }
>  
> +static int its_baser_setup(struct its_node *its, struct its_baser *baser,
> +				  u32 order, u64 indirect)
> +{
> +	u64 val = readq_relaxed(baser->hwreg);
> +	u64 type = GITS_BASER_TYPE(val);
> +	u64 entry_size = GITS_BASER_ENTRY_SIZE(val);
> +	int psz, alloc_pages;
> +	u64 cache, shr, tmp;
> +	void *base;
> +
> +	/* Do first attempt with the requested attributes */
> +	cache = baser->val & GITS_BASER_CACHEABILITY_MASK;
> +	shr = baser->val & GITS_BASER_SHAREABILITY_MASK;
> +	psz = baser->psz;
> +
> +retry_alloc_baser:
> +	alloc_pages = (PAGE_ORDER_TO_SIZE(order) / psz);
> +	if (alloc_pages > GITS_BASER_PAGES_MAX) {
> +		pr_warn("ITS@%lx: %s too large, reduce ITS pages %u->%u\n",
> +			its->phys_base, its_base_type_string[type],
> +			alloc_pages, GITS_BASER_PAGES_MAX);

By the way: as you're changing the output of various messages, please
use %pa instead of %lx (and make sure you're passing the parameter by
reference...).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
