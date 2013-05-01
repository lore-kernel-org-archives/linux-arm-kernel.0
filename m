From: csd@broadcom.com (Christian Daudt)
Date: Wed, 1 May 2013 11:09:55 -0700
Subject: [PATCH] ARM: bcm281xx: Add L2 support for Rev A2 chips
In-Reply-To: <20130501103718.GC22796@mudshark.cambridge.arm.com>
References: <1367347089-23788-1-git-send-email-csd@broadcom.com>
 <20130501103718.GC22796@mudshark.cambridge.arm.com>
Message-ID: <51815A73.9000705@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,
  Thanks for your feedback. See below for answers.

On 13-05-01 03:37 AM, Will Deacon wrote:
> Hi Christian,
>
> Thanks for CC'ing me.
>
> On Tue, Apr 30, 2013 at 07:38:09PM +0100, Christian Daudt wrote:
>> Rev A2 SoCs have an unorthodox memory re-mapping and this needs
>> to be reflected in the cache operations.
>> This patch adds new outer cache functions for the l2x0 driver
>> to support this SoC revision. It also adds a new compatible
>> value for the cache to enable this functionality.
> This is a pretty weird thing you've managed to build here...
No argument here.
>> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
>> index c465fac..6edba13 100644
>> --- a/arch/arm/mm/cache-l2x0.c
>> +++ b/arch/arm/mm/cache-l2x0.c
>> @@ -523,6 +523,162 @@ static void aurora_flush_range(unsigned long start, unsigned long end)
>>   	}
>>   }
>>   
>> +/*
>> + * For certain Broadcom SoCs, depending on the address range, different offsets
>> + * need to be added to the address before passing it to L2 for
>> + * invalidation/clean/flush
>> + *
>> + * Section Address Range              Offset        EMI
>> + *   1     0x00000000 - 0x3FFFFFFF    0x80000000    VC
>> + *   2     0x40000000 - 0xBFFFFFFF    0x40000000    SYS
>> + *   3     0xC0000000 - 0xFFFFFFFF    0x80000000    VC
> Hmm, so am I right in thinking that the `Broadcom addresses' for section 1
> and 2 overlap? It would also be worth describing which physical addresses
> Linux actually wants to use; where is the memory in the physical memory map
> for devices with this L2 controller?
I've clarified this internally. Yes, there is an overlap, and because of 
that section 1 can't actually be used. I'm going to clear up the patch 
to remove the section one calculations to simplify it.
>> + * When the start and end addresses have crossed two different sections, we
>> + * need to break the L2 operation into two, each within its own section.
>> + * For example, if we need to invalidate addresses starts at 0xBFFF0000 and
>> + * ends at 0xC0001000, we need do invalidate 1) 0xBFFF0000 - 0xBFFFFFFF and 2)
>> + * 0xC0000000 - 0xC0001000
>> + *
>> + * Note 1:
>> + * By breaking a single L2 operation into two, we may potentially suffer some
>> + * performance hit, but keep in mind the cross section case is very rare
>> + *
>> + * Note 2:
>> + * We do not need to handle the case when the start address is in
>> + * Section 1 and the end address is in Section 3, since it is not a valid use
>> + * case
>> + */
>> +
>> +#define BCM_VC_EMI_SEC1_START_ADDR    0x00000000UL
>> +#define BCM_VC_EMI_SEC1_END_ADDR      0x3FFFFFFFUL
>> +#define BCM_SYS_EMI_START_ADDR        0x40000000UL
>> +#define BCM_SYS_EMI_END_ADDR          0xBFFFFFFFUL
>> +#define BCM_VC_EMI_SEC3_START_ADDR    0xC0000000UL
>> +#define BCM_VC_EMI_SEC3_END_ADDR      0xFFFFFFFFUL
> Seems a bit odd defining the END_ADDRs here, I'd just use strict '<' against
> the start of the next section in your code.
Makes sense. Removed.
>> +#define BCM_SYS_EMI_OFFSET            0x40000000UL
>> +#define BCM_VC_EMI_OFFSET             0x80000000UL
>> +
>> +static inline int bcm_addr_is_sys_emi(unsigned long addr)
>> +{
>> +	return (addr >= BCM_SYS_EMI_START_ADDR) &&
>> +		(addr <= BCM_SYS_EMI_END_ADDR);
>> +}
>> +
>> +static inline unsigned long bcm_l2_phys_addr(unsigned long addr)
>> +{
>> +	if (bcm_addr_is_sys_emi(addr))
>> +		return addr + BCM_SYS_EMI_OFFSET;
>> +	else
>> +		return addr + BCM_VC_EMI_OFFSET;
>> +}
>> +
>> +static void bcm_inv_range(unsigned long start, unsigned long end)
>> +{
>> +	unsigned long new_start, new_end;
>> +
>> +	if (unlikely(end <= start))
>> +		return;
>> +
>> +	new_start = bcm_l2_phys_addr(start);
>> +	new_end = bcm_l2_phys_addr(end);
>> +
>> +	/* normal case, no cross section between start and end */
>> +	if (likely((bcm_addr_is_sys_emi(start) && bcm_addr_is_sys_emi(end)) ||
>> +		(!bcm_addr_is_sys_emi(start) && !bcm_addr_is_sys_emi(end)))) {
> You could avoid evaluating bcm_addr_is_sys_emi twice for each address. In
> fact, you know start < end, so you just need to check start >= EMI_START and
> end < EMI_END.
This test is to confirm that the range is completely within 1 section, 
so a single test won't do that - with the test as-is, the code after 
this 'if' already knows that there is section overlap. But I'll be 
removing section 1 handling and that will simplify things.

  thanks,
    csd
