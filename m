From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 08 Dec 2010 21:36:56 +0300
Subject: [PATCH] ARM: Add writethrough dcache support for ARM926EJS
	processor
In-Reply-To: <20090909165035.GA31462@mag.az.mvista.com>
References: <20090909165035.GA31462@mag.az.mvista.com>
Message-ID: <4CFFD048.9030605@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Mark A. Greer wrote:

> From: Mark A. Greer <mgreer@mvista.com>

> The ARM kernel supports writethrough data cache via the
> CONFIG_CPU_DCACHE_WRITETHROUGH option.  However, that
> functionality wasn't implemented in the arch/arm/boot/compressed
> code.  It is now necessary due to a new ARM926EJS processor
> that has an issue with writeback data cache.

> Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> ---
> This patch was motivated by a dcache writeback bug in some revisions
> of TI's DA830/OMAP-L137 (ARM926EJS) SoC.  It has been tested using
> Kevin Hilman's DaVinci tree where that SoC is supported.  Compile
> tested only in the linux-2.6 ARM kernel.

> I submitted this patch a while back,
> 	http://marc.info/?l=linux-arm-kernel&m=124208189923479&w=4
> and Russell responded with,
> 	http://marc.info/?l=linux-arm-kernel&m=124277262417440&w=4
> to which both George Davis and I responded but Russell has been too
> busy to continue the conversation.

> So, I'm resubmitting in the hope that this patch gets accepted or I
> can get some more feedback as to what needs to be done to make it
> acceptable.

> Many thanks to George Davis for helping me with the low-level ARM-ese.

>  arch/arm/boot/compressed/head.S |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index fa6fbf4..70806c1 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -412,7 +412,11 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory size
>  		orr	r1, r1, #3 << 10
>  		add	r2, r3, #16384
>  1:		cmp	r1, r9			@ if virt > start of RAM
> +#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
> +		orrhs	r1, r1, #0x08		@ set cacheable
> +#else
>  		orrhs	r1, r1, #0x0c		@ set cacheable, bufferable
> +#endif
>  		cmp	r1, r10			@ if virt > end of RAM
>  		bichs	r1, r1, #0x0c		@ clear cacheable, bufferable
>  		str	r1, [r0], #4		@ 1:1 mapping
> @@ -436,6 +440,12 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory size
>  		mov	pc, lr
>  ENDPROC(__setup_mmu)
>  
> +__arm926ejs_mmu_cache_on:
> +#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
> +		mov	r0, #4			@ put dcache in WT mode
> +		mcr	p15, 7, r0, c15, c0, 0
> +#endif
> +
>  __armv4_mmu_cache_on:
>  		mov	r12, lr
>  #ifdef CONFIG_MMU
> @@ -655,6 +665,12 @@ proc_types:
>  		W(b)	__armv4_mpu_cache_off
>  		W(b)	__armv4_mpu_cache_flush
>  
> +		.word	0x41069260		@ ARM926EJ-S (v5TEJ)
> +		.word	0xff0ffff0
> +		b	__arm926ejs_mmu_cache_on
> +		b	__armv4_mmu_cache_off
> +		b	__armv5tej_mmu_cache_flush
> +
>  		.word	0x00007000		@ ARM7 IDs
>  		.word	0x0000f000
>  		mov	pc, lr
> --
> 1.6.2.5.182.ga808d

    I'd like to know when this will be accepted?
    DA830/OMAP-L137 are still not bootable in mainline without this patch... :-(

WBR, Sergei
