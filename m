From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Fri, 18 Sep 2009 14:18:54 +0300
Subject: [PATCH 1/2] ARM: Pass IFSR register to do_PrefetchAbort()
In-Reply-To: <f00f1348d91d2403ea0f1c5f05b3ac713664fe7b.1253281256.git.kirill@shutemov.name>
References: <f00f1348d91d2403ea0f1c5f05b3ac713664fe7b.1253281256.git.kirill@shutemov.name>
Message-ID: <4AB36C9E.30902@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

ext Kirill A. Shutemov wrote:
>  # ifdef CPU_PABORT_HANDLER
>  #  define MULTI_PABORT 1
>  # else
> -#  define CPU_PABORT_HANDLER(reg, insn)	mrc p15, 0, reg, cr6, cr0, 2
> +#  define CPU_PABORT_HANDLER ifar_pabort
>  # endif
>  #endif
>  
> @@ -138,7 +138,7 @@
>  # ifdef CPU_PABORT_HANDLER
>  #  define MULTI_PABORT 1
>  # else
> -#  define CPU_PABORT_HANDLER(reg, insn)	mov reg, insn
> +#  define CPU_PABORT_HANDLER noifar_pabort
>  # endif
>  #endif

I think the point of these was that they can be inlined. Note that the 
kernel already have functions pabort_ifar() and pabort_noifar(). You 
should modifed them _and_ the inlined asm.

> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 85040cf..dbb4ce7 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -291,22 +291,16 @@ __pabt_svc:
>  	tst	r3, #PSR_I_BIT
>  	biceq	r9, r9, #PSR_I_BIT
>  
> -	@
> -	@ set args, then call main handler
> -	@
> -	@  r0 - address of faulting instruction
> -	@  r1 - pointer to registers on stack
> -	@
>  #ifdef MULTI_PABORT
>  	mov	r0, r2			@ pass address of aborted instruction.
>  	ldr	r4, .LCprocfns
>  	mov	lr, pc
>  	ldr	pc, [r4, #PROCESSOR_PABT_FUNC]
>  #else
> -	CPU_PABORT_HANDLER(r0, r2)
> +	bl	CPU_PABORT_HANDLER

You are not passing the correct parameter in r0.

>  #endif
>  	msr	cpsr_c, r9			@ Maybe enable interrupts
> -	mov	r1, sp				@ regs
> +	mov	r2, sp				@ regs
>  	bl	do_PrefetchAbort		@ call abort handler
>  
>  	@
> @@ -666,10 +660,10 @@ __pabt_usr:
>  	mov	lr, pc
>  	ldr	pc, [r4, #PROCESSOR_PABT_FUNC]
>  #else
> -	CPU_PABORT_HANDLER(r0, r2)
> +	bl	CPU_PABORT_HANDLER

Same here.

>  #endif
>  	enable_irq				@ Enable interrupts
> -	mov	r1, sp				@ regs
> +	mov	r2, sp				@ regs
>  	bl	do_PrefetchAbort		@ call abort handler
>  	/* fall through */
>  /*
> diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
> index 480f78a..30f1708 100644
> --- a/arch/arm/mm/Makefile
> +++ b/arch/arm/mm/Makefile
> @@ -78,3 +78,5 @@ obj-$(CONFIG_CACHE_FEROCEON_L2)	+= cache-feroceon-l2.o
>  obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
>  obj-$(CONFIG_CACHE_XSC3L2)	+= cache-xsc3l2.o
>  
> +obj-$(CONFIG_CPU_PABRT_NOIFAR)	+= pabort-noifar.o
> +obj-$(CONFIG_CPU_PABRT_IFAR)	+= pabort-ifar.o

These are duplicate functions.

> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 22c9530..c7bbb32 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -480,7 +480,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  }
>  
>  asmlinkage void __exception
> -do_PrefetchAbort(unsigned long addr, struct pt_regs *regs)
> +do_PrefetchAbort(unsigned long addr, int ifsr, struct pt_regs *regs)
>  {
>  	do_translation_fault(addr, 0, regs);
>  }
> diff --git a/arch/arm/mm/pabort-ifar.S b/arch/arm/mm/pabort-ifar.S
> new file mode 100644
> index 0000000..46838ea
> --- /dev/null
> +++ b/arch/arm/mm/pabort-ifar.S
> @@ -0,0 +1,18 @@
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +
> +/*
> + * Function: ifar_pabort
> + *
> + * Returns : r0 = address of abort
> + *	   : r1 = IFSR
> + *
> + * Purpose : obtain information about current prefetch abort.
> + */
> +	.align	5
> +ENTRY(ifar_pabort)
> +	mrc	p15, 0, r0, c6, c0, 2		@ get IFAR
> +	mrc	p15, 0, r1, c5, c0, 1		@ get IFSR
> +
> +	mov	pc, lr
> +ENDPROC(ifar_pabort)
> diff --git a/arch/arm/mm/pabort-noifar.S b/arch/arm/mm/pabort-noifar.S
> new file mode 100644
> index 0000000..46b0daf
> --- /dev/null
> +++ b/arch/arm/mm/pabort-noifar.S
> @@ -0,0 +1,18 @@
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +
> +/*
> + * Function: noifar_pabort
> +
> + * Returns : r0 = address of abort
> + *	   : r1 = 5, simulate IFSR with section translation fault status
> + *
> + * Purpose : obtain information about current prefetch abort.
> + */
> +	.align	5
> +ENTRY(noifar_pabort)
> +	mov	r0, insn
> +	mov	r1, #5		@ translation fault
> +
> +	mov	pc, lr
> +ENDPROC(noifar_pabort)

What's the "insn" here?? And even if no IFAR is implemented, there 
should be IFSR. For NOMMU there should be pabort_noifsr simply returning 
zero values, similar to data abort handler.

A.
