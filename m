From: stefan@agner.ch (Stefan Agner)
Date: Sat, 20 Dec 2014 14:33:16 +0100
Subject: [PATCH v6] ARM: zImage: add support for ARMv7-M
In-Reply-To: <1418806573-14897-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1418806573-14897-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <cfd1c941b379d2e47b0a8d1469161179@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-12-17 09:56, Uwe Kleine-K?nig wrote:
> From: Joachim Eastwood <manabian@gmail.com>
> 
> This patch makes it possible to enter zImage in Thumb mode for ARMv7-M
> (Cortex-M) CPUs that do not support ARM mode. The kernel entry is also
> made in Thumb mode.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> [ukl: fix spelling in commit log, return early in call_cache_fn]
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> I just picked up Joachim's patch and fixed the small concerns I had in
> the last round.
> 
> I thought about adding a wrapper for accessing the CPUID registers that
> are located in cp15 on v7-A/R and memory mapped on v7-M. The
> corresponding registers and their address are as follows:
> 
> name		cp15 reg [1] on -A/R	address on -M
> MIDR/CPUID  	CRm=c0, opc2=0  	0xe000ed00              
> PFR0   		CRm=c1, opc2=0  	0xe000ed40
> PFR1   		CRm=c1, opc2=1  	0xe000ed44
> DFR0   		CRm=c1, opc2=2  	0xe000ed48
> AFR0   		CRm=c1, opc2=3  	0xe000ed4c
> MMFR0  		CRm=c1, opc2=4  	0xe000ed50
> MMFR1  		CRm=c1, opc2=5  	0xe000ed54
> MMFR2  		CRm=c1, opc2=6  	0xe000ed58
> MMFR3  		CRm=c1, opc2=7  	0xe000ed5c
> ISAR0  		CRm=c2, opc2=0  	0xe000ed60
> ISAR1  		CRm=c2, opc2=1  	0xe000ed64
> ISAR2  		CRm=c2, opc2=2  	0xe000ed68
> ISAR3  		CRm=c2, opc2=3  	0xe000ed6c
> ISAR4  		CRm=c2, opc2=4  	0xe000ed70
> ISAR5  		CRm=c2, opc2=5  	0xe000ed74
> 
> But there is no nice translation and as cache handling is implementation
> defined on v7-M anyhow there is not much use and I decided to just
> return early in the cache function.
> 
> This patch is only compile tested as I don't have a machine with enough
> RAM to run a non-XIP kernel, so Tested-by tags are welcome.

Hi Uwe,

Tried the patch on Vybrid's M4 CPU. Since the M4 has full access to the
DDR3 RAM, it is even possible to use AUTO_ZRELADDR for both CPU's: The
Colibri VF61 has 256MB of RAM: A5 relocates to 0x80008000, M4 to
0x88008000. 

The uncompressing stage seems to work fine, however it seems I hit a
different bug which is triggered by using the zImage: Freeing the memory
location used by the compressed image seems to fail:

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.18.0-10889-ga84c884 (ags at trochilidae) (gcc version 4.8.3
20140401 (prerelease) (Linaro GCC 4.8-2014.04) ) #377 Sat Dec 20
14:08:07 CET 2014
CPU: ARMv7-M [410fc241] revision 1 (ARMv7M), cr=00000000
CPU: unknown data cache, unknown instruction cache
Machine model: VF610 Cortex-M4
bootconsole [earlycon0] enabled
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
12192
Kernel command line: console=ttyLP2,115200 ihash_entries=64
dhash_entries=64 earlyprintk clk_ignore_unused init=/linuxrc rw
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 64 (order: -4, 256 bytes)
Inode-cache hash table entries: 64 (order: -4, 256 bytes)
BUG: Bad page state in process swapper  pfn:8c000
page:8f020000 count:0 mapcount:0 mapping:da2fe79e index:0x6e563b3a
flags:
0x4248e05f(locked|error|referenced|uptodate|dirty|active|writeback|head|tail|swapbacked)
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
bad because of flags:
flags: 0x2041(locked|active|writeback)
CPU: 0 PID: 0 Comm: swapper Not tainted 3.18.0-10889-ga84c884 #377
Hardware name: Freescale Vybrid VF610 (Device Tree)
[<8800b129>] (unwind_backtrace) from [<8800a53f>] (show_stack+0xb/0xc)
[<8800a53f>] (show_stack) from [<8803a40d>] (bad_page+0x85/0xb8)
[<8803a40d>] (bad_page) from [<8803a4e9>] (free_pages_prepare+0xa9/0xac)
[<8803a4e9>] (free_pages_prepare) from [<8803b2ed>]
(__free_pages_ok+0x19/0x260)
[<8803b2ed>] (__free_pages_ok) from [<881978db>]
(free_all_bootmem+0xaf/0xf8)
[<881978db>] (free_all_bootmem) from [<8819201d>] (mem_init+0xb5/0x1c8)
[<8819201d>] (mem_init) from [<8818f5af>] (start_kernel+0x17b/0x2c0)
[<8818f5af>] (start_kernel) from [<08008023>] (0x8008023)


My loaders output, zImage has been loaded to the region in question
(0x8f000080...)

# ./m4boot zImage initramfs.cpio.lzo vf610m4-colibri.dtb
zImage: 1103944 bytes loaded
initramfs.cpio.lzo: 1632028 bytes loaded
vf610m4-colibri.dtb: 9911 bytes loaded
vf610m4bootldr: 128 bytes copied to 0x8f000000 through 0x8f000080
zImage: 1103944 bytes copied to 0x8f000080 through 0x8f10d8c8
initramfs.cpio.lzo: 1632028 bytes copied to 0x8d000000 through
0x8d18e71c
vf610m4-colibri.dtb: 9979 bytes copied to 0x8fff0000 through 0x8fff26fb
Entry point set to 0x0f000001
Argument set to 0x8fff0000
Cortex-M4 started...


