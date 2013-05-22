From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 22 May 2013 14:54:13 +0200
Subject: [PATCH v4] clocksource: add Vybrid Family pit timer support
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E851CBE88@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1369121274-9371-1-git-send-email-b35083@freescale.com>
 <519B48F4.8050005@linaro.org>
 <B56CDBE15CE27145A4B77D2D24263E851CBE88@039-SN1MPN1-003.039d.mgd.msft.net>
Message-ID: <519CBFF5.3060900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2013 11:47 AM, Lu Jingchang-B35083 wrote:
> 

[ ... ]

>>
>>> +}
>>> +
>>> +static void __init pit_timer_init(struct device_node *np) {
>>> +	struct clk *pit_clk;
>>> +	void __iomem *timer_base;
>>> +	int irq;
>>> +
>>> +	timer_base = of_iomap(np, 0);
>>> +	BUG_ON(!timer_base);
>>
>> You raise a bug and then you go ahead setting up the address with an
>> invalid value, leading to a random crash.
> [Lu Jingchang-B35083] 
> The BUG_ON() will call BUG() if condition is true. It will print the stack trace and the current process will die, it won't go ahead, won't it? Thanks! 

Pff, right. I just puzzled myself. Never mind.


>>> +	/*
>>> +	 * PIT0 and PIT1 can be chained to build a 64-bit timer,
>>> +	 * so choose PIT2 as clocksource, PIT3 as clockevent device,
>>> +	 * and leave PIT0 and PIT1 unused for anyone else who needs them.
>>> +	 */
>>> +	clksrc_base = timer_base + PITn_OFFSET(2);
>>> +	clkevt_base = timer_base + PITn_OFFSET(3);
>>> +
>>> +	irq = irq_of_parse_and_map(np, 0);
>>> +
>>> +	pit_clk = of_clk_get(np, 0);
>>> +	BUG_ON(IS_ERR(pit_clk));
>>> +
>>> +	BUG_ON(clk_prepare_enable(pit_clk));
>>
>> Same here.
>>
>>> +	cycle_per_jiffy = clk_get_rate(pit_clk)/(HZ);
>>> +
>>> +	/* enable the pit module */
>>> +	__raw_writel(~PITMCR_MDIS, timer_base + PITMCR);
>>> +
>>> +	BUG_ON(pit_clocksource_init(pit_clk));
>>> +
>>> +	pit_clockevent_init(pit_clk, irq);
>>
>> Please, remove these BUG_ON, this is inconsistent especially with a one
>> call init function. If pit_timer_init can't be initialized, just pr_err
>> + BUG.
> [Lu Jingchang-B35083] 
> Do you mean that I should not use the BUG_ON or I need print an error information by pr_err before BUG. Thanks!

Actually, my initial comment was wrong, so you can ignore it.

Thank
  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
