From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 5 Jan 2010 19:43:28 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v3)
In-Reply-To: <20100105182447.5374.79579.stgit@e101986-lin>
References: <20100105182447.5374.79579.stgit@e101986-lin>
Message-ID: <20100105194328.GG14376@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leif Lindholm wrote:
> +/*
> + * Error-checking SWP macros implemented using ldrex{b}/strex{b}
> + */
> +#define __user_swp_asm(data, addr, res)				\
> +	__asm__ __volatile__(					\
> +	"	mov	r3, %1\n"				\
> +	"0:	ldrex	%1, [%2]\n"				\
> +	"1:	strex	%0, r3, [%2]\n"				\
> +	"	cmp	%0, #0\n"				\
> +	"	movne	%0, %3\n"				\
> +	"2:\n"							\
> +	"	.section .fixup,\"ax\"\n"			\
> +	"	.align	2\n"					\
> +	"3:	mov	%0, %4\n"				\
> +	"	b	2b\n"					\
> +	"	.previous\n"					\
> +	"	.section __ex_table,\"a\"\n"			\
> +	"	.align	3\n"					\
> +	"	.long	0b, 3b\n"				\
> +	"	.long	1b, 3b\n"				\
> +	"	.previous"					\
> +	: "=&r" (res), "+r" (data)				\
> +	: "r" (addr), "i" (-EAGAIN), "i" (-EFAULT)		\
> +	: "cc", "r3")
> +
> +#define __user_swpb_asm(data, addr, res)			\
> +	__asm__ __volatile__(					\
> +	"	mov	r3, %1\n"				\
> +	"0:	ldrexb	%1, [%2]\n"				\
> +	"1:	strexb	%0, r3, [%2]\n"				\
> +	"	cmp	%0, #0\n"				\
> +	"	movne	%0, %3\n"				\
> +	"2:\n"							\
> +	"	.section .fixup,\"ax\"\n"			\
> +	"	.align	2\n"					\
> +	"3:	mov	%0, %4\n"				\
> +	"	b	2b\n"					\
> +	"	.previous\n"					\
> +	"	.section __ex_table,\"a\"\n"			\
> +	"	.align	3\n"					\
> +	"	.long	0b, 3b\n"				\
> +	"	.long	1b, 3b\n"				\
> +	"	.previous"					\
> +	: "=&r" (res), "+r" (data)				\
> +	: "r" (addr), "i" (-EAGAIN), "i" (-EFAULT)		\
> +	: "cc", "r3")

They are almost identical.  The duplication could be removed by
folding it into a single macro with another argument, like this:

#define __user_swp_asm(data, addr, res, B)			\
	"	mov	r3, %1\n"				\
	"0:	ldrex"B"	%1, [%2]\n"			\
	"1:	strex"B"	%0, r3, [%2]\n"			\

Then calling it like this:

		__user_swp_asm(data, address, res, "");
		__user_swp_asm(data, address, res, "b");

> +	if (abtcounter == UINT_MAX)
> +		printk(KERN_WARNING \
> +		       "SWP{B} emulation abort counter wrapped!\n");
> +	abtcounter++;

It's not atomic therefore not precise anyway.  Why not just use u64,
and skip the test and printk?  The code will be shorter and
ironically, faster with u64 because of omitting the test.

> +static int emulate_swp(struct pt_regs *regs, unsigned int address,
> +		       unsigned int destreg, unsigned int data)

> +static int emulate_swpb(struct pt_regs *regs, unsigned int address,
> +			unsigned int destreg, unsigned int data)

Two almost identical functions.  I wonder if it would be better to
merge them and take a flag.  It would also reduce the compiled code size.

> +	do {
> +		if (res == -EAGAIN)
> +			cond_resched();
> +
> +		smp_mb();
> +		__user_swp_asm(data, address, res);
> +	} while ((res == -EAGAIN) && !signal_pending(current));

Why is the smp_mb() needed?  I don't doubt there's a reason, but I
don't see what it is.

The loop looks ok, but it could be simpler in the common path:

	while (1) {
		smp_mb();
		__user_swp_asm(data, address, res);
		if (likely(res != -EAGAIN) || signal_pending(current))
			break;
		cond_resched();
	}

> +	if (res == 0) {
> +		smp_mb();

Why the smp_mb?

> +		regs->uregs[destreg] = data;
> +		if (swpcounter == UINT_MAX)
> +			printk(KERN_WARNING \
> +			       "SWP emulation counter wrapped!\n");
> +		swpcounter++;

As with the other counter, it's probably faster and certainly shorter
code to use a u64 here and omit the test and print.

> +#ifndef CONFIG_ALIGNMENT_TRAP
> +	res = proc_mkdir("cpu", NULL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	res = create_proc_entry("swp_emulation", S_IRUGO, res);
> +#else
> +	res = create_proc_entry("cpu/swp_emulation", S_IRUGO, NULL);
> +#endif

?  Is that to work with different kernel versions?

> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 3a28521..cb85aeb 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -147,8 +147,10 @@ ENTRY(cpu_v7_set_pte_ext)
>  
>  	tst	r1, #L_PTE_USER
>  	orrne	r3, r3, #PTE_EXT_AP1
> +#ifndef CONFIG_SWP_EMULATE
>  	tstne	r3, #PTE_EXT_APX
>  	bicne	r3, r3, #PTE_EXT_APX | PTE_EXT_AP0
> +#endif

Is this the part which changes kernel memory access to fault when
writing to user-read-only pages?  (I don't know anything about the
details of this, btw).

Is there any reason why this wasn't always like that?

-- Jamie
