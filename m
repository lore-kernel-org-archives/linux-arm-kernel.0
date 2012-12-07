From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 7 Dec 2012 10:45:40 +0000
Subject: [PATCH] ARM: pass syscall return value to sys_exit tracepoint
In-Reply-To: <20121204115526.GK23368@mudshark.cambridge.arm.com>
References: <1354369134-20296-1-git-send-email-andrew_gabbasov@mentor.com>
 <20121203133735.GG20074@mudshark.cambridge.arm.com>
 <20121203141251.GB14363@n2100.arm.linux.org.uk>
 <6C5EA58090A5ED459815C4D04C2B466F8C567A21@EU-MBX-01.mgc.mentorg.com>
 <20121204103809.GD14363@n2100.arm.linux.org.uk>
 <20121204104038.GA23368@mudshark.cambridge.arm.com>
 <20121204115526.GK23368@mudshark.cambridge.arm.com>
Message-ID: <20121207104523.GA13569@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 11:55:26AM +0000, Will Deacon wrote:
> On Tue, Dec 04, 2012 at 10:40:38AM +0000, Will Deacon wrote:
> > On Tue, Dec 04, 2012 at 10:38:09AM +0000, Russell King - ARM Linux wrote:
> > > On Tue, Dec 04, 2012 at 09:48:28AM +0000, Gabbasov, Andrew wrote:
> > > > The other registers in "regs" structure are not saved around ptrace_syscall_trace,
> > > > and both audit_syscall_exit and trace_sys_exit get the register values, potentially
> > > > changed by a debugger. Does it make sense to save the isolated return value
> > > > for trace_sys_exit call only and not to save other registers, passed, for example,
> > > > to audit_syscall_exit function that takes the return value from regs structure?
> > > > Isn't it a reasonable assumption that a debugger will preserve important
> > > > register values (or intentionally change them for some purpose) in case
> > > > of syscall_exit, as we rely on this for syscall_enter case?
> > > 
> > > Actually, why are we doing things in a different order to x86?  If we
> > > assume that x86 has this stuff correctly ordered, then shouldn't we
> > > be following the sequence presented there?
> > > 
> > > x86 on entry does:
> > > - secure_computing
> > > - tracehook_report_syscall_entry
> > > - trace_sys_enter
> > > - audit_syscall_entry
> > > and on exit:
> > > - audit_syscall_exit
> > > - trace_sys_exit
> > > - tracehook_report_syscall_exit
> > > 
> > > We appear to be doing the _exact_ reverse ordering in our syscall exit
> > > path - why is that?
> > 
> > 
> > I've just been looking at that and the problem stems around having ->syscall
> > set for the current thread before calling the sys_exit tracepoint. The audit
> > code should definitely be moved earlier.
> > 
> > Working on a patch...
> 
> Ok, how about something like the following?
> 
> Will
> 
> --->8
> 
> commit 0109b339755b29f92733c1f257911615fc231727
> Author: Will Deacon <will.deacon@arm.com>
> Date:   Tue Dec 4 11:47:14 2012 +0000
> 
>     ARM: syscall: rework ordering in syscall_trace_exit
>     
>     syscall_trace_exit is currently doing things back-to-front; invoking
>     the audit hook *after* signalling the debugger, which presents an
>     opportunity for the registers to be re-written by userspace in order to
>     bypass auditing constaints.
>     
>     This patch fixes the ordering by moving the audit code first and the
>     tracehook code last. On the face of it, it looks like
>     current_thread_info()->syscall may be incorrect for the sys_exit
>     tracepoint, but that's actually not an issue because it will have been
>     set during syscall entry and cannot have changed since then.
>     
>     Reported-by: Andrew Gabbasov <Andrew_Gabbasov@mentor.com>
>     Signed-off-by: Will Deacon <will.deacon@arm.com>

My board locks up upon entering userspace with this applied.

> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 8355d4b..1dd5122 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -452,7 +452,6 @@ __sys_trace:
>  
>  __sys_trace_return:
>  	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
> -	mov	r1, scno
>  	mov	r0, sp
>  	bl	syscall_trace_exit
>  	b	ret_slow_syscall
> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index 518536d..0e9c779 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -957,17 +957,22 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
>  	return scno;
>  }
>  
> -asmlinkage int syscall_trace_exit(struct pt_regs *regs, int scno)
> +asmlinkage void syscall_trace_exit(struct pt_regs *regs)
>  {
> -	current_thread_info()->syscall = scno;
> -
> -	if (test_thread_flag(TIF_SYSCALL_TRACE))
> -		scno = tracehook_report_syscall(regs, PTRACE_SYSCALL_EXIT);

I see here we used to test TIF_SYSCALL_TRACE...

> +	/*
> +	 * Audit the syscall before anything else, as a debugger may
> +	 * come in and change the current registers.
> +	 */
> +	audit_syscall_exit(regs);
>  
> +	/*
> +	 * Note that we haven't updated the ->syscall field for the
> +	 * current thread. This isn't a problem because it will have
> +	 * been set on syscall entry and there hasn't been an opportunity
> +	 * for a PTRACE_SET_SYSCALL since then.
> +	 */
>  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> -		trace_sys_exit(regs, scno);
> +		trace_sys_exit(regs, regs_return_value(regs));
>  
> -	audit_syscall_exit(regs);
> -
> -	return scno;
> +	tracehook_report_syscall(regs, PTRACE_SYSCALL_EXIT);

And here we don't. Restoring the test makes boot complete, and audit and
tracing seem to be happy afterwards.

With the test restored,
Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
