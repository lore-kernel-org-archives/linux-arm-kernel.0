From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri, 18 Jan 2013 18:23:41 +0000
Subject: [PATCH v8 2/3] Cortex-M3: Add base support for Cortex-M3
In-Reply-To: <1358413196-5609-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1358413196-5609-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1358413196-5609-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <50F9932D.3020406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

I've got a few questions about this patch, as well as some places where 
there are changes that I think would increase the quality.

The most obvious thing that applies throughout is that there are quite a 
bunch of special constants that could really do with #defines... I've 
pulled out a few obvious onese inline below.

On 17/01/13 08:59, Uwe Kleine-K?nig wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
>
> This patch adds the base support for the Cortex-M3 processor (ARMv7-M
> architecture). It consists of the corresponding arch/arm/mm/ files and
> various #ifdef's around the kernel. Exception handling is implemented by
> a subsequent patch.
>
> [ukleinek: squash in some changes originating from commit
>
> b5717ba (Cortex-M3: Add support for the Microcontroller Prototyping System)
>
> from the v2.6.33-arm1 patch stack, port to post 3.6, drop zImage
> support, drop reorganisation of pt_regs, assert CONFIG_V7M doesn't leak
> into installed headers and a few cosmetic changes]
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
[...]
> -#ifdef CONFIG_THUMB2_KERNEL
> +#if defined(CONFIG_CPU_V7M)
> +       .macro  setmode, mode, reg
> +       .endm
> +#elif defined(CONFIG_THUMB2_KERNEL)

Is it really okay to leave setmode doing nothing? My understanding of 
the reason we need it normally is that we can't rely on the bootloader 
entering the kernel in the right mode.

As far as M goes, it *looks* to me that it would be possible to enter 
the kernel in 'handler' mode, as well as privileged thread mode (which I 
presume is the 'right' mode). Is that possible? Likely? Should we 
mitigate against?

>          .macro  setmode, mode, reg
>          mov     \reg, #\mode
>          msr     cpsr_c, \reg
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index cb47d28..5bd8cb6 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -46,6 +46,9 @@ extern unsigned int processor_id;
>                      : "cc");                                            \
>                  __val;                                                  \
>          })
> +#elif defined(CONFIG_CPU_V7M)
> +#define read_cpuid(reg) (*(unsigned int *)0xe000ed00)

