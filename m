From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sun, 8 May 2016 12:10:01 -0500
Subject: [PATCH] irqchip/gicv3-its: Implement two-level(indirect) device
 table support
In-Reply-To: <20160506152247.67d0881a@arm.com>
References: <1462542216-20952-1-git-send-email-shankerd@codeaurora.org>
 <20160506152247.67d0881a@arm.com>
Message-ID: <572F72E9.3060608@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,


On 05/06/2016 09:22 AM, Marc Zyngier wrote:
> Hi Shanker,
>
> Thanks for putting this together. Comments below:
>
> On Fri, 6 May 2016 08:43:36 -0500
> Shanker Donthineni <shankerd@codeaurora.org> wrote:
>
>> Since device IDs are extremely sparse, the single, a.k.a flat table is
>> not sufficient for the following two reasons.
>>
>> 1) According to ARM-GIC spec, ITS hw can access maximum of 256(pages)*
>>    64K(pageszie) bytes. In the best case, it supports upto DEVid=21
>>    sparse with minimum device table entry size 8bytes.
>>
>> 2) The maximum memory size that is possible without memblock depends on
>>    MAX_ORDER. 4MB on 4K page size kernel with default MAX_ORDER, so it
>>    supports DEVid range 19bits.
>>
>> The two-level device table feature brings us two advantages, the first
>> is a very high possibility of supporting upto 32bit sparse, and the
>> second one is the best utilization of memory allocation.
>>
>> The feature is enabled automatically during driver probe if the flat
>> table is not adequate and the hardware is capable of two-level table
>> walk.
>>
>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>> ---
>>
>> This patch is based on Marc Zyngier's branch https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/irqchip-4.7
>>
>>  drivers/irqchip/irq-gic-v3-its.c   | 109 ++++++++++++++++++++++++++++++++-----
>>  include/linux/irqchip/arm-gic-v3.h |   2 +
>>  2 files changed, 97 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 6bd881b..caeb105 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -55,13 +55,14 @@ struct its_collection {
>>  };
>>  
>>  /*
>> - * The ITS_BASER structure - contains memory information and cached
>> - * value of BASER register configuration.
>> + * The ITS_BASER structure - contains memory information, cached value
>> + * of BASER register configuration and ITS page size in bytes.
>>   */
>>  struct its_baser {
>>  	void		*base;
>>  	u64		val;
>>  	u32		order;
>> +	u32		psz;
>>  };
>>  
>>  /*
>> @@ -853,6 +854,8 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>>  		u64 type = GITS_BASER_TYPE(val);
>>  		u64 entry_size = GITS_BASER_ENTRY_SIZE(val);
>>  		int order = get_order(psz);
>> +		bool tried_indirect = false;
>> +		u64 indirect = 0;
>>  		int alloc_pages;
>>  		u64 tmp;
>>  		void *base;
>> @@ -877,11 +880,8 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>>  			 */
>>  			order = max(get_order((1UL << ids) * entry_size),
>>  				    order);
>> -			if (order >= MAX_ORDER) {
>> +			if (order >= MAX_ORDER)
>>  				order = MAX_ORDER - 1;
>> -				pr_warn("%s: Device Table too large, reduce its page order to %u\n",
>> -					node_name, order);
>> -			}
>>  		}
>>  
>>  retry_alloc_baser:
>> @@ -889,8 +889,6 @@ retry_alloc_baser:
>>  		if (alloc_pages > GITS_BASER_PAGES_MAX) {
>>  			alloc_pages = GITS_BASER_PAGES_MAX;
>>  			order = get_order(GITS_BASER_PAGES_MAX * psz);
>> -			pr_warn("%s: Device Table too large, reduce its page order to %u (%u pages)\n",
>> -				node_name, order, alloc_pages);
>>  		}
>>  
>>  		base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
>> @@ -924,6 +922,7 @@ retry_baser:
>>  
>>  		val |= alloc_pages - 1;
>>  		its->tables[i].val = val;
>> +		its->tables[i].psz = psz;
>>  
>>  		writeq_relaxed(val, its->base + GITS_BASER + i * 8);
>>  		tmp = readq_relaxed(its->base + GITS_BASER + i * 8);
>> @@ -963,6 +962,49 @@ retry_baser:
>>  			}
>>  		}
>>  
>> +		/*
>> +		 * Attempt enabling Indirection table walk since we were unable
>> +		 * to allocate enough memory for flat device table to cover
>> +		 * whole DevID sparse that hw reporting, and ITS hardware has
>> +		 * capablity of supporting two-level table.
>> +		 */
>> +		if ((type == GITS_BASER_TYPE_DEVICE) &&
>> +		    (!tried_indirect) &&
>> +		    (PAGE_ORDER_TO_SIZE(order) < (entry_size << ids))) {
> Why not try to use indirect tables if they are available, irrespective
> of the size of the required allocation? From a memory usage point of
> view, it is likely to always be a gain, unless your id space is so
> small that it fits in a single page. And with PCIe, you know for sure
> that the ID space is extremely sparse, hence indirect tables are an
> immediate win.
>
> Do you see any value in using the indirect table as a last resort?
As such there is no strong reason other than saving one read
cycle penalty for accessing the second level table.

I need your advice, should I enable this feature always or
if the memory (ids * entry_size) requirement is more than
some threshold?


>> +
>> +			val |= GITS_BASER_INDIRECT;
>> +			writeq_relaxed(val, its->base + GITS_BASER + i * 8);
>> +			tmp = readq_relaxed(its->base + GITS_BASER + i * 8);
>> +			tried_indirect = true;
>> +
>> +			/* Does ITS HW supports Indirect table walk? */
>> +			if (!(tmp & GITS_BASER_INDIRECT)) {
>> +				pr_warn("%s: Device Table too large, reduce order to %u\n",
>> +					node_name, order);
>> +				goto retry_baser;
>> +			}
>> +
>> +			/*
>> +			 * According to GIC spec, the size of the Level2 table
>> +			 * is equal to ITS page size which is 'psz'. For
>> +			 * computing Level1 table1 size, subtract DevID bits
>> +			 * that covers Level2 table from 'ids' which is reported
>> +			 * by ITS hardware times Level1 table entry size 8bytes.
>> +			 *
>> +			 *   L2-DevIDs = ilog2(psz / entry_size)
>> +			 *      L1-DevIDs = ids (reported by HW) - L2-DevIDs
>> +			 * Table1 size = L1-DevIDs * 8Bytes
>> +			 */
>> +			ids -= ilog2(psz / entry_size);
>> +			order = get_order(GITS_LEVEL1_ENTRY_SIZE << ids);
>> +
>> +			/* Limit Level1 table size to MAX_ORDER-1 */
>> +			order = min(order, MAX_ORDER - 1);
>> +			indirect = GITS_BASER_INDIRECT;
>> +			its->tables[type].base = NULL;
>> +			goto retry_alloc_baser;
>> +		}
>> +
> Please take this opportunity to split this function into something
> manageable. It is really getting out of control. Something to directly
> deal with the device table seems in order.

