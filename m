From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 22 Mar 2013 22:48:28 +0100
Subject: [PATCH v9 1/3] ARM: Add base support for ARMv7-M
In-Reply-To: <514CA62D.2090905@arm.com>
References: <1363901310-9474-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1363901310-9474-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <514CA62D.2090905@arm.com>
Message-ID: <20130322214828.GR20530@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On Fri, Mar 22, 2013 at 06:42:53PM +0000, Jonathan Austin wrote:
> This looks like a good set of changes! Things are much cleaner now -
> just a question about the nop cache functions and a few other things
> below - some of them are just tiny little things...
Thanks

> On 21/03/13 21:28, Uwe Kleine-K?nig wrote:
> ...
> >--- a/arch/arm/include/asm/glue-cache.h
> >+++ b/arch/arm/include/asm/glue-cache.h
> >@@ -125,10 +125,37 @@
> >  # endif
> >  #endif
> >
> >+#if defined(CONFIG_CPU_V7M)
> >+# ifdef _CACHE
> >+#  define MULTI_CACHE 1
> >+# else
> >+#  define _CACHE nop
> >+# endif
> >+#endif
> >+
> >  #if !defined(_CACHE) && !defined(MULTI_CACHE)
> >  #error Unknown cache maintenance model
> >  #endif
> >
> >+#ifndef __ASSEMBLER__
> >+extern inline void nop_flush_icache_all(void) { }
> >+extern inline void nop_flush_kern_cache_all(void) { }
> >+extern inline void nop_flush_kern_cache_louis(void) { }
> >+extern inline void nop_flush_user_cache_all(void) { }
> >+extern inline void nop_flush_user_cache_range(unsigned long a,
> >+               unsigned long b, unsigned int c) { }
> >+
> >+extern inline void nop_coherent_kern_range(unsigned long a, unsigned long b) { }
> >+extern inline int nop_coherent_user_range(unsigned long a,
> >+               unsigned long b) { return 0; }
> >+extern inline void nop_flush_kern_dcache_area(void *a, size_t s) { }
> >+
> >+extern inline void nop_dma_flush_range(const void *a, const void *b) { }
> >+
> >+extern inline void nop_dma_map_area(const void *s, size_t l, int f) { }
> >+extern inline void nop_dma_unmap_area(const void *s, size_t l, int f) { }
> >+#endif
> >+
> 
> 
> Now that you've added the arch/arm/mm/cache-nop.S do we really need
> these defines? I just tried removing them and it still builds - is
> there a use-case for these I missed?
Well, they still make a difference. With the definitions I get:

	$ objdump -d vmlinux | sed -n '/__soft_restart/,/^$/p'
	8c000e8a <__soft_restart>:
	8c000e8a:	b510      	push	{r4, lr}
	8c000e8c:	4604      	mov	r4, r0
	8c000e8e:	f002 f8f6 	bl	8c00307e <setup_mm_for_reboot>
	8c000e92:	f002 f947 	bl	8c003124 <cpu_v7m_proc_fin>
	8c000e96:	4620      	mov	r0, r4
	8c000e98:	f002 f952 	bl	8c003140 <cpu_v7m_reset>

compared to the following when removing them:

	$ objdump -d vmlinux | sed -n '/__soft_restart/,/^$/p'
	8c000e8a <__soft_restart>:
	8c000e8a:	b510      	push	{r4, lr}
	8c000e8c:	4604      	mov	r4, r0
	8c000e8e:	f002 f929 	bl	8c0030e4 <setup_mm_for_reboot>
	8c000e92:	f002 f985 	bl	8c0031a0 <nop_coherent_kern_range>
	8c000e96:	f002 f995 	bl	8c0031c4 <cpu_v7m_proc_fin>
	8c000e9a:	f002 f981 	bl	8c0031a0 <nop_coherent_kern_range>
	8c000e9e:	4620      	mov	r0, r4
	8c000ea0:	f002 f99e 	bl	8c0031e0 <cpu_v7m_reset>

(Just picked out the first function using the caching functions.) I
think it's worth to keep them.

> >--- /dev/null
> >+++ b/arch/arm/include/asm/v7m.h
> >@@ -0,0 +1,47 @@
> >+/*
> >+ * Common defines for v7m cpus
> >+ */
> >+#define V7M_SCS_ICTR   IOMEM(0xe000e004)
> >+#define V7M_SCS_ICTR_INTLINESNUM_MASK          0x0000000f
> >+
> >+#define V7M_SCS_CPUID  IOMEM(0xe000ed00)
> >+
> 
> This is really the CPUID_BASE register, not the 'CPUID' register.
In "my" ARMARMv7M Table B3-4 calls it CPUID only. The description calls
it "CPUID Base Register" but still I think that CPUID is the right
mnemonic.

