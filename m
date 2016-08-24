From: panand@redhat.com (Pratyush Anand)
Date: Wed, 24 Aug 2016 15:36:44 +0530
Subject: [PATCH] arm64: kprobe: Always clear pstate.D in breakpoint
 exception handler
In-Reply-To: <CAAOGbpwcx3G8Jdf1AfNRLrkZJQLaCcLWQPRppjvpy3=hSrffjg@mail.gmail.com>
References: <1059f6762466c2cebf32aa40e4d7974731a68726.1471848065.git.panand@redhat.com>
 <20160823000531.b12ac14c18ce8e9d3abc74ec@kernel.org>
 <CAAOGbpwcx3G8Jdf1AfNRLrkZJQLaCcLWQPRppjvpy3=hSrffjg@mail.gmail.com>
Message-ID: <20160824100644.GB4408@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sandeepa,

Thanks for the review.

On 23/08/2016:04:33:08 PM, Sandeepa Prabhu wrote:
> Thanks for the fix, feel free to add my ACK as well. Has it been tested on
> guest kernel?

have not tested on guest kernel.Will do.

~Pratyush

> 
> Acked-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
> 
> 
> 
> On Mon, Aug 22, 2016 at 8:35 PM, Masami Hiramatsu <mhiramat@kernel.org>
> wrote:
> 
> > On Mon, 22 Aug 2016 12:16:00 +0530
> > Pratyush Anand <panand@redhat.com> wrote:
> >
> > > Whenever we are hitting a kprobe from a none-kprobe debug exception
> > > handler, we hit an infinite occurrences of "Unexpected kernel single-step
> > > exception at EL1"
> > >
> > > PSTATE.D is debug exception mask bit. It is set whenever we enter into an
> > > exception mode. When it is set then Watchpoint, Breakpoint, and Software
> > > Step exceptions are masked. However, software Breakpoint Instruction
> > > exceptions can never be masked. Therefore, if we ever execute a BRK
> > > instruction, irrespective of D-bit setting, we will be receiving a
> > > corresponding  breakpoint exception.
> > > For example:
> > > - We are executing kprobe pre/post handler, and kprobe has been inserted
> > in
> > >   one of the instruction of a function called by handler. So, it executes
> > >   BRK instruction and we land into the case of KPROBE_REENTER. (This
> > case is
> > >   already handled by current code)
> > > - We are executing uprobe handler or any other BRK handler such as in
> > >   WARN_ON (BRK BUG_BRK_IMM), and we trace that path using kprobe.So, we
> > >   enter into kprobe breakpoint handler,from another BRK handler.(This
> > case
> > >   is not being handled currently)
> > > In all such cases kprobe breakpoint exception will be raised when we were
> > > already in debug exception mode.
> > > SPSR's D bit (bit 9) shows the value of PSTATE.D immediately before the
> > > exception was taken.So, in above example cases we would find it set in
> > > kprobe breakpoint handler.
> > > Single step exception will always be followed by a kprobe breakpoint
> > > exception.However, it will only be raised gracefully if we clear D bit
> > > while returning from breakpoint exception. If D bit is set then, it
> > results
> > > into undefined exception and when it's handler enables dbg then single
> > step
> > > exception is generated, however it will never be handled(because address
> > > does not match and therefore treated as unexpected).
> > > This patch clears D-flag unconditionally in setup_singlestep, so that we
> > > can always get single step exception correctly after returning from
> > > breakpoint exception.
> > > Additionally, it also removes D-flag set statement for KPROBE_REENTER
> > > return path, because debug exception for KPROBE_REENTER will always take
> > > place in a debug exception state. So, D-flag will already be set in this
> > > case.
> >
> > OK, It explains this issue clearly.
> >
> > >
> > > Signed-off-by: Pratyush Anand <panand@redhat.com>
> >
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> >
> > Thanks!
> >
> > > ---
> > >  arch/arm64/kernel/probes/kprobes.c | 29 +++++++++++++----------------
> > >  1 file changed, 13 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/probes/kprobes.c
> > b/arch/arm64/kernel/probes/kprobes.c
> > > index e51f4ad97525..6e13361b9c01 100644
> > > --- a/arch/arm64/kernel/probes/kprobes.c
> > > +++ b/arch/arm64/kernel/probes/kprobes.c
> > > @@ -166,13 +166,18 @@ static void __kprobes set_current_kprobe(struct
> > kprobe *p)
> > >  }
> > >
> > >  /*
> > > - * The D-flag (Debug mask) is set (masked) upon debug exception entry.
> > > - * Kprobes needs to clear (unmask) D-flag -ONLY- in case of recursive
> > > - * probe i.e. when probe hit from kprobe handler context upon
> > > - * executing the pre/post handlers. In this case we return with
> > > - * D-flag clear so that single-stepping can be carried-out.
> > > - *
> > > - * Leave D-flag set in all other cases.
> > > + * When PSTATE.D is set (masked), then software step exceptions can not
> > be
> > > + * generated.
> > > + * SPSR's D bit shows the value of PSTATE.D immediately before the
> > > + * exception was taken. PSTATE.D is set while entering into any
> > exception
> > > + * mode, however software clears it for any normal
> > (none-debug-exception)
> > > + * mode in the exception entry. Therefore, when we are entering into
> > kprobe
> > > + * breakpoint handler from any normal mode then SPSR.D bit is already
> > > + * cleared, however it is set when we are entering from any debug
> > exception
> > > + * mode.
> > > + * Since we always need to generate single step exception after a kprobe
> > > + * breakpoint exception therefore we need to clear it unconditionally,
> > when
> > > + * we become sure that the current breakpoint exception is for kprobe.
> > >   */
> > >  static void __kprobes
> > >  spsr_set_debug_flag(struct pt_regs *regs, int mask)
> > > @@ -245,10 +250,7 @@ static void __kprobes setup_singlestep(struct
> > kprobe *p,
> > >
> > >               set_ss_context(kcb, slot);      /* mark pending ss */
> > >
> > > -             if (kcb->kprobe_status == KPROBE_REENTER)
> > > -                     spsr_set_debug_flag(regs, 0);
> > > -             else
> > > -                     WARN_ON(regs->pstate & PSR_D_BIT);
> > > +             spsr_set_debug_flag(regs, 0);
> > >
> > >               /* IRQs and single stepping do not mix well. */
> > >               kprobes_save_local_irqflag(kcb, regs);
> > > @@ -333,8 +335,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs
> > *regs, unsigned int fsr)
> > >                       BUG();
> > >
> > >               kernel_disable_single_step();
> > > -             if (kcb->kprobe_status == KPROBE_REENTER)
> > > -                     spsr_set_debug_flag(regs, 1);
> > >
> > >               if (kcb->kprobe_status == KPROBE_REENTER)
> > >                       restore_previous_kprobe(kcb);
> > > @@ -457,9 +457,6 @@ kprobe_single_step_handler(struct pt_regs *regs,
> > unsigned int esr)
> > >               kprobes_restore_local_irqflag(kcb, regs);
> > >               kernel_disable_single_step();
> > >
> > > -             if (kcb->kprobe_status == KPROBE_REENTER)
> > > -                     spsr_set_debug_flag(regs, 1);
> > > -
> > >               post_kprobe_handler(kcb, regs);
> > >       }
> > >
> > > --
> > > 2.5.5
> > >
> >
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>
> >
