From: james.morse@arm.com (James Morse)
Date: Tue, 04 Apr 2017 12:25:21 +0100
Subject: [PATCH v3] arm64: print a fault message when attempting to write
 RO memory
In-Reply-To: <20170404065803.4848-1-stephen.boyd@linaro.org>
References: <20170404065803.4848-1-stephen.boyd@linaro.org>
Message-ID: <58E382A1.4070607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 04/04/17 07:58, Stephen Boyd wrote:
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
> 
> We also fold the userspace address check into is_permission_fault()
> instead of at the current callsite so that the function can't be
> abused with software PAN and a kernel space address.


> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 156169c6981b..c6560cb4ef50 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -321,7 +337,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  		mm_flags |= FAULT_FLAG_WRITE;
>  	}
>  
> -	if (addr < USER_DS && is_permission_fault(esr, regs)) {
> +	if (is_permission_fault(esr, regs, addr)) {
>  		/* regs->orig_addr_limit may be 0 if we entered from EL0 */
>  		if (regs->orig_addr_limit == KERNEL_DS)
>  			die("Accessing user space memory with fs=KERNEL_DS", regs, esr);
> 

This change means the PAN checks claim permission faults on kernel addresses
too, we need to keep the addr check for these. (sorry, I missed this detail
first time round)

When I tried lkdtm's 'WRITE_RO' test it gave:
> [ 2114.718807] Internal error: Accessing user space memory outside uaccess.h
> routines: 9600004e [#1] PREEMPT SMP

With this hunk omitted I got the expected:
> [ 1476.243296] Unable to handle kernel write to read-only memory at virtual
> address ffff000008a11f10

I also gave this a spin on software-models with PAN and PAN+UAO, and TTBR0-PAN
on Juno.


With that hunk omitted:
Reviewed-by: James Morse <james.morse@arm.com>
Tested-by: James Morse <james.morse@arm.com>


Thanks,

James
