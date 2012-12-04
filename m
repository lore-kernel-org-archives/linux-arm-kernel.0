From: Andrew_Gabbasov@mentor.com (Gabbasov, Andrew)
Date: Tue, 4 Dec 2012 09:48:28 +0000
Subject: [PATCH] ARM: pass syscall return value to sys_exit tracepoint
In-Reply-To: <20121203141251.GB14363@n2100.arm.linux.org.uk>
References: <1354369134-20296-1-git-send-email-andrew_gabbasov@mentor.com>
 <20121203133735.GG20074@mudshark.cambridge.arm.com>,
 <20121203141251.GB14363@n2100.arm.linux.org.uk>
Message-ID: <6C5EA58090A5ED459815C4D04C2B466F8C567A21@EU-MBX-01.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sat, Dec 01, 2012 at 01:38:54PM +0000, Andrew Gabbasov wrote:
> > sys_exit tracepoint expects the syscall return value as a second
> > argument, rather than syscall number.
> >
> > Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> > ---
> >  arch/arm/kernel/ptrace.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> > index 739db3a..4206da7 100644
> > --- a/arch/arm/kernel/ptrace.c
> > +++ b/arch/arm/kernel/ptrace.c
> > @@ -956,7 +956,7 @@ asmlinkage int syscall_trace_exit(struct pt_regs *regs, int scno)
> >  {
> >       scno = ptrace_syscall_trace(regs, scno, PTRACE_SYSCALL_EXIT);
> >       if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> > -             trace_sys_exit(regs, scno);
> > +             trace_sys_exit(regs, regs->ARM_r0);
> >       audit_syscall_exit(regs);
> >       return scno;
> >  }
> 
> It might be worth stashing the return value into a local variable prior to
> the ptrace_syscall_trace invocation, just in case a debugger decides to
> rewrite the child's registers.
> 
> Will

The other registers in "regs" structure are not saved around ptrace_syscall_trace,
and both audit_syscall_exit and trace_sys_exit get the register values, potentially
changed by a debugger. Does it make sense to save the isolated return value
for trace_sys_exit call only and not to save other registers, passed, for example,
to audit_syscall_exit function that takes the return value from regs structure?
Isn't it a reasonable assumption that a debugger will preserve important
register values (or intentionally change them for some purpose) in case
of syscall_exit, as we rely on this for syscall_enter case?

Thanks,
Andrew
