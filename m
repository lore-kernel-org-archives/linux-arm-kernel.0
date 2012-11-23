From: robherring2@gmail.com (Rob Herring)
Date: Fri, 23 Nov 2012 11:06:07 -0600
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <20121122113401.GC3113@mudshark.cambridge.arm.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121122113401.GC3113@mudshark.cambridge.arm.com>
Message-ID: <50AFACFF.4000907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2012 05:34 AM, Will Deacon wrote:
> Hi Rob,
> 
> On Sun, Nov 11, 2012 at 03:20:40AM +0000, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Use the previously unused TPIDRPRW register to store percpu offsets.
>> TPIDRPRW is only accessible in PL1, so it can only be used in the kernel.
>>
>> This saves 2 loads for each percpu variable access which should yield
>> improved performance, but the improvement has not been quantified.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
>>  arch/arm/include/asm/Kbuild   |    1 -
>>  arch/arm/include/asm/percpu.h |   44 +++++++++++++++++++++++++++++++++++++++++
>>  arch/arm/kernel/smp.c         |    3 +++
>>  3 files changed, 47 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/include/asm/percpu.h
> 
> Russell pointed out to me that this patch will break on v6 CPUs if they don't
> have the thread ID registers and we're running with SMP_ON_UP=y. Looking at
> the TRMs, the only case we care about is 1136 < r1p0, but it does indeed break
> there (I have a board on my desk).

Are there any non ARM Ltd. cores without v6K we need to worry about? I
wouldn't think there are many 1136 < r1p0 out there (your desk being an
obvious exception).

> There are a few ways to fix this:
> 
> (1) Use the SMP alternates to patch the code when running on UP systems. I
>     tried this and the code is absolutely diabolical (see below).
> 
> (2) Rely on the registers being RAZ/WI rather than undef (which seems to be
>     the case on my board) and add on the pcpu delta manually. This is also
>     really horrible.
> 
> (3) Just make the thing depend on __LINUX_ARM_ARCH__ >= 7. Yes, we lose on
>     11MPCore, but we win on A8 and the code is much, much simpler.

I would lean towards this option. It really only has to depend on v6K
and !v6. We can refine the multi-platform selection to allow v7 and v6K
only builds in addition to v7 and v6. I think we are going to have
enough optimizations with v7 (gcc optimizations, thumb2, unaligned
accesses, etc.) that most people will do v7 only builds.

Rob

