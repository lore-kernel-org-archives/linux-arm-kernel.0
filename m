From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 22 May 2010 21:15:13 -0400 (EDT)
Subject: [RFC PATCH 1/2] allow each machine to specify it's own IRQ
	handlers at run-time
In-Reply-To: <AANLkTin9OHUGtKSg7554ucVhufQ3PiKXALmD0Lh7A-yt@mail.gmail.com>
References: <AANLkTin9OHUGtKSg7554ucVhufQ3PiKXALmD0Lh7A-yt@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1005222106500.15379@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 22 May 2010, Eric Miao wrote:

> commit edec494b3dbf52a61a18b484dd05cce6a9d90e2f
> Author: Eric Miao <eric.y.miao@gmail.com>
> Date:   Sat May 22 11:58:01 2010 +0800
> 
>     [ARM] allow each machine to specify it's own IRQ handlers at run-time
> 
>     Normally different ARM platform has different way to decode the IRQ
>     hardware status and demultiplex to the corresponding IRQ handler.
>     This is highly optimized by macro irq_handler in entry-armv.S, and
>     each machine class defines their own macro to decode the IRQ number.
>     However, this prevents multiple machine classes to be built into a
>     single kernel.
> 
>     By allowing each machine to specify thier own handler, and making
>     function pointer 'handle_arch_irq' to point to it at run time, this
>     can be solved. And introduce CONFIG_MULTI_IRQ_HANDLER to allow both
>     solutions to work.
> 
>     Comparing with the highly optimized macro of irq_handler, the new
>     function must be written with care not to lose too much performance.
> 
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

Looks fine to me.

Might be a good idea to mention in the patch description text that the 
IPI stuff on SMP is expected to move to the provided arch IRQ handler as 
well.  That would probably be a good thing given the current comment 
above that code.


> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ddf5676..a8f5f78 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -958,6 +958,11 @@ config CPU_HAS_PMU
>  	default y
>  	bool
> 
> +config MULTI_IRQ_HANDLER
> +	bool
> +	help
> +	  Allow each machine to specify it's own IRQ handler at run time.
> +
>  if !MMU
>  source "arch/arm/Kconfig-nommu"
>  endif
> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> index 5ee6f85..b611895 100644
> --- a/arch/arm/include/asm/mach/arch.h
> +++ b/arch/arm/include/asm/mach/arch.h
> @@ -42,6 +42,9 @@ struct machine_desc {
>  	void			(*init_irq)(void);
>  	struct sys_timer	*timer;		/* system tick timer	*/
>  	void			(*init_machine)(void);
> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> +	void			(*handle_irq)(struct pt_regs *);
> +#endif
>  };
> 
>  /*
> diff --git a/arch/arm/include/asm/mach/irq.h b/arch/arm/include/asm/mach/irq.h
> index ce3eee9..6ecdad9 100644
> --- a/arch/arm/include/asm/mach/irq.h
> +++ b/arch/arm/include/asm/mach/irq.h
> @@ -22,6 +22,10 @@ extern void (*init_arch_irq)(void);
>  extern void init_FIQ(void);
>  extern int show_fiq_list(struct seq_file *, void *);
> 
> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> +extern void (*handle_arch_irq)(struct pt_regs *);
> +#endif
> +
>  /*
>   * This is for easy migration, but should be changed in the source
>   */
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 7ee48e7..ecb8492 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -28,6 +28,7 @@
>  /*
>   * Interrupt handling.  Preserves r7, r8, r9
>   */
> +#ifndef CONFIG_MULTI_IRQ_HANDLER
>  	.macro	irq_handler
>  	get_irqnr_preamble r5, lr
>  1:	get_irqnr_and_base r0, r6, r5, lr
> @@ -59,6 +60,14 @@
>  #endif
> 
>  	.endm
> +#else
> +	.macro	irq_handler
> +	ldr	r4, =handle_arch_irq
> +	mov	r0, sp
> +	mov	lr, pc
> +	ldr	pc, [r4]
> +	.endm
> +#endif	/* CONFIG_MULTI_IRQ_HANDLER */
> 
>  #ifdef CONFIG_KPROBES
>  	.section	.kprobes.text,"ax",%progbits
> @@ -1251,3 +1260,9 @@ cr_alignment:
>  	.space	4
>  cr_no_alignment:
>  	.space	4
> +
> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> +	.globl	handle_arch_irq
> +handle_arch_irq:
> +	.long	0
> +#endif
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index f1aee0d..61d5f8d 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -732,6 +732,10 @@ void __init setup_arch(char **cmdline_p)
>  	system_timer = mdesc->timer;
>  	init_machine = mdesc->init_machine;
> 
> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> +	handle_arch_irq = mdesc->handle_irq;
> +#endif
> +
>  #ifdef CONFIG_VT
>  #if defined(CONFIG_VGA_CONSOLE)
>  	conswitchp = &vga_con;
> 
