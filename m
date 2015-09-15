From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Sep 2015 15:39:53 +0100
Subject: [PATCH 1/2] arm64: fpsimd: Fix FPSIMD corruption in rt_sigreturn
 with CONFIG_PREEMPT
In-Reply-To: <CAKv+Gu8Yt0T6AF7MmOtpPpk8VcDBVraSNMbgm03dW5BR1QMqsA@mail.gmail.com>
References: <1442316997-32282-1-git-send-email-will.deacon@arm.com>
 <CAKv+Gu8Yt0T6AF7MmOtpPpk8VcDBVraSNMbgm03dW5BR1QMqsA@mail.gmail.com>
Message-ID: <20150915143952.GE31157@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 01:11:10PM +0100, Ard Biesheuvel wrote:
> Hi Will,

Hi Ard,

Thanks for having a look.

> On 15 September 2015 at 13:36, Will Deacon <will.deacon@arm.com> wrote:
> > From: Dave P Martin <Dave.Martin@arm.com>
> >
> > The arm64 context switch implementation uses a flag
> > TIF_FOREIGN_FPSTATE to track whether the hardware FPSIMD regs are
> > out of sync with the logical state of current's registers.
> >
> > During sigreturn, the registers and task_struct are temporarily out
> > of sync, between writing the task_struct and loading its contents
> > back into the FPSIMD registers -- however, TIF_FOREIGN_FPSTATE is
> > not set.  This can cause the context switch code to discard some or
> > all of the restored FPSIMD state if preemption occurs during the
> > critical region of rt_sigreturn.
> >
> > This patch sets TIF_FOREIGN_FPSTATE before transferring the
> > sigframe's saved registers back to the task_struct, so that the
> > task_struct data will take precedence over the hardware registers
> > if a context switch occurs before everything is back in sync.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > [will: removed preempt_{enable,disable} calls, added compat version]
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/signal.c   | 3 +++
> >  arch/arm64/kernel/signal32.c | 2 ++
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> > index e18c48cb6db1..6d50d839b6e9 100644
> > --- a/arch/arm64/kernel/signal.c
> > +++ b/arch/arm64/kernel/signal.c
> > @@ -79,6 +79,9 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
> >         if (magic != FPSIMD_MAGIC || size != sizeof(struct fpsimd_context))
> >                 return -EINVAL;
> >
> > +       /* Ensure we don't reload stale data from the hardware registers */
> > +       set_ti_thread_flag(current_thread_info(), TIF_FOREIGN_FPSTATE);
> > +
> >         /* copy the FP and status/control registers */
> >         err = __copy_from_user(fpsimd.vregs, ctx->vregs,
> >                                sizeof(fpsimd.vregs));
> 
> I am not following something here. If the task gets preempted before
> the call to fpsimd_update_current_state(), it will proceed to
> overwrite the registers with whatever is on the stack in fpsimd after
> being scheduled back in, and everything should work fine, right?.

You're completely right, sorry for wasting your time. Dave and I have
been working on the fpsimd code recently and have another patch that
restores the state directly into the current thread to avoid the stack
entirely. *That* is what caused this problem, and I incorrectly
identified this as a fix for mainline (it's extremely similar to
2af276dfb172 ("ARM: 7306/1: vfp: flush thread hwstate before restoring
context from sigframe"), which continues to haunt me).

Anyway, that also explains why we hadn't seen any problems in our
previous testing! The second patch (compat big-endian fix) still stands,
however.

Will
