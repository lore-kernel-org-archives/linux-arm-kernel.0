From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Mar 2011 20:32:35 +0000
Subject: [RFC PATCH] ARM: Use generic BUG() handler
In-Reply-To: <1298939263-16421-1-git-send-email-sjg@chromium.org>
References: <1298939263-16421-1-git-send-email-sjg@chromium.org>
Message-ID: <20110301203235.GE27107@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 04:27:43PM -0800, Simon Glass wrote:
> @@ -55,7 +56,8 @@ static void dump_mem(const char *, const char *, unsigned long, unsigned long);
>  void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame)
>  {
>  #ifdef CONFIG_KALLSYMS
> -	printk("[<%08lx>] (%pS) from [<%08lx>] (%pS)\n", where, (void *)where, from, (void *)from);
> +	printk(" [<%08lx>] (%pS) from [<%08lx>] (%pS)\n", where, (void *)where,
> +	       from, (void *)from);
>  #else
>  	printk("Function entered at [<%08lx>] from [<%08lx>]\n", where, from);
>  #endif
> @@ -171,7 +173,7 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  	unsigned int fp, mode;
>  	int ok = 1;
>  
> -	printk("Backtrace: ");
> +	printk("Backtrace:\n");
>  
>  	if (!tsk)
>  		tsk = current;

Why are you changing the way backtraces are printed?  This introduces a
useless blank line in the oops dump.  The previous hunk increases the
probability of mailers wrapping the backtrace making it harder to read.

If you're going to change the formatting of the Oops dump, please do it
as a separate patch and explain carefully why the change is necessary.

> diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
> index d2cb0b3..3f065bd 100644
> --- a/arch/arm/kernel/unwind.c
> +++ b/arch/arm/kernel/unwind.c
> @@ -355,6 +355,7 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  	register unsigned long current_sp asm ("sp");
>  
>  	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
> +	printk("Backtrace:\n");

Err, no.  This is in the wrong place.

> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 86b66f3..591ab50 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -72,6 +72,18 @@ SECTIONS
>  
>  	PERCPU(PAGE_SIZE)
>  
> +	/*
> +	 * .exit.text is discarded at runtime, not link time, to deal with
> +	 *  references from bug_table
> +	 */
> +	.exit.text : AT(ADDR(.exit.text)) {
> +		EXIT_TEXT
> +	}
> +
> +	.exit.data : AT(ADDR(.exit.data)) {
> +		EXIT_DATA
> +	}
> +
>  #ifndef CONFIG_XIP_KERNEL
>  	. = ALIGN(PAGE_SIZE);
>  	__init_end = .;
> @@ -246,7 +258,6 @@ SECTIONS
>  		__tcm_end = .;
>  	}
>  #endif
> -
>  	BSS_SECTION(0, 0, 0)
>  	_end = .;
>  
> @@ -254,7 +265,7 @@ SECTIONS
>  	.comment 0 : { *(.comment) }
>  
>  	/* Default discards */
> -	DISCARDS
> +	/*DISCARDS*/
>  
>  #ifndef CONFIG_SMP_ON_UP
>  	/DISCARD/ : {

And this is a mess.
