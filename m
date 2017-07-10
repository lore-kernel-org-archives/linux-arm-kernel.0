From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 10 Jul 2017 14:54:27 +0100
Subject: [PATCH RESEND] arm64: arch_timer: fix the infinite recursion when
 enable ftrace and erratum workaround
In-Reply-To: <20170710112229.GA18040@leverpostej>
References: <321e4c16-aa14-beee-b6dc-36e19e5ec35a@huawei.com>
 <20170710112229.GA18040@leverpostej>
Message-ID: <b95c1c4e-2464-379b-e067-4e7c107760f8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/17 12:22, Mark Rutland wrote:
> On Sun, Jul 09, 2017 at 04:30:54PM +0800, Ding Tianhong wrote:
>> When enable preempt and debug ftrace, and perform the following steps, the
>> system will hang:
>> mount -t debugfs nodev /sys/kernel/debug/
>> cd /sys/kernel/debug/tracing/
>> echo function_graph > current_tracer
>>
>> This is because tracing the preempt_disable/enable calls would cause
>> trace_clock() which would get local timer to go into infinite recursion
>> when enable the arch timer erratum workaround for some chips, so Prevent
>> tracing of preempt_disable/enable() in arch_timer_reg_read_stable().
>>
>> This problem is similar to the fixed by upstream commit 96b3d28bf4
>> ("sched/clock: Prevent tracing recursion in sched_clock_cpu()").
> 
> As I mentioned before, the patch itself looks fine to me, but the commit
> message is somewhat difficult to read.
> 
> Can we please change this to:
> 
>   arm64: arch_timer: avoid infinite recursion when ftrace is enabled
> 
>   On platforms with an arch timer erratum workaround, it's possible for
>   arch_timer_reg_read_stable() to recurse into itself when certain
>   tracing options are enabled, leading to stack overflows and related
>   problems.
>  
>   For example, when PREEMPT_TRACER and FUNCTION_GRAPH_TRACER are
>   selected, it's possible to trigger this with:
>   
>   $ mount -t debugfs nodev /sys/kernel/debug/
>   $ echo function_graph > /sys/kernel/debug/tracing/current_tracer
> 
>   The problem is that in such cases, preempt_disable() instrumentation
>   attempts to acquire a timestamp via trace_clock(), resulting in a call
>   back to arch_timer_reg_read_stable(), and hence recursion.
> 
>   This patch changes arch_timer_reg_read_stable() to use
>   preempt_{disable,enable}_notrace(), which avoids this.
> 
> With that commit message:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Daniel, Thomas, would you be happy to fold that in when picking this? Or
> would you prefer that I fix this up and resend?

With the proposed changes:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
