From: will.deacon@arm.com (Will Deacon)
Date: Fri, 7 Dec 2012 16:01:42 +0000
Subject: [PATCH] ARM: pass syscall return value to sys_exit tracepoint
In-Reply-To: <20121207104523.GA13569@e106331-lin.cambridge.arm.com>
References: <1354369134-20296-1-git-send-email-andrew_gabbasov@mentor.com>
 <20121203133735.GG20074@mudshark.cambridge.arm.com>
 <20121203141251.GB14363@n2100.arm.linux.org.uk>
 <6C5EA58090A5ED459815C4D04C2B466F8C567A21@EU-MBX-01.mgc.mentorg.com>
 <20121204103809.GD14363@n2100.arm.linux.org.uk>
 <20121204104038.GA23368@mudshark.cambridge.arm.com>
 <20121204115526.GK23368@mudshark.cambridge.arm.com>
 <20121207104523.GA13569@e106331-lin.cambridge.arm.com>
Message-ID: <20121207160142.GD5863@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 07, 2012 at 10:45:40AM +0000, Mark Rutland wrote:
> On Tue, Dec 04, 2012 at 11:55:26AM +0000, Will Deacon wrote:
> > +asmlinkage void syscall_trace_exit(struct pt_regs *regs)
> >  {
> > -	current_thread_info()->syscall = scno;
> > -
> > -	if (test_thread_flag(TIF_SYSCALL_TRACE))
> > -		scno = tracehook_report_syscall(regs, PTRACE_SYSCALL_EXIT);
> 
> I see here we used to test TIF_SYSCALL_TRACE...
> 
> > +	/*
> > +	 * Audit the syscall before anything else, as a debugger may
> > +	 * come in and change the current registers.
> > +	 */
> > +	audit_syscall_exit(regs);
> >  
> > +	/*
> > +	 * Note that we haven't updated the ->syscall field for the
> > +	 * current thread. This isn't a problem because it will have
> > +	 * been set on syscall entry and there hasn't been an opportunity
> > +	 * for a PTRACE_SET_SYSCALL since then.
> > +	 */
> >  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> > -		trace_sys_exit(regs, scno);
> > +		trace_sys_exit(regs, regs_return_value(regs));
> >  
> > -	audit_syscall_exit(regs);
> > -
> > -	return scno;
> > +	tracehook_report_syscall(regs, PTRACE_SYSCALL_EXIT);
> 
> And here we don't. Restoring the test makes boot complete, and audit and
> tracing seem to be happy afterwards.
> 
> With the test restored,
> Tested-by: Mark Rutland <mark.rutland@arm.com>

Cheers Mark, I'll fix this oversight and stick it in the patch system with
your tag.

Will
