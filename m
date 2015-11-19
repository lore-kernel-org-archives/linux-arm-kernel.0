From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 19 Nov 2015 10:54:16 -0500 (EST)
Subject: [PATCH] ARM: xip: Move XIP linking to a separate file
In-Reply-To: <1447943047-22427-1-git-send-email-chris.brandt@renesas.com>
References: <1447943047-22427-1-git-send-email-chris.brandt@renesas.com>
Message-ID: <alpine.LFD.2.20.1511191050080.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Nov 2015, Chris Brandt wrote:

> When building an XIP kernel, the linker script needs to be much different
> than a conventional kernel's script. Over time, it's been difficult to
> maintain both XIP and non-XIP layouts in one linker script. Therefore,
> this patch separates the two procedures into two completely different
> files.
> 
> The new linker script is essentially a straight copy of the current script
> with all the non-CONFIG_XIP_KERNEL portions removed.
> 
> Additionally, all CONFIG_XIP_KERNEL portions have been removed from the
> existing linker script...never to return again.

Would be worth mentioning that XIP is still broken and this is just the 
first move to fix it properly with subsequent patches.

> From now on, for any architecture, when CONFIG_XIP_KERNEL is enabled, you
> must provide a vmlinux-xip.lds.S for the build process.

I agree with Michal's suggestion to do the selection locally with an 
include.  This could be commonalized in the main makefile if many 
architecturs come to have XIP support.





