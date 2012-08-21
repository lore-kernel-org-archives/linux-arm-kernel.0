From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Aug 2012 09:27:35 +0100
Subject: [PATCH v3] ARM: support syscall tracing
In-Reply-To: <5032A1D6.6010605@mentor.com>
References: <50324BED.9000500@mentor.com>
 <20120820172559.GW25864@mudshark.cambridge.arm.com>
 <5032A1D6.6010605@mentor.com>
Message-ID: <20120821082734.GA28660@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 09:45:10PM +0100, Wade Farnsworth wrote:
> Will Deacon wrote:
> >
> > I think that trace_sys_{enter,exit} should take ret rather than scno. A
> > debugger could change the syscall number if TIF_SYSCALL_TRACE is set and
> > that new number should be the one that we use.
> >
> > The style, however, is much better and I think the code is fairly clear now
> > so we just need to wait for my fix to the core code to get merged (it got
> > picked up by Steve Rostedt) and I think we can use ret directly. It might be
> > worth dropping the local variable and using scno for everything, so that
> > it's obvious where the syscall number is stored.
> >
> 
> I agree that your patch needs to get merged before mine gets picked up 
> so that we don't introduce a new bug.  I've sent v4 with the changes you 
> suggest.  Would you like me to modify syscall_trace_* to remove the 
> local variable in this patch as well?  It seems to me that such a rework 
> is better handled separately, but let me know if you think otherwise.

Don't worry about the scno rework -- I'll do that as a separate patch
because I think that the audit calls need updating to use the return value
from ptrace_syscall_trace too (otherwise you could use a debugger to execute
syscalls that you shouldn't be allowed to make).

So, if it's ok with you, I'll take this into my tree and then send it to
Russell along with the scno change once the core fix has been merged into
mainline.

Cheers,

Will

--- >8

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 3e0fc5f..90396a6 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -941,15 +941,15 @@ static int ptrace_syscall_trace(struct pt_regs *regs, int scno,
 
 asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
 {
-       int ret = ptrace_syscall_trace(regs, scno, PTRACE_SYSCALL_ENTER);
+       scno = ptrace_syscall_trace(regs, scno, PTRACE_SYSCALL_ENTER);
        audit_syscall_entry(AUDIT_ARCH_ARM, scno, regs->ARM_r0, regs->ARM_r1,
                            regs->ARM_r2, regs->ARM_r3);
-       return ret;
+       return scno;
 }
 
 asmlinkage int syscall_trace_exit(struct pt_regs *regs, int scno)
 {
-       int ret = ptrace_syscall_trace(regs, scno, PTRACE_SYSCALL_EXIT);
+       scno = ptrace_syscall_trace(regs, scno, PTRACE_SYSCALL_EXIT);
        audit_syscall_exit(regs);
-       return ret;
+       return scno;
 }
