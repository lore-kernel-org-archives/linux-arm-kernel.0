From: eparis@redhat.com (Eric Paris)
Date: Tue, 21 Feb 2012 11:08:32 -0500
Subject: [PATCH] ARM/audit: use correct arch on audit_syscall_enter
In-Reply-To: <20120221145822.GL19696@mudshark.cambridge.arm.com>
References: <1329832059-11000-1-git-send-email-eparis@redhat.com>
 <20120221145822.GL19696@mudshark.cambridge.arm.com>
Message-ID: <1329840512.2337.47.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-02-21 at 14:58 +0000, Will Deacon wrote:
> Hi Eric,
> 
> On Tue, Feb 21, 2012 at 01:47:39PM +0000, Eric Paris wrote:
> > ARM has both LE and BE versions however the audit code was called as if
> > it was always BE.  If audit userspace were to try to interpret the bits
> > it got from a LE system it would obviously do so incorrectly.  Fix this
> > by using the right arch flag on the right system.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > ---
> >  arch/arm/kernel/ptrace.c |    7 ++++++-
> >  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> It might be worth adding the #include <linux/audit.h> in this patch as well,
> since they're both fixes for problems introduced by the same commit. That
> way we only need to deal with one patch as well.

Doing that fixes two distinct bugs in one patch, which most subsystems
frown upon, but I guess your reason makes sense and we can be sure one
of them doesn't get lost.  I'll resend.

> > diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> > index e33870f..8009e84 100644
> > --- a/arch/arm/kernel/ptrace.c
> > +++ b/arch/arm/kernel/ptrace.c
> > @@ -915,10 +915,15 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
> >  	ip = regs->ARM_ip;
> >  	regs->ARM_ip = why;
> >  
> > +#ifdef __ARMEB__
> > +#define AUDIT_ARCH_NR AUDIT_ARCH_ARMEB
> > +#else
> > +#define AUDIT_ARCH_NR AUDIT_ARCH_ARM
> > +#endif
> 
> Pedantry, but I prefer the #defines outside of the function scope (I'd probably
> just stick them before the function given that they're not used anywhere else).

Fair enough.  Will do.

> >  	if (!ip)
> >  		audit_syscall_exit(regs);
> >  	else
> > -		audit_syscall_entry(AUDIT_ARCH_ARMEB, scno, regs->ARM_r0,
> > +		audit_syscall_entry(AUDIT_ARCH_NR, scno, regs->ARM_r0,
> >  				    regs->ARM_r1, regs->ARM_r2, regs->ARM_r3);
> >  
> >  	if (!test_thread_flag(TIF_SYSCALL_TRACE))
> 
> Cheers,
> 
> Will
