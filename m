From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Jan 2016 11:31:00 +0000
Subject: [PATCH 1/1] [V2] irqchip: gicv3-its: Introduce indirect
 device-ITT table support
In-Reply-To: <1453762723-19477-1-git-send-email-shankerd@codeaurora.org>
References: <1453762723-19477-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <56A758F4.4010001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shanker,

On 25/01/16 22:58, Shanker Donthineni wrote:
> Current ITS driver implementation limits the device ID to a few
> number of bits depending on memory that has been allocated to a
> flat DEV-ITT table. Some of the devices are not usable when device
> ID is spread out across a large range of 32 bit values.

That's not really it. Indirect tables allow the system not to waste
memory on very sparse tables (you could implement flat 32bit device ID
tables by carving out memory out of the Linux managed memory).

> 
> This patch covers more DEVID bits by implementing the GIC-ITS indirect
> device table. This feature is enabled automatically during driver
> probe if the flat table is not adequate to hold all DEVID bits.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
> [v1]->[v2]:
>   -Removed the line "Change-Id: I9c6d005dexxx" from commit message.
>   -Fixed the its->max_devid field initialization. 
> 
>  drivers/irqchip/irq-gic-v3-its.c   | 79 +++++++++++++++++++++++++++++++++++---
>  include/linux/irqchip/arm-gic-v3.h |  1 +
>  2 files changed, 75 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index e23d1d1..408a358 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -41,6 +41,8 @@
>  
>  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
>  #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
> +#define ITS_FLAGS_DEVICE_NEEDS_FLUSHING		(1ULL << 2)
> +#define ITS_FLAGS_INDIRECT_DEVICE_TABLE		(1ULL << 3)
>  
>  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
>  
> @@ -71,6 +73,10 @@ struct its_node {
>  	struct list_head	its_device_list;
>  	u64			flags;
>  	u32			ite_size;
> +	u32			dev_table_idx;
> +	u32			dev_table_shift;
> +	u32			max_devid;
> +	u32			order;

What are these new fields for?

>  };
>  
>  #define ITS_ITT_ALIGN		SZ_256
> @@ -824,6 +830,8 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>  	u64 typer;
>  	u32 ids;
>  
> +#define ITS_DEVICE_MAX_ORDER	min(MAX_ORDER, get_order(SZ_8M))

Where is this 8MB value coming from?

> +
>  	if (its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_22375) {
>  		/*
>  		 * erratum 22375: only alloc 8MB table size
> @@ -867,11 +875,12 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>  			 */
>  			order = max(get_order((1UL << ids) * entry_size),
>  				    order);
> -			if (order >= MAX_ORDER) {
> -				order = MAX_ORDER - 1;
> -				pr_warn("%s: Device Table too large, reduce its page order to %u\n",
> -					node_name, order);
> -			}
> +			if (order >= ITS_DEVICE_MAX_ORDER) {
> +				/* Update flags for two-level setup */
> +				its->flags |= ITS_FLAGS_INDIRECT_DEVICE_TABLE;
> +				order = ITS_DEVICE_MAX_ORDER - 1;
> +			} else
> +				its->max_devid =  (1 << ids) - 1;

We deal with the ID space in number of bits, not in number of devices we
can represent. Yes, there is a direct relationship between the two, but
I'd like to keep it consistent with the architecture specification.

>  		}
>  
>  		alloc_size = (1 << order) * PAGE_SIZE;
> @@ -911,6 +920,26 @@ retry_baser:
>  			break;
>  		}
>  
> +		/* Enable two-level (indirect) device table if it is required */
> +		if ((type == GITS_BASER_TYPE_DEVICE) &&
> +		    (its->flags & ITS_FLAGS_INDIRECT_DEVICE_TABLE)) {
> +			u32 shift = ilog2(psz / entry_size);
> +			u32 max_ids = ilog2(alloc_size >> 3) + shift;

Please explain this calculation.

> +
> +			if (ids > max_ids) {
> +				pr_warn(
> +					"ITS: @%pa DEVID too large reduce %u->%u\n",
> +					&its->phys_base, ids, max_ids);
> +			}
> +			its->max_devid =  (1UL << max_ids) - 1;
> +			its->order = get_order(psz);
> +			its->dev_table_idx = i;
> +			its->dev_table_shift = shift;
> +			if (!(val & GITS_BASER_SHAREABILITY_MASK))
> +				its->flags |= ITS_FLAGS_DEVICE_NEEDS_FLUSHING;

You can only evaluate the shareability after having written something,
and read it back. Also, the name of the flag is a bit wrong: it is not
the device that needs flushing, bit the ITS Device table.

> +			val |= GITS_BASER_INDIRECT;

Erm... Do you realize that this is an optional feature? What happens if
the HW doesn't support it?

> +		}
> +
>  		val |= alloc_pages - 1;
>  
>  		writeq_relaxed(val, its->base + GITS_BASER + i * 8);
> @@ -1134,6 +1163,32 @@ static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
>  	return its_dev;
>  }
>  
> +static int its_alloc_device_table(struct its_node *its, u32 dev_id)
> +{
> +	u64 *devtbl = its->tables[its->dev_table_idx];
> +	u32 alloc_size = (1 << its->order) * PAGE_SIZE;
> +	u32 idx = dev_id >> its->dev_table_shift;

All this should be explained. I don't want to have to refer to the spec
to understand how you're computing things. It also means that you need
to define some helpers.

> +	struct page *page;
> +
> +	/* Do nothing if the level-2 DEV-ITT entry was mapped earlier */

There is no such thing as a DEV-ITT. There is a Device table (what you
are allocating here), and a per-device ITT, which is not dealt with here
at all.

> +	if (devtbl[idx])
> +		return 0;
> +
> +	/* Allocate memory for level-2 device table & map to level-1 table */
> +	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, its->order);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	devtbl[idx] = page_to_phys(page) | GITS_BASER_VALID;
> +
> +	if (its->flags & ITS_FLAGS_DEVICE_NEEDS_FLUSHING) {
> +		__flush_dcache_area(page_address(page), alloc_size);
> +		__flush_dcache_area(devtbl + idx, sizeof(*devtbl));
> +	}
> +
> +	return 0;

It really time we convert this driver to use dma_alloc_coherent. This is
getting out of control...

> +}
> +
>  static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>  					    int nvecs)
>  {
> @@ -1147,6 +1202,20 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>  	int nr_ites;
>  	int sz;
>  
> +	if (dev_id > its->max_devid) {
> +		pr_err("ITS: dev_id too large %d\n", dev_id);
> +		return NULL;
> +	}

Under which circumstances can this actually happen?

> +
> +	/* Ensure memory for level-2 table is allocated for dev_id */
> +	if (its->flags & ITS_FLAGS_INDIRECT_DEVICE_TABLE) {
> +		int ret;
> +
> +		ret = its_alloc_device_table(its, dev_id);
> +		if (ret)
> +			return NULL;
> +	}
> +
>  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>  	/*
>  	 * At least one bit of EventID is being used, hence a minimum
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index d5d798b..04dfe09 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -206,6 +206,7 @@
>  #define GITS_BASER_NR_REGS		8
>  
>  #define GITS_BASER_VALID		(1UL << 63)
> +#define GITS_BASER_INDIRECT		(1UL << 62)
>  #define GITS_BASER_nCnB			(0UL << 59)
>  #define GITS_BASER_nC			(1UL << 59)
>  #define GITS_BASER_RaWt			(2UL << 59)
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
