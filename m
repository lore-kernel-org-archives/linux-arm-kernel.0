From: panand@redhat.com (Pratyush Anand)
Date: Wed, 3 Aug 2016 17:52:55 +0530
Subject: [PATCH 3/4] arm64: kprobes: WARN if attempting to step with
 PSTATE.D=1
In-Reply-To: <1468937260-23988-3-git-send-email-will.deacon@arm.com>
References: <1468937260-23988-1-git-send-email-will.deacon@arm.com>
 <1468937260-23988-3-git-send-email-will.deacon@arm.com>
Message-ID: <CAHB_Guonf6qc-yCr2oKDZgX+5q7qXJpSpLU3qafChrBkBqk7FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Its already in torvalds/linux.git: master now. I have some related
queries, so thought to discuss it here.

On Tue, Jul 19, 2016 at 7:37 PM, Will Deacon <will.deacon@arm.com> wrote:
> Stepping with PSTATE.D=1 is bad news. The step won't generate a debug
> exception and we'll likely walk off into random data structures. This
> should never happen, but when it does, it's a PITA to debug. Add a

But it happens in many know scenarios, like:

1) We are executing a WARN_ON(), which will call `BRK  BUG_BRK_IMM`.
It prints warning messages through breakpoint handler. Now, suppose we
have a kprobe instrumented at a print function branch, say
print_worker_info(), we will land into
kprobe_handler()->setup_singlestep() with D-bit set. In this case if
we do not clear it, then we receive undefined exception before we
could get single step exception.

2) Similarly, if we instrument kprobe at uprobe_breakpoint_handler()
(code not yet in upstream),  we land into similar situation which
leads to infinite "Unexpected kernel single-step exception at EL1".

So, why can't we clear PSR_D_BIT in setup_singlestep unconditionally?
I found that both of the above issue is resolved by doing that.

~Pratyush

> WARN_ON to shout if we realise this is about to take place.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/probes/kprobes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 9c70e8812ea9..c89811d1e294 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -254,6 +254,8 @@ static void __kprobes setup_singlestep(struct kprobe *p,
>
>                 if (kcb->kprobe_status == KPROBE_REENTER)
>                         spsr_set_debug_flag(regs, 0);
> +               else
> +                       WARN_ON(regs->pstate & PSR_D_BIT);
>
>                 /* IRQs and single stepping do not mix well. */
>                 kprobes_save_local_irqflag(kcb, regs);
> --
> 2.1.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
