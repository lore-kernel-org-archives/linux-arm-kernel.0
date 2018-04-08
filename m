From: ji.zhang@mediatek.com (Ji.Zhang)
Date: Sun, 8 Apr 2018 15:58:48 +0800
Subject: [PATCH] arm64: avoid race condition issue in dump_backtrace
In-Reply-To: <20180404090431.rqwtaqovipxa5gta@lakrids.cambridge.arm.com>
References: <1521687960-3744-1-git-send-email-ji.zhang@mediatek.com>
 <20180322055929.z25brvwlmdighz66@salmiak>
 <1521711329.26617.31.camel@mtksdccf07>
 <20180326113932.2i6qp3776jtmcqk4@lakrids.cambridge.arm.com>
 <1522229612.26617.47.camel@mtksdccf07>
 <20180328101240.moo44g5qd3qjuxgn@lakrids.cambridge.arm.com>
 <1522397292.26617.63.camel@mtksdccf07>
 <20180404090431.rqwtaqovipxa5gta@lakrids.cambridge.arm.com>
Message-ID: <1523174328.26617.91.camel@mtksdccf07>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-04-04 at 10:04 +0100, Mark Rutland wrote:
> On Fri, Mar 30, 2018 at 04:08:12PM +0800, Ji.Zhang wrote:
> > On Wed, 2018-03-28 at 11:12 +0100, Mark Rutland wrote:
> > > On Wed, Mar 28, 2018 at 05:33:32PM +0800, Ji.Zhang wrote:
> > > 
> > > I'm very much not keen on this.
> > > 
> > > I think that if we're going to do this, the only sane way to do it is to
> > > have unwind_frame() verify the current fp against the previous one, and
> > > verify that we have some strict nesting of stacks. Generally, that means
> > > we can go:
> > > 
> > >   overflow -> irq -> task
> > > 
> > > ... though I'm not sure what to do about the SDEI stack vs the overflow
> > > stack.
> > Actually I have had the fp check in unwind_frame(), but since I use the
> > in_entry_text() to determine if stack spans, and I did not want to
> > include traps.h in stacktrace.c, so I move the check out to
> > dump_backtrace.
> > Anyway, It seems that the key point is how should we verify that there
> > are some nesting of stacks. Since in unwind_frame() we already have the
> > previous fp and current fp, could we assume that if these two fps are
> > NOT belong to the same stack, there should be stack spans (no matter
> > task->irq, or irq->overflow, etc), and we can do the tricky to bypass
> > the fp check.The sample of the prosal just like:
> 
> Unfortuantely, this still allows for loops, like task -> irq -> task, so
> I think if we're going to try to fix this, we must define a nesting
> order and check against that.
Yes, I see where the loop is, I have missed that the loop may cross
different stacks.
Define a nesting order and check against is a good idea, and it can
resolve the issue exactly, but as you mentioned before, we have no idea
how to handle with overflow and sdei stack, and the nesting order is
strongly related with the scenario of the stack, which means if someday
we add another stack, we should consider the relationship of the new
stack with other stacks. From the perspective of your experts, is that
suitable for doing this in unwind?

Or could we just find some way easier but not so accurate, eg.
Proposal 1: 
When we do unwind and detect that the stack spans, record the last fp of
previous stack and next time if we get into the same stack, compare it
with that last fp, the new fp should still smaller than last fp, or
there should be potential loop.
For example, when we unwind from irq to task, we record the last fp in
irq stack such as last_irq_fp, and if it unwind task stack back to irq
stack, no matter if it is the same irq stack with previous, just let it
go and compare the new irq fp with last_irq_fp, although the process may
be wrong since from task stack it could not unwind to irq stack, but the
whole process will eventually stop.

Proposal 2:
So far we have four types of stack: task, irq, overflow and sdei, could
we just assume that the MAX number of stack spanning is just 3
times?(task->irq->overflow->sdei or task->irq->sdei->overflow), if yes,
we can just check the number of stack spanning when we detect the stack
spans.

Best Regards,
Ji
> 
> Thanks,
> Mark.
> 
> > diff --git a/arch/arm64/include/asm/stacktrace.h
> > b/arch/arm64/include/asm/stacktrace.h
> > index 902f9ed..fc2bf4d 100644
> > --- a/arch/arm64/include/asm/stacktrace.h
> > +++ b/arch/arm64/include/asm/stacktrace.h
> > @@ -92,4 +92,18 @@ static inline bool on_accessible_stack(struct
> > task_struct *tsk, unsigned long sp
> >         return false;
> >  }
> > 
> > +static inline bool on_same_stack(struct task_struct *tsk, unsigned long
> > sp1, unsigned sp2)
> > +{
> > +       if (on_task_stack(tsk, sp1) && on_task_stack(tsk, sp2))
> > +               return true;
> > +       if (on_irq_stack(sp1) && on_irq_stack(sp2))
> > +               return true;
> > +       if (on_overflow_stack(sp1) && on_overflow_stack(sp2))
> > +               return true;
> > +       if (on_sdei_stack(sp1) && on_sdei_stack(sp2))
> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> >  #endif /* __ASM_STACKTRACE_H */
> > diff --git a/arch/arm64/kernel/stacktrace.c
> > b/arch/arm64/kernel/stacktrace.c
> > index d5718a0..4907a67 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -56,6 +56,13 @@ int notrace unwind_frame(struct task_struct *tsk,
> > struct stackframe *frame)
> >         frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
> >         frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
> > 
> > +       if (!on_same_stack(fp, frame->fp))
> > +               fp = frame->fp + 0x8;
> > +       if (fp <= frame->fp) {
> > +               pr_notice("fp invalid, stop unwind\n");
> > +               return -EINVAL;
> > +       }
> > +
> >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >         if (tsk->ret_stack &&
> >                         (frame->pc == (unsigned long)return_to_handler))
> > {
> > 
> > Could this work?
> > 
> > Best Regards,
> > Ji
> > 
