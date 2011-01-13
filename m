From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jan 2011 23:11:36 +0000
Subject: SMP: BUG() on cat /proc/$PID/stack
In-Reply-To: <AANLkTinSNPC7+m1Uie5hbUW_hgPecAK=RRGKkMx2AqOm@mail.gmail.com>
References: <AANLkTinSNPC7+m1Uie5hbUW_hgPecAK=RRGKkMx2AqOm@mail.gmail.com>
Message-ID: <20110113231136.GF24149@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 12:24:19AM +0530, Rabin Vincent wrote:
> On SMP, this BUG() in save_stack_trace_tsk() can be easily triggered
> from user space by reading /proc/$PID/stack, where $PID is any pid but
> the current process:
> 
>         if (tsk != current) {
> #ifdef CONFIG_SMP
>                 /*
>                  * What guarantees do we have here that 'tsk'
>                  * is not running on another CPU?
>                  */
>                 BUG();
> #else
> 
> x86 appears to go ahead in this case, but has its stack walking code
> check at every step that the stack pointer it's reading from is valid --
> is this what is needed in the ARM unwind code to get rid of this BUG()?

x86 stack walking is very different from ARM unwinding.  I'd rather not
expose the unwinder to a volatile stack - that's probably a recipe for
it "sometimes" working and other times going oops because the stack
changed beneath it.

I suspect this may be one of the reasons x86 merged a dwarf unwinder
and then threw it out as it was too unreliable.

So, rather than going BUG(), lets instead return a terminated trace -
something like this.  Could you test and report back please?

Thanks.

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index c2e112e..381d23a 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -94,10 +94,13 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	if (tsk != current) {
 #ifdef CONFIG_SMP
 		/*
-		 * What guarantees do we have here that 'tsk'
-		 * is not running on another CPU?
+		 * What guarantees do we have here that 'tsk' is not
+		 * running on another CPU?  For now, ignore it as we
+		 * can't guarantee we won't explode.
 		 */
-		BUG();
+		if (trace->nr_entries < trace->max_entries)
+			trace->entries[trace->nr_entries++] = ULONG_MAX;
+		return;
 #else
 		data.no_sched_functions = 1;
 		frame.fp = thread_saved_fp(tsk);
