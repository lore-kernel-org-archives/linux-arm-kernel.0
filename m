From: tim.bird@am.sony.com (Tim Bird)
Date: Tue, 15 Feb 2011 17:39:21 -0800
Subject: Question about ARM function graph tracing
In-Reply-To: <4D4C61A5.4050403@am.sony.com>
References: <4D4B3D63.4090207@am.sony.com>	<AANLkTinoFRE2ho9u9yF5nhfgr1gGouHV3anf2OX0mN2T@mail.gmail.com>
	<4D4C61A5.4050403@am.sony.com>
Message-ID: <4D5B2AC9.3030502@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2011 12:29 PM, Tim Bird wrote:
>> OMAP is missing a notrace annotation on omap_readl():
>>
>> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg38911.html
>>
>> Part of that patch was merged through rmk's work, but the
>> omap_readl() annotation seems to have been missed.
> Yep.  It's missing in 2.6.38-rc3.
> 
>> Also, if this is OMAP1 and not latest mainline, I think you
>> will need  a notrace on omap_rev() also (called from inside
>> omap_readl() until recently).
> 
> I couldn't find that in the sched_clock code paths, but
> I 'notrace'd it anyways.
> 
>>
>> I think this is most probably what is wrong, since IIRC I saw
>> crashes like this on BeagleBoard before I added the notrace on
>> omap_readl.  Could you please try with these changes?
> 
> I have sprinkled 'notrace's liberally throughout the sched_clock
> code (including omap_readl() and omap_rev()), and I'm still
> seeing problems.  I put a recursion guard in
> prepare_ftrace_return, and I'm seeing lots of recursion.  So
> there's still a notrace missing somewhere.

OK.  The notrace was indeed missing fro omap_readl(), but fixing
this did not completely fix the problem.  I put the following
(crude) recursion guard in arch/arm/kernel/ftrace.c:prepare_ftrace_return:

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index c0062ad..5872c25 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -209,6 +209,8 @@ int __init ftrace_dyn_arch_init(void *data)
 #endif /* CONFIG_DYNAMIC_FTRACE */

 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
+static int already_here = 0;
+
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
                           unsigned long frame_pointer)
 {
@@ -217,8 +219,16 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_a
        unsigned long old;
        int err;

-       if (unlikely(atomic_read(&current->tracing_graph_pause)))
+       if(unlikely(already_here)) {
                return;
+       } else {
+               already_here=1;
+       }
+
+       if (unlikely(atomic_read(&current->tracing_graph_pause))) {
+               already_here=0;
+               return;
+       }

        old = *parent;
        *parent = return_hooker;
@@ -227,6 +237,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_ad
                                       frame_pointer);
        if (err == -EBUSY) {
                *parent = old;
+               already_here=0;
                return;
        }

@@ -237,6 +248,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_ad
                current->curr_ret_stack--;
                *parent = old;
        }
+       already_here=0;
 }

 #ifdef CONFIG_DYNAMIC_FTRACE

Without this, the system hangs for long periods of time after starting
the function graph tracer (echo function_graph >/debug/tracing/current_tracer)
Sometimes the system comes back and sometimes it doesn't.  With the above
code, the system works, and I can get traces (but obviously I'm dumping
a bunch of tracepoints whenever the tracer nests.)

I put some extra instrumentation in, and MOST of the time, the item
causing nesting is asm_do_IRQ(), which is to be expected.  However,
I have seen a recursion from preempt_schedule(), which I didn't really
expect.  Does the tracer invoke anything that would cause a schedule
from inside the trace-recording code?

Should I try this with CONFIG_PREEMPT off? (It's currently on.)

Any ideas for debugging this would be appreciated.
 -- Tim


=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Network Entertainment
=============================
