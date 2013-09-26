From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 26 Sep 2013 12:54:27 +0200
Subject: [PATCH] clockevent: exynos_mct: fix lockdep warning
In-Reply-To: <17472486.7GQJa9ux9F@amdc1227>
References: <1380120578-17458-1-git-send-email-tom.leiming@gmail.com>
 <5243823D.4040208@linaro.org> <17472486.7GQJa9ux9F@amdc1227>
Message-ID: <52441263.8010507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2013 12:32 PM, Tomasz Figa wrote:
> Hi Daniel,
>
> On Thursday 26 of September 2013 02:39:25 Daniel Lezcano wrote:
>> On 09/25/2013 04:49 PM, Ming Lei wrote:
>>> This patch moves request_irq() out of cpu notifier callback
>>> to fix below lockdep warning:
>>>
>>> [    0.249513] ------------[ cut here ]------------
>>> [    0.249525] WARNING: CPU: 1 PID: 0 at kernel/lockdep.c:2740 lockdep_trace_alloc+0xc8/0x10c()
>>> [    0.249534] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
>>> [    0.249538] Modules linked in:
>>> [    0.249548] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.12.0-rc1-next-20130923+ #338
>>> [    0.249564] [<c00165d0>] (unwind_backtrace+0x0/0xec) from [<c0012b48>] (show_stack+0x20/0x24)
>>> [    0.249577] [<c0012b48>] (show_stack+0x20/0x24) from [<c04ebf0c>] (dump_stack+0x74/0xb4)
>>> [    0.249591] [<c04ebf0c>] (dump_stack+0x74/0xb4) from [<c00237a8>] (warn_slowpath_common+0x78/0x9c)
>>> [    0.249604] [<c00237a8>] (warn_slowpath_common+0x78/0x9c) from [<c0023888>] (warn_slowpath_fmt+0x40/0x48)
>>> [    0.249615] [<c0023888>] (warn_slowpath_fmt+0x40/0x48) from [<c007f194>] (lockdep_trace_alloc+0xc8/0x10c)
>>> [    0.249626] [<c007f194>] (lockdep_trace_alloc+0xc8/0x10c) from [<c01173b0>] (kmem_cache_alloc_trace+0x38/0x2
>>> 24)
>>> [    0.249638] [<c01173b0>] (kmem_cache_alloc_trace+0x38/0x224) from [<c006bc4c>] (request_threaded_irq+0x90/0x130)
>>> [    0.249651] [<c006bc4c>] (request_threaded_irq+0x90/0x130) from [<c0408c60>] (exynos4_local_timer_setup+0xdc/0x140)
>>> [    0.249663] [<c0408c60>] (exynos4_local_timer_setup+0xdc/0x140) from [<c0408d78>] (exynos4_mct_cpu_notify+0x40/0xb0)
>>> [    0.249675] [<c0408d78>] (exynos4_mct_cpu_notify+0x40/0xb0) from [<c04f4e18>] (notifier_call_chain+0x48/0x78)
>>> [    0.249688] [<c04f4e18>] (notifier_call_chain+0x48/0x78) from [<c004abb0>] (__raw_notifier_call_chain+0x24/0x2c)
>>> [    0.249700] [<c004abb0>] (__raw_notifier_call_chain+0x24/0x2c) from [<c0023908>] (__cpu_notify+0x3c/0x58)
>>> [    0.249713] [<c0023908>] (__cpu_notify+0x3c/0x58) from [<c0023944>] (cpu_notify+0x20/0x24)
>>> [    0.249725] [<c0023944>] (cpu_notify+0x20/0x24) from [<c002407c>] (notify_cpu_starting+0x58/0x60)
>>> [    0.249737] [<c002407c>] (notify_cpu_starting+0x58/0x60) from [<c00143cc>] (secondary_start_kernel+0xec/0x13
>>> 8)
>>> [    0.249748] [<c00143cc>] (secondary_start_kernel+0xec/0x138) from [<40008664>] (0x40008664)
>>> [    0.249767] ---[ end trace 3406ff24bd97382e ]---
>>>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: linux-samsung-soc at vger.kernel.org
>>> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>>> ---
>>
>> Tomasz, what do you think ?
>
> This is a fix that we may want to have, but it must be modified to take
> my regression fix[1] into account.
>
> [1] clocksource: exynos_mct: Set IRQ affinity when the CPU goes online
> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/22511/focus=23418

Ok, as the clockevents fixes PR for 3.12-rc2 has already been sent, this 
patch will go to next round of fixes.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
