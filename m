From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Jun 2017 16:50:30 +0100
Subject: [PATCH v2 2/3] arm64: mm: don't print out page table entries on
 EL0 faults
In-Reply-To: <1497022554-1451-2-git-send-email-kristina.martsenko@arm.com>
References: <1497022554-1451-1-git-send-email-kristina.martsenko@arm.com>
 <1497022554-1451-2-git-send-email-kristina.martsenko@arm.com>
Message-ID: <20170609155030.GI10665@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 04:35:53PM +0100, Kristina Martsenko wrote:
> When we take a fault from EL0 that can't be handled, we print out the
> page table entries associated with the faulting address. This allows
> userspace to print out any current page table entries, including kernel
> (TTBR1) entries. Exposing kernel mappings like this could pose a
> security risk, so don't print out page table information on EL0 faults.
> (But still print it out for EL1 faults.) This also follows the same
> behaviour as x86, printing out page table entries on kernel mode faults
> but not user mode faults.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
> 
> v2:
>  - mention x86 in commit message
> 
>  arch/arm64/mm/fault.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index a9dfb37c87a2..b070dcd50ed0 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -259,7 +259,6 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
>  		pr_info("%s[%d]: unhandled %s (%d) at 0x%08lx, esr 0x%03x\n",
>  			tsk->comm, task_pid_nr(tsk), inf->name, sig,
>  			addr, esr);
> -		show_pte(addr);
>  		__show_regs(regs);
>  	}

AFAICT, we haven't taken mmap_sem or anything else that would stop
another thread modifying the user page tables. So show_pte() here could
result in dereferencing junk if we were particularly unlucky.

I think we might want to Cc stable on this.

Either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