> >+#define V7M_SCS_ICSR   IOMEM(0xe000ed04)
> >+#define V7M_SCS_ICSR_PENDSVSET                 (1 << 28)
> >+#define V7M_SCS_ICSR_PENDSVCLR                 (1 << 27)
> >+#define V7M_SCS_ICSR_RETTOBASE                 (1 << 11)
> >+
> >+#define V7M_SCS_VTOR   IOMEM(0xe000ed08)
> >+
> >+#define V7M_SCS_SCR    IOMEM(0xe000ed10)
> >+#define V7M_SCS_SCR_SLEEPDEEP                  (1 << 2)
> >+
> >+#define V7M_SCS_CCR    IOMEM(0xe000ed14)
> >+#define V7M_SCS_CCR_STKALIGN                   (1 << 9)
> >+
> >+#define V7M_SCS_SHPR2  IOMEM(0xe000ed1c)
> >+#define V7M_SCS_SHPR3  IOMEM(0xe000ed20)
> 
> This is just a minor nit, but when reading these it is confusing not
> to have the IOMEM(...) lines aligned with the bitfields...
> 
> Did you have some reasons for doing it this way?
Yes, I consider it confusing if they are aligned. :-)

> If not, I'd like to see them all lined up (and you can remove one
> tabstop too ;-)
> 
> >+
> >+#define V7M_SCS_SHCSR  IOMEM(0xe000ed24)
> >+#define V7M_SCS_SHCSR_USGFAULTENA              (1 << 18)
> >+#define V7M_SCS_SHCSR_BUSFAULTENA              (1 << 17)
> >+#define V7M_SCS_SHCSR_MEMFAULTENA              (1 << 16)
> >+
> >+#define V7M_xPSR_FPALIGN                       0x00000200
> >+
> >+#define EXC_RET_SBOP                           0xffffffe1
> >+#define EXC_RET_FRAMETYPE_MASK                 0x00000010
> >+#define EXC_RET_FRAMETYPE__BASIC               0x00000010
> >+#define EXC_RET_MODE_MASK                      0x00000008
> >+#define EXC_RET_MODE__HANDLER                  0x00000000
> >+#define EXC_RET_MODE__THREAD                   0x00000008
> >+#define EXC_RET_STACK_MASK                     0x00000004
> >+#define EXC_RET_STACK__MAIN                    0x00000000
> >+#define EXC_RET_STACK__PROCESS                 0x00000004
> 
> I grep'd around the source tree looking for a precedent for this
> double underscore behaviour and couldn't find anything.
> 
> I presume that you're trying to denote that these are values 'served
> by' the mask above?
Yes, that's the motivation.

> I think the double underscore looks weird - made me think it was a
> typo... I think you could safely stick with just one, or if you're
> really concerned about the extra distinction, use
> EXC_RET_STACK_VAL_MAIN etc.
I don't like VAL. (But note I don't really like that double underscore
either.) I'll go with

	#define EXC_RET_FRAMETYPE		0x00000010
	#define EXC_RET_FRAMETYPE_BASIC		0x00000010

in the next iteration. So no suffix means it's a mask and with a suffix
it's the corresponding value. Sounds better?

> >+
> >+#define EXC_RET_HANDLERMODE_MAINSTACK  \
> >+       (EXC_RET_SBOP | EXC_RET_FRAMETYPE__BASIC | EXC_RET_MODE__HANDLER | EXC_RET_STACK__MAIN)
> >+#define EXC_RET_THREADMODE_MAINSTACK   \
> >+       (EXC_RET_SBOP | EXC_RET_FRAMETYPE__BASIC | EXC_RET_MODE__THREAD | EXC_RET_STACK__MAIN)
> 
> Do we ever use these two? I can't find any places where we do in
> uwe/efm32. If not, I think perhaps this is a bit over-engineered...
> If you plan to extend the kernel port in the future to use the extra
> modes, by all means keep them in, but couldn't we just define
> EXC_RET_THREADMODE_PROCESSSTACK? (or even call it
> EXC_RET_THREAD_PROCESS?)
I'd really like to see kernel threads run in priviledged thread mode.
But don't know if we'll come to that point. Dropping them is fine for
now because readding them later when (and if) they are needed won't
create much churn I guess.

> ...
> >--- a/arch/arm/kernel/head-nommu.S
> >+++ b/arch/arm/kernel/head-nommu.S
> >@@ -19,6 +19,7 @@
> >  #include <asm/asm-offsets.h>
> >  #include <asm/cp15.h>
> >  #include <asm/thread_info.h>
> >+#include <asm/v7m.h>
> >
> >  /*
> >   * Kernel startup entry point.
> >@@ -50,10 +51,13 @@ ENTRY(stext)
> >
> >         setmode PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
> >                                                 @ and irqs disabled
> >-#ifndef CONFIG_CPU_CP15
> >-       ldr     r9, =CONFIG_PROCESSOR_ID
> >-#else
> >+#if defined(CONFIG_CPU_CP15)
> >         mrc     p15, 0, r9, c0, c0              @ get processor id
> >+#elif defined(CONFIG_CPU_V7M)
> >+       ldr     r9, =V7M_SCS_CPUID
> 
> If you do choose to rename to CPUID_BASE then fix this up too :)
And if not, I don't :-)

> ...
> >--- a/arch/arm/kernel/traps.c
> >+++ b/arch/arm/kernel/traps.c
> >@@ -819,6 +819,7 @@ static void __init kuser_get_tls_init(unsigned long vectors)
> >
> >  void __init early_trap_init(void *vectors_base)
> >  {
> >+#ifndef CONFIG_CPU_V7M
> 
> I think a comment would be nice, just so as not to scare people who
> expect us to need to copy the vector table somewhere.
> 
> /* V7M allows us to use the vector_table in the kernel image */
> 
> Or similar.
good idea

