From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 27 Oct 2009 15:35:31 -0400 (EDT)
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <200910272012.53488.jpihet@mvista.com>
References: <1256123277.3851.36.camel@debian-nb>
	<200910271937.57146.jpihet@mvista.com>
	<alpine.LFD.2.00.0910271454110.10545@xanadu.home>
	<200910272012.53488.jpihet@mvista.com>
Message-ID: <alpine.LFD.2.00.0910271533060.10545@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Oct 2009, Jean Pihet wrote:

> Nicolas,
> 
> On Tuesday 27 October 2009 19:59:36 Nicolas Pitre wrote:
> ...
> > > Side question: does the put_user requires a flush of some sort? If not,
> > > why?
> >
> > No because it stores data into the d-cache directly at the virtual
> > address to be used by user space.  Previously the d-cache needed to
> > be cleaned for data to hit main memory and the i-cache invalidated for
> > the newly stored _code_ to be seen by the instruction path.  Since there
> > is no code involved anymore the cache flushes are useless.
> >
> > > Is it OK to re-send a patch with the call to flush_icache_range removed?
> >
> > Yes.
> Ok here is the updated patch. Let's hope it is the good one that time ;-)

Well, the commit message is certainly wrong. There is no copying of 
restart_syscall to user stack anymore.

And is there a reason for touching sp in the error case?




> 
> Can it be merged? It applies cleanly on top of Russell's latest patch 
> (http://marc.info/?l=linux-arm-kernel&m=125638133624452&w=2).
> >
> >
> > Nicolas
> 
> Regards,
> Jean
> 
> ---
> From d862e03679f7ea44fca1bf1ea256bbade3fbe76a Mon Sep 17 00:00:00 2001
> From: Jean Pihet <jpihet@mvista.com>
> Date: Tue, 27 Oct 2009 10:09:22 +0100
> Subject: ARM: Check put_user fail in do_signal when enable OABI_COMPAT
> 
> Using OABI, do_signal need to copy restart_syscall to user stack.
> It is possible that put_user fail. This triggers flush_icache page
> fault and crash kernel.
> 
> Signed-off-by: janboe <janboe.ye@gmail.com>
> 
> Merged from
> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/002621.html
> on top of
> http://marc.info/?l=linux-arm-kernel&m=125638133624452&w=2
> 
> Tested with multiple sleeping apps/threads (using the nanosleep syscall) and
> suspend/resume.
> 
> Signed-off-by: Jean Pihet <jpihet@mvista.com>
> ---
>  arch/arm/kernel/signal.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index f330974..ea9722a 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -676,8 +676,12 @@ static int do_signal(sigset_t *oldset, struct pt_regs 
> *regs, int syscall)
>  				regs->ARM_sp -= 4;
>  				usp = (u32 __user *)regs->ARM_sp;
>  
> -				put_user(regs->ARM_pc, usp);
> -				regs->ARM_pc = KERN_RESTART_CODE;
> +				if (put_user(regs->ARM_pc, usp) == 0) {
> +					regs->ARM_pc = KERN_RESTART_CODE;
> +				} else {
> +					regs->ARM_sp += 4;
> +					force_sigsegv(0, current);
> +				}
>  #endif
>  			}
>  		}
> -- 
> 1.6.2.5.168.g3823
> 
> 
