From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 27 Jul 2011 10:13:57 -0400 (EDT)
Subject: [PATCH v2] ARM: alignment: Make SIGBUS sent to userspace POSIXly
	correct
In-Reply-To: <1311768636-29582-1-git-send-email-dave.martin@linaro.org>
References: <1311768636-29582-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1107271013110.12766@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jul 2011, Dave Martin wrote:

> With the UM_SIGNAL alignment fault mode, no siginfo structure is
> passed to userspace.
> 
> POSIX specifies how siginfo_t should be populated for alignment
> faults, so this patch does just that:
> 
>   * si_signo = SIGBUS
>   * si_code = BUS_ADRALN
>   * si_addr = misaligned data address at which access was attempted
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
> v2: si_addr in siginfo_t changed to contain the faulting data
>     access address, not the address of the faulting instruction.
> 
>     This behaviour is consistent with the way other fault signals
>     such as SIGSEGV are already reported, as well as matching the
>     apparent intent of the POSIX sigaction interface.

Makes sense.  ACK.

> 
>  arch/arm/mm/alignment.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index 724ba3b..65ed9c6 100644
> --- a/arch/arm/mm/alignment.c
> +++ b/arch/arm/mm/alignment.c
> @@ -22,6 +22,7 @@
>  #include <linux/sched.h>
>  #include <linux/uaccess.h>
>  
> +#include <asm/system.h>
>  #include <asm/unaligned.h>
>  
>  #include "fault.h"
> @@ -883,9 +884,16 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	if (ai_usermode & UM_FIXUP)
>  		goto fixup;
>  
> -	if (ai_usermode & UM_SIGNAL)
> -		force_sig(SIGBUS, current);
> -	else {
> +	if (ai_usermode & UM_SIGNAL) {
> +		siginfo_t si;
> +
> +		si.si_signo = SIGBUS;
> +		si.si_errno = 0;
> +		si.si_code = BUS_ADRALN;
> +		si.si_addr = (void __user *)addr;
> +
> +		force_sig_info(si.si_signo, &si, current);
> +	} else {
>  		/*
>  		 * We're about to disable the alignment trap and return to
>  		 * user space.  But if an interrupt occurs before actually
> -- 
> 1.7.4.1
> 