> 
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
>  Makefile                          |    4 +
>  arch/arm/kernel/.gitignore        |    1 +
>  arch/arm/kernel/vmlinux-xip.lds.S |  322 +++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/vmlinux.lds.S     |   31 +---
>  4 files changed, 331 insertions(+), 27 deletions(-)
>  create mode 100644 arch/arm/kernel/vmlinux-xip.lds.S
> 
> diff --git a/Makefile b/Makefile
> index 3a0234f..b55440f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -900,7 +900,11 @@ virt-y		:= $(patsubst %/, %/built-in.o, $(virt-y))
>  # Externally visible symbols (used by link-vmlinux.sh)
>  export KBUILD_VMLINUX_INIT := $(head-y) $(init-y)
>  export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y) $(virt-y)
> +ifdef CONFIG_XIP_KERNEL
> +export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux-xip.lds
> +else
>  export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
> +endif
>  export LDFLAGS_vmlinux
>  # used by scripts/pacmage/Makefile
>  export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) arch Documentation include samples scripts tools)
> diff --git a/arch/arm/kernel/.gitignore b/arch/arm/kernel/.gitignore
> index c5f676c..522c636 100644
> --- a/arch/arm/kernel/.gitignore
> +++ b/arch/arm/kernel/.gitignore
> @@ -1 +1,2 @@
>  vmlinux.lds
> +vmlinux-xip.lds
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> new file mode 100644
> index 0000000..1fd938d
> --- /dev/null
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -0,0 +1,322 @@
> +/* ld script to make ARM Linux kernel
> + * taken from the i386 version by Russell King
> + * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
> + */
> +
> +#include <asm-generic/vmlinux.lds.h>
> +#include <asm/cache.h>
> +#include <asm/thread_info.h>
> +#include <asm/memory.h>
> +#include <asm/page.h>
> +#ifdef CONFIG_ARM_KERNMEM_PERMS
> +#include <asm/pgtable.h>
> +#endif
> +
> +#define PROC_INFO							\
> +	. = ALIGN(4);							\
> +	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
> +	*(.proc.info.init)						\
> +	VMLINUX_SYMBOL(__proc_info_end) = .;
> +
> +#define IDMAP_TEXT							\
> +	ALIGN_FUNCTION();						\
> +	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
> +	*(.idmap.text)							\
> +	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
> +	. = ALIGN(PAGE_SIZE);						\
> +	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;			\
> +	*(.hyp.idmap.text)						\
> +	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +#define ARM_CPU_DISCARD(x)
> +#define ARM_CPU_KEEP(x)		x
> +#else
> +#define ARM_CPU_DISCARD(x)	x
> +#define ARM_CPU_KEEP(x)
> +#endif
> +
> +#if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
> +	defined(CONFIG_GENERIC_BUG)
> +#define ARM_EXIT_KEEP(x)	x
> +#define ARM_EXIT_DISCARD(x)
> +#else
> +#define ARM_EXIT_KEEP(x)
> +#define ARM_EXIT_DISCARD(x)	x
> +#endif
> +
> +OUTPUT_ARCH(arm)
> +ENTRY(stext)
> +
> +#ifndef __ARMEB__
> +jiffies = jiffies_64;
> +#else
> +jiffies = jiffies_64 + 4;
> +#endif
> +
> +SECTIONS
> +{
> +	/*
> +	 * XXX: The linker does not define how output sections are
> +	 * assigned to input sections when there are multiple statements
> +	 * matching the same input section name.  There is no documented
> +	 * order of matching.
> +	 *
> +	 * unwind exit sections must be discarded before the rest of the
> +	 * unwind sections get included.
> +	 */
> +	/DISCARD/ : {
> +		*(.ARM.exidx.exit.text)
> +		*(.ARM.extab.exit.text)
> +		ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))
> +		ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))
> +		ARM_EXIT_DISCARD(EXIT_TEXT)
> +		ARM_EXIT_DISCARD(EXIT_DATA)
> +		EXIT_CALL
> +#ifndef CONFIG_MMU
> +		*(.text.fixup)
> +		*(__ex_table)
> +#endif
> +#ifndef CONFIG_SMP_ON_UP
> +		*(.alt.smp.init)
> +#endif
> +		*(.discard)
> +		*(.discard.*)
> +	}
> +
> +	. = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
> +
> +	.head.text : {
> +		_text = .;
> +		HEAD_TEXT
> +	}
> +
> +#ifdef CONFIG_ARM_KERNMEM_PERMS
> +	. = ALIGN(1<<SECTION_SHIFT);
> +#endif
> +
> +	.text : {			/* Real text segment		*/
> +		_stext = .;		/* Text and read-only data	*/
> +			IDMAP_TEXT
> +			__exception_text_start = .;
> +			*(.exception.text)
> +			__exception_text_end = .;
> +			IRQENTRY_TEXT
> +			TEXT_TEXT
> +			SCHED_TEXT
> +			LOCK_TEXT
> +			KPROBES_TEXT
> +			*(.gnu.warning)
> +			*(.glue_7)
> +			*(.glue_7t)
> +		. = ALIGN(4);
> +		*(.got)			/* Global offset table		*/
> +			ARM_CPU_KEEP(PROC_INFO)
> +	}
> +
> +#ifdef CONFIG_DEBUG_RODATA
> +	. = ALIGN(1<<SECTION_SHIFT);
> +#endif
> +	RO_DATA(PAGE_SIZE)
> +
> +	. = ALIGN(4);
> +	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
> +		__start___ex_table = .;
> +#ifdef CONFIG_MMU
> +		*(__ex_table)
> +#endif
> +		__stop___ex_table = .;
> +	}
> +
> +#ifdef CONFIG_ARM_UNWIND
> +	/*
> +	 * Stack unwinding tables
> +	 */
> +	. = ALIGN(8);
> +	.ARM.unwind_idx : {
> +		__start_unwind_idx = .;
> +		*(.ARM.exidx*)
> +		__stop_unwind_idx = .;
> +	}
> +	.ARM.unwind_tab : {
> +		__start_unwind_tab = .;
> +		*(.ARM.extab*)
> +		__stop_unwind_tab = .;
> +	}
> +#endif
> +
> +	NOTES
> +
> +	_etext = .;			/* End of text and rodata section */
> +
> +	/*
> +	 * The vectors and stubs are relocatable code, and the
> +	 * only thing that matters is their relative offsets
> +	 */
> +	__vectors_start = .;
> +	.vectors 0 : AT(__vectors_start) {
> +		*(.vectors)
> +	}
> +	. = __vectors_start + SIZEOF(.vectors);
> +	__vectors_end = .;
> +
> +	__stubs_start = .;
> +	.stubs 0x1000 : AT(__stubs_start) {
> +		*(.stubs)
> +	}
> +	. = __stubs_start + SIZEOF(.stubs);
> +	__stubs_end = .;
> +
> +	INIT_TEXT_SECTION(8)
> +	.exit.text : {
> +		ARM_EXIT_KEEP(EXIT_TEXT)
> +	}
> +	.init.proc.info : {
> +		ARM_CPU_DISCARD(PROC_INFO)
> +	}
> +	.init.arch.info : {
> +		__arch_info_begin = .;
> +		*(.arch.info.init)
> +		__arch_info_end = .;
> +	}
> +	.init.tagtable : {
> +		__tagtable_begin = .;
> +		*(.taglist.init)
> +		__tagtable_end = .;
> +	}
> +#ifdef CONFIG_SMP_ON_UP
> +	.init.smpalt : {
> +		__smpalt_begin = .;
> +		*(.alt.smp.init)
> +		__smpalt_end = .;
> +	}
> +#endif
> +	.init.pv_table : {
> +		__pv_table_begin = .;
> +		*(.pv_table)
> +		__pv_table_end = .;
> +	}
> +	.init.data : {
> +		INIT_SETUP(16)
> +		INIT_CALLS
> +		CON_INITCALL
> +		SECURITY_INITCALL
> +		INIT_RAM_FS
> +	}
> +
> +#ifdef CONFIG_SMP
> +	PERCPU_SECTION(L1_CACHE_BYTES)
> +#endif
> +
> +	__data_loc = ALIGN(4);		/* location in binary */
> +	. = PAGE_OFFSET + TEXT_OFFSET;
> +
> +	.data : AT(__data_loc) {
> +		_data = .;		/* address in memory */
> +		_sdata = .;
> +
> +		/*
> +		 * first, the init task union, aligned
> +		 * to an 8192 byte boundary.
> +		 */
> +		INIT_TASK_DATA(THREAD_SIZE)
> +
> +		. = ALIGN(PAGE_SIZE);
> +		__init_begin = .;
> +		INIT_DATA
> +		ARM_EXIT_KEEP(EXIT_DATA)
> +		. = ALIGN(PAGE_SIZE);
> +		__init_end = .;
> +
> +		NOSAVE_DATA
> +		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
> +		READ_MOSTLY_DATA(L1_CACHE_BYTES)
> +
> +		/*
> +		 * and the usual data section
> +		 */
> +		DATA_DATA
> +		CONSTRUCTORS
> +
> +		_edata = .;
> +	}
> +	_edata_loc = __data_loc + SIZEOF(.data);
> +
> +#ifdef CONFIG_HAVE_TCM
> +        /*
> +	 * We align everything to a page boundary so we can
> +	 * free it after init has commenced and TCM contents have
> +	 * been copied to its destination.
> +	 */
> +	.tcm_start : {
> +		. = ALIGN(PAGE_SIZE);
> +		__tcm_start = .;
> +		__itcm_start = .;
> +	}
> +
> +	/*
> +	 * Link these to the ITCM RAM
> +	 * Put VMA to the TCM address and LMA to the common RAM
> +	 * and we'll upload the contents from RAM to TCM and free
> +	 * the used RAM after that.
> +	 */
> +	.text_itcm ITCM_OFFSET : AT(__itcm_start)
> +	{
> +		__sitcm_text = .;
> +		*(.tcm.text)
> +		*(.tcm.rodata)
> +		. = ALIGN(4);
> +		__eitcm_text = .;
> +	}
> +
> +	/*
> +	 * Reset the dot pointer, this is needed to create the
> +	 * relative __dtcm_start below (to be used as extern in code).
> +	 */
> +	. = ADDR(.tcm_start) + SIZEOF(.tcm_start) + SIZEOF(.text_itcm);
> +
> +	.dtcm_start : {
> +		__dtcm_start = .;
> +	}
> +
> +	/* TODO: add remainder of ITCM as well, that can be used for data! */
> +	.data_dtcm DTCM_OFFSET : AT(__dtcm_start)
> +	{
> +		. = ALIGN(4);
> +		__sdtcm_data = .;
> +		*(.tcm.data)
> +		. = ALIGN(4);
> +		__edtcm_data = .;
> +	}
> +
> +	/* Reset the dot pointer or the linker gets confused */
> +	. = ADDR(.dtcm_start) + SIZEOF(.data_dtcm);
> +
> +	/* End marker for freeing TCM copy in linked object */
> +	.tcm_end : AT(ADDR(.dtcm_start) + SIZEOF(.data_dtcm)){
> +		. = ALIGN(PAGE_SIZE);
> +		__tcm_end = .;
> +	}
> +#endif
> +
> +	BSS_SECTION(0, 0, 0)
> +	_end = .;
> +
> +	STABS_DEBUG
> +}
> +
> +/*
> + * These must never be empty
> + * If you have to comment these two assert statements out, your
> + * binutils is too old (for other reasons as well)
> + */
> +ASSERT((__proc_info_end - __proc_info_begin), "missing CPU support")
> +ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
> +
> +/*
> + * The HYP init code can't be more than a page long,
> + * and should not cross a page boundary.
> + * The above comment applies as well.
> + */
> +ASSERT(__hyp_idmap_text_end - (__hyp_idmap_text_start & PAGE_MASK) <= PAGE_SIZE,
> +	"HYP init code too big or misaligned")
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 8b60fde..2c5b76e 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -84,11 +84,7 @@ SECTIONS
>  		*(.discard.*)
>  	}
>  
> -#ifdef CONFIG_XIP_KERNEL
> -	. = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
> -#else
>  	. = PAGE_OFFSET + TEXT_OFFSET;
> -#endif
>  	.head.text : {
>  		_text = .;
>  		HEAD_TEXT
> @@ -152,14 +148,13 @@ SECTIONS
>  
>  	_etext = .;			/* End of text and rodata section */
>  
> -#ifndef CONFIG_XIP_KERNEL
> -# ifdef CONFIG_ARM_KERNMEM_PERMS
> +#ifdef CONFIG_ARM_KERNMEM_PERMS
>  	. = ALIGN(1<<SECTION_SHIFT);
> -# else
> +#else
>  	. = ALIGN(PAGE_SIZE);
> -# endif
> -	__init_begin = .;
>  #endif
> +	__init_begin = .;
> +
>  	/*
>  	 * The vectors and stubs are relocatable code, and the
>  	 * only thing that matters is their relative offsets
> @@ -208,29 +203,21 @@ SECTIONS
>  		__pv_table_end = .;
>  	}
>  	.init.data : {
> -#ifndef CONFIG_XIP_KERNEL
>  		INIT_DATA
> -#endif
>  		INIT_SETUP(16)
>  		INIT_CALLS
>  		CON_INITCALL
>  		SECURITY_INITCALL
>  		INIT_RAM_FS
>  	}
> -#ifndef CONFIG_XIP_KERNEL
>  	.exit.data : {
>  		ARM_EXIT_KEEP(EXIT_DATA)
>  	}
> -#endif
>  
>  #ifdef CONFIG_SMP
>  	PERCPU_SECTION(L1_CACHE_BYTES)
>  #endif
>  
> -#ifdef CONFIG_XIP_KERNEL
> -	__data_loc = ALIGN(4);		/* location in binary */
> -	. = PAGE_OFFSET + TEXT_OFFSET;
> -#else
>  #ifdef CONFIG_ARM_KERNMEM_PERMS
>  	. = ALIGN(1<<SECTION_SHIFT);
>  #else
> @@ -238,7 +225,6 @@ SECTIONS
>  #endif
>  	__init_end = .;
>  	__data_loc = .;
> -#endif
>  
>  	.data : AT(__data_loc) {
>  		_data = .;		/* address in memory */
> @@ -250,15 +236,6 @@ SECTIONS
>  		 */
>  		INIT_TASK_DATA(THREAD_SIZE)
>  
> -#ifdef CONFIG_XIP_KERNEL
> -		. = ALIGN(PAGE_SIZE);
> -		__init_begin = .;
> -		INIT_DATA
> -		ARM_EXIT_KEEP(EXIT_DATA)
> -		. = ALIGN(PAGE_SIZE);
> -		__init_end = .;
> -#endif
> -
>  		NOSAVE_DATA
>  		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
>  		READ_MOSTLY_DATA(L1_CACHE_BYTES)
> -- 
> 1.7.9.5
> 
> 
> 
