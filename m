From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 13 Jul 2012 15:40:38 -0400 (EDT)
Subject: Loading handle_arch_irq with a PC relative load
In-Reply-To: <50007197.8030403@xenomai.org>
References: <50007197.8030403@xenomai.org>
Message-ID: <alpine.LFD.2.02.1207131536260.14068@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jul 2012, Gilles Chanteperdrix wrote:

> 
> I do not know if it is really useful, but it seems it would be possible 
> to reduce the number of memory accesses to just one in the irq_handler 
> macro in the case where CONFIG_MULTI_IRQ_HANDLER is enabled, by using a 
> PC relative load, with something like the following patch:

To be strict with ccode sections, you can't do this.  The 
handle_arch_irq symbol identifies a variable and with your patch you're 
moving it from the .data section to the .text section.  The .text 
section is meant to be read only, and this is even more true when using 
a XIP kernel where .text is in ROM, or if we could make the access 
protection of the kernel ro.


> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 0d1851c..48ee46a 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -37,10 +37,9 @@
>   */
>  	.macro	irq_handler
>  #ifdef CONFIG_MULTI_IRQ_HANDLER
> -	ldr	r1, =handle_arch_irq
>  	mov	r0, sp
>  	adr	lr, BSYM(9997f)
> -	ldr	pc, [r1]
> +	ldr	pc, handle_arch_irq
>  #else
>  	arch_irq_handler_default
>  #endif
> @@ -325,6 +324,12 @@ ENDPROC(__pabt_svc)
>  #endif
>  .LCfp:
>  	.word	fp_enter
> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> +	.globl	handle_arch_irq
> +handle_arch_irq:
> +	.space	4
> +#endif
> +
>  
>  /*
>   * User mode handlers
> @@ -1151,9 +1156,3 @@ cr_alignment:
>  	.space	4
>  cr_no_alignment:
>  	.space	4
> -
> -#ifdef CONFIG_MULTI_IRQ_HANDLER
> -	.globl	handle_arch_irq
> -handle_arch_irq:
> -	.space	4
> -#endif
> 
> 
> -- 
>                                                                 Gilles.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
