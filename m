From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 21 Aug 2014 03:50:57 +0200
Subject: [PATCH] clocksource: sirf: disable counter before re-setting
 it
In-Reply-To: <CAGsJ_4wAMYwGfLCfu+RE4O=JtzBPEU8EmVMcKap4Bhu8TTYc6w@mail.gmail.com>
References: <1406124197-25083-1-git-send-email-21cnbao@gmail.com>
 <CAGsJ_4wAMYwGfLCfu+RE4O=JtzBPEU8EmVMcKap4Bhu8TTYc6w@mail.gmail.com>
Message-ID: <53F55081.3020802@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/2014 11:24 AM, Barry Song wrote:
> 2014-07-23 22:03 GMT+08:00 Barry Song <21cnbao@gmail.com>:
>> From: Hao Liu <Hao.Liu@csr.com>
>>
>> according to HW spec, we have to disable counter before setting
>> it, if we don't this, in pressure test, sometimes the timer might
>> not generate interrupt any more.
>>
>> and this patch also fixes a typo for register set by changing 0x7
>> to 0x3. 0x7 is loop mode in HW, but here we are using oneshot 0x3.
>>
>> Signed-off-by: Hao Liu <Hao.Liu@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>
> Hi Daniel,
> did you miss this one?

Nope, I have it locally. Let me review it in details next week when I 
return from the kernel summit.

Thanks

   -- Daniel


>
>>   drivers/clocksource/timer-marco.c |    5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/timer-marco.c b/drivers/clocksource/timer-marco.c
>> index 330e930..caf7a20 100644
>> --- a/drivers/clocksource/timer-marco.c
>> +++ b/drivers/clocksource/timer-marco.c
>> @@ -63,7 +63,7 @@ static inline void sirfsoc_timer_count_disable(int idx)
>>   /* enable count and interrupt */
>>   static inline void sirfsoc_timer_count_enable(int idx)
>>   {
>> -       writel_relaxed(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL + 4 * idx) | 0x7,
>> +       writel_relaxed(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL + 4 * idx) | 0x3,
>>                  sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL + 4 * idx);
>>   }
>>
>> @@ -103,6 +103,9 @@ static int sirfsoc_timer_set_next_event(unsigned long delta,
>>   {
>>          int cpu = smp_processor_id();
>>
>> +       /* disable timer first, then modify the related registers */
>> +       sirfsoc_timer_count_disable(cpu);
>> +
>>          writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_0 +
>>                  4 * cpu);
>>          writel_relaxed(delta, sirfsoc_timer_base + SIRFSOC_TIMER_MATCH_0 +
>> --
>> 1.7.9.5
>>
>
> -barry
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
