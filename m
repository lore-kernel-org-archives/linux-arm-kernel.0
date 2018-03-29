From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 29 Mar 2018 14:07:34 +0200
Subject: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
In-Reply-To: <20180329114255.GL13942@piout.net>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
 <3478710.yJBBt3uoRT@ada> <20180329104542.GK13942@piout.net>
 <3103570.fW0XyqvKVi@ada> <20180329114255.GL13942@piout.net>
Message-ID: <e3235587-8362-e1fc-a813-39f790a1c8b4@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/03/2018 13:42, Alexandre Belloni wrote:
> On 29/03/2018 at 13:31:18 +0200, Alexander Dahl wrote:
>> Pretty sure. I rebuilt the whole BSP and added another line to the kernel 
>> source to see if the tree I applied the patches to, was actually built:
>>
>>
>> diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
>> index 7fde9cfbf203..f85affc74a86 100644
>> --- a/drivers/clocksource/timer-atmel-tcb.c
>> +++ b/drivers/clocksource/timer-atmel-tcb.c
>> @@ -222,7 +222,8 @@ static int __init tc_clkevt_register(struct device_node *node,
>>                 goto err_slow;
>>         clk_disable(tce.clk);
>>  
>> -       clockevents_config_and_register(&tce.clkevt, 32768, 1, bits - 1);
>> +       pr_info( "*** bits: 0x%x, BIT(bits): 0x%lx\n", bits, BIT(bits) );
>> +       clockevents_config_and_register(&tce.clkevt, 32768, 1, BIT(bits) - 1);
>>  
>>         ret = request_irq(tce.irq, tc_clkevt2_irq, IRQF_TIMER | IRQF_SHARED,
>>                           tce.clkevt.name, &tce);
>>
>>
> 
> I've just tested on a g20, old driver:
> INT                NAME          RATE             MAX
>  16 [vel     at91_tick,]   175 Ints/s     (max:   231)
>  19 [ vel     tc_clkevt]   129 Ints/s     (max:   129)
> 
> 
> new driver:
> INT                NAME          RATE             MAX
>  17 [vel     timer at fffa]   129 Ints/s     (max:   129)
>  18 [     vel     ttyS0]   175 Ints/s     (max:   231)

Can you give in both platforms how fast the clocksource wraps up ?

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
