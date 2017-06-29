From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 29 Jun 2017 17:39:52 +0100
Subject: [PATCH 1/3] arm64: ptrace: Avoid setting compat FP[SC]R to
 garbage if get_user fails
In-Reply-To: <20170629153709.GC21883@arm.com>
References: <1498746379-27340-1-git-send-email-Dave.Martin@arm.com>
 <1498746379-27340-2-git-send-email-Dave.Martin@arm.com>
 <20170629153709.GC21883@arm.com>
Message-ID: <20170629163950.GB3966@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 04:37:09PM +0100, Will Deacon wrote:
> On Thu, Jun 29, 2017 at 03:25:47PM +0100, Dave Martin wrote:
> > If get_user() fails when reading the new FPSCR value from userspace
> > in compat_vfp_get(), then garbage* will be written to the task's
> > FPSR and FPCR registers.
> > 
> > This patch prevents this by checking the return from get_user()
> > first.
> > 
> > [*] Actually, zero, due to the behaviour of get_user() on error, but
> > that's still not what userspace expects.
> 
> On the other hand, I don't think userspace can expect that if ptrace returns
> an error then none of the state has been updated, can it?
> 
> Given that we don't propagate the return value from __copy_from_user,
> I don't see what we're really fixing here and what userspace can now rely
> on that it couldn't rely on before.

My main concern was to avoid the apparent leak of kernel stack to
userspace.  The reason this is safe is not obvious from the code here.
The zeroing behaviour of get_user() does not appear to be documented
anywhere (at least, not that I've found).

Alternative options are to initialise fpscr to 0, or (since there is no
actual bug here) to drop the patch.

Cheers
---Dave

> 
> Will
> 
> > 
> > Fixes: 478fcb2cdb23 ("arm64: Debugging support")
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/kernel/ptrace.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > index 35846f1..4c068dc 100644
> > --- a/arch/arm64/kernel/ptrace.c
> > +++ b/arch/arm64/kernel/ptrace.c
> > @@ -947,8 +947,10 @@ static int compat_vfp_set(struct task_struct *target,
> >  
> >  	if (count && !ret) {
> >  		ret = get_user(fpscr, (compat_ulong_t *)ubuf);
> > -		uregs->fpsr = fpscr & VFP_FPSCR_STAT_MASK;
> > -		uregs->fpcr = fpscr & VFP_FPSCR_CTRL_MASK;
> > +		if (!ret) {
> > +			uregs->fpsr = fpscr & VFP_FPSCR_STAT_MASK;
> > +			uregs->fpcr = fpscr & VFP_FPSCR_CTRL_MASK;
> > +		}
> >  	}
> >  
> >  	fpsimd_flush_task_state(target);
> > -- 
> > 2.1.4
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
