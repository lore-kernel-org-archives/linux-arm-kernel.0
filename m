From: james.morse@arm.com (James Morse)
Date: Fri, 17 Feb 2017 11:00:39 +0000
Subject: [PATCH v2] arm64: print a fault message when attempting to write
 RO memory
In-Reply-To: <20170217011959.26754-1-stephen.boyd@linaro.org>
References: <20170217011959.26754-1-stephen.boyd@linaro.org>
Message-ID: <58A6D7D7.1030704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 17/02/17 01:19, Stephen Boyd wrote:
> If a page is marked read only we should print out that fact,
> instead of printing out that there was a page fault. Right now we
> get a cryptic error message that something went wrong with an
> unhandled fault, but we don't evaluate the esr to figure out that
> it was a read/write permission fault.
> 
> Instead of seeing:
> 
>   Unable to handle kernel paging request at virtual address ffff000008e460d8
>   pgd = ffff800003504000
>   [ffff000008e460d8] *pgd=0000000083473003, *pud=0000000083503003, *pmd=0000000000000000
>   Internal error: Oops: 9600004f [#1] PREEMPT SMP
> 
> we'll see:
> 
>   Unable to handle kernel write to read-only memory at virtual address ffff000008e760d8
>   pgd = ffff80003d3de000
>   [ffff000008e760d8] *pgd=0000000083472003, *pud=0000000083435003, *pmd=0000000000000000
>   Internal error: Oops: 9600004f [#1] PREEMPT SMP

This looks like a good idea..



> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 156169c6981b..8bd4e7f11c70 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c

>  /*
>   * The kernel tried to access some page that wasn't present.
>   */
>  static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
>  			      unsigned int esr, struct pt_regs *regs)
>  {
> +	const char *msg;
>  	/*
>  	 * Are we prepared to handle this kernel fault?
>  	 * We are almost certainly not prepared to handle instruction faults.
> @@ -177,9 +193,19 @@ static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
>  	 * No handler, we'll have to terminate things with extreme prejudice.
>  	 */
>  	bust_spinlocks(1);
> -	pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
> -		 (addr < PAGE_SIZE) ? "NULL pointer dereference" :
> -		 "paging request", addr);
> +
> +	if (is_permission_fault(esr, regs)) {

is_permission_fault() was previously guarded with a 'addr<USER_DS' check, this
is because it assumes software-PAN is relevant.

The corner case is when the kernel accesses TTBR1-mapped memory while
software-PAN happens to have swivelled TTBR0. Translation faults will be matched
by is_permission_fault(), but permission faults won't.

Juggling is_permission_fault() to look something like:
---%<---
	if (fsc_type == ESR_ELx_FSC_PERM)
		return true;

	if (addr < USER_DS && system_uses_ttbr0_pan())
		return fsc_type == ESR_ELx_FSC_FAULT &&
			(regs->pstate & PSR_PAN_BIT);

	return false;
---%<---
... should fix this.



> +		if (esr & ESR_ELx_WNR)
> +			msg = "write to read-only memory";
> +		else
> +			msg = "read from unreadable memory";
> +	} else if (addr < PAGE_SIZE)
> +		msg = "NULL pointer dereference";
> +	else
> +		msg = "paging request";

Nit: {} all the way down!


> +
> +	pr_alert("Unable to handle kernel %s at virtual address %08lx\n", msg,
> +		 addr);
>  
>  	show_pte(mm, addr);
>  	die("Oops", regs, esr);
> @@ -269,21 +295,6 @@ static int __do_page_fault(struct mm_struct *mm, unsigned long addr,
>  	return fault;
>  }

> -static inline bool is_permission_fault(unsigned int esr, struct pt_regs *regs)
> -{
> -	unsigned int ec       = ESR_ELx_EC(esr);
> -	unsigned int fsc_type = esr & ESR_ELx_FSC_TYPE;
> -
> -	if (ec != ESR_ELx_EC_DABT_CUR && ec != ESR_ELx_EC_IABT_CUR)
> -		return false;
> -
> -	if (system_uses_ttbr0_pan())
> -		return fsc_type == ESR_ELx_FSC_FAULT &&
> -			(regs->pstate & PSR_PAN_BIT);
> -	else
> -		return fsc_type == ESR_ELx_FSC_PERM;
> -}


Thanks!

James
