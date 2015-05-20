From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 May 2015 13:14:38 +0100
Subject: [PATCH 2/4] arm64: gicv3: its: Add range check for number of
 allocated pages
In-Reply-To: <1430686172-18222-3-git-send-email-rric@kernel.org>
References: <1430686172-18222-1-git-send-email-rric@kernel.org>
 <1430686172-18222-3-git-send-email-rric@kernel.org>
Message-ID: <20150520131438.6e94e661@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 3 May 2015 21:49:30 +0100
Robert Richter <rric@kernel.org> wrote:

> From: Robert Richter <rrichter@cavium.com>
> 
> The number of pages for the its table may exceed the maximum of 256.
> Adding a range check and limitting the number to its maximum.
> 
> Based on a patch from Tirumalesh Chalamarla <tchalamarla@cavium.com>.
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>

Looks good to me.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

> ---
>  drivers/irqchip/irq-gic-v3-its.c   | 11 ++++++++++-
>  include/linux/irqchip/arm-gic-v3.h |  1 +
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index e30b4de04c6c..a2619a1d5bb3 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -810,6 +810,7 @@ static int its_alloc_tables(struct its_node *its)
>  		u64 entry_size = GITS_BASER_ENTRY_SIZE(val);
>  		int order = get_order(psz);
>  		int alloc_size;
> +		int alloc_pages;
>  		u64 tmp;
>  		void *base;
>  
> @@ -837,6 +838,14 @@ static int its_alloc_tables(struct its_node *its)
>  		}
>  
>  		alloc_size = (1 << order) * PAGE_SIZE;
> +		alloc_pages = (alloc_size / psz);
> +		if (alloc_pages > GITS_BASER_PAGES_MAX) {
> +			alloc_pages = GITS_BASER_PAGES_MAX;
> +			order = get_order(GITS_BASER_PAGES_MAX * psz);
> +			pr_warn("%s: Device Table too large, reduce its page order to %u (%u pages)\n",
> +				its->msi_chip.of_node->full_name, order, alloc_pages);
> +		}
> +
>  		base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
>  		if (!base) {
>  			err = -ENOMEM;
> @@ -865,7 +874,7 @@ static int its_alloc_tables(struct its_node *its)
>  			break;
>  		}
>  
> -		val |= (alloc_size / psz) - 1;
> +		val |= alloc_pages - 1;
>  
>  		writeq_relaxed(val, its->base + GITS_BASER + i * 8);
>  		tmp = readq_relaxed(its->base + GITS_BASER + i * 8);
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index ffbc034c8810..f28da189c4aa 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -229,6 +229,7 @@
>  #define GITS_BASER_PAGE_SIZE_16K	(1UL << GITS_BASER_PAGE_SIZE_SHIFT)
>  #define GITS_BASER_PAGE_SIZE_64K	(2UL << GITS_BASER_PAGE_SIZE_SHIFT)
>  #define GITS_BASER_PAGE_SIZE_MASK	(3UL << GITS_BASER_PAGE_SIZE_SHIFT)
> +#define GITS_BASER_PAGES_MAX		256
>  
>  #define GITS_BASER_TYPE_NONE		0
>  #define GITS_BASER_TYPE_DEVICE		1



-- 
Without deviation from the norm, progress is not possible.
