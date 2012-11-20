From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 20 Nov 2012 14:49:34 +0000
Subject: [PATCH] ARM: decompressor: Enable unaligned memory access for v6
 and above
In-Reply-To: <1352205711-15787-1-git-send-email-dave.martin@linaro.org>
References: <1352205711-15787-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20121120144934.GA1969@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 12:41:51PM +0000, Dave Martin wrote:
> Modern GCC can generate code which makes use of the CPU's native
> unaligned memory access capabilities.  This is useful for the C
> decompressor implementations used for unpacking compressed kernels.
> 
> This patch disables alignment faults and enables the v6 unaligned
> access model on CPUs which support these features (i.e., v6 and
> later), allowing full unaligned access support for C code in the
> decompressor.
> 
> The decompressor C code must not be built to assume that unaligned
> access works if support for v5 or older platforms is included in
> the kernel.
> 
> For correct code generation, C decompressor code must always use
> the get_unaligned and put_unaligned accessors when dealing with
> unaligned pointers, regardless of this patch.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Acked-by: Nicolas Pitre <nico@linaro.org>

Does anyone have any further comments on this before I send it to the
patch system?

Cheers
---Dave

> ---
> This is the same as the previous post, with an additional comment
> in the commit message regarding the use of {get,put}_unaligned,
> as suggested by Nico.
> 
> Tested on ARM1136JF-S (Integrator/CP) and ARM1176JZF-S (RealView
> PB1176JZF-S).  ARM1176 is like v7 regarding the MIDR and SCTLR
> alignment control bits, so this tests the v7 code path.
> 
>  arch/arm/boot/compressed/head.S |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 90275f0..49ca86e 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -652,6 +652,15 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory size
>  		mov	pc, lr
>  ENDPROC(__setup_mmu)
>  
> +@ Enable unaligned access on v6, to allow better code generation
> +@ for the decompressor C code:
> +__armv6_mmu_cache_on:
> +		mrc	p15, 0, r0, c1, c0, 0	@ read SCTLR
> +		bic	r0, r0, #2		@ A (no unaligned access fault)
> +		orr	r0, r0, #1 << 22	@ U (v6 unaligned access model)
> +		mcr	p15, 0, r0, c1, c0, 0	@ write SCTLR
> +		b	__armv4_mmu_cache_on
> +
>  __arm926ejs_mmu_cache_on:
>  #ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
>  		mov	r0, #4			@ put dcache in WT mode
> @@ -694,6 +703,9 @@ __armv7_mmu_cache_on:
>  		bic	r0, r0, #1 << 28	@ clear SCTLR.TRE
>  		orr	r0, r0, #0x5000		@ I-cache enable, RR cache replacement
>  		orr	r0, r0, #0x003c		@ write buffer
> +		bic	r0, r0, #2		@ A (no unaligned access fault)
> +		orr	r0, r0, #1 << 22	@ U (v6 unaligned access model)
> +						@ (needed for ARM1176)
>  #ifdef CONFIG_MMU
>  #ifdef CONFIG_CPU_ENDIAN_BE8
>  		orr	r0, r0, #1 << 25	@ big-endian page tables
> @@ -914,7 +926,7 @@ proc_types:
>  
>  		.word	0x0007b000		@ ARMv6
>  		.word	0x000ff000
> -		W(b)	__armv4_mmu_cache_on
> +		W(b)	__armv6_mmu_cache_on
>  		W(b)	__armv4_mmu_cache_off
>  		W(b)	__armv6_mmu_cache_flush
>  
> -- 
> 1.7.4.1
> 
