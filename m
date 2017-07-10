From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 10 Jul 2017 12:22:29 +0100
Subject: [PATCH RESEND] arm64: arch_timer: fix the infinite recursion
 when enable ftrace and erratum workaround
In-Reply-To: <321e4c16-aa14-beee-b6dc-36e19e5ec35a@huawei.com>
References: <321e4c16-aa14-beee-b6dc-36e19e5ec35a@huawei.com>
Message-ID: <20170710112229.GA18040@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 09, 2017 at 04:30:54PM +0800, Ding Tianhong wrote:
> When enable preempt and debug ftrace, and perform the following steps, the
> system will hang:
> mount -t debugfs nodev /sys/kernel/debug/
> cd /sys/kernel/debug/tracing/
> echo function_graph > current_tracer
> 
> This is because tracing the preempt_disable/enable calls would cause
> trace_clock() which would get local timer to go into infinite recursion
> when enable the arch timer erratum workaround for some chips, so Prevent
> tracing of preempt_disable/enable() in arch_timer_reg_read_stable().
> 
> This problem is similar to the fixed by upstream commit 96b3d28bf4
> ("sched/clock: Prevent tracing recursion in sched_clock_cpu()").

As I mentioned before, the patch itself looks fine to me, but the commit
message is somewhat difficult to read.

Can we please change this to:

  arm64: arch_timer: avoid infinite recursion when ftrace is enabled

  On platforms with an arch timer erratum workaround, it's possible for
  arch_timer_reg_read_stable() to recurse into itself when certain
  tracing options are enabled, leading to stack overflows and related
  problems.
 
  For example, when PREEMPT_TRACER and FUNCTION_GRAPH_TRACER are
  selected, it's possible to trigger this with:
  
  $ mount -t debugfs nodev /sys/kernel/debug/
  $ echo function_graph > /sys/kernel/debug/tracing/current_tracer

  The problem is that in such cases, preempt_disable() instrumentation
  attempts to acquire a timestamp via trace_clock(), resulting in a call
  back to arch_timer_reg_read_stable(), and hence recursion.

  This patch changes arch_timer_reg_read_stable() to use
  preempt_{disable,enable}_notrace(), which avoids this.

With that commit message:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Daniel, Thomas, would you be happy to fold that in when picking this? Or
would you prefer that I fix this up and resend?

Thanks,
Mark.

> Fixes: 6acc71ccac71 ("arm64: arch_timer: Allows a CPU-specific erratum to only affect a subset of CPUs")
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> ---
>  arch/arm64/include/asm/arch_timer.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 74d08e4..67bb7a4 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -65,13 +65,13 @@ struct arch_timer_erratum_workaround {
>  	u64 _val;							\
>  	if (needs_unstable_timer_counter_workaround()) {		\
>  		const struct arch_timer_erratum_workaround *wa;		\
> -		preempt_disable();					\
> +		preempt_disable_notrace();				\
>  		wa = __this_cpu_read(timer_unstable_counter_workaround); \
>  		if (wa && wa->read_##reg)				\
>  			_val = wa->read_##reg();			\
>  		else							\
>  			_val = read_sysreg(reg);			\
> -		preempt_enable();					\
> +		preempt_enable_notrace();				\
>  	} else {							\
>  		_val = read_sysreg(reg);				\
>  	}								\
> -- 
> 1.9.0
> 
> 
