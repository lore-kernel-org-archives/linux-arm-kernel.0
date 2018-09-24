From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 24 Sep 2018 11:55:58 +0100
Subject: [PATCH 02/10] irqchip/gic-v3-its: Consolidate LPI_PENDBASE_SZ
 usage
In-Reply-To: <f37b69a8-64fd-490d-1680-9f6aef235e10@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
 <20180921195954.21574-3-marc.zyngier@arm.com>
 <e267123d-af92-0871-455c-cb74a2bc4103@arm.com>
 <cab043d8-c9bb-6975-8304-ff80dbe62027@arm.com>
 <f37b69a8-64fd-490d-1680-9f6aef235e10@arm.com>
Message-ID: <d901b068-66f8-e817-e2fb-7728f597cbeb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/09/18 11:54, Suzuki K Poulose wrote:
> 
> 
> On 24/09/18 11:50, Julien Thierry wrote:
>> Hi,
>>
>> On 24/09/18 11:33, Suzuki K Poulose wrote:
>>> Hi Marc,
>>>
>>> On 21/09/18 20:59, Marc Zyngier wrote:
>>>> LPI_PENDING_SZ is always used in conjunction with a max(). Let's
>>>> factor this in the definition of the macro, and simplify the rest
>>>> of the code.
>>>>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>> ? drivers/irqchip/irq-gic-v3-its.c | 12 ++++--------
>>>> ? 1 file changed, 4 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>>>> b/drivers/irqchip/irq-gic-v3-its.c
>>>> index c2df341ff6fa..ed6aab11e019 100644
>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>> @@ -62,7 +62,7 @@ static u32 lpi_id_bits;
>>>> ?? */
>>>> ? #define LPI_NRBITS??????? lpi_id_bits
>>>> ? #define LPI_PROPBASE_SZ??????? ALIGN(BIT(LPI_NRBITS), SZ_64K)
>>>> -#define LPI_PENDBASE_SZ??????? ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K)
>>>> +#define LPI_PENDBASE_SZ??????? max_t(u32, SZ_64K, 
>>>> ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K))
>>>
>>> minor nit: The ALIGN() already aligns the given value up to the required
>>> alignment. So, if the LPI_NRBITS is guaranteed to be non-zero,
>>> we could simply drop the max_t().
>>>
>>
>> Hmmm, Doesn't ALIGN only aligns down? So if "BIT(LPI_NR_BITS) / 8 < 
>> SZ_64K" (i.e. LPI_NRBITS < 20) The ALIGN(..., SZ_64K) would give 0.
> 
> Isn't it the ALIGN_DOWN(), which aligns it down ? Following the kernel
> definitions :
> linux/kernel.h -> uapi/linux/kernel.h
> ALIGN(x,a) =>???? __ALIGN_KERNEL(x, a)
>  ??????? \ => __ALIGN_KERNEL_MASK(x, (a -1)
>  ??????? \ => (((x + (a - 1)) & ~ (a - 1))

Oh, yes you're right, made the wrong assumption.
Your suggestion makes sense. Sorry for the noise.

Thanks,

> 
> Cheers
> Suzuki
> 
> 
>>
>> Thanks,
>>
>>> Rest looks good to me.
>>>
>>> Suzuki
>>>
>>>> ? #define LPI_PROP_DEFAULT_PRIO??? 0xa0
>>>> @@ -1924,12 +1924,9 @@ static int its_alloc_collections(struct 
>>>> its_node *its)
>>>> ? static struct page *its_allocate_pending_table(gfp_t gfp_flags)
>>>> ? {
>>>> ????? struct page *pend_page;
>>>> -??? /*
>>>> -???? * The pending pages have to be at least 64kB aligned,
>>>> -???? * hence the 'max(LPI_PENDBASE_SZ, SZ_64K)' below.
>>>> -???? */
>>>> +
>>>> ????? pend_page = alloc_pages(gfp_flags | __GFP_ZERO,
>>>> -??????????????? get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
>>>> +??????????????? get_order(LPI_PENDBASE_SZ));
>>>> ????? if (!pend_page)
>>>> ????????? return NULL;
>>>> @@ -1941,8 +1938,7 @@ static struct page 
>>>> *its_allocate_pending_table(gfp_t gfp_flags)
>>>> ? static void its_free_pending_table(struct page *pt)
>>>> ? {
>>>> -??? free_pages((unsigned long)page_address(pt),
>>>> -?????????? get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
>>>> +??? free_pages((unsigned long)page_address(pt), 
>>>> get_order(LPI_PENDBASE_SZ));
>>>> ? }
>>>> ? static void its_cpu_init_lpis(void)
>>>>
>>

-- 
Julien Thierry