Virtual kernel memory layout:
    vector  : 0x00000000 - 0x00001000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0x00000000 - 0xffffffff   (4095 MB)
    lowmem  : 0x88000000 - 0x8f000000   ( 112 MB)
      .text : 0x88008000 - 0x8818acfc   (1548 kB)
      .init : 0x8818b000 - 0x8819e000   (  76 kB)
      .data : 0x8819e000 - 0x881b2900   (  83 kB)
       .bss : 0x881b2900 - 0x881dc210   ( 167 kB)

I used CONFIG_SET_MEM_PARAM and configured the RAM at those fixed
values:
CONFIG_DRAM_BASE=0x88000000                                             
                                
CONFIG_DRAM_SIZE=0x08000000

Any idea what could be the issue here?

--
Stefan


> 
> Best regards
> Uwe
> 
> [1] all have in common: CRn=c0, opc1=0, so only CRm and opc2 are listed
> 
>  arch/arm/boot/compressed/head.S | 33 +++++++++++++++++++++++++++------
>  arch/arm/include/asm/unified.h  |  8 ++++++++
>  2 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 68be9017593d..3788eedabb15 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -10,8 +10,11 @@
>   */
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
> +#include <asm/v7m.h>
> +
> + AR_CLASS(	.arch	armv7-a	)
> + M_CLASS(	.arch	armv7-m	)
>  
> -	.arch	armv7-a
>  /*
>   * Debugging stuff
>   *
> @@ -114,7 +117,12 @@
>   * sort out different calling conventions
>   */
>  		.align
> -		.arm				@ Always enter in ARM state
> +		/*
> +		 * Always enter in ARM state for CPUs that support the ARM ISA.
> +		 * As of today (2014) that's exactly the members of the A and R
> +		 * classes.
> +		 */
> + AR_CLASS(	.arm	)
>  start:
>  		.type	start,#function
>  		.rept	7
> @@ -132,14 +140,15 @@ start:
>  
>   THUMB(		.thumb			)
>  1:
> - ARM_BE8(	setend	be )			@ go BE8 if compiled for BE8
> -		mrs	r9, cpsr
> + ARM_BE8(	setend	be		)	@ go BE8 if compiled for BE8
> + AR_CLASS(	mrs	r9, cpsr	)
>  #ifdef CONFIG_ARM_VIRT_EXT
>  		bl	__hyp_stub_install	@ get into SVC mode, reversibly
>  #endif
>  		mov	r7, r1			@ save architecture ID
>  		mov	r8, r2			@ save atags pointer
>  
> +#ifndef CONFIG_CPU_V7M
>  		/*
>  		 * Booting from Angel - need to enter SVC mode and disable
>  		 * FIQs/IRQs (numeric definitions from angel arm.h source).
> @@ -155,6 +164,7 @@ not_angel:
>  		safe_svcmode_maskall r0
>  		msr	spsr_cxsf, r9		@ Save the CPU boot mode in
>  						@ SPSR
> +#endif
>  		/*
>  		 * Note that some cache flushing and other stuff may
>  		 * be needed here - is there an Angel SWI call for this?
> @@ -789,6 +799,16 @@ __common_mmu_cache_on:
>  call_cache_fn:	adr	r12, proc_types
>  #ifdef CONFIG_CPU_CP15
>  		mrc	p15, 0, r9, c0, c0	@ get processor ID
> +#elif defined(CONFIG_CPU_V7M)
> +		/*
> +		 * On v7-M the processor id is located in the V7M_SCB_CPUID
> +		 * register, but as cache handling is IMPLEMENTATION DEFINED on
> +		 * v7-M (if existant at all) we just return early here.
> +		 * If V7M_SCB_CPUID were used the cpu ID functions (i.e.
> +		 * __armv7_mmu_cache_{on,off,flush}) would be selected which
> +		 * use cp15 registers that are not implemented on v7-M.
> +		 */
> +		bx	lr
>  #else
>  		ldr	r9, =CONFIG_PROCESSOR_ID
>  #endif
> @@ -1289,8 +1309,9 @@ __hyp_reentry_vectors:
>  
>  __enter_kernel:
>  		mov	r0, #0			@ must be 0
> - ARM(		mov	pc, r4	)		@ call kernel
> - THUMB(		bx	r4	)		@ entry point is always ARM
> + ARM(		mov	pc, r4		)	@ call kernel
> + M_CLASS(	add	r4, r4, #1	)	@ enter in Thumb mode for M class
> + THUMB(		bx	r4		)	@ entry point is always ARM for A/R classes
>  
>  reloc_code_end:
>  
> diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
> index b88beaba6b4a..200f9a7cd623 100644
> --- a/arch/arm/include/asm/unified.h
> +++ b/arch/arm/include/asm/unified.h
> @@ -24,6 +24,14 @@
>  	.syntax unified
>  #endif
>  
> +#ifdef CONFIG_CPU_V7M
> +#define AR_CLASS(x...)
> +#define M_CLASS(x...)	x
> +#else
> +#define AR_CLASS(x...)	x
> +#define M_CLASS(x...)
> +#endif
> +
>  #ifdef CONFIG_THUMB2_KERNEL
>  
>  #if __GNUC__ < 4
