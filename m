From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 29 Sep 2011 09:53:26 +0100
Subject: [PATCH v2 07/16] ARM: GIC: Add global gic_handle_irq_offset()
	function
In-Reply-To: <4E834248.3010908@gmail.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
	<1317034955-1029-8-git-send-email-marc.zyngier@arm.com>
	<4E834248.3010908@gmail.com>
Message-ID: <4E843206.4040500@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/09/11 16:50, Rob Herring wrote:
> On 09/26/2011 06:02 AM, Marc Zyngier wrote:
>> Similar to gic_handle_irq(), gic_handle_irq_offset() is provided
>> for those platform who insist on having their GIC base interrupt
>> at something different from zero. At the moment, Exynos4 is the
>> only one...
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/common/gic.c               |   24 ++++++++++++++++++++++++
>>  arch/arm/include/asm/hardware/gic.h |    1 +
>>  2 files changed, 25 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>> index 5a22896..ef803d2 100644
>> --- a/arch/arm/common/gic.c
>> +++ b/arch/arm/common/gic.c
>> @@ -232,6 +232,30 @@ asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
>>  	} while (1);
>>  }
>>  
>> +asmlinkage void __exception_irq_entry gic_handle_irq_offset(struct pt_regs *regs)
>> +{
>> +	u32 irqstat, irqnr;
>> +	u32 offset = gic_data[0].irq_offset;
>> +
>> +	do {
>> +		irqstat = readl_relaxed(gic_cpu_base_addr + GIC_CPU_INTACK);
>> +		irqnr = irqstat & ~0x1c00;
>> +
>> +		if (likely(irqnr > 15 && irqnr < 1021)) {
>> +			handle_IRQ(irqnr + offset, regs);
> 
> Can't this be combined with gic_handle_irq. irq_offset will be 0 in that
> case. Really, irq_domain should be used here.

I completely agree on the irq_domain thing. The reason I introduced two
functions is to keep things as similar as possible to the old
implementation, and also to save a memory reference + addition on the
hot path of all the other platforms.

If we all agree that keeping that piece of code as generic as possible
is the way forward, then I'll happily drop that patch and let Exynos4
use the same handler.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
