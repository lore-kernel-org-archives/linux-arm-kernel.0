From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 30 Nov 2011 14:37:31 -0500 (EST)
Subject: [PATCH] ARM: fix unwinding for XIP kernels
In-Reply-To: <1322680072-14269-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20111130175847.GB6005@mbp-linux>
 <1322680072-14269-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1111301436160.2357@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Nov 2011, Uwe Kleine-K?nig wrote:

> The linker places the unwind tables in readonly sections. So when using
> an XIP kernel these are located in ROM and cannot be modified.
> For that reason the current approach to convert the relative offsets in
> the unwind index to absolute addresses early in the boot process doesn't
> work with XIP.
> 
> The offsets in the unwind index section are signed 31 bit numbers and
> the structs are sorted by this offset. So it first has offsets between
> 0x40000000 and 0x7fffffff (i.e. the negative offsets) and then offsets
> between 0x00000000 and 0x3fffffff. When seperating these two blocks the
> numbers are sorted even when interpreting the offsets as unsigned longs.
> 
> So determine the first non-negative entry once and track that using the
> new origin pointer. The actual bisection can then use a plain unsigned
> long comparison. The only thing that makes the new bisection more
> complicated is that the offsets are relative to their position in the
> index section, so the key to search needs to be adapted accordingly in
> each step.
> 
> Moreover several consts are added to catch future writes and rename the
> member "addr" of struct unwind_idx to "addr_offset" to better match the
> new semantic. (This has the additional benefit of breaking eventual
> users at compile time to make them aware of the change.)
> 
> In my tests the new algorithm was a tad faster than the original and has
> the additional upside of not needing the initial conversion and so saves
> some boot time and it's possible to unwind even earlier.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>

Acked-by: Nicolas Pitre <nico@linaro.org>

> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> the code is the same as the two previous patches combined, only some
> whitespace changes.
> 
> There are a few checkpatch issues left, namely one line over 80 chars
> (which was already there before and IMHO is ok) and two warnings about
> externs in arch/arm/kernel/unwind.c (__start_unwind_idx and
> __stop_unwind_idx) which are ok, too. These externs were there before
> and only the unwinder should care about them.
> 
> Thanks to Catalin to take the time to review my work.
> 
> Best regards
> Uwe
> 
>  arch/arm/include/asm/unwind.h |   16 +----
>  arch/arm/kernel/setup.c       |    2 -
>  arch/arm/kernel/unwind.c      |  129 ++++++++++++++++++++++++++--------------
>  3 files changed, 88 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
> index a5edf42..d1c3f3a 100644
> --- a/arch/arm/include/asm/unwind.h
> +++ b/arch/arm/include/asm/unwind.h
> @@ -30,14 +30,15 @@ enum unwind_reason_code {
>  };
>  
>  struct unwind_idx {
> -	unsigned long addr;
> +	unsigned long addr_offset;
>  	unsigned long insn;
>  };
>  
>  struct unwind_table {
>  	struct list_head list;
> -	struct unwind_idx *start;
> -	struct unwind_idx *stop;
> +	const struct unwind_idx *start;
> +	const struct unwind_idx *origin;
> +	const struct unwind_idx *stop;
>  	unsigned long begin_addr;
>  	unsigned long end_addr;
>  };
> @@ -49,15 +50,6 @@ extern struct unwind_table *unwind_table_add(unsigned long start,
>  extern void unwind_table_del(struct unwind_table *tab);
>  extern void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk);
>  
> -#ifdef CONFIG_ARM_UNWIND
> -extern int __init unwind_init(void);
> -#else
> -static inline int __init unwind_init(void)
> -{
> -	return 0;
> -}
> -#endif
> -
>  #endif	/* !__ASSEMBLY__ */
>  
>  #ifdef CONFIG_ARM_UNWIND
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 7e7977a..cf9d71a 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -893,8 +893,6 @@ void __init setup_arch(char **cmdline_p)
>  {
>  	struct machine_desc *mdesc;
>  
> -	unwind_init();
> -
>  	setup_processor();
>  	mdesc = setup_machine_fdt(__atags_pointer);
>  	if (!mdesc)
> diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
> index e7e8365..3f03fe0 100644
> --- a/arch/arm/kernel/unwind.c
> +++ b/arch/arm/kernel/unwind.c
> @@ -67,7 +67,7 @@ EXPORT_SYMBOL(__aeabi_unwind_cpp_pr2);
>  
>  struct unwind_ctrl_block {
>  	unsigned long vrs[16];		/* virtual register set */
> -	unsigned long *insn;		/* pointer to the current instructions word */
> +	const unsigned long *insn;	/* pointer to the current instructions word */
>  	int entries;			/* number of entries left to interpret */
>  	int byte;			/* current byte number in the instructions word */
>  };
> @@ -83,8 +83,9 @@ enum regs {
>  	PC = 15
>  };
>  
> -extern struct unwind_idx __start_unwind_idx[];
> -extern struct unwind_idx __stop_unwind_idx[];
> +extern const struct unwind_idx __start_unwind_idx[];
> +static const struct unwind_idx *__origin_unwind_idx;
> +extern const struct unwind_idx __stop_unwind_idx[];
>  
>  static DEFINE_SPINLOCK(unwind_lock);
>  static LIST_HEAD(unwind_tables);
> @@ -98,45 +99,99 @@ static LIST_HEAD(unwind_tables);
>  })
>  
>  /*
> - * Binary search in the unwind index. The entries entries are
> + * Binary search in the unwind index. The entries are
>   * guaranteed to be sorted in ascending order by the linker.
> + *
> + * start = first entry
> + * origin = first entry with positive offset (or stop if there is no such entry)
> + * stop - 1 = last entry
>   */
> -static struct unwind_idx *search_index(unsigned long addr,
> -				       struct unwind_idx *first,
> -				       struct unwind_idx *last)
> +static const struct unwind_idx *search_index(unsigned long addr,
> +				       const struct unwind_idx *start,
> +				       const struct unwind_idx *origin,
> +				       const struct unwind_idx *stop)
>  {
> -	pr_debug("%s(%08lx, %p, %p)\n", __func__, addr, first, last);
> +	unsigned long addr_prel31;
> +
> +	pr_debug("%s(%08lx, %p, %p, %p)\n",
> +			__func__, addr, start, origin, stop);
> +
> +	/*
> +	 * only search in the section with the matching sign. This way the
> +	 * prel31 numbers can be compared as unsigned longs.
> +	 */
> +	if (addr < (unsigned long)start)
> +		/* negative offsets: [start; origin) */
> +		stop = origin;
> +	else
> +		/* positive offsets: [origin; stop) */
> +		start = origin;
> +
> +	/* prel31 for address relavive to start */
> +	addr_prel31 = (addr - (unsigned long)start) & 0x7fffffff;
>  
> -	if (addr < first->addr) {
> +	while (start < stop - 1) {
> +		const struct unwind_idx *mid = start + ((stop - start) >> 1);
> +
> +		/*
> +		 * As addr_prel31 is relative to start an offset is needed to
> +		 * make it relative to mid.
> +		 */
> +		if (addr_prel31 - ((unsigned long)mid - (unsigned long)start) <
> +				mid->addr_offset)
> +			stop = mid;
> +		else {
> +			/* keep addr_prel31 relative to start */
> +			addr_prel31 -= ((unsigned long)mid -
> +					(unsigned long)start);
> +			start = mid;
> +		}
> +	}
> +
> +	if (likely(start->addr_offset <= addr_prel31))
> +		return start;
> +	else {
>  		pr_warning("unwind: Unknown symbol address %08lx\n", addr);
>  		return NULL;
> -	} else if (addr >= last->addr)
> -		return last;
> +	}
> +}
>  
> -	while (first < last - 1) {
> -		struct unwind_idx *mid = first + ((last - first + 1) >> 1);
> +static const struct unwind_idx *unwind_find_origin(
> +		const struct unwind_idx *start, const struct unwind_idx *stop)
> +{
> +	pr_debug("%s(%p, %p)\n", __func__, start, stop);
> +	while (start < stop - 1) {
> +		const struct unwind_idx *mid = start + ((stop - start) >> 1);
>  
> -		if (addr < mid->addr)
> -			last = mid;
> +		if (mid->addr_offset >= 0x40000000)
> +			/* negative offset */
> +			start = mid;
>  		else
> -			first = mid;
> +			/* positive offset */
> +			stop = mid;
>  	}
> -
> -	return first;
> +	pr_debug("%s -> %p\n", __func__, stop);
> +	return stop;
>  }
>  
> -static struct unwind_idx *unwind_find_idx(unsigned long addr)
> +static const struct unwind_idx *unwind_find_idx(unsigned long addr)
>  {
> -	struct unwind_idx *idx = NULL;
> +	const struct unwind_idx *idx = NULL;
>  	unsigned long flags;
>  
>  	pr_debug("%s(%08lx)\n", __func__, addr);
>  
> -	if (core_kernel_text(addr))
> +	if (core_kernel_text(addr)) {
> +		if (unlikely(!__origin_unwind_idx))
> +			__origin_unwind_idx =
> +				unwind_find_origin(__start_unwind_idx,
> +						__stop_unwind_idx);
> +
>  		/* main unwind table */
>  		idx = search_index(addr, __start_unwind_idx,
> -				   __stop_unwind_idx - 1);
> -	else {
> +				   __origin_unwind_idx,
> +				   __stop_unwind_idx);
> +	} else {
>  		/* module unwind tables */
>  		struct unwind_table *table;
>  
> @@ -145,7 +200,8 @@ static struct unwind_idx *unwind_find_idx(unsigned long addr)
>  			if (addr >= table->begin_addr &&
>  			    addr < table->end_addr) {
>  				idx = search_index(addr, table->start,
> -						   table->stop - 1);
> +						   table->origin,
> +						   table->stop);
>  				/* Move-to-front to exploit common traces */
>  				list_move(&table->list, &unwind_tables);
>  				break;
> @@ -274,7 +330,7 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
>  int unwind_frame(struct stackframe *frame)
>  {
>  	unsigned long high, low;
> -	struct unwind_idx *idx;
> +	const struct unwind_idx *idx;
>  	struct unwind_ctrl_block ctrl;
>  
>  	/* only go to a higher address on the stack */
> @@ -399,7 +455,6 @@ struct unwind_table *unwind_table_add(unsigned long start, unsigned long size,
>  				      unsigned long text_size)
>  {
>  	unsigned long flags;
> -	struct unwind_idx *idx;
>  	struct unwind_table *tab = kmalloc(sizeof(*tab), GFP_KERNEL);
>  
>  	pr_debug("%s(%08lx, %08lx, %08lx, %08lx)\n", __func__, start, size,
> @@ -408,15 +463,12 @@ struct unwind_table *unwind_table_add(unsigned long start, unsigned long size,
>  	if (!tab)
>  		return tab;
>  
> -	tab->start = (struct unwind_idx *)start;
> -	tab->stop = (struct unwind_idx *)(start + size);
> +	tab->start = (const struct unwind_idx *)start;
> +	tab->stop = (const struct unwind_idx *)(start + size);
> +	tab->origin = unwind_find_origin(tab->start, tab->stop);
>  	tab->begin_addr = text_addr;
>  	tab->end_addr = text_addr + text_size;
>  
> -	/* Convert the symbol addresses to absolute values */
> -	for (idx = tab->start; idx < tab->stop; idx++)
> -		idx->addr = prel31_to_addr(&idx->addr);
> -
>  	spin_lock_irqsave(&unwind_lock, flags);
>  	list_add_tail(&tab->list, &unwind_tables);
>  	spin_unlock_irqrestore(&unwind_lock, flags);
> @@ -437,16 +489,3 @@ void unwind_table_del(struct unwind_table *tab)
>  
>  	kfree(tab);
>  }
> -
> -int __init unwind_init(void)
> -{
> -	struct unwind_idx *idx;
> -
> -	/* Convert the symbol addresses to absolute values */
> -	for (idx = __start_unwind_idx; idx < __stop_unwind_idx; idx++)
> -		idx->addr = prel31_to_addr(&idx->addr);
> -
> -	pr_debug("unwind: ARM stack unwinding initialised\n");
> -
> -	return 0;
> -}
> -- 
> 1.7.7.2
> 
