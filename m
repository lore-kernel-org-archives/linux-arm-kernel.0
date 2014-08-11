From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Aug 2014 16:47:55 +0100
Subject: [PATCH] arm64: audit: Fix build for audit changes
In-Reply-To: <20140811151502.GS24268@arm.com>
References: <1405596402-23844-1-git-send-email-broonie@kernel.org>
 <20140811090947.GC15344@arm.com>
 <1407763344.2423.0.camel@redhat.com>
 <20140811133338.GB15853@arm.com> <20140811151502.GS24268@arm.com>
Message-ID: <20140811154755.GI15853@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 04:15:02PM +0100, Catalin Marinas wrote:
> On Mon, Aug 11, 2014 at 02:33:38PM +0100, Will Deacon wrote:
> > On Mon, Aug 11, 2014 at 02:22:24PM +0100, Eric Paris wrote:
> > > On Mon, 2014-08-11 at 10:09 +0100, Will Deacon wrote:
> > > > On Thu, Jul 17, 2014 at 12:26:42PM +0100, Mark Brown wrote:
> > > > > From: Mark Brown <broonie@linaro.org>
> > > > > 
> > > > > Commit 3efe33f5d2 (audit: x86: drop arch from __audit_syscall_entry()
> > > > > interface) removed the arch parameter from __audit_syscall_entry() and
> > > > > updated the only current user in mainline but this breaks the ARMv8 audit
> > > > > code that has been added in -next. Fix this by making the equivalent
> > > > > update to ARMv8.
> > > > > 
> > > > > Signed-off-by: Mark Brown <broonie@linaro.org>
> > > > > ---
> > > > >  arch/arm64/kernel/ptrace.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > > > > index 70526cfda056..310842e3d477 100644
> > > > > --- a/arch/arm64/kernel/ptrace.c
> > > > > +++ b/arch/arm64/kernel/ptrace.c
> > > > > @@ -1115,8 +1115,8 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
> > > > >  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> > > > >  		trace_sys_enter(regs, regs->syscallno);
> > > > >  
> > > > > -	audit_syscall_entry(syscall_get_arch(), regs->syscallno,
> > > > > -		regs->orig_x0, regs->regs[1], regs->regs[2], regs->regs[3]);
> > > > > +	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
> > > > > +			    regs->regs[2], regs->regs[3]);
> > > > 
> > > > Eric, Richard: when is 3efe33f5d2 ("audit: x86: drop arch from
> > > > __audit_syscall_entry() interface") going to hit mainline? I've been holding
> > > > off this fix until the offending commit is merged, but if that's not going
> > > > to happen for 3.17, then we probably need to do something else to fix -next.
> > > 
> > > I think I'm being lazy this window and not oging to send a pull.  So
> > > I'll pick up this fix as soon as rc1 cuts in my tree.
> > 
> > Oh, alright then. If you're not going to send the code for mainline, you
> > could also just drop it from -next ;)
> > 
> > Anyway, if you do fix it, please let me know so that I can remove our #ifdef
> > CONFIG_AUDITSYSCALL guards (which only exist to stop build breakage in -next
> > with defconfig).
> 
> Actually, Eric could carry the arm64 change from Mark into -next as well
> and we can drop the arm64 #ifdef before the API change hits mainline.

Indeed -- I think that's what we'd agreed, right?

Will
