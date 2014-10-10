From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Oct 2014 12:05:39 +0100
Subject: [PATCH v7 2/6] arm64: ptrace: allow tracer to skip a system call
In-Reply-To: <54360F2D.3090602@linaro.org>
References: <1412243176-16192-1-git-send-email-takahiro.akashi@linaro.org>
 <1412243176-16192-3-git-send-email-takahiro.akashi@linaro.org>
 <20141008142328.GR26140@arm.com> <54360F2D.3090602@linaro.org>
Message-ID: <20141010110539.GG7755@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 05:29:33AM +0100, AKASHI Takahiro wrote:
> On 10/08/2014 11:23 PM, Will Deacon wrote:
> > On Thu, Oct 02, 2014 at 10:46:12AM +0100, AKASHI Takahiro wrote:
> >> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> >> index 41ed9e1..736ebc3 100644
> >> --- a/arch/arm64/include/asm/ptrace.h
> >> +++ b/arch/arm64/include/asm/ptrace.h
> >> @@ -65,6 +65,14 @@
> >>   #define COMPAT_PT_TEXT_ADDR		0x10000
> >>   #define COMPAT_PT_DATA_ADDR		0x10004
> >>   #define COMPAT_PT_TEXT_END_ADDR		0x10008
> >> +
> >> +/*
> >> + * System call will be skipped if a syscall number is changed to -1
> >> + * with ptrace(PTRACE_SET_SYSCALL).
> >> + * Upper 32-bit should be ignored for safe check.
> >> + */
> >> +#define IS_SKIP_SYSCALL(no)	((int)(no & 0xffffffff) == -1)
> >
> > I don't think this macro is very useful, especially considering that we
> > already use ~0UL explicitly in other places. Just move the comment into
> > syscall_trace_enter and be done with it. I also don't think you need the
> > mask (the cast is enough).
> 
> I remember it was necessary for compat PTRACE_SET_SYSCALL, but
> will double-check it anyway.

Ok, thanks.

> >> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> >> index 2842f9f..6b11c6a 100644
> >> --- a/arch/arm64/kernel/ptrace.c
> >> +++ b/arch/arm64/kernel/ptrace.c
> >> @@ -1126,6 +1126,8 @@ static void tracehook_report_syscall(struct pt_regs *regs,
> >>
> >>   asmlinkage int syscall_trace_enter(struct pt_regs *regs)
> >>   {
> >> +	unsigned int orig_syscallno = regs->syscallno;
> >> +
> >>   	if (test_thread_flag(TIF_SYSCALL_TRACE))
> >>   		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
> >>
> >> @@ -1133,7 +1135,26 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
> >>   		trace_sys_enter(regs, regs->syscallno);
> >>
> >>   	audit_syscall_entry(syscall_get_arch(), regs->syscallno,
> >> -		regs->orig_x0, regs->regs[1], regs->regs[2], regs->regs[3]);
> >> +			regs->orig_x0, regs->regs[1],
> >> +			regs->regs[2], regs->regs[3]);
> >> +
> >> +	if (IS_SKIP_SYSCALL(regs->syscallno) &&
> >> +			IS_SKIP_SYSCALL(orig_syscallno)) {
> >> +		/*
> >> +		 * For compatibility, we handles user-issued syscall(-1).
> >
> > Compatibility with what? arch/arm/?
> 
> with the case where a process is *not* traced (including audit).

Ok, please make that explicit in the comment.

> >> +		 *
> >> +		 * RESTRICTION: we can't modify a return value here in this
> >> +		 * specific case. In order to ease this flavor, we have to
> >> +		 * take whatever value x0 has as a return value, but this
> >> +		 * might result in a bogus value being returned.
> >
> > This comment isn't helping me. Are we returning a bogus value or not? If so,
> > why is that acceptable?
> 
> I mean that syscall(-1) always returns -1 with ENOSYS.
> 
> Let's think about the case that we didn't have this 'if' statement.
> If a debugger catches an user-issued syscall(-1), but let it go without
> doing anything (especially changing a value in x0), this syscall will
> return an original value in x0, which is the first argument of syscall(-1).
> I mentioned this as "bogus."
> In this way, a traced process would see a different behavior of syscall(-1).
> (On arm, this doesn't happen because syscall(-1) is supposed to raise SIGILL.)
> (On x86, this doesn't happen, probably, because syscall arguments are passed
> via a stack and we can set a default return value in a register to ENOSYS.)

In which case, it's worth mentioning this in the comment and being explicit
that this only applies to -1, as that's the same value we use to indicate
that the syscall should be skipped. syscall(-2), for example, doesn't have
an issue and will always return -ENOSYS.

Will
