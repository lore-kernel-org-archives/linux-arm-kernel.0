From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 26 Sep 2018 11:28:47 +0100
Subject: [PATCH 02/10] irqchip/gic-v3-its: Consolidate LPI_PENDBASE_SZ
 usage
In-Reply-To: <e267123d-af92-0871-455c-cb74a2bc4103@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
 <20180921195954.21574-3-marc.zyngier@arm.com>
 <e267123d-af92-0871-455c-cb74a2bc4103@arm.com>
Message-ID: <1fe9460d-c90a-a6ce-b0ce-754e22d834e1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/09/18 11:33, Suzuki K Poulose wrote:
> Hi Marc,
> 
> On 21/09/18 20:59, Marc Zyngier wrote:
>> LPI_PENDING_SZ is always used in conjunction with a max(). Let's
>> factor this in the definition of the macro, and simplify the rest
>> of the code.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>    drivers/irqchip/irq-gic-v3-its.c | 12 ++++--------
>>    1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index c2df341ff6fa..ed6aab11e019 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -62,7 +62,7 @@ static u32 lpi_id_bits;
>>     */
>>    #define LPI_NRBITS		lpi_id_bits
>>    #define LPI_PROPBASE_SZ		ALIGN(BIT(LPI_NRBITS), SZ_64K)
>> -#define LPI_PENDBASE_SZ		ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K)
>> +#define LPI_PENDBASE_SZ		max_t(u32, SZ_64K, ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K))
> 
> minor nit: The ALIGN() already aligns the given value up to the required
> alignment. So, if the LPI_NRBITS is guaranteed to be non-zero,
> we could simply drop the max_t().

Yeah, that's a brain fart on my part. I've fixed up.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