Sure, I'll post a separate patch for this change.
>>  		if (val != tmp) {
>>  			pr_err("ITS: %s: GITS_BASER%d doesn't stick: %lx %lx\n",
>>  			       node_name, i,
>> @@ -971,10 +1013,12 @@ retry_baser:
>>  			goto out_free;
>>  		}
>>  
>> -		pr_info("ITS: allocated %d %s @%lx (psz %dK, shr %d)\n",
>> -			(int)(PAGE_ORDER_TO_SIZE(order) / entry_size),
>> +		pr_info("ITS: allocated %d %s @%lx (%s, psz %dK, shr %d)\n",
>> +			(int)(PAGE_ORDER_TO_SIZE(order) /
>> +			(indirect ? GITS_LEVEL1_ENTRY_SIZE : entry_size)),
>>  			its_base_type_string[type],
>>  			(unsigned long)virt_to_phys(base),
>> +			indirect ? "indirect" : "flat",
>>  			psz / SZ_1K, (int)shr >> GITS_BASER_SHAREABILITY_SHIFT);
>>  	}
>>  
>> @@ -1149,6 +1193,46 @@ static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
>>  	return its_dev;
>>  }
>>  
>> +static bool its_alloc_device_table(struct its_baser *baser, u32 dev_id)
>> +{
>> +	u32 entry_size = GITS_BASER_ENTRY_SIZE(baser->val);
>> +	u64 *table = baser->base;
>> +	struct page *page;
>> +	u32 psz = SZ_64K;
>> +	u32 idx;
>> +
>> +	/* Don't allow 'dev_id' that exceeds single, flat table limit */
>> +	if (!(baser->val & GITS_BASER_INDIRECT)) {
>> +		if (dev_id >= (PAGE_ORDER_TO_SIZE(baser->order) / entry_size))
>> +			return false;
>> +		return true;
>> +	}
>> +
>> +	/* Compute Level1 table index & check if that exceeds table range */
>> +	idx = dev_id >> ilog2(baser->psz / entry_size);
>> +	if (idx >= (PAGE_ORDER_TO_SIZE(baser->order) / GITS_LEVEL1_ENTRY_SIZE))
>> +		return false;
>> +
>> +	/* Allocate memory for Level2 table */
>> +	if (!table[idx]) {
>> +		page = alloc_pages_exact(psz, GFP_KERNEL | __GFP_ZERO);
>> +		if (!page)
>> +			return false;
>> +
>> +		table[idx] = page_to_phys(page) | GITS_BASER_VALID;
> Be careful, this must be written in LE format. If you're running a BE
> kernel, you're in for a nasty surprise...

Sorry, I didn't think about breaking BE machines. I'll fix it.
>> +
>> +		/* Flush memory to PoC if hardware dosn't support coherency */
>> +		if (!(baser->val & GITS_BASER_SHAREABILITY_MASK)) {
>> +			__flush_dcache_area(table + idx, GITS_LEVEL1_ENTRY_SIZE);
>> +			__flush_dcache_area(page_address(page), psz);
>> +		}
>> +		/* Ensure updated table contents are visible to ITS hardware */
>> +		dsb(sy);
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>  static struct its_baser *its_get_baser(struct its_node *its, u32 type)
>>  {
>>  	int i;
>> @@ -1176,11 +1260,8 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>>  	int sz;
>>  
>>  	baser = its_get_baser(its, GITS_BASER_TYPE_DEVICE);
>> -
>> -	/* Don't allow 'dev_id' that exceeds single, flat table limit */
>>  	if (baser) {
>> -		if (dev_id >= (PAGE_ORDER_TO_SIZE(baser->order) /
>> -			      GITS_BASER_ENTRY_SIZE(baser->val)))
>> +		if (!its_alloc_device_table(baser, dev_id))
>>  			return NULL;
>>  	} else if (ilog2(dev_id) >= its->device_ids)
>>  		return NULL;
> Please fold these checks into its_alloc_device_table so that it takes
> an its_node as a first parameter instead of an its_baser. That will make
> the code a bit more readable.

I'll fix it in the next patch.
>> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
>> index 9e6fdd3..df404ea 100644
>> --- a/include/linux/irqchip/arm-gic-v3.h
>> +++ b/include/linux/irqchip/arm-gic-v3.h
>> @@ -187,6 +187,7 @@
>>  #define GITS_TYPER_PTA			(1UL << 19)
>>  
>>  #define GITS_CBASER_VALID		(1UL << 63)
>> +#define GITS_BASER_INDIRECT		(1UL << 62)
>>  #define GITS_CBASER_nCnB		(0UL << 59)
>>  #define GITS_CBASER_nC			(1UL << 59)
>>  #define GITS_CBASER_RaWt		(2UL << 59)
>> @@ -238,6 +239,7 @@
>>  #define GITS_BASER_TYPE_RESERVED6	6
>>  #define GITS_BASER_TYPE_RESERVED7	7
>>  
>> +#define GITS_LEVEL1_ENTRY_SIZE		(8UL)
>>  /*
>>   * ITS commands
>>   */
>
> Thanks,
>
> 	M.

-- 
Shanker Donthineni
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