Here's the first example of magic constants that aren't ideal, but I've 
said more about magic constants below (I'd much prefer #defines)

> +#define read_cpuid_ext(reg) 0
>   #else
>   #define read_cpuid(reg) (processor_id)
>   #define read_cpuid_ext(reg) 0
> diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
> index cca9f15..ea98658 100644
> --- a/arch/arm/include/asm/glue-cache.h
> +++ b/arch/arm/include/asm/glue-cache.h
> @@ -125,10 +125,35 @@
>   # endif
>   #endif
>
> +#if defined(CONFIG_CPU_V7M)
> +# ifdef _CACHE
> +#  error "Multi-cache not supported on ARMv7-M"
> +# else
> +#  define _CACHE nop
> +# endif
> +#endif
> +

What's the difficulty with MULTI_CACHE that's not encountered with 
MULTI_CPU? Or the reason that you've got MULTI_CPU supported but not 
MULTI_CACHE

I had a look at the mechanisms and couldn't see what would stop your 
nop_cache_fns from being listed in the __v7m_proc_info?

It seems sensible to do this right from the start, especially given the 
scarcity of eyes for review of NOMMU code...

>   #if !defined(_CACHE) && !defined(MULTI_CACHE)
>   #error Unknown cache maintenance model
>   #endif
>
> +#ifndef __ASSEMBLER__
> +static inline void nop_flush_icache_all(void) { }
> +static inline void nop_flush_kern_cache_all(void) { }
> +static inline void nop_flush_kern_cache_louis(void) { }
> +static inline void nop_flush_user_cache_all(void) { }
> +static inline void nop_flush_user_cache_range(unsigned long a, unsigned long b, unsigned int c) { }
> +
> +static inline void nop_coherent_kern_range(unsigned long a, unsigned long b) { }
> +static inline int nop_coherent_user_range(unsigned long a, unsigned long b) { return 0; }
> +static inline void nop_flush_kern_dcache_area(void *a, size_t s) { }
> +
> +static inline void nop_dma_flush_range(const void *a, const void *b) { }
> +
> +static inline void nop_dma_map_area(const void *s, size_t l, int f) { }
> +static inline void nop_dma_unmap_area(const void *s, size_t l, int f) { }
> +#endif
> +
>   #ifndef MULTI_CACHE
>   #define __cpuc_flush_icache_all                __glue(_CACHE,_flush_icache_all)
>   #define __cpuc_flush_kern_all          __glue(_CACHE,_flush_kern_cache_all)
> diff --git a/arch/arm/include/asm/glue-df.h b/arch/arm/include/asm/glue-df.h
> index 8cacbcd..1f2339c 100644
> --- a/arch/arm/include/asm/glue-df.h
> +++ b/arch/arm/include/asm/glue-df.h
> @@ -95,6 +95,14 @@
>   # endif
>   #endif
>
> +#ifdef CONFIG_CPU_ABRT_NOMMU
> +# ifdef CPU_DABORT_HANDLER
> +#  define MULTI_DABORT 1
> +# else
> +#  define CPU_DABORT_HANDLER nommu_early_abort
> +# endif
> +#endif
> +

You haven't added this to the list of models further up in the file - 
looks like until now that list has been maintained so surely we should 
keep it up-to-date?

>   #ifndef CPU_DABORT_HANDLER
>   #error Unknown data abort handler type
>   #endif
> diff --git a/arch/arm/include/asm/glue-proc.h b/arch/arm/include/asm/glue-proc.h
> index ac1dd54..f2f39bc 100644
> --- a/arch/arm/include/asm/glue-proc.h
> +++ b/arch/arm/include/asm/glue-proc.h
> @@ -230,6 +230,15 @@
>   # endif
>   #endif
>
> +#ifdef CONFIG_CPU_V7M
> +# ifdef CPU_NAME
> +#  undef  MULTI_CPU
> +#  define MULTI_CPU
> +# else
> +#  define CPU_NAME cpu_v7m
> +# endif
> +#endif
> +

See my question above about MULTI_CPU and not MULTI_CACHE - strikes me 
as strange...

>   #ifndef MULTI_CPU
>   #define cpu_proc_init                  __glue(CPU_NAME,_proc_init)
>   #define cpu_proc_fin                   __glue(CPU_NAME,_proc_fin)
> diff --git a/arch/arm/include/asm/irqflags.h b/arch/arm/include/asm/irqflags.h
> index 1e6cca5..3b763d6 100644
> --- a/arch/arm/include/asm/irqflags.h
> +++ b/arch/arm/include/asm/irqflags.h
> @@ -8,6 +8,16 @@
>   /*
>    * CPU interrupt mask handling.
>    */
> +#ifdef CONFIG_CPU_V7M
> +#define IRQMASK_REG_NAME_R "primask"
> +#define IRQMASK_REG_NAME_W "primask"
> +#define IRQMASK_I_BIT  1
> +#else
> +#define IRQMASK_REG_NAME_R "cpsr"
> +#define IRQMASK_REG_NAME_W "cpsr_c"
> +#define IRQMASK_I_BIT  PSR_I_BIT
> +#endif
> +
>   #if __LINUX_ARM_ARCH__ >= 6
>
>   static inline unsigned long arch_local_irq_save(void)
> @@ -15,7 +25,7 @@ static inline unsigned long arch_local_irq_save(void)
>          unsigned long flags;
>
>          asm volatile(
> -               "       mrs     %0, cpsr        @ arch_local_irq_save\n"
> +               "       mrs     %0, " IRQMASK_REG_NAME_R "      @ arch_local_irq_save\n"
>                  "       cpsid   i"
>                  : "=r" (flags) : : "memory", "cc");
>          return flags;
> @@ -129,7 +139,7 @@ static inline unsigned long arch_local_save_flags(void)
>   {
>          unsigned long flags;
>          asm volatile(
> -               "       mrs     %0, cpsr        @ local_save_flags"
> +               "       mrs     %0, " IRQMASK_REG_NAME_R "      @ local_save_flags"
>                  : "=r" (flags) : : "memory", "cc");
>          return flags;
>   }
> @@ -140,7 +150,7 @@ static inline unsigned long arch_local_save_flags(void)
>   static inline void arch_local_irq_restore(unsigned long flags)
>   {
>          asm volatile(
> -               "       msr     cpsr_c, %0      @ local_irq_restore"
> +               "       msr     " IRQMASK_REG_NAME_W ", %0      @ local_irq_restore"
>                  :
>                  : "r" (flags)
>                  : "memory", "cc");
> @@ -148,8 +158,8 @@ static inline void arch_local_irq_restore(unsigned long flags)
>
>   static inline int arch_irqs_disabled_flags(unsigned long flags)
>   {
> -       return flags & PSR_I_BIT;
> +       return flags & IRQMASK_I_BIT;
>   }
>
> -#endif
> -#endif
> +#endif /* ifdef __KERNEL__ */
> +#endif /* ifndef __ASM_ARM_IRQFLAGS_H */
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index 06e7d50..5e61b88 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -49,7 +49,14 @@ struct thread_struct {
>   #ifdef CONFIG_MMU
>   #define nommu_start_thread(regs) do { } while (0)
>   #else
> +#ifndef CONFIG_CPU_V7M
>   #define nommu_start_thread(regs) regs->ARM_r10 = current->mm->start_data
> +#else
> +#define nommu_start_thread(regs) do {                                  \
> +       regs->ARM_r10 = current->mm->start_data;                        \

This one isn't really a comment on your patch, because you're 
duplicating the normal nommu behaviour, but why don't we do anything 
special with r9? Isn't that the PIC offset base regiser exclusively in 
uClinux?

Does someone know - is this legacy from before the uClinux stuff was 
EABI compliant and used r10, or is this doing something else?

> +       regs->ARM_EXC_RET = 0xfffffffdL;                                \

So, here's another magic constant...

This corresponds to 'Return to thread mode with process stack'

I think it'd be much clearer to #define these somewhere where the FP 
versions can be added later..

how about
#define ER_THREAD_PROCESS_BASIC 0xFFFFFFFdL

Which I think gives us scope for adding all the FP options (Table 8.8, 
8.9 in V7M ARMARM)

That said, as discussed in the next comment, and on IRC, we should 
probably get rid of this particular instance (regs->ARM_EXC_RET) and 
derive this value based on other saved information.

> +} while (0)
> +#endif
>   #endif
>
>   #define start_thread(regs,pc,sp)                                       \
> diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
> index 3d52ee1..67661e8 100644
> --- a/arch/arm/include/asm/ptrace.h
> +++ b/arch/arm/include/asm/ptrace.h
> @@ -14,7 +14,11 @@
>
>   #ifndef __ASSEMBLY__
>   struct pt_regs {
> +#ifdef CONFIG_CPU_V7M
> +       unsigned long uregs[20];

This increase in pt_regs size is due to the addition of ARM_EXC_RET to 
pt_regs (for the kernel only, not userspace)

However, I think we can avoid doing this, which is nicer because we don't
a) Have a register in pt_regs that isn't actually a register
b) Have less #ifdef'd code, and so the chance of NOMMU getting 
inadvertently broken is lower.

ARM_EXC_RET can be one of the following (assuming we always use the 
basic stack frame)

EXC_RETURN	Return to	Return stack
0xFFFFFFF1	Handler mode	Main
0xFFFFFFF9	Thread mode	Main
0xFFFFFFFD	Thread mode	Process

But we never return to thread mode with the main stack (right?) - so 
really to calculate what ARM_EXC_RET should be we just need to know 
whether the thread is handler mode or thread mode. We can know this from 
the IPSR, and as the xPSR gets saved by both the core at exception time, 
and then by us in to the pt_regs struct, we shouldn't need to *also* 
store EXC_RET out of the lr. This would, of course, also need 
appropriate changes to v7m_exception_entry and v7m_exception_{fast, 
slow}_exit and __irq_entry where we also load EXC_RET into lr.

This way, only when some change or new feature for the kernel actually 
needs to be storing ARM_EXC_RET do we need to think about storing it 
somewhere, be that in the thread_info or pt_regs.

> +#else
>          unsigned long uregs[18];
> +#endif
>   };
>
>   #define user_mode(regs)        \
> @@ -45,6 +49,7 @@ struct pt_regs {
>    */
>   static inline int valid_user_regs(struct pt_regs *regs)
>   {
> +#ifndef CONFIG_CPU_V7M
>          unsigned long mode = regs->ARM_cpsr & MODE_MASK;
>
>          /*
> @@ -67,6 +72,9 @@ static inline int valid_user_regs(struct pt_regs *regs)
>                  regs->ARM_cpsr |= USR_MODE;
>
>          return 0;
> +#else /* ifndef CONFIG_CPU_V7M */
> +       return 1;
> +#endif
>   }
>
>   static inline long regs_return_value(struct pt_regs *regs)
> diff --git a/arch/arm/include/asm/system_info.h b/arch/arm/include/asm/system_info.h
> index dfd386d..720ea03 100644
> --- a/arch/arm/include/asm/system_info.h
> +++ b/arch/arm/include/asm/system_info.h
> @@ -11,6 +11,7 @@
>   #define CPU_ARCH_ARMv5TEJ      7
>   #define CPU_ARCH_ARMv6         8
>   #define CPU_ARCH_ARMv7         9
> +#define CPU_ARCH_ARMv7M                10
>
>   #ifndef __ASSEMBLY__
>
> diff --git a/arch/arm/include/uapi/asm/ptrace.h b/arch/arm/include/uapi/asm/ptrace.h
> index 96ee092..d3be66e 100644
> --- a/arch/arm/include/uapi/asm/ptrace.h
> +++ b/arch/arm/include/uapi/asm/ptrace.h
> @@ -34,28 +34,47 @@
>
>   /*
>    * PSR bits
> + * Note on V7M there is no mode contained in the PSR
>    */
>   #define USR26_MODE     0x00000000
>   #define FIQ26_MODE     0x00000001
>   #define IRQ26_MODE     0x00000002
>   #define SVC26_MODE     0x00000003
> +#if defined(__KERNEL__) && defined(CONFIG_CPU_V7M)
> +/*
> + * Use 0 here to get code right that creates a userspace
> + * or kernel space thread.
> + */
> +#define USR_MODE       0x00000000
> +#define SVC_MODE       0x00000000
> +#else
>   #define USR_MODE       0x00000010
> +#define SVC_MODE       0x00000013
> +#endif
>   #define FIQ_MODE       0x00000011
>   #define IRQ_MODE       0x00000012
> -#define SVC_MODE       0x00000013
>   #define ABT_MODE       0x00000017
>   #define HYP_MODE       0x0000001a
>   #define UND_MODE       0x0000001b
>   #define SYSTEM_MODE    0x0000001f
>   #define MODE32_BIT     0x00000010
>   #define MODE_MASK      0x0000001f
> -#define PSR_T_BIT      0x00000020
> -#define PSR_F_BIT      0x00000040
> -#define PSR_I_BIT      0x00000080
> -#define PSR_A_BIT      0x00000100
> -#define PSR_E_BIT      0x00000200
> -#define PSR_J_BIT      0x01000000
> -#define PSR_Q_BIT      0x08000000
> +
> +#define V4_PSR_T_BIT   0x00000020      /* >= V4T, but not V7M */
> +#define V7M_PSR_T_BIT  0x01000000
> +#if defined(__KERNEL__) && defined(CONFIG_CPU_V7M)
> +#define PSR_T_BIT      V7M_PSR_T_BIT
> +#else
> +/* for compatibility */
> +#define PSR_T_BIT      V4_PSR_T_BIT
> +#endif
> +
> +#define PSR_F_BIT      0x00000040      /* >= V4, but not V7M */
> +#define PSR_I_BIT      0x00000080      /* >= V4, but not V7M */
> +#define PSR_A_BIT      0x00000100      /* >= V6, but not V7M */
> +#define PSR_E_BIT      0x00000200      /* >= V6, but not V7M */
> +#define PSR_J_BIT      0x01000000      /* >= V5J, but not V7M */
> +#define PSR_Q_BIT      0x08000000      /* >= V5E, including V7M */
>   #define PSR_V_BIT      0x10000000
>   #define PSR_C_BIT      0x20000000
>   #define PSR_Z_BIT      0x40000000
> @@ -125,6 +144,7 @@ struct pt_regs {
>   #define ARM_r1         uregs[1]
>   #define ARM_r0         uregs[0]
>   #define ARM_ORIG_r0    uregs[17]
> +#define ARM_EXC_RET    uregs[18]
>

If we can get rid of the pt_regs change, then this can also go away - 
that'd be nice because I'm not sure about it... I don't know what the 
implications of having this defined for userspace are, given that you've got

#ifndef __KERNEL__
struct pt_regs {
         long uregs[18];
};
#endif /* __KERNEL__ */

Should that last definition for ARM_EXC_RET be #ifdef __KERNEL__ too?

>   /*
>    * The size of the user-visible VFP state as seen by PTRACE_GET/SETVFPREGS
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index c985b48..5fe9ace 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -93,6 +93,9 @@ int main(void)
>     DEFINE(S_PC,                 offsetof(struct pt_regs, ARM_pc));
>     DEFINE(S_PSR,                        offsetof(struct pt_regs, ARM_cpsr));
>     DEFINE(S_OLD_R0,             offsetof(struct pt_regs, ARM_ORIG_r0));
> +#ifdef CONFIG_CPU_V7M
> +  DEFINE(S_EXC_RET,            offsetof(struct pt_regs, ARM_EXC_RET));
> +#endif
>     DEFINE(S_FRAME_SIZE,         sizeof(struct pt_regs));
>     BLANK();
>   #ifdef CONFIG_CACHE_L2X0
> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> index 278cfc1..c391c05 100644
> --- a/arch/arm/kernel/head-nommu.S
> +++ b/arch/arm/kernel/head-nommu.S
> @@ -44,10 +44,13 @@ ENTRY(stext)
>
>          setmode PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
>                                                  @ and irqs disabled
> -#ifndef CONFIG_CPU_CP15
> -       ldr     r9, =CONFIG_PROCESSOR_ID
> -#else
> +#if defined(CONFIG_CPU_CP15)
>          mrc     p15, 0, r9, c0, c0              @ get processor id
> +#elif defined(CONFIG_CPU_V7M)
> +       ldr     r9, =0xe000ed00                 @ CPUID register address

Another case where the magic constant makes things less clear...

As these things are architecturally defined (ARMARMv7-M) then can we 
please #define them with their register names?

ldr	r9, =V7M_CPUID

reads much more cleanly.

> +       ldr     r9, [r9]
> +#else
> +       ldr     r9, =CONFIG_PROCESSOR_ID
>   #endif
>          bl      __lookup_processor_type         @ r5=procinfo r9=cpuid
>          movs    r10, r5                         @ invalid processor (r5=0)?
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index da1d1aa..3cca0c8 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -128,7 +128,9 @@ struct stack {
>          u32 und[3];
>   } ____cacheline_aligned;
>
> +#ifndef CONFIG_CPU_V7M
>   static struct stack stacks[NR_CPUS];
> +#endif
>
>   char elf_platform[ELF_PLATFORM_SIZE];
>   EXPORT_SYMBOL(elf_platform);
> @@ -207,7 +209,7 @@ static const char *proc_arch[] = {
>          "5TEJ",
>          "6TEJ",
>          "7",
> -       "?(11)",
> +       "7M",
>          "?(12)",
>          "?(13)",
>          "?(14)",
> @@ -216,6 +218,12 @@ static const char *proc_arch[] = {
>          "?(17)",
>   };
>
> +#ifdef CONFIG_CPU_V7M
> +static int __get_cpu_architecture(void)
> +{
> +       return CPU_ARCH_ARMv7M;
> +}
 > +#else
 >   static int __get_cpu_architecture(void)
 >   {
 >          int cpu_arch;

You've wired up read_cpu_id() and a stub read_cpuid_ext() for V7M so it 
would be better to get rid of this #ifdef.

I'm guessing the problem that caused you to do this was the inline asm 
in __get_cpu_architecture that uses cp15 access.

If you used read_cpu_ext(CPUID_EXT_MMFR0) instead of that asm then you'd
a) clean up the code
b) avoid a possible bug as that asm is not predicated on CONFIG_CPU_CP15

I reckon that could be a separate patch, perhaps?

Then you don't need the #ifdef anymore, right?

> @@ -248,6 +256,7 @@ static int __get_cpu_architecture(void)
>
>          return cpu_arch;
>   }
> +#endif
>
>   int __pure cpu_architecture(void)
>   {
> @@ -375,6 +384,7 @@ static void __init feat_v6_fixup(void)
>    */
>   void cpu_init(void)
>   {
> +#ifndef CONFIG_CPU_V7M

What is it in here that we're avoiding? Couldn't the #ifdefs go around 
the __asm__ in this function instead of the whole thing? Or at most the 
initialisation of stk and the __asm__ block?

cpu_proc_init() is wired (albeit as a stub) for v7m, and I don't  see 
why smp_processor_id() should hurt (it seems like it is defined away in 
the !SMP case in include/linux/smp.h). It could also get quite confusing 
to debug now that we've got a function we can't execute.

Yes, we execute a few more instructions, but reducing the 'delta' 
between M and A/R seems to be a worthwhile pay-off to me...

If there's something hiding in there that I've missed then apologies...

>          unsigned int cpu = smp_processor_id();
>          struct stack *stk = &stacks[cpu];
>
> @@ -419,6 +429,7 @@ void cpu_init(void)
>                "I" (offsetof(struct stack, und[0])),
>                PLC (PSR_F_BIT | PSR_I_BIT | SVC_MODE)
>              : "r14");
> +#endif
>   }
>
>   int __cpu_logical_map[NR_CPUS];
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index b0179b8..12d976b 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -819,6 +819,7 @@ static void __init kuser_get_tls_init(unsigned long vectors)
>
>   void __init early_trap_init(void *vectors_base)
>   {
> +#ifndef CONFIG_CPU_V7M
>          unsigned long vectors = (unsigned long)vectors_base;
>          extern char __stubs_start[], __stubs_end[];
>          extern char __vectors_start[], __vectors_end[];
> @@ -850,4 +851,5 @@ void __init early_trap_init(void *vectors_base)
>
>          flush_icache_range(vectors, vectors + PAGE_SIZE);
>          modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
> +#endif

This looks scary enough ("What, we don't install any vectors!?") that it 
could probably do with a comment along the lines of 'V7M allows us to 
point to a vector table inside the kernel image'

Also helps explain why the kuser helpers aren't going to be around.

>   }
> diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
> index d51225f..4bc8ae5 100644
> --- a/arch/arm/mm/nommu.c
> +++ b/arch/arm/mm/nommu.c
> @@ -20,12 +20,14 @@
>
>   void __init arm_mm_memblock_reserve(void)
>   {
> +#ifndef CONFIG_CPU_V7M
>          /*
>           * Register the exception vector page.
>           * some architectures which the DRAM is the exception vector to trap,
>           * alloc_page breaks with error, although it is not NULL, but "0."
>           */
>          memblock_reserve(CONFIG_VECTORS_BASE, PAGE_SIZE);
> +#endif
>   }
>
>   void __init sanity_check_meminfo(void)
> diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
> new file mode 100644
> index 0000000..2b8eb97
> --- /dev/null
> +++ b/arch/arm/mm/proc-v7m.S
> @@ -0,0 +1,161 @@
> +/*
> + *  linux/arch/arm/mm/proc-v7m.S
> + *
> + *  Copyright (C) 2008 ARM Ltd.
> + *  Copyright (C) 2001 Deep Blue Solutions Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + *  This is the "shell" of the ARMv7-M processor support.
> + */
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +
> +ENTRY(cpu_v7m_proc_init)
> +       mov     pc, lr
> +ENDPROC(cpu_v7m_proc_init)
> +
> +ENTRY(cpu_v7m_proc_fin)
> +       mov     pc, lr
> +ENDPROC(cpu_v7m_proc_fin)
> +
> +/*
> + *     cpu_v7m_reset(loc)
> + *
> + *     Perform a soft reset of the system.  Put the CPU into the
> + *     same state as it would be if it had been reset, and branch
> + *     to what would be the reset vector.
> + *
> + *     - loc   - location to jump to for soft reset
> + */
> +       .align  5
> +ENTRY(cpu_v7m_reset)
> +       mov     pc, r0
> +ENDPROC(cpu_v7m_reset)
> +
> +/*
> + *     cpu_v7m_do_idle()
> + *
> + *     Idle the processor (eg, wait for interrupt).
> + *
> + *     IRQs are already disabled.
> + */
> +ENTRY(cpu_v7m_do_idle)
> +       wfi
> +       mov     pc, lr
> +ENDPROC(cpu_v7m_do_idle)
> +
> +ENTRY(cpu_v7m_dcache_clean_area)
> +       mov     pc, lr
> +ENDPROC(cpu_v7m_dcache_clean_area)
> +
> +/*
> + * There is no MMU, so here is nothing to do.
> + */
> +ENTRY(cpu_v7m_switch_mm)
> +       mov     pc, lr
> +ENDPROC(cpu_v7m_switch_mm)
> +
> +cpu_v7m_name:
> +       .ascii  "ARMv7-M Processor"
> +       .align
> +
> +       .section ".text.init", #alloc, #execinstr
> +
> +/*
> + *     __v7m_setup
> + *
> + *     This should be able to cover all ARMv7-M cores.
> + */
> +__v7m_setup:
> +       @ Configure the vector table base address
> +       ldr     r0, =0xe000ed08         @ vector table base address

Here's the next case of using a 'magic constant register'

In this case, using the register name (say V7M_VTOR) also gives us the 
joy of being able to trivially search in the ARMARM to understand what's 
going on.

I'll stop pointing out the magic registers now, but there are a bunch 
more - I think a search of e000 should pick a lot of them up. (though 
the SVC and PendSV priorities below don't conform to that).

> +       ldr     r12, =vector_table
> +       str     r12, [r0]
> +
> +       @ Lower the priority of the SVC and PendSV exceptions
> +       ldr     r0, =0xe000ed1c
> +       mov     r5, #0x80000000
> +       str     r5, [r0]                @ set SVC priority
> +       ldr     r0, =0xe000ed20
> +       mov     r5, #0x00800000
> +       str     r5, [r0]                @ set PendSV priority
> +
> +       @ SVC to run the kernel in this mode
> +       adr     r0, BSYM(1f)
> +       ldr     r5, [r12, #11 * 4]      @ read the SVC vector entry
> +       str     r0, [r12, #11 * 4]      @ write the temporary SVC vector entry
> +       mov     r6, lr                  @ save LR
> +       mov     r7, sp                  @ save SP
> +       ldr     sp, =__v7m_setup_stack_top
> +       cpsie   i
> +       svc     #0
> +1:     cpsid   i
> +       str     r5, [r12, #11 * 4]      @ restore the original SVC vector entry
> +       mov     lr, r6                  @ restore LR
> +       mov     sp, r7                  @ restore SP
> +
> +       @ Special-purpose control register
> +       mov     r0, #1
> +       msr     control, r0             @ Thread mode has unpriviledged access
> +
> +       @ Configure the System Control Register
> +       ldr     r0, =0xe000ed14         @ system control register
> +       ldr     r12, [r0]
> +       orr     r12, #1 << 9            @ STKALIGN
> +       str     r12, [r0]
> +       mov     pc, lr
> +ENDPROC(__v7m_setup)
> +
> +       .align  2
> +       .type   v7m_processor_functions, #object
> +ENTRY(v7m_processor_functions)
> +       .word   nommu_early_abort
> +       .word   cpu_v7m_proc_init
> +       .word   cpu_v7m_proc_fin
> +       .word   cpu_v7m_reset
> +       .word   cpu_v7m_do_idle
> +       .word   cpu_v7m_dcache_clean_area
> +       .word   cpu_v7m_switch_mm
> +       .word   0                       @ cpu_v7m_set_pte_ext
> +       .word   legacy_pabort
> +       .size   v7m_processor_functions, . - v7m_processor_functions
> +
> +       .type   cpu_arch_name, #object
> +cpu_arch_name:
> +       .asciz  "armv7m"
> +       .size   cpu_arch_name, . - cpu_arch_name
> +
> +       .type   cpu_elf_name, #object
> +cpu_elf_name:
> +       .asciz  "v7m"
> +       .size   cpu_elf_name, . - cpu_elf_name
> +       .align
> +
> +       .section ".proc.info.init", #alloc, #execinstr
> +
> +       /*
> +        * Match any ARMv7-M processor core.
> +        */
> +       .type   __v7m_proc_info, #object
> +__v7m_proc_info:
> +       .long   0x000f0000              @ Required ID value
> +       .long   0x000f0000              @ Mask for ID
> +       .long   0                       @ proc_info_list.__cpu_mm_mmu_flags
> +       .long   0                       @ proc_info_list.__cpu_io_mmu_flags
> +       b       __v7m_setup             @ proc_info_list.__cpu_flush
> +       .long   cpu_arch_name
> +       .long   cpu_elf_name
> +       .long   HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
> +       .long   cpu_v7m_name
> +       .long   v7m_processor_functions @ proc_info_list.proc
> +       .long   0                       @ proc_info_list.tlb
> +       .long   0                       @ proc_info_list.user
> +       .long   0                       @ proc_info_list.cache

Surely here's where we could specify the nop_cache_fns for MULTI_CACHE?

> +       .size   __v7m_proc_info, . - __v7m_proc_info
> +
> +__v7m_setup_stack:
> +       .space  4 * 8                           @ 8 registers
> +__v7m_setup_stack_top:
> --

Hope that's helpful!

Jonny
