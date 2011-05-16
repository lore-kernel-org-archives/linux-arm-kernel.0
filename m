From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 22:33:46 +0100
Subject: [PATCH 16/19] clockevents: ARM sp804: allow clockevent name to
	be specified
In-Reply-To: <4DD19657.5010203@gmail.com>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1dA-0003EH-61@rmk-PC.arm.linux.org.uk>
	<4DD19657.5010203@gmail.com>
Message-ID: <20110516213346.GJ13659@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 04:25:43PM -0500, Rob Herring wrote:
> On 05/16/2011 12:30 PM, Russell King - ARM Linux wrote:
>> This allows platforms to specify the clcokevent name upon registration.
>>
>> Cc: Catalin Marinas<catalin.marinas@arm.com>
>> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
>> ---
>>   arch/arm/common/timer-sp.c               |    7 ++++---
>>   arch/arm/include/asm/hardware/timer-sp.h |    2 +-
>>   arch/arm/mach-integrator/integrator_cp.c |    2 +-
>>   arch/arm/mach-realview/core.c            |    2 +-
>>   arch/arm/mach-versatile/core.c           |    2 +-
>>   arch/arm/mach-vexpress/ct-ca9x4.c        |    3 ++-
>>   arch/arm/mach-vexpress/v2m.c             |    3 ++-
>>   7 files changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
>> index 45a5eb8..bf92afe 100644
>> --- a/arch/arm/common/timer-sp.c
>> +++ b/arch/arm/common/timer-sp.c
>> @@ -139,7 +139,6 @@ static int sp804_set_next_event(unsigned long next,
>>   }
>>
>>   static struct clock_event_device sp804_clockevent = {
>> -	.name		= "timer0",
>>   	.shift		= 32,
>>   	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
>>   	.set_mode	= sp804_set_mode,
>> @@ -155,13 +154,15 @@ static struct irqaction sp804_timer_irq = {
>>   	.dev_id		=&sp804_clockevent,
>>   };
>>
>> -void __init sp804_clockevents_init(void __iomem *base, unsigned int timer_irq)
>> +void __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
>> +	const char *name)
>>   {
>>   	struct clock_event_device *evt =&sp804_clockevent;
>>
>>   	clkevt_base = base;
>>
>> -	evt->irq = timer_irq;
>> +	evt->name = name;
>> +	evt->irq = irq;
>
> Also need to change timer_irq to irq in setup_irq farther down in this  
> function.

Grr.
