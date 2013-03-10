From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 10 Mar 2013 19:22:24 +0100
Subject: [PATCH 0/4] time: dynamic irq affinity
In-Reply-To: <513CC404.6000200@ti.com>
References: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org>
 <513CC404.6000200@ti.com>
Message-ID: <513CCF60.6060406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2013 06:33 PM, Santosh Shilimkar wrote:
> On Wednesday 27 February 2013 03:47 AM, Daniel Lezcano wrote:
>> When a cpu goes to a deep idle state where its local timer is shutdown,
>> it notifies the time framework to use the broadcast timer instead.
>>
>> Unfortunately, the broadcast device could wake up any CPU, including an
>> idle one which is not concerned by the wake up at all.
>>
>> This implies, in the worst case, an idle CPU will wake up to send an IPI
>> to another idle cpu.
>>
>> This patch solves this by setting the irq affinity to the cpu concerned
>> by the nearest timer event, by this way, the CPU which is wake up is
>> guarantee to be the one concerned by the next event and we are safe with
>> unnecessary wakeup for another idle CPU.
>>
>> As the irq affinity is not supported by all the archs, a flag is needed
>> to specify which clocksource can handle it.
>>
>> Daniel Lezcano (3):
>>   time : pass broadcast parameter
>>   time : set broadcast irq affinity
>>   ARM: nomadik: add dynamic irq flag to the timer
>>
>> Viresh Kumar (1):
>>   ARM: timer-sp: Set dynamic irq affinity
>>
> Thanks Daniel for addressing the comments from earlier version. This
> version looks good to me.
> 
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Regards,
> Santosh
> P.S: As I mentioned 'CLOCK_EVT_FEAT_DYNIRQ' optimization on
> OMAP at least I found risky because you might end up missing
> the asynchronous IPI wakeups because of the current SGI's
> implementation. This must be true for other ARM platforms
> as well.

I don't think it is the case for all the ARM platforms, at least we
tested it on vexpress TC2 and u8500, and the number of IPI were reduced
very significantly increasing the idle time for cpu0. TC2 will need
another optimization on another area for the idle wake up to gain real
improvements.

I will test it on OMAP but with the coupled idle state, I am not sure of
the behavior. Could elaborate a bit the specificity of OMAP ? I am not
sure to understand why I may miss some IPI wakeups.

Testing on more boards will be worth but not until we have correct
cpuidle support, with deep idle states.

Thanks
  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
