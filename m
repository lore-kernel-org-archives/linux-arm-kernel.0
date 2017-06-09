From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Jun 2017 16:54:55 +0100
Subject: [PATCH v2 3/3] arm64: mm: print file name of faulting vma
In-Reply-To: <1497022554-1451-3-git-send-email-kristina.martsenko@arm.com>
References: <1497022554-1451-1-git-send-email-kristina.martsenko@arm.com>
 <1497022554-1451-3-git-send-email-kristina.martsenko@arm.com>
Message-ID: <20170609155455.GJ10665@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 04:35:54PM +0100, Kristina Martsenko wrote:
> Print out the name of the file associated with the vma that faulted.
> This is usually the executable or shared library name. We already print
> out the task name, but also printing the library name is useful for
> pinpointing bugs to libraries.
> 
> Also print the base address and size of the vma, which together with the
> PC (printed by __show_regs) gives the offset into the library.
> 
> Fault prints now look like:
> test[2361]: unhandled level 2 translation fault (11) at 0x00000012, esr 0x92000006, in libfoo.so[ffffa0145000+1000]
> 
> This is already done on x86, for more details see commit 03252919b798
> ("x86: print which shared library/executable faulted in segfault etc.
> messages v3").
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> 
> v2:
>  - add this patch
> 
>  arch/arm64/mm/fault.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index b070dcd50ed0..6a2a5dd7cf36 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -256,9 +256,11 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
>  
>  	if (unhandled_signal(tsk, sig) && show_unhandled_signals_ratelimited()) {
>  		inf = esr_to_fault_info(esr);
> -		pr_info("%s[%d]: unhandled %s (%d) at 0x%08lx, esr 0x%03x\n",
> +		pr_info("%s[%d]: unhandled %s (%d) at 0x%08lx, esr 0x%03x",
>  			tsk->comm, task_pid_nr(tsk), inf->name, sig,
>  			addr, esr);
> +		print_vma_addr(KERN_CONT ", in ", regs->pc);
> +		pr_cont("\n");
>  		__show_regs(regs);
>  	}
>  
> -- 
> 2.1.4
> 
