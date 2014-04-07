From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Apr 2014 12:41:44 +0100
Subject: [PATCH 1/3] arm64: Provide read/write fault information in
 compat signal handlers
In-Reply-To: <53427248.4000406@monstr.eu>
References: <1396822746-26241-1-git-send-email-catalin.marinas@arm.com>
 <1396822746-26241-2-git-send-email-catalin.marinas@arm.com>
 <53427248.4000406@monstr.eu>
Message-ID: <20140407114143.GC3360@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 10:39:20AM +0100, Michal Simek wrote:
> On 04/07/2014 12:19 AM, Catalin Marinas wrote:
> > --- a/arch/arm64/kernel/signal32.c
> > +++ b/arch/arm64/kernel/signal32.c
> > @@ -500,7 +500,9 @@ static int compat_setup_sigframe(struct compat_sigframe __user *sf,
> >  	__put_user_error(regs->pstate, &sf->uc.uc_mcontext.arm_cpsr, err);
> >  
> >  	__put_user_error((compat_ulong_t)0, &sf->uc.uc_mcontext.trap_no, err);
> > -	__put_user_error((compat_ulong_t)0, &sf->uc.uc_mcontext.error_code, err);
> > +	/* compat tasks expect bit 11 as WnR status bit */
> > +	__put_user_error((current->thread.fault_code & (1 << 6)) << 5,
> 
> Isn't it better to use macros for these magic values?

I was too lazy ;). I'll add some macros.

-- 
Catalin
