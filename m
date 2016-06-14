From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 14 Jun 2016 13:48:18 +0200
Subject: [PATCH v2 1/2] clocksource: Add Oxford Semiconductor RPS Dual
 Timer
In-Reply-To: <575FD3F0.6040604@baylibre.com>
References: <1465315452-20599-1-git-send-email-narmstrong@baylibre.com>
 <1465315452-20599-2-git-send-email-narmstrong@baylibre.com>
 <20160613143502.GD10634@linaro.org> <575FD3F0.6040604@baylibre.com>
Message-ID: <575FEF02.4000805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2016 11:52 AM, Neil Armstrong wrote:
> Hi Daniel,

Hi Neil,

[ ... ]

>>> +config OXNAS_RPS_TIMER
>>
>>     config OXNAS_RPS_TIMER "bla bla" if COMPILE_TEST
>>
> OK
>
> Shoud I also add CLKSRC_OF ?

Yes, right.

>>> +	bool
>>> +	select CLKSRC_MMIO
>>> +	help
>>> +	  This enables support for the Oxford Semiconductor OXNAS RPS timers.
>>> +
>>> @@ -0,0 +1,270 @@
>>> +/*
>>> + * drivers/clocksource/timer-oxnas-rps.c
>>> + *
>>> + * Copyright (C) 2009 Oxford Semiconductor Ltd
>>> + * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>
>>
>> What are these two copyrights ?
>>
>> [ ... ]
>
> This driver is based from a driver from the OX820 sdk from Oxford and modified by Ma Haijun, thus the copyrights.

Ok.

>>> +static void __init oxnas_rps_timer_init(struct device_node *np)
>>> +{
>>> +	struct oxnas_rps_timer *rps;
>>> +	void __iomem *base;
>>> +	int ret;
>>> +
>>> +	rps = kzalloc(sizeof(*rps), GFP_KERNEL);
>>> +	if (WARN_ON(!rps))
>>
>> It is pointless to add a WARN_ON, kzalloc already does that on failure.
>>
>>> +		return;
>>> +
>>> +	rps->clk = of_clk_get(np, 0);
>>> +	if (WARN_ON(IS_ERR(rps->clk)))
>>> +		return;
>
> [....]
>
>>> +		goto err;
>>> +
>>> +	oxnas_rps_clockevent_init(rps);
>>> +	oxnas_rps_clocksource_init(rps);
>>> +
>>> +	return;
>>
>> err_iounmap:
>> 	iounmap(base);
>>
>> err_clk_unprepare:
>> 	clk_unprepare(rps->clk)
>>
>> err_clk_put:
>>> +	clk_put(rps->clk);
>>> +	kfree(rps);
>>> +}
>>
>> Regarding the current work I am doing to change the init function to return
>> an error in case of failure, can you do proper error handling in this
>> function and rollback ?
>>
>> 1. replace WARN_ON by a pr_err
>> 2. make oxnas_rps_clockevent_init and oxnas_rps_clocksource_init to return
>> an error code
> It can be done.
>
>> 3. rollback clockevent or clocksource if one fails.
> Sure, but as for 4.6, it seems neither sched_clock_register, clocksource_mmio_init or clockevents_config_and_register can be reverted !
> What should I do ?

Just try to do the best effort.

eg.

ret = oxnas_rps_clockevent_init(rps);
if (ret)
	goto err_...

ret = oxnas_rps_clocksource_init(rps);
if (ret)
	goto err_...

If the function themselves just return 0, it is fine for me.

I initiated a process to cleanup and factor out the clocksource / 
clockevents, so any changes being able to rollback will help in this 
process.

   -- Daniel



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
