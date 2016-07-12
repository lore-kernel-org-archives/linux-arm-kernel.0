From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 12 Jul 2016 14:37:44 +0100
Subject: [PATCHv3] arm64: Handle el1 synchronous instruction aborts cleanly
In-Reply-To: <1467757373-31242-2-git-send-email-labbott@redhat.com>
References: <1467757373-31242-1-git-send-email-labbott@redhat.com>
 <1467757373-31242-2-git-send-email-labbott@redhat.com>
Message-ID: <20160712133741.GC21909@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Tue, Jul 05, 2016 at 03:22:53PM -0700, Laura Abbott wrote:
> Executing from a non-executable area gives an ugly message:
> 
> lkdtm: Performing direct entry EXEC_RODATA
> lkdtm: attempting ok execution at ffff0000084c0e08
> lkdtm: attempting bad execution at ffff000008880700
> Bad mode in Synchronous Abort handler detected on CPU2, code 0x8400000e -- IABT (current EL)
> CPU: 2 PID: 998 Comm: sh Not tainted 4.7.0-rc2+ #13
> Hardware name: linux,dummy-virt (DT)
> task: ffff800077e35780 ti: ffff800077970000 task.ti: ffff800077970000
> PC is at lkdtm_rodata_do_nothing+0x0/0x8
> LR is at execute_location+0x74/0x88
> 
> The 'IABT (current EL)' indicates the error but it's a bit cryptic
> without knowledge of the ARM ARM. There is also no indication of the
> specific address which triggered the fault. The increase in kernel
> page permissions makes hitting this case more likely as well.
> Handling the case in the vectors gives a much more familiar looking
> error message:
> 
> lkdtm: Performing direct entry EXEC_RODATA
> lkdtm: attempting ok execution at ffff0000084c0840
> lkdtm: attempting bad execution at ffff000008880680
> Unable to handle kernel paging request at virtual address ffff000008880680
> pgd = ffff8000089b2000
> [ffff000008880680] *pgd=00000000489b4003, *pud=0000000048904003, *pmd=0000000000000000
> Internal error: Oops: 8400000e [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 PID: 997 Comm: sh Not tainted 4.7.0-rc1+ #24
> Hardware name: linux,dummy-virt (DT)
> task: ffff800077f9f080 ti: ffff800008a1c000 task.ti: ffff800008a1c000
> PC is at lkdtm_rodata_do_nothing+0x0/0x8
> LR is at execute_location+0x74/0x88
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

It's unfortunate that those of us used to looking for 'IABT' lose the
ability to immediately distinguish instruction and data aborts, but that
can be reverse engineered from the later register dump, or the ESR
hidden in the Oops message. I guess we'll need to do some more cleanup
work in this area to make reporting more consistently useful.

Regardless, this looks good, and worked for me in local testing. The
page table dump in the report looks especially useful.

So, with the below comments addressed:

Acked-by: Mark Rutland <mark.rutland@arm.com>

> ---
> v3: Fixup permission in do_page_fault to detect the kernel iabort, don't run
> fixup handlers on kernel instruction aborts.
> 
> Dropped the Acked-by since the addition of checks is pretty significant.
> ---
>  arch/arm64/kernel/entry.S | 18 ++++++++++++++++++
>  arch/arm64/mm/fault.c     | 11 +++++++++--
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 12e8d2b..54e93d12 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -336,6 +336,8 @@ el1_sync:
>  	lsr	x24, x1, #ESR_ELx_EC_SHIFT	// exception class
>  	cmp	x24, #ESR_ELx_EC_DABT_CUR	// data abort in EL1
>  	b.eq	el1_da
> +	cmp	x24, #ESR_ELx_EC_IABT_CUR	// instruction abort in EL1
> +	b.eq	el1_ia
>  	cmp	x24, #ESR_ELx_EC_SYS64		// configurable trap
>  	b.eq	el1_undef
>  	cmp	x24, #ESR_ELx_EC_SP_ALIGN	// stack alignment exception
> @@ -347,6 +349,22 @@ el1_sync:
>  	cmp	x24, #ESR_ELx_EC_BREAKPT_CUR	// debug exception in EL1
>  	b.ge	el1_dbg
>  	b	el1_inv
> +el1_ia:
> +	/*
> +	 * Instruction abort handling
> +	 */
> +	mrs	x0, far_el1
> +	enable_dbg
> +	// re-enable interrupts if they were enabled in the aborted context
> +	tbnz	x23, #7, 1f			// PSR_I_BIT
> +	enable_irq
> +1:
> +	mov	x2, sp				// struct pt_regs
> +	bl	do_mem_abort
> +
> +	// disable interrupts before pulling preserved data off the stack
> +	disable_irq
> +	kernel_exit 1
>  el1_da:
>  	/*
>  	 * Data abort handling
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 013e2cb..e25b0891 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -131,6 +131,11 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
>  }
>  #endif
>  
> +static bool is_el1_instruction_abort(unsigned int esr)
> +{
> +	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_CUR;
> +}

Could we check this in do_page_fault for the
!search_exception_tables(regs->pc) case?

For the EXEC_USERSPACE case, we will log "Accessing user space memory
outside uaccess.h routines", which seems a little off. It would be nice
if we could use this to determine the message, and log something like
"Attempting to execute userspace memory" in the case.

> +
>  /*
>   * The kernel tried to access some page that wasn't present.
>   */
> @@ -139,8 +144,9 @@ static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
>  {
>  	/*
>  	 * Are we prepared to handle this kernel fault?
> +	 * We are almost certainly not prepared to handle instruction faults.
>  	 */
> -	if (fixup_exception(regs))
> +	if (!is_el1_instruction_abort(esr) && fixup_exception(regs))
>  		return;
>  
>  	/*

Your cover letter convinced me that if this occurs we're likely hosed
anyway, so I guess my prior comment about this being a gnarly case
doesn't really hold.

Given that, I'm happy with or without the is_el1_instruction_abort
check here.

> @@ -247,7 +253,8 @@ static inline int permission_fault(unsigned int esr)
>  	unsigned int ec       = (esr & ESR_ELx_EC_MASK) >> ESR_ELx_EC_SHIFT;
>  	unsigned int fsc_type = esr & ESR_ELx_FSC_TYPE;
>  
> -	return (ec == ESR_ELx_EC_DABT_CUR && fsc_type == ESR_ELx_FSC_PERM);
> +	return (ec == ESR_ELx_EC_DABT_CUR && fsc_type == ESR_ELx_FSC_PERM) ||
> +	       (ec == ESR_ELx_EC_IABT_CUR && fsc_type == ESR_ELx_FSC_PERM);
>  }

The name of this function changed with the version of my
kill-esr-lnx-exec series queued in the arm64 for-next/core branch.
Luckily git am -3 is clever enough to figure that out itself, but you
might want to rebase.

Thanks,
Mark.
