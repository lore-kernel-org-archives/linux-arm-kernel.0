From: huangtao@rock-chips.com (Huang, Tao)
Date: Wed, 1 Jun 2016 09:58:08 +0800
Subject: [PATCH 4/5] clocksource: rockchip: add support for rk3399 SoC
In-Reply-To: <574D9A66.4090209@linaro.org>
References: <1464169802-6033-1-git-send-email-wxt@rock-chips.com>
 <1464169802-6033-5-git-send-email-wxt@rock-chips.com>
 <574CCCB4.1030001@linaro.org> <574D95AF.2020905@rock-chips.com>
 <574D9A66.4090209@linaro.org>
Message-ID: <574E4130.8090600@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel:
On 2016?05?31? 22:06, Daniel Lezcano wrote:
>>
>> @@ -46,15 +48,20 @@ static inline void __iomem *rk_base(struct
>> clock_event_device *ce)
>>   	return rk_timer(ce)->base;
>>   }
>>
>> +static inline void __iomem *rk_ctrl(struct clock_event_device *ce)
>> +{
>> +	return rk_timer(ce)->base + rk_timer(ce)->ctrl;
> 
> You can do a small optimization by pre-computing 'ctrl' at init time, so 
> no need to do this addition each time.

I understand what you mean, please see comment below.
And even we use ctrl as pointer, we still will get addition LDR other
then ADD.
This is disassemble code before:
   0:	f9408021 	ldr	x1, [x1,#256]
   4:	52800003 	mov	w3, #0x0
   8:	91004022 	add	x2, x1, #0x10
   c:	b9000043 	str	w3, [x2]
This is disassemble code after change:
   0:	52800003 	mov	w3, #0x0
   4:	f9408422 	ldr	x2, [x1,#264]
   8:	b9000043 	str	w3, [x2]
   c:	f9408021 	ldr	x1, [x1,#256]
Of course we can assume cache hit.

> 
>> +}
>> +
>>   static inline void rk_timer_disable(struct clock_event_device *ce)
>>   {
>> -	writel_relaxed(TIMER_DISABLE, rk_base(ce) + TIMER_CONTROL_REG);
>> +	writel_relaxed(TIMER_DISABLE, rk_ctrl(ce));
>>   }
>>
>>   static inline void rk_timer_enable(struct clock_event_device *ce, u32
>> flags)
>>   {
>>   	writel_relaxed(TIMER_ENABLE | TIMER_INT_UNMASK | flags,
>> -		       rk_base(ce) + TIMER_CONTROL_REG);
>> +		       rk_ctrl(ce));
>>   }
>>
>>   static void rk_timer_update_counter(unsigned long cycles,
>> @@ -179,4 +186,19 @@ out_unmap:
>>   	iounmap(bc_timer.base);
>>   }
>>
>> -CLOCKSOURCE_OF_DECLARE(rk_timer, "rockchip,rk3288-timer", rk_timer_init);
>> +static void __init rk3288_timer_init(struct device_node *np)
>> +{
>> +	bc_timer.ctrl = TIMER_CONTROL_REG3288;
>> +	rk_timer_init(np);
> 
> 	rk_timer_init(np);
> 	bc_timer.ctrl = bc_timer.base + TIMER_CONTROL_REG3288;

No. It's not such simple. You will access null pointer when
rk_timer_init, if we keep rk_timer_disable call in init or after
request_irq/clockevents_config_and_register and interrupt happen
immediately.

So the code maybe:
static void __init rk3288_timer_init(struct device_node *np)
{
	bc_timer.base = of_iomap(np, 0);
	if (!bc_timer.base) {
		pr_err("Failed to get base address for '%s'\n", TIMER_NAME);
		return;
	}
	bc_timer.ctrl = bc_timer.base + TIMER_CONTROL_REG3288;
	rk_imter_init(np); // of course remove of_iomap from init.

Is this what you want?