> ...
> >+__v7m_setup:
> >+       @ Configure the vector table base address
> >+       ldr     r0, =V7M_SCS_VTOR       @ vector table base address
> >+       ldr     r12, =vector_table
> >+       str     r12, [r0]
> >+
> >+       @ enable UsageFault, BusFault and MemManage fault.
> >+       ldr     r5, [r0, #(V7M_SCS_SHCSR - V7M_SCS_VTOR)]
> >+       orr     r5, #(V7M_SCS_SHCSR_USGFAULTENA | V7M_SCS_SHCSR_BUSFAULTENA | V7M_SCS_SHCSR_MEMFAULTENA)
> >+       str     r5, [r0, #(V7M_SCS_SHCSR - V7M_SCS_VTOR)]
> 
> This looks weird and is confusing - it makes it seem like there is
> some relationship between SCS_SHCSR and SCS_VTOR, which there isn't
> at all - the only link is that we just loaded SCS_VTOR in to r0 and
> now we want V7M_SCS_SHCSR - right?
> 
> Why not do the "ldr r0, =V7M_SCS_SHCS"? Is it to save the one
> instruction? Or save an entry in the literal pool?
> 
> I don't think for a single instruction/word it is worth the
> confusing way of writing it...
> 
> But then, perhaps I'm missing something?
I think you don't. As this isn't a hot path the few more bytes probably
don't harm.

> ...
> >+       @ Configure the System Control Register
> 
> Can we be a bit more specific here?
> 
> @Configure the System Control Register to ensure 8-byte stack alignment
> 
> >+       ldr     r0, =V7M_SCS_CCR        @ system control register
> >+       ldr     r12, [r0]
> >+       orr     r12, #V7M_SCS_CCR_STKALIGN
> 
> Whether this bit is RO or RW is implementation defined - sorry I
> didn't notice this with earlier responses...
IIRC 8-byte stack alignment is a requirement of EABI. I didn't find out
why yet, but maybe someone can comment here? Russell? Nico?

Section B1.5.7 of ARMARMv7 specifies that if the bit is RO it is also
RAO. So maybe apart from a comment I think this is fine.

> As we always check the stack alignment on exception entry/return I
> think this isn't an issue - but does leave me asking why we bother
> with this if we always do the check?
I don't know why EABI requires an 8-byte aligned stack. See above.

> >+       str     r12, [r0]
> >+       mov     pc, lr
> >+ENDPROC(__v7m_setup)
> >+
> >+       .align  2
> >+       .type   v7m_processor_functions, #object
> >+ENTRY(v7m_processor_functions)
> >+       .word   nommu_early_abort
> >+       .word   cpu_v7m_proc_init
> >+       .word   cpu_v7m_proc_fin
> >+       .word   cpu_v7m_reset
> >+       .word   cpu_v7m_do_idle
> >+       .word   cpu_v7m_dcache_clean_area
> >+       .word   cpu_v7m_switch_mm
> >+       .word   0                       @ cpu_v7m_set_pte_ext
> 
> The fact that we lack a stub function here will mean that compiling
> with module support won't work.
AFAIK no-MMU and modules is always a problematic combination. We have
the kernel run xip from the efm32's flash at address 0x8c000000 and RAM
starts at 0x88000000. That means that a branch from a module (that lives
in RAM) to core kernel code might well be bigger than possible for a
branch instruction.
 
> Do you expect modules to work?
> If not, can we therefore make V7M and CONFIG_MODULES mutually exclusive.
> If so, we should fix this.
the MODULES symbol is defined in init/Kconfig without any preconditions.
Not sure people would welcome me adding a

	depends !ARM || MMU

there ...

> ...
> >+       /*
> >+        * Match any ARMv7-M processor core.
> >+        */
> >+       .type   __v7m_proc_info, #object
> >+__v7m_proc_info:
> >+       .long   0x000f0000              @ Required ID value
> >+       .long   0x000f0000              @ Mask for ID
> >+       .long   0                       @ proc_info_list.__cpu_mm_mmu_flags
> >+       .long   0                       @ proc_info_list.__cpu_io_mmu_flags
> >+       b       __v7m_setup             @ proc_info_list.__cpu_flush
> >+       .long   cpu_arch_name
> >+       .long   cpu_elf_name
> >+       .long   HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
> 
> I don't think M3 has SWP and EDSP...
> 
> based on V7M ARMARM:
> (For SWP)
> "For synchronization, ARMv7-M only supports the byte, halfword, and
> word versions of the load and store exclusive instructions. ARMv7-R
> also supports the doubleword versions of these instructions, and the
> legacy swap instructions"
> (For EDSP)
> None of the instructions listed as coming from the DSP extensions
> are listed in the M3 TRM (eg PKHTB, SXTAB)
Ok. I didn't question these.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
