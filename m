From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Feb 2016 17:56:56 +0000
Subject: KASAN issues with idle / hotplug area (was: Re: [PATCH v5sub1
 7/8] arm64: move kernel image to base of vmalloc area)
In-Reply-To: <20160217170110.GE32647@leverpostej>
References: <20160212151006.GJ31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
 <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
 <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
 <56C31D1D.50708@virtuozzo.com> <20160217143950.GC32647@leverpostej>
 <20160217170110.GE32647@leverpostej>
Message-ID: <20160217175656.GJ32647@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 05:01:11PM +0000, Mark Rutland wrote:
> On Wed, Feb 17, 2016 at 02:39:51PM +0000, Mark Rutland wrote:
> > Perhaps the simplest option is to not instrument invoke_psci_fn_* and
> > psci_suspend_finisher. Do we have a per-function annotation to avoid
> > KASAN instrumentation, like notrace? I need to investigate, but we may
> > also need notrace for similar reasons.
>
> I came up with the patch below, per the reasoning above.
> 
> It _changes_ the KASAN splats (I see errors in tick_program_event rather
> than find_busiest_group), but doesn't seem to get rid of them. I'm not
> sure if I've missed something, or if we also have another latent issue.
> 
> Ideas?

I'd missed annotating __cpu_suspend_save. I've fixed that up locally
(along with s/virt_to_phys/__virt_to_phys due to the inlining issue).

I'm still missing somehing; I'm getting KASAN warnings in find_busiest_group
again, and the shadow looks like it's corrupt (the second batch of f3 /
KASAN_STACK_RIGHT don't have a matching f1 / KASAN_STACK_LEFT):

[   13.138791] Memory state around the buggy address:
[   13.143624]  ffffffc936a7fb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   13.150929]  ffffffc936a7fc00: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00
[   13.158232] >ffffffc936a7fc80: f3 f3 f3 f3 00 00 00 00 00 f4 f4 f4 f3 f3 f3 f3
[   13.165530]                       ^
[   13.169066]  ffffffc936a7fd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   13.176369]  ffffffc936a7fd80: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1

This is turning into a whack-a-mole game...

Mark.

> ---->8----
> From 8f7ae44d8f8862f5300483d45617b5bd05fc652f Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Wed, 17 Feb 2016 15:38:22 +0000
> Subject: [PATCH] arm64/psci: avoid KASAN splats with idle
> 
> When a CPU goes into a deep idle state, we store CPU context in
> __cpu_suspend_enter, then call psci_suspend_finisher to invoke the
> firmware. If we entered a deep idle state, we do not return directly,
> and instead start cold, restoring state in cpu_resume.
> 
> Thus we may execute the prologue and body of psci_suspend_finisher and
> the PSCI invocation function, but not their epilogue. When using KASAN
> this means that we poison a region of shadow memory, but never unpoison
> it. After we resume, subsequent stack accesses may hit the stale poison
> values, leading to false positives from KASAN.
> 
> To avoid this, we must ensure that functions called after the context
> save are not instrumented, and do not posion the shadow region, by
> annotating them with __no_sanitize_address. As common inlines they may
> call are not similarly annotated, and the compiler refuses to allow
> function attribute mismatches, we must also avoid calls to such
> functions.
> 
> ARM is not affected, as it does not support KASAN. When CONFIG_KASAN is
> not selected, __no_sanitize_address expands to nothing, so the
> annotation should not be harmful.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/kernel/psci.c | 14 ++++++++------
>  drivers/firmware/psci.c  |  3 +++
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index f67f35b..8324ce8 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -32,12 +32,16 @@
>  
>  static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
>  
> +static phys_addr_t cpu_resume_phys;
> +
>  static int __maybe_unused cpu_psci_cpu_init_idle(unsigned int cpu)
>  {
>  	int i, ret, count = 0;
>  	u32 *psci_states;
>  	struct device_node *state_node, *cpu_node;
>  
> +	cpu_resume_phys = virt_to_phys(cpu_resume);
> +
>  	cpu_node = of_get_cpu_node(cpu, NULL);
>  	if (!cpu_node)
>  		return -ENODEV;
> @@ -178,12 +182,10 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
>  }
>  #endif
>  
> -static int psci_suspend_finisher(unsigned long index)
> +__no_sanitize_address
> +static int psci_suspend_finisher(unsigned long state)
>  {
> -	u32 *state = __this_cpu_read(psci_power_state);
> -
> -	return psci_ops.cpu_suspend(state[index - 1],
> -				    virt_to_phys(cpu_resume));
> +	return psci_ops.cpu_suspend(state, cpu_resume_phys);
>  }
>  
>  static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
> @@ -200,7 +202,7 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
>  	if (!psci_power_state_loses_context(state[index - 1]))
>  		ret = psci_ops.cpu_suspend(state[index - 1], 0);
>  	else
> -		ret = cpu_suspend(index, psci_suspend_finisher);
> +		ret = cpu_suspend(state[index - 1], psci_suspend_finisher);
>  
>  	return ret;
>  }
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index f25cd79..e4e8dc1 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -106,6 +106,7 @@ bool psci_power_state_is_valid(u32 state)
>  	return !(state & ~valid_mask);
>  }
>  
> +__no_sanitize_address
>  static unsigned long __invoke_psci_fn_hvc(unsigned long function_id,
>  			unsigned long arg0, unsigned long arg1,
>  			unsigned long arg2)
> @@ -116,6 +117,7 @@ static unsigned long __invoke_psci_fn_hvc(unsigned long function_id,
>  	return res.a0;
>  }
>  
> +__no_sanitize_address
>  static unsigned long __invoke_psci_fn_smc(unsigned long function_id,
>  			unsigned long arg0, unsigned long arg1,
>  			unsigned long arg2)
> @@ -148,6 +150,7 @@ static u32 psci_get_version(void)
>  	return invoke_psci_fn(PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0);
>  }
>  
> +__no_sanitize_address
>  static int psci_cpu_suspend(u32 state, unsigned long entry_point)
>  {
>  	int err;
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
