From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 Jun 2017 16:03:36 +0100
Subject: [RFC PATCH 23/33] irqchip/gic-v3-its: Add VPENDBASER/VPROPBASER
 accessors
In-Reply-To: <29ab17b1-40c3-205b-cb6a-ea6fdbc96ac9@codeaurora.org>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-24-git-send-email-marc.zyngier@arm.com>
 <29ab17b1-40c3-205b-cb6a-ea6fdbc96ac9@codeaurora.org>
Message-ID: <cdcdfc76-a914-49f2-3744-c711710ee868@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/02/17 23:39, Shanker Donthineni wrote:
> Hi Marc,
> 
> 
> On 01/17/2017 04:20 AM, Marc Zyngier wrote:
>> V{PEND,PROP}BASER being 64bit registers, they need some ad-hoc
>> accessors on 32bit, specially given that VPENDBASER contains
>> a Valid bit, making the access a bit convoluted.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>   arch/arm/include/asm/arch_gicv3.h   | 28 ++++++++++++++++++++++++++++
>>   arch/arm64/include/asm/arch_gicv3.h |  5 +++++
>>   2 files changed, 33 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/arch_gicv3.h
>> b/arch/arm/include/asm/arch_gicv3.h
>> index 2747590..3f18832 100644
>> --- a/arch/arm/include/asm/arch_gicv3.h
>> +++ b/arch/arm/include/asm/arch_gicv3.h
>> @@ -291,5 +291,33 @@ static inline u64 __gic_readq_nonatomic(const
>> volatile void __iomem *addr)
>>    */
>>   #define gits_write_cwriter(v, c)	__gic_writeq_nonatomic(v, c)
>>   
>> +/*
>> + * GITS_VPROPBASER - hi and lo bits may be accessed independently.
>> + */
>> +#define gits_write_vpropbaser(v, c)	__gic_writeq_nonatomic(v, c)
>> +
>> +/*
>> + * GITS_VPENDBASER - the Valid bit must be cleared before changing
>> + * anything else.
>> + */
>> +static inline void gits_write_vpendbaser(u64 val, void * __iomem addr)
>> +{
>> +	u32 tmp;
>> +
>> +	tmp = readl_relaxed(addr + 4);
>> +	if (tmp & GICR_PENDBASER_Valid) {
>> +		tmp &= ~GICR_PENDBASER_Valid;
>> +		writel_relaxed(tmp, addr + 4);
>> +	}
>> +
>> +	/*
>> +	 * Use the fact that __gic_writeq_nonatomic writes the second
>> +	 * half of the 64bit quantity after the first.
>> +	 */
>> +	__gic_writeq_nonatomic(val, addr);
> I'm not sure whether software has to check a register write pending bit 
> GICR_CTLR.RWP or not. GICv3 spec says, the effect of a write to 
> GICR_VPENDBASER register is not guaranteed to be visible throughout the 
> affinity hierarchy,as indicated by GICR_CTLR.RWP == 0.

Yeah, that's a bit odd, and I've raised this internally. GICR_CTLR.RWP
doesn't mention anything about GICR_VPENDBASER at all, and this makes me
think that it could be a leftover from an earlier spec...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