> 
> As an aside, you also need to make the asm block volatile in
> __my_cpu_offset -- I can see it being re-ordered before the set for
> secondary CPUs otherwise.
> 
> Will
> 
> --->8
> 
> From b12ab049b864c2b6f0be1558c934d7213871b223 Mon Sep 17 00:00:00 2001
> From: Will Deacon <will.deacon@arm.com>
> Date: Wed, 21 Nov 2012 10:53:28 +0000
> Subject: [PATCH 1/2] ARM: smp: move SMP_ON_UP alternate macros to common
>  header file
> 
> The ALT_{UP,SMP} macros are used to patch instructions at runtime
> depending on whether we are running on an SMP platform or not. This is
> generally done in out-of-line assembly code, but there is also the need
> for this functionality in inline assembly (e.g. spinlocks).
> 
> This patch moves the macros into their own header file, which provides
> the correct definitions depending on __ASSEMBLY__.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/assembler.h | 29 +------------------
>  arch/arm/include/asm/smp_on_up.h | 60 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/include/asm/spinlock.h  | 21 +++++---------
>  arch/arm/kernel/head.S           |  1 +
>  arch/arm/kernel/module.c         |  8 ++----
>  5 files changed, 71 insertions(+), 48 deletions(-)
>  create mode 100644 arch/arm/include/asm/smp_on_up.h
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 2ef9581..7da33e0 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -23,6 +23,7 @@
>  #include <asm/ptrace.h>
>  #include <asm/domain.h>
>  #include <asm/opcodes-virt.h>
> +#include <asm/smp_on_up.h>
>  
>  #define IOMEM(x)	(x)
>  
> @@ -166,34 +167,6 @@
>  	.long	9999b,9001f;			\
>  	.popsection
>  
> -#ifdef CONFIG_SMP
> -#define ALT_SMP(instr...)					\
> -9998:	instr
> -/*
> - * Note: if you get assembler errors from ALT_UP() when building with
> - * CONFIG_THUMB2_KERNEL, you almost certainly need to use
> - * ALT_SMP( W(instr) ... )
> - */
> -#define ALT_UP(instr...)					\
> -	.pushsection ".alt.smp.init", "a"			;\
> -	.long	9998b						;\
> -9997:	instr							;\
> -	.if . - 9997b != 4					;\
> -		.error "ALT_UP() content must assemble to exactly 4 bytes";\
> -	.endif							;\
> -	.popsection
> -#define ALT_UP_B(label)					\
> -	.equ	up_b_offset, label - 9998b			;\
> -	.pushsection ".alt.smp.init", "a"			;\
> -	.long	9998b						;\
> -	W(b)	. + up_b_offset					;\
> -	.popsection
> -#else
> -#define ALT_SMP(instr...)
> -#define ALT_UP(instr...) instr
> -#define ALT_UP_B(label) b label
> -#endif
> -
>  /*
>   * Instruction barrier
>   */
> diff --git a/arch/arm/include/asm/smp_on_up.h b/arch/arm/include/asm/smp_on_up.h
> new file mode 100644
> index 0000000..cc9c527
> --- /dev/null
> +++ b/arch/arm/include/asm/smp_on_up.h
> @@ -0,0 +1,60 @@
> +#ifndef __ASM_ARM_SMP_ON_UP_H_
> +#define __ASM_ARM_SMP_ON_UP_H_
> +
> +#ifndef __ASSEMBLY__
> +#ifdef CONFIG_SMP_ON_UP
> +extern int fixup_smp(const void *addr, unsigned long size);
> +#else
> +static inline int fixup_smp(const void *addr, unsigned long size)
> +{
> +	return -EINVAL;
> +}
> +#endif	/* CONFIG_SMP_ON_UP */
> +#endif	/* __ASSEMBLY__ */
> +
> +/*
> + * Note: if you get assembler errors from ALT_UP() when building with
> + * CONFIG_THUMB2_KERNEL, you almost certainly need to use
> + * ALT_SMP( W(instr) ... )
> + */
> +#ifdef CONFIG_SMP
> +#ifndef __ASSEMBLY__
> +
> +#define ALT_SMP(instr)						\
> +	"9998:	" instr "\n"
> +
> +#define ALT_UP(instr)						\
> +	"	.pushsection \".alt.smp.init\", \"a\"\n"	\
> +	"	.long	9998b\n"				\
> +	"	" instr "\n"					\
> +	"	.popsection\n"
> +
> +#else
> +
> +#define ALT_SMP(instr...)					\
> +9998:	instr
> +
> +#define ALT_UP(instr...)					\
> +	.pushsection ".alt.smp.init", "a"			;\
> +	.long	9998b						;\
> +9997:	instr							;\
> +	.if . - 9997b != 4					;\
> +		.error "ALT_UP() content must assemble to exactly 4 bytes";\
> +	.endif							;\
> +	.popsection
> +
> +#define ALT_UP_B(label)						\
> +	.equ	up_b_offset, label - 9998b			;\
> +	.pushsection ".alt.smp.init", "a"			;\
> +	.long	9998b						;\
> +	W(b)	. + up_b_offset					;\
> +	.popsection
> +
> +#endif	/* __ASSEMBLY */
> +#else
> +#define ALT_SMP(instr...)
> +#define ALT_UP(instr...) instr
> +#define ALT_UP_B(label) b label
> +#endif	/* CONFIG_SMP */
> +
> +#endif	/* __ASM_ARM_SMP_ON_UP_H_ */
> diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
> index b4ca707..58d2f42 100644
> --- a/arch/arm/include/asm/spinlock.h
> +++ b/arch/arm/include/asm/spinlock.h
> @@ -6,20 +6,14 @@
>  #endif
>  
>  #include <asm/processor.h>
> +#include <asm/smp_on_up.h>
>  
>  /*
>   * sev and wfe are ARMv6K extensions.  Uniprocessor ARMv6 may not have the K
>   * extensions, so when running on UP, we have to patch these instructions away.
>   */
> -#define ALT_SMP(smp, up)					\
> -	"9998:	" smp "\n"					\
> -	"	.pushsection \".alt.smp.init\", \"a\"\n"	\
> -	"	.long	9998b\n"				\
> -	"	" up "\n"					\
> -	"	.popsection\n"
> -
>  #ifdef CONFIG_THUMB2_KERNEL
> -#define SEV		ALT_SMP("sev.w", "nop.w")
> +#define SEV		ALT_SMP("sev.w")	ALT_UP("nop.w")
>  /*
>   * For Thumb-2, special care is needed to ensure that the conditional WFE
>   * instruction really does assemble to exactly 4 bytes (as required by
> @@ -33,13 +27,12 @@
>   */
>  #define WFE(cond)	ALT_SMP(		\
>  	"it " cond "\n\t"			\
> -	"wfe" cond ".n",			\
> -						\
> -	"nop.w"					\
> -)
> +	"wfe" cond ".n")			\
> +			ALT_UP(			\
> +	"nop.w")
>  #else
> -#define SEV		ALT_SMP("sev", "nop")
> -#define WFE(cond)	ALT_SMP("wfe" cond, "nop")
> +#define SEV		ALT_SMP("sev")		ALT_UP("nop")
> +#define WFE(cond)	ALT_SMP("wfe" cond)	ALT_UP("nop")
>  #endif
>  
>  static inline void dsb_sev(void)
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 4eee351..c44b51f 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -495,6 +495,7 @@ smp_on_up:
>  	.text
>  __do_fixup_smp_on_up:
>  	cmp	r4, r5
> +	movhs	r0, #0
>  	movhs	pc, lr
>  	ldmia	r4!, {r0, r6}
>   ARM(	str	r6, [r0, r3]	)
> diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> index 1e9be5d..f2299d0 100644
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -23,6 +23,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/sections.h>
>  #include <asm/smp_plat.h>
> +#include <asm/smp_on_up.h>
>  #include <asm/unwind.h>
>  
>  #ifdef CONFIG_XIP_KERNEL
> @@ -266,7 +267,6 @@ static const Elf_Shdr *find_mod_section(const Elf32_Ehdr *hdr,
>  }
>  
>  extern void fixup_pv_table(const void *, unsigned long);
> -extern void fixup_smp(const void *, unsigned long);
>  
>  int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
>  		    struct module *mod)
> @@ -323,11 +323,7 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
>  #endif
>  	s = find_mod_section(hdr, sechdrs, ".alt.smp.init");
>  	if (s && !is_smp())
> -#ifdef CONFIG_SMP_ON_UP
> -		fixup_smp((void *)s->sh_addr, s->sh_size);
> -#else
> -		return -EINVAL;
> -#endif
> +		return fixup_smp((void *)s->sh_addr, s->sh_size);
>  	return 0;
>  }
>  
> 
