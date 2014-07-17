From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 16 Jul 2014 21:49:56 -0400 (EDT)
Subject: [PATCH v2] ARM: zImage: add DSB and ISB barriers after relocating
 code
In-Reply-To: <1405554841-28503-1-git-send-email-marc.ceeeee@gmail.com>
References: <1405554841-28503-1-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <alpine.LFD.2.11.1407162123500.3647@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Jul 2014, Marc Carino wrote:

> The zImage loader will relocate the image if it determines that
> decompression will overwrite its current location. Since the act
> of relocation is basically a form of code self-modification, we
> need to ensure that the CPU fetches the updated instruction stream.
> 
> Since cache maintenance is skipped during the relocation phase (the
> MMUs and caches are off), we need to execute both a data sync
> and instruction sync barrier prior to jumping to the relocated code.
> Skipping the barriers can result in execution of stale prefetched
> code, leading to hangs or an UNDEFINED INSTRUCTION exception.
> 
> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>

Comments below.

> ---
>  arch/arm/boot/compressed/head.S | 71 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 3a8b32d..3888a0d 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -395,8 +395,13 @@ dtb_check_done:
>  		add	sp, sp, r6
>  #endif
>  
> +		/*
> +		 * Perform full cache maintenance if caches were enabled
> +		 * earlier. Otherwise, only invalidate the instruction cache.
> +		 */
>  		tst	r4, #1
>  		bleq	cache_clean_flush
> +		blne	i_cache_inval

This is wrong.  Suppose the Z (equal to zero) flag is set and 
cache_clean_flush is called.  Nothing guarantees that the Z flag will 
still be set when cache_clean_flush returns and then i_cache_inval would 
then be called as well.

In fact, maybe it would be cleaner to always call i_cache_inval 
separately and remove i-cache invalidation from any cache_clean_flush 
code.

>  		adr	r0, BSYM(restart)
>  		add	r0, r0, r6
> @@ -769,7 +774,7 @@ __common_mmu_cache_on:
>  		sub	pc, lr, r0, lsr #32	@ properly flush pipeline
>  #endif
>  
> -#define PROC_ENTRY_SIZE (4*5)
> +#define PROC_ENTRY_SIZE (4*6)
>  
>  /*
>   * Here follow the relocatable cache support functions for the
> @@ -808,6 +813,7 @@ call_cache_fn:	adr	r12, proc_types
>   *   - 'cache on' method instruction
>   *   - 'cache off' method instruction
>   *   - 'cache flush' method instruction
> + *   - 'instruction cache invalidate' method instruction
>   *
>   * We match an entry using: ((real_id ^ match) & mask) == 0
>   *
> @@ -826,6 +832,8 @@ proc_types:
>   THUMB(		nop				)
>  		mov	pc, lr
>   THUMB(		nop				)
> +		mov	pc, lr
> + THUMB(		nop				)
>  
>  		.word	0x41007000		@ ARM7/710
>  		.word	0xfff8fe00
> @@ -835,6 +843,8 @@ proc_types:
>   THUMB(		nop				)
>  		mov	pc, lr
>   THUMB(		nop				)
> +		mov	pc, lr
> + THUMB(		nop				)
>  
>  		.word	0x41807200		@ ARM720T (writethrough)
>  		.word	0xffffff00
> @@ -842,24 +852,32 @@ proc_types:
>  		W(b)	__armv4_mmu_cache_off
>  		mov	pc, lr
>   THUMB(		nop				)
> +		mov	pc, lr
> + THUMB(		nop				)
>  
>  		.word	0x41007400		@ ARM74x
>  		.word	0xff00ff00
>  		W(b)	__armv3_mpu_cache_on
>  		W(b)	__armv3_mpu_cache_off
>  		W(b)	__armv3_mpu_cache_flush
> -		
> +		mov	pc, lr
> + THUMB(		nop				)
> +
>  		.word	0x41009400		@ ARM94x
>  		.word	0xff00ff00
>  		W(b)	__armv4_mpu_cache_on
>  		W(b)	__armv4_mpu_cache_off
>  		W(b)	__armv4_mpu_cache_flush
> +		mov	pc, lr
> + THUMB(		nop				)
>  
>  		.word	0x41069260		@ ARM926EJ-S (v5TEJ)
>  		.word	0xff0ffff0
>  		W(b)	__arm926ejs_mmu_cache_on
>  		W(b)	__armv4_mmu_cache_off
>  		W(b)	__armv5tej_mmu_cache_flush
> +		mov	pc, lr
> + THUMB(		nop				)
>  
>  		.word	0x00007000		@ ARM7 IDs
>  		.word	0x0000f000
> @@ -869,6 +887,8 @@ proc_types:
>   THUMB(		nop				)
>  		mov	pc, lr
>   THUMB(		nop				)
> +		mov	pc, lr
> + THUMB(		nop				)
>  
>  		@ Everything from here on will be the new ID system.
>  
> @@ -877,30 +897,40 @@ proc_types:
>  		W(b)	__armv4_mmu_cache_on
>  		W(b)	__armv4_mmu_cache_off
>  		W(b)	__armv4_mmu_cache_flush
> +		mov	pc, lr
> + THUMB(		nop				)
>  
>  		.word	0x6901b110		@ sa1110
>  		.word	0xfffffff0
>  		W(b)	__armv4_mmu_cache_on
>  		W(b)	__armv4_mmu_cache_off
>  		W(b)	__armv4_mmu_cache_flush
> +		mov	pc, lr
> + THUMB(		nop				)
[...]

I think all Harvard caches should have something here to be "correct".  
Looking at the actual kernel code:

$ grep -A3 "ENTRY.*_flush_icache_all" arch/arm/mm/*.S | grep mcr
cache-fa.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
cache-v4wb.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
cache-v4wt.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
cache-v7.S-	ALT_SMP(mcr	p15, 0, r0, c7, c1, 0)		@ invalidate I-cache inner shareable
cache-v7.S-	ALT_UP(mcr	p15, 0, r0, c7, c5, 0)		@ I+BTB cache invalidate
proc-arm1020e.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
proc-arm1020.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
proc-arm1022.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
proc-arm1026.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
proc-arm920.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
proc-arm922.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
proc-arm925.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
proc-arm926.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
proc-arm940.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
proc-arm946.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
proc-feroceon.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
proc-mohawk.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
proc-xsc3.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
proc-xscale.S-	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache

So it should be simple to have a common one-liner for most cases.


Nicolas
