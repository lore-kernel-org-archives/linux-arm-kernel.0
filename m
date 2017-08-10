From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 10 Aug 2017 14:38:16 +0200
Subject: [PATCH v2] arm64: arch_timer: avoid infinite recursion when
 ftrace is enabled
In-Reply-To: <88a09999-3b89-ea49-1565-22e3fa7fbd7c@huawei.com>
References: <a53349bd-aa6c-cdc1-1476-a068a5cfc2c2@huawei.com>
 <88a09999-3b89-ea49-1565-22e3fa7fbd7c@huawei.com>
Message-ID: <8eb7b958-95c2-6b98-9795-b02c1c13261d@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2017 05:33, Ding Tianhong wrote:
> add Danial and Thomas.
> 
> On 2017/8/10 10:52, Ding Tianhong wrote:
>> On platforms with an arch timer erratum workaround, it's possible for
>> arch_timer_reg_read_stable() to recurse into itself when certain
>> tracing options are enabled, leading to stack overflows and related
>> problems.
>>
>> For example, when PREEMPT_TRACER and FUNCTION_GRAPH_TRACER are
>> selected, it's possible to trigger this with:
>>
>> $ mount -t debugfs nodev /sys/kernel/debug/
>> $ echo function_graph > /sys/kernel/debug/tracing/current_tracer
>>
>> The problem is that in such cases, preempt_disable() instrumentation
>> attempts to acquire a timestamp via trace_clock(), resulting in a call
>> back to arch_timer_reg_read_stable(), and hence recursion.
>>
>> This patch changes arch_timer_reg_read_stable() to use
>> preempt_{disable,enable}_notrace(), which avoids this.
>>
>> This problem is similar to the fixed by upstream commit 96b3d28bf4
>> ("sched/clock: Prevent tracing recursion in sched_clock_cpu()").
>>
>> Fixes: 6acc71ccac71 ("arm64: arch_timer: Allows a CPU-specific erratum to only affect a subset of CPUs")
>> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---


Applied.

Thanks!

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
