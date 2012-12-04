From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Dec 2012 10:40:38 +0000
Subject: [PATCH] ARM: pass syscall return value to sys_exit tracepoint
In-Reply-To: <20121204103809.GD14363@n2100.arm.linux.org.uk>
References: <1354369134-20296-1-git-send-email-andrew_gabbasov@mentor.com>
 <20121203133735.GG20074@mudshark.cambridge.arm.com>
 <20121203141251.GB14363@n2100.arm.linux.org.uk>
 <6C5EA58090A5ED459815C4D04C2B466F8C567A21@EU-MBX-01.mgc.mentorg.com>
 <20121204103809.GD14363@n2100.arm.linux.org.uk>
Message-ID: <20121204104038.GA23368@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 10:38:09AM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 04, 2012 at 09:48:28AM +0000, Gabbasov, Andrew wrote:
> > The other registers in "regs" structure are not saved around ptrace_syscall_trace,
> > and both audit_syscall_exit and trace_sys_exit get the register values, potentially
> > changed by a debugger. Does it make sense to save the isolated return value
> > for trace_sys_exit call only and not to save other registers, passed, for example,
> > to audit_syscall_exit function that takes the return value from regs structure?
> > Isn't it a reasonable assumption that a debugger will preserve important
> > register values (or intentionally change them for some purpose) in case
> > of syscall_exit, as we rely on this for syscall_enter case?
> 
> Actually, why are we doing things in a different order to x86?  If we
> assume that x86 has this stuff correctly ordered, then shouldn't we
> be following the sequence presented there?
> 
> x86 on entry does:
> - secure_computing
> - tracehook_report_syscall_entry
> - trace_sys_enter
> - audit_syscall_entry
> and on exit:
> - audit_syscall_exit
> - trace_sys_exit
> - tracehook_report_syscall_exit
> 
> We appear to be doing the _exact_ reverse ordering in our syscall exit
> path - why is that?


I've just been looking at that and the problem stems around having ->syscall
set for the current thread before calling the sys_exit tracepoint. The audit
code should definitely be moved earlier.

Working on a patch...

Will
