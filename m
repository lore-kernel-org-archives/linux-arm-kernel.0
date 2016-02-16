From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Tue, 16 Feb 2016 17:03:33 -0600
Subject: [PATCH] irqchip/gicv3-its: Avoid cache flush beyond ITS_BASERn
 memory size
In-Reply-To: <20160216083549.5c889627@arm.com>
References: <1455594112-27783-1-git-send-email-shankerd@codeaurora.org>
 <20160216083549.5c889627@arm.com>
Message-ID: <56C3AAC5.7020300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 02/16/2016 02:35 AM, Marc Zyngier wrote:
> On Mon, 15 Feb 2016 21:41:52 -0600
> Shanker Donthineni <shankerd@codeaurora.org> wrote:
>
>> Function its_alloc_tables() maintains two local variables, "order" and
>> and "alloc_size", to hold memory size that has been allocated to
>> ITS_BASEn. We don't always refresh the variable alloc_size whenever
>> value of the variable order changes, causing the following two problems.
>>
>>    - Cache flush operation with size more than required.
>>    - Information reported by pr_info is not correct.
>>
>> Use a helper macro that converts page order to size in bytes instead of
>> variable "alloc_size" to fix both the problems.
>>
>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 0a73632..6f717f7 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -78,6 +78,9 @@ struct its_node {
>>   
>>   #define ITS_ITT_ALIGN		SZ_256
>>   
>> +/* Convert page order to size in bytes */
>> +#define PAGE_ORDER_TO_BYTES(o)	(PAGE_SIZE << (o))
>> +
> nit: PAGE_ORDER_TO_size() seems more appropriate.
>
I will change to PAGE_ORDER_TO_SIZE in v2 patch.

>>   struct event_lpi_map {
>>   	unsigned long		*lpi_map;
>>   	u16			*col_map;
>> @@ -846,7 +849,6 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>>   		u64 type = GITS_BASER_TYPE(val);
>>   		u64 entry_size = GITS_BASER_ENTRY_SIZE(val);
>>   		int order = get_order(psz);
>> -		int alloc_size;
>>   		int alloc_pages;
>>   		u64 tmp;
>>   		void *base;
>> @@ -878,9 +880,8 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>>   			}
>>   		}
>>   
>> -		alloc_size = (1 << order) * PAGE_SIZE;
>>   retry_alloc_baser:
>> -		alloc_pages = (alloc_size / psz);
>> +		alloc_pages = (PAGE_ORDER_TO_BYTES(order) / psz);
>>   		if (alloc_pages > GITS_BASER_PAGES_MAX) {
>>   			alloc_pages = GITS_BASER_PAGES_MAX;
>>   			order = get_order(GITS_BASER_PAGES_MAX * psz);
>> @@ -933,7 +934,8 @@ retry_baser:
>>   			shr = tmp & GITS_BASER_SHAREABILITY_MASK;
>>   			if (!shr) {
>>   				cache = GITS_BASER_nC;
>> -				__flush_dcache_area(base, alloc_size);
>> +				__flush_dcache_area(base,
>> +						    PAGE_ORDER_TO_BYTES(order));
> Please keep it on the same line. It helps my random grepping...
Sure, I will keep it on the same line in v2 patch.

>>   			}
>>   			goto retry_baser;
>>   		}
>> @@ -966,7 +968,7 @@ retry_baser:
>>   		}
>>   
>>   		pr_info("ITS: allocated %d %s @%lx (psz %dK, shr %d)\n",
>> -			(int)(alloc_size / entry_size),
>> +			(int)(PAGE_ORDER_TO_BYTES(order) / entry_size),
>>   			its_base_type_string[type],
>>   			(unsigned long)virt_to_phys(base),
>>   			psz / SZ_1K, (int)shr >> GITS_BASER_SHAREABILITY_SHIFT);
>
> Otherwise looks good.
>
> Thanks,
>
> 	M.
