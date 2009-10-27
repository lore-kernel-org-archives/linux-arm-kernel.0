From: mikpe@it.uu.se (Mikael Pettersson)
Date: Tue, 27 Oct 2009 16:42:43 +0100
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <200910271514.54506.jpihet@mvista.com>
References: <1256123277.3851.36.camel@debian-nb>
	<20091025154416.GB1774@n2100.arm.linux.org.uk>
	<af3ea28a0910251959id60ad5kf95dd1f908fa55c9@mail.gmail.com>
	<200910271514.54506.jpihet@mvista.com>
Message-ID: <19175.5363.259051.477820@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet writes:
 > --- a/arch/arm/kernel/signal.c
 > +++ b/arch/arm/kernel/signal.c
 > @@ -643,6 +643,7 @@ static int do_signal(sigset_t *oldset, struct pt_regs 
 > *regs, int syscall)
 >  	struct k_sigaction ka;
 >  	siginfo_t info;
 >  	int signr;
 > +	int ret = 0;
 >  
 >  	/*
 >  	 * We want the common case to go fast, which
 > @@ -685,8 +686,15 @@ static int do_signal(sigset_t *oldset, struct pt_regs 
 > *regs, int syscall)
 >  				regs->ARM_sp -= 4;
 >  				usp = (u32 __user *)regs->ARM_sp;
 >  
 > -				put_user(regs->ARM_pc, usp);
 > -				regs->ARM_pc = KERN_RESTART_CODE;
 > +				ret |= put_user(regs->ARM_pc, usp);
 > +				if (!ret) {
 > +					flush_icache_range((unsigned long)usp,
 > +						(unsigned long)(usp + 1));
 > +					regs->ARM_pc = KERN_RESTART_CODE;
 > +				} else {
 > +					regs->ARM_sp += 4;
 > +					force_sigsegv(0, current);
 > +				}
 >  #endif

I don't like this 'ret' variable:
- it's only for OABI, but declared at the top and initialised also for EABI
- you update it with |=, but clearly there's no useful previous value

I'd drop 'ret' and just do:

				if (put_user(regs->ARM_pc, usp) == 0) {
					flush...
				} else {
					... force_sigsegv
				}

(Note: == 0 not !, since ! is often read as "failed" whereas for
put_user() 0 means Ok and non-zero means -errno.)
