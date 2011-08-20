From: robherring2@gmail.com (Rob Herring)
Date: Sat, 20 Aug 2011 14:24:56 -0500
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <201108191611.36147.arnd@arndb.de>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<201108181734.25397.arnd@arndb.de>
	<20110818154048.GD21865@n2100.arm.linux.org.uk>
	<201108191611.36147.arnd@arndb.de>
Message-ID: <4E500A08.5000400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 08/19/2011 09:11 AM, Arnd Bergmann wrote:
> On Thursday 18 August 2011, Russell King - ARM Linux wrote:
>> On Thu, Aug 18, 2011 at 05:34:25PM +0200, Arnd Bergmann wrote:
>>> On Tuesday 16 August 2011, Rob Herring wrote:
>>>> +static void __init highbank_timer_init(void)
>>>> +{
>>>> +   int irq;
>>>> +   struct device_node *np;
>>>> +   void __iomem *timer_base;
>>>> +
>>>> +   /* Map system registers */
>>>> +   np = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
>>>> +   sregs_base = of_iomap(np, 0);
>>>> +
>>>> +   np = of_find_compatible_node(NULL, NULL, "arm,sp804");
>>>> +   timer_base = of_iomap(np, 0);
>>>> +   irq = irq_of_parse_and_map(np, 0);
>>>> +
>>>> +   highbank_clocks_init();
>>>> +
>>>> +   sp804_clocksource_init(timer_base + 0x20, "timer1");
>>>> +   sp804_clockevents_init(timer_base, irq, "timer0");
>>>> +}
>>>
>>> How about moving the sp804 initialization from device tree into the
>>> arch/arm/common/timer-sp.c file?
>>>
>>> Why do you initialize sregs_base from timer_init?
>>
>> That'd create special cases - ARM platforms need registers twiddled to
>> change the clock rate for the timers from 32kHz to a more sensible 1MHz.
> 
> Is that a bad thing? Platforms that don't need the special case can
> simply call sp804_clocksource_init_dt() which scans the device tree,
> while other platforms do whatever is necessary to the registers
> and then call the existing sp804_clockevents_init.
> 

This was something I considered as I've worked on doing that in other
cases like l2x0 and gic.

There's also the issue that the clocksource and clockevent timers may or
may not be at the same address range (base and base + 0x20), so you may
need 1 or 2 mappings. You could figure all that out, but it would be a
lot of work for little gain. Also, which timer is used for which
function is also platform dependent. For example, we don't have the 2nd
timer's interrupt hooked up so it has to be the .

On top of that this really needs to wait until the DT clock binding is
in place as clock setup is a major part of the init.

Rob
