From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 9 Jun 2017 23:22:36 +0300
Subject: [PATCH v2 1/3] arm64: mm: print out correct page table entries
In-Reply-To: <1497022554-1451-1-git-send-email-kristina.martsenko@arm.com>
References: <1497022554-1451-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <20170609202236.t75jejhvhksqmkw3@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Kristina,

On Fri, Jun 09, 2017 at 04:35:52PM +0100, Kristina Martsenko wrote:
> When we take a fault that can't be handled, we print out the page table
> entries associated with the faulting address. In some cases we currently
> print out the wrong entries. For a faulting TTBR1 address, we sometimes
> print out TTBR0 table entries instead, and for a faulting TTBR0 address
> we sometimes print out TTBR1 table entries. Fix this by choosing the
> tables based on the faulting address.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
> 
> v2:
>  - use TASK_SIZE and VA_START, change printed message
> 
>  arch/arm64/include/asm/system_misc.h |  2 +-
>  arch/arm64/mm/fault.c                | 29 +++++++++++++++++++----------
>  2 files changed, 20 insertions(+), 11 deletions(-)

[...]

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index c3f2b1048f83..a9dfb37c87a2 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -80,14 +80,24 @@ static inline int notify_page_fault(struct pt_regs *regs, unsigned int esr)
>  #endif
>  
>  /*
> - * Dump out the page tables associated with 'addr' in mm 'mm'.
> + * Dump out the page tables associated with 'addr' in the currently active mm.
>   */
> -void show_pte(struct mm_struct *mm, unsigned long addr)
> +void show_pte(unsigned long addr)
>  {
> +	struct mm_struct *mm;
>  	pgd_t *pgd;
>  
> -	if (!mm)
> +	if (addr < TASK_SIZE) {
> +		/* TTBR0 */
> +		mm = current->active_mm;
> +	} else if (addr >= VA_START) {
> +		/* TTBR1 */
>  		mm = &init_mm;
> +	} else {
> +		pr_alert("[%08lx] address between user and kernel address ranges\n",
> +			 addr);
> +		return;
> +	}
>  
>  	pr_alert("pgd = %p\n", mm->pgd);
>  	pgd = pgd_offset(mm, addr);

Is there any reason to change the prototype of the function?
You say nothing about it in patch description. The show_pte()
is implemented in several arches, and everywhere it takes mm_struct
as 1st argument. For me, if you don't need to change the prototype,
you'd better leave things as is. The patch will get much shorter
and expressive with it.

If you really need to change the prototype, it would be better to do
it in separated patch and give clear explanations - what for?

Yury
