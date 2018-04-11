From: ji.zhang@mediatek.com (Ji.Zhang)
Date: Wed, 11 Apr 2018 14:30:28 +0800
Subject: [PATCH] arm64: avoid race condition issue in dump_backtrace
In-Reply-To: <20180409112559.uh76jpiytznymw6w@lakrids.cambridge.arm.com>
References: <1521687960-3744-1-git-send-email-ji.zhang@mediatek.com>
 <20180322055929.z25brvwlmdighz66@salmiak>
 <1521711329.26617.31.camel@mtksdccf07>
 <20180326113932.2i6qp3776jtmcqk4@lakrids.cambridge.arm.com>
 <1522229612.26617.47.camel@mtksdccf07>
 <20180328101240.moo44g5qd3qjuxgn@lakrids.cambridge.arm.com>
 <1522397292.26617.63.camel@mtksdccf07>
 <20180404090431.rqwtaqovipxa5gta@lakrids.cambridge.arm.com>
 <1523174328.26617.91.camel@mtksdccf07>
 <20180409112559.uh76jpiytznymw6w@lakrids.cambridge.arm.com>
Message-ID: <1523428228.26617.100.camel@mtksdccf07>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-04-09 at 12:26 +0100, Mark Rutland wrote:
> On Sun, Apr 08, 2018 at 03:58:48PM +0800, Ji.Zhang wrote:
> > Yes, I see where the loop is, I have missed that the loop may cross
> > different stacks.
> > Define a nesting order and check against is a good idea, and it can
> > resolve the issue exactly, but as you mentioned before, we have no idea
> > how to handle with overflow and sdei stack, and the nesting order is
> > strongly related with the scenario of the stack, which means if someday
> > we add another stack, we should consider the relationship of the new
> > stack with other stacks. From the perspective of your experts, is that
> > suitable for doing this in unwind?
> > 
> > Or could we just find some way easier but not so accurate, eg.
> > Proposal 1: 
> > When we do unwind and detect that the stack spans, record the last fp of
> > previous stack and next time if we get into the same stack, compare it
> > with that last fp, the new fp should still smaller than last fp, or
> > there should be potential loop.
> > For example, when we unwind from irq to task, we record the last fp in
> > irq stack such as last_irq_fp, and if it unwind task stack back to irq
> > stack, no matter if it is the same irq stack with previous, just let it
> > go and compare the new irq fp with last_irq_fp, although the process may
> > be wrong since from task stack it could not unwind to irq stack, but the
> > whole process will eventually stop.
> 
> I agree that saving the last fp per-stack could work.
> 
> > Proposal 2:
> > So far we have four types of stack: task, irq, overflow and sdei, could
> > we just assume that the MAX number of stack spanning is just 3
> > times?(task->irq->overflow->sdei or task->irq->sdei->overflow), if yes,
> > we can just check the number of stack spanning when we detect the stack
> > spans.
> 
> I also agree that counting the number of stack transitions will prevent
> an inifinite loop, even if less accurately than proposal 1.
> 
> I don't have a strong preference either way.
Thank you for your comment.
Compared with proposal 1 and 2, I decide to use proposal2 since
proposal1 seems a little complicated and it is not as easy as proposal2
when new stack is added.
The sample is as below:
diff --git a/arch/arm64/include/asm/stacktrace.h
b/arch/arm64/include/asm/stacktrace.h
index 902f9ed..72d1f34 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -92,4 +92,22 @@ static inline bool on_accessible_stack(struct
task_struct *tsk, unsigned long sp
        return false;
 }
 
+#define MAX_STACK_SPAN 3
+DECLARE_PER_CPU(int, num_stack_span);
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
index d5718a0..db905e8 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -27,6 +27,8 @@
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 
+DEFINE_PER_CPU(int, num_stack_span);
+
 /*
  * AArch64 PCS assigns the frame pointer to x29.
  *
@@ -56,6 +58,20 @@ int notrace unwind_frame(struct task_struct *tsk,
struct stackframe *frame)
        frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
        frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
 
+       if (!on_same_stack(tsk, fp, frame->fp)) {
+               int num = (int)__this_cpu_read(num_stack_span);
+
+               if (num >= MAX_STACK_SPAN)
+                       return -EINVAL;
+               num++;
+               __this_cpu_write(num_stack_span, num);
+               fp = frame->fp + 0x8;
+       }
+       if (fp <= frame->fp) {
+               pr_notice("fp invalid, stop unwind\n");
+               return -EINVAL;
+       }
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
        if (tsk->ret_stack &&
                        (frame->pc == (unsigned long)return_to_handler))
{
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index eb2d151..e6b5181 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -102,6 +102,8 @@ void dump_backtrace(struct pt_regs *regs, struct
task_struct *tsk)
        struct stackframe frame;
        int skip;
 
+       __this_cpu_write(num_stack_span, 0);
+
        pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
 
        if (!tsk)
@@ -144,6 +146,7 @@ void dump_backtrace(struct pt_regs *regs, struct
task_struct *tsk)
        } while (!unwind_frame(tsk, &frame));
 
        put_task_stack(tsk);
+       __this_cpu_write(num_stack_span, 0);
 }
 
 void show_stack(struct task_struct *tsk, unsigned long *sp)
-- 
1.9.1

If that is ok then I will submit a new patch.

Best Regards,
Ji
> 
> Thanks,
> Mark.
