From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 27 Oct 2009 14:08:07 -0400 (EDT)
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <200910271857.35371.jpihet@mvista.com>
References: <1256123277.3851.36.camel@debian-nb>
	<200910271514.54506.jpihet@mvista.com>
	<19175.5363.259051.477820@pilspetsen.it.uu.se>
	<200910271857.35371.jpihet@mvista.com>
Message-ID: <alpine.LFD.2.00.0910271407020.10545@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Oct 2009, Jean Pihet wrote:

> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index f330974..4366cc0 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -676,8 +676,14 @@ static int do_signal(sigset_t *oldset, struct pt_regs 
> *regs, int syscall)
>  				regs->ARM_sp -= 4;
>  				usp = (u32 __user *)regs->ARM_sp;
>  
> -				put_user(regs->ARM_pc, usp);
> -				regs->ARM_pc = KERN_RESTART_CODE;
> +				if (put_user(regs->ARM_pc, usp) == 0) {
> +					flush_icache_range((unsigned long)usp,
> +						(unsigned long)(usp + 1));

Why are you flushing the icache?  There is no code on the stack anymore.


Nicolas
