From: robherring2@gmail.com (Rob Herring)
Date: Wed, 24 Aug 2011 21:45:28 -0500
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <4E5000A1.8060609@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-3-git-send-email-robherring2@gmail.com>
	<201108181734.25397.arnd@arndb.de> <4E5000A1.8060609@gmail.com>
Message-ID: <4E55B748.1000306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 08/20/2011 01:44 PM, Rob Herring wrote:
> Arnd,
> 
> On 08/18/2011 10:34 AM, Arnd Bergmann wrote:
>> On Tuesday 16 August 2011, Rob Herring wrote:
>>
>>> +void __iomem *a9_base_addr = ((void __iomem *)(HB_MPIC_VIRT_BASE));
>>> +void __iomem *sregs_base;
>>> +
>>> +static struct map_desc highbank_io_desc[] __initdata = {
>>> +	{
>>> +		.virtual	= HB_MPIC_VIRT_BASE,
>>> +		.pfn		= 0, /* run-time */
>>> +		.length		= SZ_4K,
>>> +		.type		= MT_DEVICE,
>>> +	},
>>> +#ifdef CONFIG_DEBUG_LL
>>> +	{
>>> +		.virtual	= HB_DEBUG_LL_VIRT_BASE,
>>> +		.pfn		= __phys_to_pfn(HB_DEBUG_LL_PHYS_BASE),
>>> +		.length		= SZ_4K,
>>> +		.type		= MT_DEVICE,
>>> +	},
>>> +#endif
>>> +};
>>> +
>>> +static void __init highbank_map_io(void)
>>> +{
>>> +	unsigned long base;
>>> +
>>> +	/* Get SCU base */
>>> +	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
>>> +
>>> +	highbank_io_desc[0].pfn = __phys_to_pfn(base);
>>> +	iotable_init(highbank_io_desc, ARRAY_SIZE(highbank_io_desc));
>>> +}
>>
>> I really liked the way that Barry moved the io_desc out to the
>> drivers using them, e.g arch/arm/mach-prima2/lluart.c.
>>
>> Can you do the same thing with your lluart and with the a9_base_addr?
>> I guess it can live locally in platsmp.c.
> 
> Okay.

Looking at this some more, it doesn't work too well. platsmp.c depends
on CONFIG_SMP, but the SCU mapping is always needed even for !SMP
because the SCU has a power mode register for each core used by the
power controller. So putting it in platsmp.c would add ifdefs.

So I'll move out the lluart mapping, but keep SCU mapping in highbank.c.

Rob
> 
>>
>>> +void highbank_init_irq(void)
>>> +{
>>> +	struct device_node *node;
>>> +	struct of_intc_desc desc;
>>> +	int n = 0;
>>> +
>>> +	memset(&desc, 0, sizeof(desc));
>>> +	desc.controller = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
>>> +	gic_of_init(&desc);
>>> +	node = desc.controller;
>>> +	for_each_child_of_node(node, desc.controller) {
>>> +		gic_of_ppi_init(&desc);
>>> +	}
>>> +
>>> +	for_each_compatible_node(node, NULL, "arm,pl061") {
>>> +		irq_domain_add_simple(node, 160 + (8 * n));
>>> +		n++;
>>> +	}
>>
>> Where does the "160 + (8 * n)" come from? Is that something that should
>> be in a property of the gic binding?
> 
> All this should go away once we have dynamic linux irq number
> assignment. Actually, I should just delete this for now as the pl061
> driver doesn't support interrupts yet with DT binding (without platform
> data).
> 
>>
>>> +#ifdef CONFIG_CACHE_L2X0
>>> +	l2x0_of_init(0, ~0UL);
>>> +#endif
>>> +}
>>
>> Hmm, I missed that during the review of the patch that adds l2x0_of_init,
>> but I think the #ifdef should really be in the header file, not in the
>> user, so that calling l2x0_of_init when CONFIG_CACHE_L2X0 is not set
>> automatically turns into an empty stub.
> 
> It's also a problem with l2x0_init. I'll add a patch to do that.
> 
>>
>>> +static void __init highbank_timer_init(void)
>>> +{
>>> +	int irq;
>>> +	struct device_node *np;
>>> +	void __iomem *timer_base;
>>> +
>>> +	/* Map system registers */
>>> +	np = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
>>> +	sregs_base = of_iomap(np, 0);
>>> +
>>> +	np = of_find_compatible_node(NULL, NULL, "arm,sp804");
>>> +	timer_base = of_iomap(np, 0);
>>> +	irq = irq_of_parse_and_map(np, 0);
>>> +
>>> +	highbank_clocks_init();
>>> +
>>> +	sp804_clocksource_init(timer_base + 0x20, "timer1");
>>> +	sp804_clockevents_init(timer_base, irq, "timer0");
>>> +}
>>
>> How about moving the sp804 initialization from device tree into the
>> arch/arm/common/timer-sp.c file?
>>
>> Why do you initialize sregs_base from timer_init?
> 
> It will be needed before the clocks are initialized. The clock code is
> not using it at the moment as I just did a minimal fixed clock
> implementation until the clock api and DT clock bindings gets sorted
> out. As there are multiple users, I didn't put it in highbank_clocks_init.
> 
>>
>>> diff --git a/arch/arm/mach-highbank/include/mach/timex.h b/arch/arm/mach-highbank/include/mach/timex.h
>>> new file mode 100644
>>> index 0000000..88dac7a
>>> --- /dev/null
>>> +++ b/arch/arm/mach-highbank/include/mach/timex.h
>>> @@ -0,0 +1,6 @@
>>> +#ifndef __MACH_TIMEX_H
>>> +#define __MACH_TIMEX_H
>>> +
>>> +#define CLOCK_TICK_RATE		1000000
>>> +
>>> +#endif
>>
>> In 3.2, we shouldn't need this any more. We'll have to come up with a
>> way to remember removing the new definitions that come in in parallel
>> to the patch that removes the old ones.
> 
> I'm tracking the various clean-ups and we can coordinate the order
> things go in. I've already made gpio.h empty for example, so gpio will
> fail to compile if enabled in this series.
> 
> Or I can just submit a patch deleting this file later. It will just be
> dead code and won't conflict.
> 
>>
>>> +#ifndef _MACH_HIGHBANK__SYSREGS_H_
>>> +#define _MACH_HIGHBANK__SYSREGS_H_
>>> +
>>> +extern void __iomem *sregs_base;
>>> +
>>> +#define HB_SREG_A9_PWR_REQ		0xf00
>>> +#define HB_SREG_A9_BOOT_STAT		0xf04
>>> +#define HB_SREG_A9_BOOT_DATA		0xf08
>>> +
>>> +#define HB_PWR_SUSPEND			0
>>> +#define HB_PWR_SOFT_RESET		1
>>> +#define HB_PWR_HARD_RESET		2
>>> +#define HB_PWR_SHUTDOWN			3
>>> +
>>> +#endif
>>
>> Do these really need to be global?
>>
>> I think it's better to put the base address and register definitions into a
>> single file and export functions to be used from elsewhere.
> 
> Yes, sregs are a random collection of functions, so it's going to be a
> mixture of various users. Just HB_PWR_* alone are in 2 or 3 different
> places.
> 
> Rob
