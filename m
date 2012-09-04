From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 04 Sep 2012 16:50:18 +0200
Subject: [PATCH V2 3/6] arm: cache-l2x0: add support for Aurora L2 cache
 ctrl
In-Reply-To: <20120904112247.GF2458@mudshark.cambridge.arm.com>
References: <1346755232-26006-1-git-send-email-gregory.clement@free-electrons.com>
 <1346755232-26006-4-git-send-email-gregory.clement@free-electrons.com>
 <20120904112247.GF2458@mudshark.cambridge.arm.com>
Message-ID: <5046152A.1050601@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

thanks for you review

On 09/04/2012 01:22 PM, Will Deacon wrote:> On Tue, Sep 04, 2012 at 11:40:29AM +0100, Gregory CLEMENT wrote:
>> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
>> index 3591940..684c188 100644
>> --- a/arch/arm/mm/cache-l2x0.c
>> +++ b/arch/arm/mm/cache-l2x0.c
>> @@ -25,6 +25,7 @@
>>
>>  #include <asm/cacheflush.h>
>>  #include <asm/hardware/cache-l2x0.h>
>> +#include <asm/hardware/cache-aurora-l2.h>
>>
>>  #define CACHE_LINE_SIZE                32
>>
>> @@ -33,6 +34,11 @@ static DEFINE_RAW_SPINLOCK(l2x0_lock);
>>  static u32 l2x0_way_mask;      /* Bitmask of active ways */
>>  static u32 l2x0_size;
>>  static unsigned long sync_reg_offset = L2X0_CACHE_SYNC;
>> +static int l2_wt_override;
>> +
>> +/* Aurora don't have the cache ID register available, so we have to
>> + * pass it though the device tree */
>> +static u32  cache_id_part_number_from_dt;
>>
>>  struct l2x0_regs l2x0_saved_regs;
>>
>> @@ -275,6 +281,130 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
>>         cache_sync();
>>         raw_spin_unlock_irqrestore(&l2x0_lock, flags);
>>  }
>> +/*
>> + * Note that the end addresses passed to Linux primitives are
>> + * noninclusive, while the hardware cache range operations use
>> + * inclusive start and end addresses.
>> + */
>> +static unsigned long calc_range_end(unsigned long start, unsigned long end)
>> +{
>> +       unsigned long range_end;
>> +
>> +       BUG_ON(start & (CACHE_LINE_SIZE - 1));
>> +       BUG_ON(end & (CACHE_LINE_SIZE - 1));
>
> Seems a bit overkill to use BUG_ON here. Can you not just ALIGN the
> addresses instead?

OK I can align them and issue a warning about it.

>
>> +       /*
>> +        * Try to process all cache lines between 'start' and 'end'.
>> +        */
>> +       range_end = end;
>> +
>> +       /*
>> +        * Limit the number of cache lines processed at once,
>> +        * since cache range operations stall the CPU pipeline
>> +        * until completion.
>> +        */
>> +       if (range_end > start + MAX_RANGE_SIZE)
>> +               range_end = start + MAX_RANGE_SIZE;
>> +
>> +       /*
>> +        * Cache range operations can't straddle a page boundary.
>> +        */
>> +       if (range_end > (start | (PAGE_SIZE - 1)) + 1)
>> +               range_end = (start | (PAGE_SIZE - 1)) + 1;
>
> PAGE_ALIGN(start) instead of these bitwise operations?

Yes it's better.

>
>> +       return range_end;
>> +}
>> +
>> +static void aurora_pa_range(unsigned long start, unsigned long end,
>> +                       unsigned long offset)
>> +{
>> +       unsigned long flags;
>> +
>> +       /*
>> +        * Make sure 'start' and 'end' reference the same page, as
>> +        * L2 is PIPT and range operations only do a TLB lookup on
>> +        * the start address.
>> +        */
>> +       BUG_ON((start ^ end) & ~(PAGE_SIZE - 1));
>
> Eek. I think you should instead split this into multiple operations, one for
> each page contained in the range.

Actually this function is already called for each page. Before each
call we use calc_range_end() which ensure that start address and end
address are in the same page. Maybe I can just removed this test and
move the comment on top of the function.

>
>> +       raw_spin_lock_irqsave(&l2x0_lock, flags);
>> +       writel(start, l2x0_base + AURORA_RANGE_BASE_ADDR_REG);
>> +       writel(end, l2x0_base + offset);
>> +       raw_spin_unlock_irqrestore(&l2x0_lock, flags);
>> +
>> +       cache_sync();
>> +}
>> +
>> +static void aurora_inv_range(unsigned long start, unsigned long end)
>> +{
>> +       /*
>> +        * Clean and invalidate partial first cache line.
>> +        */
>> +       if (start & (CACHE_LINE_SIZE - 1)) {
>> +               writel((start & ~(CACHE_LINE_SIZE - 1)) & ~0x1f,
>> +                       l2x0_base + AURORA_FLUSH_PHY_ADDR_REG);
>> +               cache_sync();
>
> writel implies a cache_sync if you have CONFIG_ARM_DMA_MEM_BUFFERABLE (there
> are other places in your code where this comment also applies). For v7, this
> is always the case.

As the aurora cache controller is only use with v7 CPU, then we can
removed them.

>
>> +               start = (start | (CACHE_LINE_SIZE - 1)) + 1;
>> +       }
>
> It's pretty strange for a cache to be able to operate only on a subset of a
> cacheline. Should you not just be rounding everything up to cache line size?

We have CACHE_LINE_SIZE = 32 and we mask it with 0x1F. So indeed we
can round everything to cache line size and make only one call.

>
>> +       /*
>> +        * Clean and invalidate partial last cache line.
>> +        */
>> +       if (start < end && end & (CACHE_LINE_SIZE - 1)) {
>> +               writel((end & ~(CACHE_LINE_SIZE - 1)) & ~0x1f,
>> +                       l2x0_base + AURORA_FLUSH_PHY_ADDR_REG);
>> +               cache_sync();
>> +               end &= ~(CACHE_LINE_SIZE - 1);
>> +       }
>> +
>> +       /*
>> +        * Invalidate all full cache lines between 'start' and 'end'.
>> +        */
>> +       while (start < end) {
>> +               unsigned long range_end = calc_range_end(start, end);
>> +               aurora_pa_range(start, range_end - CACHE_LINE_SIZE,
>> +                               AURORA_INVAL_RANGE_REG);
>> +               start = range_end;
>> +       }
>> +
>> +       dsb();
>
> Why? (same for the other dsbs following writels/cache_syncs).

I will ask if it is really needed.

>
>> @@ -312,18 +449,22 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
>>         u32 cache_id;
>>         u32 way_size = 0;
>>         int ways;
>> +       int way_size_shift = 3;
>
> Can this be expressed in terms of a named constant? (something like
> L2X0_AUX_CTRL_WAY_SIZE_MASK).

Sure.

>
>>         /* Determine the number of ways */
>> -       switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
>> +       switch (cache_id) {
>>         case L2X0_CACHE_ID_PART_L310:
>>                 if (aux & (1 << 16))
>>                         ways = 16;
>> @@ -340,6 +481,30 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
>>                 ways = (aux >> 13) & 0xf;
>>                 type = "L210";
>>                 break;
>> +
>> +       case AURORA_CACHE_ID:
>> +               sync_reg_offset = AURORA_SYNC_REG;
>> +
>> +               switch ((aux >> 13) & 0xf) {
>> +               case 3:
>> +                       ways = 4;
>> +                       break;
>> +               case 7:
>> +                       ways = 8;
>> +                       break;
>> +               case 11:
>> +                       ways = 16;
>> +                       break;
>> +               case 15:
>> +                       ways = 32;
>> +                       break;
>> +               default:
>> +                       ways = 8;
>> +                       break;
>
> Do the 3,7,11,15 correspond to something meaningful or can you do:
>
> 	ways = 2 << ((n + 1) >> 2);
>
> instead?

Good, you found the logic behind this series! I will use it.

>
>> +static void aurora_resume(void)
>> +{
>> +       u32 u;
>> +
>> +       u = readl(l2x0_base + L2X0_CTRL);
>> +       if (!(u & 1)) {
>
> We should probably add a L2X0_CTRL_EN define and use that (also update the
> enabling code to use it as well).
>

Should it be a separate patch or can I include it with this one?

>> +static void __init aurora_broadcast_l2_commands(void)
>> +{
>> +       __u32 u;
>> +       /* Enable Broadcasting of cache commands to L2*/
>> +       __asm__ __volatile__("mrc p15, 1, %0, c15, c2, 0" : "=r"(u));
>> +       u |= 0x100;             /* Set the FW bit */
>
> Again, just add a AURORA_CTRL_FW define for this.

OK

>
>> +static void __init aurora_of_setup(const struct device_node *np,
>> +                               u32 *aux_val, u32 *aux_mask)
>> +{
>> +       u32 val = AURORA_ACR_REPLACEMENT_TYPE_SEMIPLRU;
>> +       u32 mask =  AURORA_ACR_REPLACEMENT_MASK;
>> +
>> +       of_property_read_u32(np, "cache-id-part",
>> +                       &cache_id_part_number_from_dt);
>> +
>> +       /* Determine and save the write policy */
>> +       l2_wt_override = of_property_read_bool(np, "wt-override");
>> +
>> +       if (l2_wt_override) {
>> +               val |= AURORA_ACR_FORCE_WRITE_THRO_POLICY;
>> +               mask |= AURORA_ACR_FORCE_WRITE_POLICY_MASK;
>> +       }
>
> smp_mb() after the assignment to l2_wt_override?

Sorry I don't get your point, why do you think we need this?

>
>> +       *aux_val &= ~mask;
>> +       *aux_val |= val;
>> +       *aux_mask &= ~mask;
>> +}
>> +
>
> Will
>
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
