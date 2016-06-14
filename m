From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 14 Jun 2016 11:52:48 +0200
Subject: [PATCH v2 1/2] clocksource: Add Oxford Semiconductor RPS Dual
 Timer
In-Reply-To: <20160613143502.GD10634@linaro.org>
References: <1465315452-20599-1-git-send-email-narmstrong@baylibre.com>
 <1465315452-20599-2-git-send-email-narmstrong@baylibre.com>
 <20160613143502.GD10634@linaro.org>
Message-ID: <575FD3F0.6040604@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 06/13/2016 04:35 PM, Daniel Lezcano wrote:
> On Tue, Jun 07, 2016 at 06:04:11PM +0200, Neil Armstrong wrote:
>> Add clocksource and clockevent driver from dual RPS timer.
>> The HW provides a dual one-shot or periodic 24bit timers,
>> the drivers set the first one as tick event source and the
>> second as a continuous scheduler clock source.
>> The timer can use 1, 16 or 256 as pre-dividers, thus the
>> clocksource uses 16 by default.
>>
>> CC: Ma Haijun <mahaijuns@gmail.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/clocksource/Kconfig           |   6 +
>>  drivers/clocksource/Makefile          |   1 +
>>  drivers/clocksource/timer-oxnas-rps.c | 270 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 277 insertions(+)
>>  create mode 100644 drivers/clocksource/timer-oxnas-rps.c
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 47352d2..7e382c5 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -293,6 +293,12 @@ config VF_PIT_TIMER
>>  	help
>>  	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
>>  
>> +config OXNAS_RPS_TIMER
> 
>    config OXNAS_RPS_TIMER "bla bla" if COMPILE_TEST
> 
OK

Shoud I also add CLKSRC_OF ?

>> +	bool
>> +	select CLKSRC_MMIO
>> +	help
>> +	  This enables support for the Oxford Semiconductor OXNAS RPS timers.
>> +
>> @@ -0,0 +1,270 @@
>> +/*
>> + * drivers/clocksource/timer-oxnas-rps.c
>> + *
>> + * Copyright (C) 2009 Oxford Semiconductor Ltd
>> + * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>
> 
> What are these two copyrights ?
> 
> [ ... ]

This driver is based from a driver from the OX820 sdk from Oxford and modified by Ma Haijun, thus the copyrights.

>> +static void __init oxnas_rps_timer_init(struct device_node *np)
>> +{
>> +	struct oxnas_rps_timer *rps;
>> +	void __iomem *base;
>> +	int ret;
>> +
>> +	rps = kzalloc(sizeof(*rps), GFP_KERNEL);
>> +	if (WARN_ON(!rps))
> 
> It is pointless to add a WARN_ON, kzalloc already does that on failure.
> 
>> +		return;
>> +
>> +	rps->clk = of_clk_get(np, 0);
>> +	if (WARN_ON(IS_ERR(rps->clk)))
>> +		return;

[....]

>> +		goto err;
>> +
>> +	oxnas_rps_clockevent_init(rps);
>> +	oxnas_rps_clocksource_init(rps);
>> +
>> +	return;
> 
> err_iounmap:
> 	iounmap(base);
> 
> err_clk_unprepare:
> 	clk_unprepare(rps->clk)
> 
> err_clk_put:
>> +	clk_put(rps->clk);
>> +	kfree(rps);
>> +}
> 
> Regarding the current work I am doing to change the init function to return 
> an error in case of failure, can you do proper error handling in this 
> function and rollback ?
> 
> 1. replace WARN_ON by a pr_err
> 2. make oxnas_rps_clockevent_init and oxnas_rps_clocksource_init to return 
> an error code
It can be done.

> 3. rollback clockevent or clocksource if one fails.
Sure, but as for 4.6, it seems neither sched_clock_register, clocksource_mmio_init or clockevents_config_and_register can be reverted !
What should I do ?

> 
> Thanks !
> 
>   -- Daniel
> 
Neil
