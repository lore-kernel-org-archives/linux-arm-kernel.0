From: ji.zhang@mediatek.com (Ji.Zhang)
Date: Thu, 12 Apr 2018 14:13:13 +0800
Subject: [PATCH] arm64: avoid race condition issue in dump_backtrace
In-Reply-To: <20180411104656.4afhb4durpntxqxl@lakrids.cambridge.arm.com>
References: <20180322055929.z25brvwlmdighz66@salmiak>
 <1521711329.26617.31.camel@mtksdccf07>
 <20180326113932.2i6qp3776jtmcqk4@lakrids.cambridge.arm.com>
 <1522229612.26617.47.camel@mtksdccf07>
 <20180328101240.moo44g5qd3qjuxgn@lakrids.cambridge.arm.com>
 <1522397292.26617.63.camel@mtksdccf07>
 <20180404090431.rqwtaqovipxa5gta@lakrids.cambridge.arm.com>
 <1523174328.26617.91.camel@mtksdccf07>
 <20180409112559.uh76jpiytznymw6w@lakrids.cambridge.arm.com>
 <1523428228.26617.100.camel@mtksdccf07>
 <20180411104656.4afhb4durpntxqxl@lakrids.cambridge.arm.com>
Message-ID: <1523513593.26617.106.camel@mtksdccf07>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-04-11 at 11:46 +0100, Mark Rutland wrote:
> On Wed, Apr 11, 2018 at 02:30:28PM +0800, Ji.Zhang wrote:
> > On Mon, 2018-04-09 at 12:26 +0100, Mark Rutland wrote:
> > > On Sun, Apr 08, 2018 at 03:58:48PM +0800, Ji.Zhang wrote:
> > > > Yes, I see where the loop is, I have missed that the loop may cross
> > > > different stacks.
> > > > Define a nesting order and check against is a good idea, and it can
> > > > resolve the issue exactly, but as you mentioned before, we have no idea
> > > > how to handle with overflow and sdei stack, and the nesting order is
> > > > strongly related with the scenario of the stack, which means if someday
> > > > we add another stack, we should consider the relationship of the new
> > > > stack with other stacks. From the perspective of your experts, is that
> > > > suitable for doing this in unwind?
> > > > 
> > > > Or could we just find some way easier but not so accurate, eg.
> > > > Proposal 1: 
> > > > When we do unwind and detect that the stack spans, record the last fp of
> > > > previous stack and next time if we get into the same stack, compare it
> > > > with that last fp, the new fp should still smaller than last fp, or
> > > > there should be potential loop.
> > > > For example, when we unwind from irq to task, we record the last fp in
> > > > irq stack such as last_irq_fp, and if it unwind task stack back to irq
> > > > stack, no matter if it is the same irq stack with previous, just let it
> > > > go and compare the new irq fp with last_irq_fp, although the process may
> > > > be wrong since from task stack it could not unwind to irq stack, but the
> > > > whole process will eventually stop.
> > > 
> > > I agree that saving the last fp per-stack could work.
> > > 
> > > > Proposal 2:
> > > > So far we have four types of stack: task, irq, overflow and sdei, could
> > > > we just assume that the MAX number of stack spanning is just 3
> > > > times?(task->irq->overflow->sdei or task->irq->sdei->overflow), if yes,
> > > > we can just check the number of stack spanning when we detect the stack
> > > > spans.
> > > 
> > > I also agree that counting the number of stack transitions will prevent
> > > an inifinite loop, even if less accurately than proposal 1.
> > > 
> > > I don't have a strong preference either way.
> > Thank you for your comment.
> > Compared with proposal 1 and 2, I decide to use proposal2 since
> > proposal1 seems a little complicated and it is not as easy as proposal2
> > when new stack is added.
> > The sample is as below:
> > diff --git a/arch/arm64/include/asm/stacktrace.h
> > b/arch/arm64/include/asm/stacktrace.h
> > index 902f9ed..72d1f34 100644
> > --- a/arch/arm64/include/asm/stacktrace.h
> > +++ b/arch/arm64/include/asm/stacktrace.h
> > @@ -92,4 +92,22 @@ static inline bool on_accessible_stack(struct
> > task_struct *tsk, unsigned long sp
> >         return false;
> >  }
> >  
> > +#define MAX_STACK_SPAN 3
> 
> Depending on configuration we can have:
> 
> * task
> * irq
> * overflow (optional with VMAP_STACK)
> * sdei (optional with ARM_SDE_INTERFACE && VMAP_STACK)
> 
> So 3 isn't always correct.
> 
> Also, could we please call this something like MAX_NR_STACKS?
> 
> > +DECLARE_PER_CPU(int, num_stack_span);
> 
> I'm pretty sure we can call unwind_frame() in a preemptible context, so
> this isn't safe.
> 
> Put this counter into the struct stackframe, and call it something like
> nr_stacks;
> 
> [...]
> 
> > +DEFINE_PER_CPU(int, num_stack_span);
> 
> As above, this can go.
> 
> > +
> >  /*
> >   * AArch64 PCS assigns the frame pointer to x29.
> >   *
> > @@ -56,6 +58,20 @@ int notrace unwind_frame(struct task_struct *tsk,
> > struct stackframe *frame)
> >         frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
> >         frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
> >  
> > +       if (!on_same_stack(tsk, fp, frame->fp)) {
> > +               int num = (int)__this_cpu_read(num_stack_span);
> > +
> > +               if (num >= MAX_STACK_SPAN)
> > +                       return -EINVAL;
> > +               num++;
> > +               __this_cpu_write(num_stack_span, num);
> > +               fp = frame->fp + 0x8;
> > +       }
> > +       if (fp <= frame->fp) {
> > +               pr_notice("fp invalid, stop unwind\n");
> > +               return -EINVAL;
> > +       }
> 
> I think this can be simplified to something like:
> 
> 	bool same_stack;
> 
> 	same_stack = on_same_stack(tsk, fp, frame->fp);
> 
> 	if (fp <= frame->fp && same_stack)
> 		return -EINVAL;
> 	if (!same_stack && ++frame->nr_stacks > MAX_NR_STACKS)
> 		return -EINVAL;
> 
> ... assuming we add nr_stacks to struct stackframe.
Thank you very much for your advice, they are very valuable.
According to your suggestion, the modified code as follows.
I did a little change that define MAX_NR_STACKS as the number of stacks,
instead of the number of stack spans.

diff --git a/arch/arm64/include/asm/stacktrace.h
b/arch/arm64/include/asm/stacktrace.h
index 902f9ed..f235b86 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -24,9 +24,18 @@
 #include <asm/ptrace.h>
 #include <asm/sdei.h>
 
+#ifndef CONFIG_VMAP_STACK
+#define MAX_NR_STACKS  2
+#elif !defined(CONFIG_ARM_SDE_INTERFACE)
+#define MAX_NR_STACKS  3
+#else
+#define MAX_NR_STACKS  4
+#endif
+
 struct stackframe {
        unsigned long fp;
        unsigned long pc;
+       int nr_stacks;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
        int graph;
 #endif
@@ -92,4 +101,20 @@ static inline bool on_accessible_stack(struct
task_struct *tsk, unsigned long sp
        return false;
 }
 
+
+static inline bool on_same_stack(struct task_struct *tsk,
+                               unsigned long sp1, unsigned long sp2)
+{
+       if (on_task_stack(tsk, sp1) && on_task_stack(tsk, sp2))
+               return true;
+       if (on_irq_stack(sp1) && on_irq_stack(sp2))
+               return true;
+       if (on_overflow_stack(sp1) && on_overflow_stack(sp2))
+               return true;
+       if (on_sdei_stack(sp1) && on_sdei_stack(sp2))
+               return true;
+
+       return false;
+}
+
 #endif /* __ASM_STACKTRACE_H */
