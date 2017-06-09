From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Jun 2017 17:04:07 +0100
Subject: [PATCH v2 1/3] arm64: mm: print out correct page table entries
In-Reply-To: <1497022554-1451-1-git-send-email-kristina.martsenko@arm.com>
References: <1497022554-1451-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <20170609160407.GK10665@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 04:35:52PM +0100, Kristina Martsenko wrote:
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

Can we log something for the active_mm == &init_mm case?

e.g.

	if (addr < TASK_SIZE) {
		if (current->active_mm == &init_mm)
			pr_alert("[%016lx] address in unknown TTBR0 range\n",
				addr);
		else
			mm = current->active_mm;
	} ...
	
> +	} else if (addr >= VA_START) {
> +		/* TTBR1 */
>  		mm = &init_mm;
> +	} else {
> +		pr_alert("[%08lx] address between user and kernel address ranges\n",
> +			 addr);

I think that should be %016lx, given the address will be 64-bit.

With those:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
