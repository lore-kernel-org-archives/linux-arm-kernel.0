From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Tue, 26 Jul 2011 19:29:05 +0300
Subject: [PATCH 1/2] ARM: alignment: Make SIGBUS sent to userspace
	POSIXly correct
In-Reply-To: <1311689686-7451-1-git-send-email-dave.martin@linaro.org>
References: <1311689686-7451-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20110726162905.GA4969@shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 03:14:46PM +0100, Dave Martin wrote:
> With the UM_SIGNAL alignment fault mode, no siginfo structure is
> passed to userspace.
> 
> POSIX specifies how siginfo_t should be populated for alignment
> faults, so this patch does just that:
> 
>   * si_signo = SIGBUS
>   * si_code = BUS_ADRALN
>   * si_addr = address of the faulted instruction
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
>  arch/arm/mm/alignment.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index 724ba3b..9a65aaf 100644
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
> +		si.si_addr = (void __user *)instruction_pointer(regs);

This is wrong. You need something like:

si.si_addr = (void __user *)instruction_pointer(regs) -
	(thumb_mode(regs) ? 2 : 4);
> +
> +		force_sig_info(si.si_signo, &si, current);
> +	} else {
>  		/*
>  		 * We're about to disable the alignment trap and return to
>  		 * user space.  But if an interrupt occurs before actually
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
 Kirill A. Shutemov
