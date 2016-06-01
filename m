From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 1 Jun 2016 08:16:41 +0200
Subject: [PATCH 4/5] clocksource: rockchip: add support for rk3399 SoC
In-Reply-To: <574E4130.8090600@rock-chips.com>
References: <1464169802-6033-1-git-send-email-wxt@rock-chips.com>
 <1464169802-6033-5-git-send-email-wxt@rock-chips.com>
 <574CCCB4.1030001@linaro.org> <574D95AF.2020905@rock-chips.com>
 <574D9A66.4090209@linaro.org> <574E4130.8090600@rock-chips.com>
Message-ID: <574E7DC9.4000102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 03:58 AM, Huang, Tao wrote:
> Hi Daniel:
> On 2016?05?31? 22:06, Daniel Lezcano wrote:

[ ... ]

>>> -CLOCKSOURCE_OF_DECLARE(rk_timer, "rockchip,rk3288-timer", rk_timer_init);
>>> +static void __init rk3288_timer_init(struct device_node *np)
>>> +{
>>> +	bc_timer.ctrl = TIMER_CONTROL_REG3288;
>>> +	rk_timer_init(np);
>>
>> 	rk_timer_init(np);
>> 	bc_timer.ctrl = bc_timer.base + TIMER_CONTROL_REG3288;
>
> No. It's not such simple. You will access null pointer when
> rk_timer_init, if we keep rk_timer_disable call in init or after
> request_irq/clockevents_config_and_register and interrupt happen
> immediately.
>
> So the code maybe:
> static void __init rk3288_timer_init(struct device_node *np)
> {
> 	bc_timer.base = of_iomap(np, 0);
> 	if (!bc_timer.base) {
> 		pr_err("Failed to get base address for '%s'\n", TIMER_NAME);
> 		return;
> 	}
> 	bc_timer.ctrl = bc_timer.base + TIMER_CONTROL_REG3288;
> 	rk_imter_init(np); // of course remove of_iomap from init.
>
> Is this what you want?

Not necessarily. There are plenty of variants.

eg. rk_timer_init(np, TIMER_CONTROL_REG3288);



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
