From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 May 2017 13:21:16 +0100
Subject: [PATCH 2/2] arm64: mm: don't print out page table entries on EL0
 faults
In-Reply-To: <1495453554-9412-2-git-send-email-kristina.martsenko@arm.com>
References: <1495453554-9412-1-git-send-email-kristina.martsenko@arm.com>
 <1495453554-9412-2-git-send-email-kristina.martsenko@arm.com>
Message-ID: <20170522122115.GF1107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 12:45:54PM +0100, Kristina Martsenko wrote:
> When we take a fault from EL0 that can't be handled, we print out the
> page table entries associated with the faulting address. This allows
> userspace to print out any current page table entries, including kernel
> (TTBR1) entries.  Exposing kernel mappings like this could pose a
> security risk, so don't print out page table information on EL0 faults.
> (But still print it out for EL1 faults.)
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>

It might be worth mentioning that this follows the same behaviour as x86.
In fact, they print the name of the faulting VMA using print_vma_addr,
which might be useful too.

Will

> ---
>  arch/arm64/mm/fault.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 0c32f34fb4af..798841f4b00a 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -260,7 +260,6 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
>  		pr_info("%s[%d]: unhandled %s (%d) at 0x%08lx, esr 0x%03x\n",
>  			tsk->comm, task_pid_nr(tsk), inf->name, sig,
>  			addr, esr);
> -		show_pte(addr);
>  		show_regs(regs);
>  	}
>  
> -- 
> 2.1.4
> 