diff --git a/arch/arm64/kernel/stacktrace.c
b/arch/arm64/kernel/stacktrace.c
index d5718a0..a09e247 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -27,6 +27,7 @@
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 
+
 /*
  * AArch64 PCS assigns the frame pointer to x29.
  *
@@ -43,6 +44,7 @@
 int notrace unwind_frame(struct task_struct *tsk, struct stackframe
*frame)
 {
        unsigned long fp = frame->fp;
+       bool same_stack;
 
        if (fp & 0xf)
                return -EINVAL;
@@ -56,6 +58,13 @@ int notrace unwind_frame(struct task_struct *tsk,
struct stackframe *frame)
        frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
        frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
 
+       same_stack = on_same_stack(tsk, fp, frame->fp);
+
+       if (fp <= frame->fp && same_stack)
+               return -EINVAL;
+       if (!same_stack && ++frame->nr_stacks > MAX_NR_STACKS)
+               return -EINVAL;
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
        if (tsk->ret_stack &&
                        (frame->pc == (unsigned long)return_to_handler))
{
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index eb2d151..3b1c472 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -120,6 +120,7 @@ void dump_backtrace(struct pt_regs *regs, struct
task_struct *tsk)
                frame.fp = thread_saved_fp(tsk);
                frame.pc = thread_saved_pc(tsk);
        }
+       frame.nr_stacks = 1;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
        frame.graph = tsk->curr_ret_stack;
 #endif
-- 
1.9.1

Best Regards,
Ji
