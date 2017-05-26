From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 26 May 2017 12:26:22 +0100
Subject: Query: arm64: hwbreakpoint: single stepping in case of custom
 overflow_handler
In-Reply-To: <d3b1a128-b97c-7e52-b30c-56ec3990381a@redhat.com>
References: <d3b1a128-b97c-7e52-b30c-56ec3990381a@redhat.com>
Message-ID: <20170526112621.GC21770@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 04:42:33PM +0530, Pratyush Anand wrote:
> Hi Will,
> 
> When we run test from samples/hw_breakpoint/data_breakpoint.c, it
> triggers continuous watchpoint exception handler.
> 
> Reproducer:
> # insmod data_breakpoint.ko ksym=__sysrq_enabled
> # cat /proc/sys/kernel/sysrq
> 
> So, wanted to understand that why do we not allow single stepping in
> case overflow_handler is a customized one and not from perf
> infrastructure?
> 
> Patch [1] allows to work with a custom overflow_handler, but I am
> not sure if that could be an acceptable choice.

Changing this would break userspace, such as GDB, as Will noted last
time this came up:

http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/425363.html

I don't beleive that this is something we can change.

Thanks,
Mark.

> There are issues with samples/hw_breakpoint/data_breakpoint.c, even
> when using patch [1],because overflow_handler  of test calls
> dump_stack(). I am not yet sure,what happened here..my guess is that
> dump_stack() triggered a SW BRK exception somewhere. Anyway,thats a
> secondary problem,I can look into if patch [1] makes sense.
> 
> 
> ~Pratyush
> 
> [1]
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index 749f81779420..ea8ab0656dd0 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -661,7 +661,7 @@ static int breakpoint_handler(unsigned long
> unused, unsigned int esr,
>                 perf_bp_event(bp, regs);
> 
>                 /* Do we need to handle the stepping? */
> -               if (is_default_overflow_handler(bp))
> +               if (bp->overflow_handler)
>                         step = 1;
>  unlock:
>                 rcu_read_unlock();
> @@ -789,7 +789,7 @@ static int watchpoint_handler(unsigned long
> addr, unsigned int esr,
>                 perf_bp_event(wp, regs);
> 
>                 /* Do we need to handle the stepping? */
> -               if (is_default_overflow_handler(wp))
> +               if (wp->overflow_handler)
>                         step = 1;
>         }
>         if (min_dist > 0 && min_dist != -1) {
> @@ -800,7 +800,7 @@ static int watchpoint_handler(unsigned long
> addr, unsigned int esr,
>                 perf_bp_event(wp, regs);
> 
>                 /* Do we need to handle the stepping? */
> -               if (is_default_overflow_handler(wp))
> +               if (wp->overflow_handler)
>                         step = 1;
>         }
>         rcu_read_unlock();
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
