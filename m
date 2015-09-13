From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Sun, 13 Sep 2015 21:24:48 +0200
Subject: [PATCH] irqchip: bcm2835: Add FIQ support
In-Reply-To: <87d1zj6fq2.fsf@eliezer.anholt.net>
References: <1434130016-26574-1-git-send-email-noralf@tronnes.org>
 <87d1zj6fq2.fsf@eliezer.anholt.net>
Message-ID: <55F5CD80.3020700@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 22.07.2015 23:32, skrev Eric Anholt:
> Noralf Tr?nnes <noralf@tronnes.org> writes:
>
>> Add a duplicate irq range with an offset on the hwirq's so the
>> driver can detect that enable_fiq() is used.
>> Tested with downstream dwc_otg USB controller driver.
>>
>> Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
>> ---
>>   arch/arm/mach-bcm/Kconfig     |  1 +
>>   drivers/irqchip/irq-bcm2835.c | 53 ++++++++++++++++++++++++++++++++++++++-----
>>   2 files changed, 48 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> index 8b11f44..7cfef7b 100644
>> --- a/arch/arm/mach-bcm/Kconfig
>> +++ b/arch/arm/mach-bcm/Kconfig
>> @@ -114,6 +114,7 @@ config ARCH_BCM2835
>>   	select ARM_ERRATA_411920
>>   	select ARM_TIMER_SP804
>>   	select CLKSRC_OF
>> +	select FIQ
>>   	select PINCTRL
>>   	select PINCTRL_BCM2835
>>   	help
>> diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
>> index 5916d6c..db66246 100644
>> --- a/drivers/irqchip/irq-bcm2835.c
>> +++ b/drivers/irqchip/irq-bcm2835.c
>> @@ -56,7 +56,7 @@
>>   #include "irqchip.h"
>>   
>>   /* Put the bank and irq (32 bits) into the hwirq */
>> -#define MAKE_HWIRQ(b, n)	((b << 5) | (n))
>> +#define MAKE_HWIRQ(b, n)	(((b) << 5) | (n))
>>   #define HWIRQ_BANK(i)		(i >> 5)
>>   #define HWIRQ_BIT(i)		BIT(i & 0x1f)
>>   
>> @@ -72,9 +72,13 @@
>>   					| SHORTCUT1_MASK | SHORTCUT2_MASK)
>>   
>>   #define REG_FIQ_CONTROL		0x0c
>> +#define REG_FIQ_ENABLE		0x80
>> +#define REG_FIQ_DISABLE		0
>>   
>>   #define NR_BANKS		3
>>   #define IRQS_PER_BANK		32
>> +#define NUMBER_IRQS		MAKE_HWIRQ(NR_BANKS, 0)
>> +#define FIQ_START		(NR_IRQS_BANK0 + MAKE_HWIRQ(NR_BANKS - 1, 0))
>>   
>>   static int reg_pending[] __initconst = { 0x00, 0x04, 0x08 };
>>   static int reg_enable[] __initconst = { 0x18, 0x10, 0x14 };
>> @@ -98,14 +102,38 @@ static struct armctrl_ic intc __read_mostly;
>>   static void __exception_irq_entry bcm2835_handle_irq(
>>   	struct pt_regs *regs);
>>   
>> +static inline unsigned int hwirq_to_fiq(unsigned long hwirq)
>> +{
>> +	hwirq -= NUMBER_IRQS;
>> +	/*
>> +	 * The hwirq numbering used in this driver is:
>> +	 *   BASE (0-7) GPU1 (32-63) GPU2 (64-95).
>> +	 * This differ from the one used in the FIQ register:
>> +	 *   GPU1 (0-31) GPU2 (32-63) BASE (64-71)
>> +	 */
>> +	if (hwirq >= 32)
>> +		return hwirq - 32;
>> +
>> +	return hwirq + 64;
>> +}
>> +
>>   static void armctrl_mask_irq(struct irq_data *d)
>>   {
>> -	writel_relaxed(HWIRQ_BIT(d->hwirq), intc.disable[HWIRQ_BANK(d->hwirq)]);
>> +	if (d->hwirq >= NUMBER_IRQS)
>> +		writel_relaxed(REG_FIQ_DISABLE, intc.base + REG_FIQ_CONTROL);
>> +	else
>> +		writel_relaxed(HWIRQ_BIT(d->hwirq),
>> +			       intc.disable[HWIRQ_BANK(d->hwirq)]);
>>   }
>>   
>>   static void armctrl_unmask_irq(struct irq_data *d)
>>   {
>> -	writel_relaxed(HWIRQ_BIT(d->hwirq), intc.enable[HWIRQ_BANK(d->hwirq)]);
>> +	if (d->hwirq >= NUMBER_IRQS)
>> +		writel_relaxed(REG_FIQ_ENABLE | hwirq_to_fiq(d->hwirq),
>> +			       intc.base + REG_FIQ_CONTROL);
>> +	else
>> +		writel_relaxed(HWIRQ_BIT(d->hwirq),
>> +			       intc.enable[HWIRQ_BANK(d->hwirq)]);
>>   }
> I found it nice for the 2836 controller to declare a new irqchip when
> both the mask/unmask hooks needed to be changed for that class of
> interrupt.  However, it looks like these functions aren't going to be
> called regularly, so it doesn't matter much.
>
> As far as interaction with my 2836 series, it looks like the only thing
> downstream does is make the FIQ get handled on CPU1 instead of CPU0.  I
> think we'll be fine fixing this up later.
>
> Reviewed-by: Eric Anholt <eric@anholt.net>

It seems that this has slipped through the cracks, at least it didn't
enter in the 4.3 merge window.


Noralf.
