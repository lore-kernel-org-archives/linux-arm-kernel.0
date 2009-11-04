From: jpihet@mvista.com (Jean Pihet)
Date: Wed, 4 Nov 2009 14:33:31 +0100
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <200910281800.47681.jpihet@mvista.com>
References: <1256123277.3851.36.camel@debian-nb>
	<200910281723.01684.jpihet@mvista.com>
	<200910281800.47681.jpihet@mvista.com>
Message-ID: <200911041433.32010.jpihet@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Is this one OK? Can it be merged now that your fix for signal restart has been 
merged into mainline?

Regards,
Jean

On Wednesday 28 October 2009 18:00:47 Jean Pihet wrote:
> On Wednesday 28 October 2009 17:23:01 Jean Pihet wrote:
> ...
>
> > > Still wrong.  Why flush_icache?
> >
> > Indeed that is wrong (again!). I had put it in the problem description
> > but that does not apply anymore.
> >
> > Thanks, will send an update.
>
> Here is the updated patch. Is it OK?
>
> Jean
>
> > > Nicolas
> >
> > Jean
>
> ---
> From 28336b68b2e2507ba0922c55147e5e72ec1a88dc Mon Sep 17 00:00:00 2001
> From: Jean Pihet <jpihet@mvista.com>
> Date: Tue, 27 Oct 2009 10:09:22 +0100
> Subject: ARM: Check put_user fail in do_signal when enable OABI_COMPAT
>
> Source: Janboe Ye <janboe.ye@gmail.com>
> MR: 36048
> Type: Defect Fix
> Disposition: Submitted to linux-arm-kernel ML
> ChangeID: 689ddf707d2232e9cf01387ac1264bc8812b9ffd
> Description:
>
> Using OABI, the call to put_user in do_signal can fail causing the calling
> app to hang.
>
> The solution is to check if put_user fails and force the app to
> seg fault in that case.
>
> Signed-off-by: janboe <janboe.ye@gmail.com>
>
> Merged from
> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/002621.h
>tml on top of
> http://marc.info/?l=linux-arm-kernel&m=125638133624452&w=2
>
> Tested with multiple sleeping apps/threads (using the nanosleep syscall)
> and suspend/resume.
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
