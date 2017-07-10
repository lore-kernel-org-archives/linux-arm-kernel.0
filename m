From: guohanjun@huawei.com (Hanjun Guo)
Date: Mon, 10 Jul 2017 14:12:29 +0800
Subject: [PATCH RESEND] arm64: arch_timer: fix the infinite recursion when
 enable ftrace and erratum workaround
In-Reply-To: <321e4c16-aa14-beee-b6dc-36e19e5ec35a@huawei.com>
References: <321e4c16-aa14-beee-b6dc-36e19e5ec35a@huawei.com>
Message-ID: <59631ACD.4020103@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/7/9 16:30, Ding Tianhong wrote:
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
>
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

This fixes my system hang issue when I using function tracer with
enabled timer errata on D03,

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
