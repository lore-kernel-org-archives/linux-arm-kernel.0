From: eparis@redhat.com (Eric Paris)
Date: Mon, 11 Aug 2014 09:22:24 -0400
Subject: [PATCH] arm64: audit: Fix build for audit changes
In-Reply-To: <20140811090947.GC15344@arm.com>
References: <1405596402-23844-1-git-send-email-broonie@kernel.org>
 <20140811090947.GC15344@arm.com>
Message-ID: <1407763344.2423.0.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-08-11 at 10:09 +0100, Will Deacon wrote:
> On Thu, Jul 17, 2014 at 12:26:42PM +0100, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>
> > 
> > Commit 3efe33f5d2 (audit: x86: drop arch from __audit_syscall_entry()
> > interface) removed the arch parameter from __audit_syscall_entry() and
> > updated the only current user in mainline but this breaks the ARMv8 audit
> > code that has been added in -next. Fix this by making the equivalent
> > update to ARMv8.
> > 
> > Signed-off-by: Mark Brown <broonie@linaro.org>
> > ---
> >  arch/arm64/kernel/ptrace.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > index 70526cfda056..310842e3d477 100644
> > --- a/arch/arm64/kernel/ptrace.c
> > +++ b/arch/arm64/kernel/ptrace.c
> > @@ -1115,8 +1115,8 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
> >  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> >  		trace_sys_enter(regs, regs->syscallno);
> >  
> > -	audit_syscall_entry(syscall_get_arch(), regs->syscallno,
> > -		regs->orig_x0, regs->regs[1], regs->regs[2], regs->regs[3]);
> > +	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
> > +			    regs->regs[2], regs->regs[3]);
> 
> Eric, Richard: when is 3efe33f5d2 ("audit: x86: drop arch from
> __audit_syscall_entry() interface") going to hit mainline? I've been holding
> off this fix until the offending commit is merged, but if that's not going
> to happen for 3.17, then we probably need to do something else to fix -next.

I think I'm being lazy this window and not oging to send a pull.  So
I'll pick up this fix as soon as rc1 cuts in my tree.
