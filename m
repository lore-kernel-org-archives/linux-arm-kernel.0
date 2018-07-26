From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Jul 2018 14:56:32 +0100
Subject: [PATCH 1/6] ARM: signal: copy registers using __copy_from_user()
In-Reply-To: <20180726122350.qtf7h6qekru23bv2@lakrids.cambridge.arm.com>
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
 <E1fctOl-0005ul-69@rmk-PC.armlinux.org.uk>
 <20180726122350.qtf7h6qekru23bv2@lakrids.cambridge.arm.com>
Message-ID: <20180726135632.GZ17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 01:23:50PM +0100, Mark Rutland wrote:
> On Tue, Jul 10, 2018 at 03:13:47PM +0100, Russell King wrote:
> > When restoring the ARM integer registers, use __copy_from_user() to
> > copy them into kernel space before restoring them, rather than
> > __get_user_error().
> 
> I assume that this is so that we only have to pay the cost of sanitizing
> the user pointer once in __copy_from_user(), rather than in each
> __get_user_error()?
> 
> Can we mention that in the commit message? e.g. something like:
> 
>   In subsequent patches, each uaccess will sanitize the __user pointer
>   to prevent speculative accesses to kernel memory.
>   
>   To amortize the cost of this sanitization when restoring the integer
>   registers, we can use __copy_from_user() rather than a sequence of
>   __get_user_error() calls.

It's not only that, it's also the overhead of the software PAN support
as well, and it's a change I've been thinking has been worth doing
for some time.

>  
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  arch/arm/kernel/signal.c | 38 +++++++++++++++++++++-----------------
> >  1 file changed, 21 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> > index bd8810d4acb3..0ae74207e43e 100644
> > --- a/arch/arm/kernel/signal.c
> > +++ b/arch/arm/kernel/signal.c
> > @@ -176,6 +176,7 @@ static int restore_vfp_context(char __user **auxp)
> >  
> >  static int restore_sigframe(struct pt_regs *regs, struct sigframe __user *sf)
> >  {
> > +	struct sigcontext context;
> >  	char __user *aux;
> >  	sigset_t set;
> >  	int err;
> > @@ -184,23 +185,26 @@ static int restore_sigframe(struct pt_regs *regs, struct sigframe __user *sf)
> >  	if (err == 0)
> >  		set_current_blocked(&set);
> >  
> > -	__get_user_error(regs->ARM_r0, &sf->uc.uc_mcontext.arm_r0, err);
> > -	__get_user_error(regs->ARM_r1, &sf->uc.uc_mcontext.arm_r1, err);
> > -	__get_user_error(regs->ARM_r2, &sf->uc.uc_mcontext.arm_r2, err);
> > -	__get_user_error(regs->ARM_r3, &sf->uc.uc_mcontext.arm_r3, err);
> > -	__get_user_error(regs->ARM_r4, &sf->uc.uc_mcontext.arm_r4, err);
> > -	__get_user_error(regs->ARM_r5, &sf->uc.uc_mcontext.arm_r5, err);
> > -	__get_user_error(regs->ARM_r6, &sf->uc.uc_mcontext.arm_r6, err);
> > -	__get_user_error(regs->ARM_r7, &sf->uc.uc_mcontext.arm_r7, err);
> > -	__get_user_error(regs->ARM_r8, &sf->uc.uc_mcontext.arm_r8, err);
> > -	__get_user_error(regs->ARM_r9, &sf->uc.uc_mcontext.arm_r9, err);
> > -	__get_user_error(regs->ARM_r10, &sf->uc.uc_mcontext.arm_r10, err);
> > -	__get_user_error(regs->ARM_fp, &sf->uc.uc_mcontext.arm_fp, err);
> > -	__get_user_error(regs->ARM_ip, &sf->uc.uc_mcontext.arm_ip, err);
> > -	__get_user_error(regs->ARM_sp, &sf->uc.uc_mcontext.arm_sp, err);
> > -	__get_user_error(regs->ARM_lr, &sf->uc.uc_mcontext.arm_lr, err);
> > -	__get_user_error(regs->ARM_pc, &sf->uc.uc_mcontext.arm_pc, err);
> > -	__get_user_error(regs->ARM_cpsr, &sf->uc.uc_mcontext.arm_cpsr, err);
> > +	err |= __copy_from_user(&context, &sf->uc.uc_mcontext, sizeof(context));
> 
> IIUC, this means that we'll also copy the (unused) fault_address field,
> but I assume that's ok.

It is completely fine, because the stack contains everything in
sf->uc.uc_mcontext - this is a member in the middle of the parent
struct sigframe, and we access both before and after that member.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
