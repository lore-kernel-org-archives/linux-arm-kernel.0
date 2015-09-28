From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 28 Sep 2015 15:43:51 +0100
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56094543.2040101@free.fr> (Mason's message of "Mon, 28 Sep 2015
 15:48:51 +0200")
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
 <56016780.5080104@free.fr> <144297172.JfjI0hNJ9J@wuerfel>
 <56094543.2040101@free.fr>
Message-ID: <yw1xa8s6r4d4.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 22/09/2015 16:51, Arnd Bergmann wrote:
>
>> On Tuesday 22 September 2015 16:36:48 Mason wrote:
>> 
>>> +void __init tangox_timer_init(void)
>>> +{
>>> +	int err;
>>> +
>>> +	clkgen_base = ioremap(CLKGEN_BASE, 0x100);
>> 
>> Remove all hardcoded physical memory addresses.
>> 
>>> +	if (clkgen_base == NULL) return;
>>> +
>>> +	register_current_timer_delay(&delay_timer);
>>> +	sched_clock_register(read_sched_clock, 32, XTAL_FREQ);
>>> +
>>> +	err = clocksource_register_hz(&tangox_xtal, XTAL_FREQ);
>>> +	if (err) pi_alert("Failed to register tangox_xtal clocksource!\n");
>>> +
>>> +	tangox_clock_tree_register();
>>> +
>>> +	of_clk_init(NULL);
>>> +	clocksource_of_init();
>>> +}
>> 
>> CLK_OF_DECLARE() for the clk
>> 
>> CLOCKSOURCE_OF_DECLARE() for the clocksource/clockevent
>> 
>> Make these two drivers.
>
> Hmmm, about that (splitting clock-tango.c in two drivers)
>
> The "legacy" order of calls was:
>
>   register_current_timer_delay
>   sched_clock_register
>   clocksource_register_hz
>   /* Should the above 3 be called in a different order? */
>
> then
>
>   tangox_clock_tree_register
>
> then
>
>   of_clk_init
>   clocksource_of_init
>   /* To invoke the smp_twd OF init, after the clock tree is registered */
>
> I moved the first three to a separate clocksource driver:
>
> static void __init tango_timer_init(struct device_node *np)
> {
> 	clkgen_base = of_iomap(np, 0);
> 	register_current_timer_delay(&delay_timer);
> 	sched_clock_register(read_sched_clock, 32, XTAL_FREQ);
> 	clocksource_register_hz(&tango_xtal, XTAL_FREQ);
> }
> CLOCKSOURCE_OF_DECLARE(tango, "sigma,tango-xtal", tango_timer_init);
>
> But tango_timer_init() is not being called...
>
> I updated my device tree with
>
> 	tango-xtal at 10000 {
> 		compatible = "sigma,tango-xtal";
> 		reg = <0x10000 0x100>;
> 	};
>
> Shouldn't the kernel call tango_timer_init?

Why don't you use the drivers from my tree?  It has drivers for
everything clock related in tango3 and shouldn't need much tweaking to
work with tango4 as well.

-- 
M?ns Rullg?rd
mans at mansr.com
