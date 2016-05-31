From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 31 May 2016 16:06:30 +0200
Subject: [PATCH 4/5] clocksource: rockchip: add support for rk3399 SoC
In-Reply-To: <574D95AF.2020905@rock-chips.com>
References: <1464169802-6033-1-git-send-email-wxt@rock-chips.com>
 <1464169802-6033-5-git-send-email-wxt@rock-chips.com>
 <574CCCB4.1030001@linaro.org> <574D95AF.2020905@rock-chips.com>
Message-ID: <574D9A66.4090209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2016 03:46 PM, Huang, Tao wrote:
> Hi Daniel:
> On 2016?05?31? 07:28, Daniel Lezcano wrote:
>> On 05/25/2016 11:50 AM, Caesar Wang wrote:
>>> From: Huang Tao <huangtao@rock-chips.com>
>>>
>>> The CONTROL register offset is different from old SoCs.
>>> For Linux driver, there are not functional changes at all.
>>> Let's call it v2.
>>>
>>> Signed-off-by: Huang Tao <huangtao@rock-chips.com>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Heiko Stuebner <heiko@sntech.de>
>>> Tested-by: Jianqun Xu <jay.xu@rock-chips.com>
>>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>>> ---
>>
>> That's hackish.
> Yes:( I blamed our IC guy.
>>
>> Please consider something like:
>>
>> diff --git a/drivers/clocksource/rockchip_timer.c
>> b/drivers/clocksource/rockchip_timer.c
>> index b991b28..b6ba6f9 100644
>> --- a/drivers/clocksource/rockchip_timer.c
>> +++ b/drivers/clocksource/rockchip_timer.c
>> @@ -19,7 +19,8 @@
>>
>>    #define TIMER_LOAD_COUNT0	0x00
>>    #define TIMER_LOAD_COUNT1	0x04
>> -#define TIMER_CONTROL_REG	0x10
>> +#define TIMER_CONTROL_REG3288	0x10
>> +#define TIMER_CONTROL_REG3399	0x1C
>>    #define TIMER_INT_STATUS	0x18
>>
>>    #define TIMER_DISABLE		0x0
>> @@ -31,6 +32,7 @@
>>    struct bc_timer {
>>    	struct clock_event_device ce;
>>    	void __iomem *base;
>> +	void __iomem *ctrl;
>>    	u32 freq;
>>    };
>>
>> @@ -46,15 +48,20 @@ static inline void __iomem *rk_base(struct
>> clock_event_device *ce)
>>    	return rk_timer(ce)->base;
>>    }
>>
>> +static inline void __iomem *rk_ctrl(struct clock_event_device *ce)
>> +{
>> +        return rk_timer(ce)->ctrl;
>> +}
>> +
>>    static inline void rk_timer_disable(struct clock_event_device *ce)
>>    {
>> -	writel_relaxed(TIMER_DISABLE, rk_base(ce) + TIMER_CONTROL_REG);
>> +	writel_relaxed(TIMER_DISABLE, rk_ctrl(ce));
>>    }
>>
>>    static inline void rk_timer_enable(struct clock_event_device *ce, u32
>> flags)
>>    {
>>    	writel_relaxed(TIMER_ENABLE | TIMER_INT_UNMASK | flags,
>> -		       rk_base(ce) + TIMER_CONTROL_REG);
>> +		       rk_ctrl(ce));
>>    }
>>
>>    static void rk_timer_update_counter(unsigned long cycles,
>> @@ -179,4 +186,18 @@ out_unmap:
>>    	iounmap(bc_timer.base);
>>    }
>>
>> -CLOCKSOURCE_OF_DECLARE(rk_timer, "rockchip,rk3288-timer", rk_timer_init);
>> +static void __init rk3288_timer_init(struct device_node *np)
>> +{
>> +	bc_timer.ctrl = TIMER_CONTROL_REG3288;
>> +	rk_timer_init(np);
>> +}
>> +
>> +static void __init rk3399_timer_init(struct device_node *np)
>> +{
>> +        bc_timer.ctrl = TIMER_CONTROL_REG3399;
>> +	rk_timer_init(np);
>> +}
>> +
>> +
>> +CLOCKSOURCE_OF_DECLARE(rk_timer, "rockchip,rk3288-timer",
>> rk3288_timer_init);
>> +CLOCKSOURCE_OF_DECLARE(rk_timer, "rockchip,rk3399-timer",
>> rk3399_timer_init);
>>
>>
>
> I think you mean this patch otherwise compile will fail:
> @@ -19,7 +19,8 @@
>
>   #define TIMER_LOAD_COUNT0	0x00
>   #define TIMER_LOAD_COUNT1	0x04
> -#define TIMER_CONTROL_REG	0x10
> +#define TIMER_CONTROL_REG3288	0x10
> +#define TIMER_CONTROL_REG3399	0x1C
>   #define TIMER_INT_STATUS	0x18
>
>   #define TIMER_DISABLE		0x0
> @@ -31,6 +32,7 @@
>   struct bc_timer {
>   	struct clock_event_device ce;
>   	void __iomem *base;
> +	u32 ctrl;
>   	u32 freq;
>   };
>
> @@ -46,15 +48,20 @@ static inline void __iomem *rk_base(struct
> clock_event_device *ce)
>   	return rk_timer(ce)->base;
>   }
>
> +static inline void __iomem *rk_ctrl(struct clock_event_device *ce)
> +{
> +	return rk_timer(ce)->base + rk_timer(ce)->ctrl;

You can do a small optimization by pre-computing 'ctrl' at init time, so 
no need to do this addition each time.

> +}
> +
>   static inline void rk_timer_disable(struct clock_event_device *ce)
>   {
> -	writel_relaxed(TIMER_DISABLE, rk_base(ce) + TIMER_CONTROL_REG);
> +	writel_relaxed(TIMER_DISABLE, rk_ctrl(ce));
>   }
>
>   static inline void rk_timer_enable(struct clock_event_device *ce, u32
> flags)
>   {
>   	writel_relaxed(TIMER_ENABLE | TIMER_INT_UNMASK | flags,
> -		       rk_base(ce) + TIMER_CONTROL_REG);
> +		       rk_ctrl(ce));
>   }
>
>   static void rk_timer_update_counter(unsigned long cycles,
> @@ -179,4 +186,19 @@ out_unmap:
>   	iounmap(bc_timer.base);
>   }
>
> -CLOCKSOURCE_OF_DECLARE(rk_timer, "rockchip,rk3288-timer", rk_timer_init);
> +static void __init rk3288_timer_init(struct device_node *np)
> +{
> +	bc_timer.ctrl = TIMER_CONTROL_REG3288;
> +	rk_timer_init(np);

	rk_timer_init(np);
	bc_timer.ctrl = bc_timer.base + TIMER_CONTROL_REG3288;

> +}
> +
> +static void __init rk3399_timer_init(struct device_node *np)
> +{
> +	bc_timer.ctrl = TIMER_CONTROL_REG3399;
> +	rk_timer_init(np);

	rk_timer_init(np);
	bc_timer.ctrl = bc_timer.base + TIMER_CONTROL_REG3399;

> +}
> +
> +CLOCKSOURCE_OF_DECLARE(rk3288_timer, "rockchip,rk3288-timer",
> +		       rk3288_timer_init);
> +CLOCKSOURCE_OF_DECLARE(rk3399_timer, "rockchip,rk3399-timer",
> +		       rk3399_timer_init);
>
> This patch will give us a little lager text size. If we do disassemble,
> we can see additional LDR is called. I can accept this performance drop.
> So we will send new patches.
> BTW, the patch "clocksource: rockchip: remove unnecessary clear irq
> before request_irq" can drop if we use this patch.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
