From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 5 Nov 2012 12:46:40 -0500 (EST)
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <20121105172624.GE2005@linaro.org>
References: <20121025093411.GA32662@sig21.net> <50893389.2090002@gmail.com>
 <20121025141645.GA16962@sig21.net> <50894BC2.5050706@gmail.com>
 <20121025150816.GA3874@sig21.net> <20121105104839.GA2005@linaro.org>
 <20121105111346.GF28327@n2100.arm.linux.org.uk>
 <20121105130255.GD2005@linaro.org>
 <20121105153917.GG28327@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1211051111150.21033@xanadu.home>
 <20121105172624.GE2005@linaro.org>
Message-ID: <alpine.LFD.2.02.1211051242580.21033@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Nov 2012, Dave Martin wrote:

> On Mon, Nov 05, 2012 at 11:13:51AM -0500, Nicolas Pitre wrote:
> > On Mon, 5 Nov 2012, Russell King - ARM Linux wrote:
> > 
> > > On Mon, Nov 05, 2012 at 01:02:55PM +0000, Dave Martin wrote:
> > > > Why not allow unaligned accesses in the decompressor, though, both
> > > > for v6 and v7?
> > > 
> > > EXACTLY.
> > 
> > I have no objections to that.  In fact, I made a remark to this effect 
> > in my initial review of this patch.  Whether or not gcc does take 
> > advantage of this hardware ability in the end is orthogonal.
> 
> For the sake of argument, here's how it might look.
> 
> Currently, I make no attempt to restore the original state of the U bit.
> The A bit if forced later by the kernel during boot, after a short window
> during which we should only run low-level arch code and therefore where
> no unaligned accesses should happen.
> 
> Does anyone think these issues are likely to be important?
> 
> Cheers
> ---Dave
> 
> 
> >From 160a5576b53264951ff8164775146b2d4feddecb Mon Sep 17 00:00:00 2001
> From: Dave Martin <dave.martin@linaro.org>
> Date: Mon, 5 Nov 2012 16:34:57 +0000
> Subject: [PATCH] ARM: decompressor: Enable unaligned memory access for v6 and above
> 
> Modern GCC can generate code which makes use of the CPU's native
> unaligned memory access capabilities.  This is useful for the C
> decompressor implementations used for unpacking compressed kernels.
> 
> This patch disables the alignment faults and enabled the v6
> unaligned access on CPUs which support these features (i.e., v6 and
> later), allowing full unaligned access support for C code in the
> decompressor.
> 
> The decompressor C code must not be built to assume that unaligned
> access works if support for v5 or older platforms is included in
> the kernel.

I'd suggest here that the code must always use the get_unaligned and 
put_unaligned accessors when dealing with unaligned pointers, regardless 
of this patch.  The compiler will optimize the access performed via 
those accessors when possible.

> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
> Note: I have only build-tested this so far.
> 
>  arch/arm/boot/compressed/head.S |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 90275f0..cfbb4c9 100644
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
> @@ -694,6 +703,7 @@ __armv7_mmu_cache_on:
>  		bic	r0, r0, #1 << 28	@ clear SCTLR.TRE
>  		orr	r0, r0, #0x5000		@ I-cache enable, RR cache replacement
>  		orr	r0, r0, #0x003c		@ write buffer
> +		bic	r0, r0, #2		@ A (no unaligned access fault)
>  #ifdef CONFIG_MMU
>  #ifdef CONFIG_CPU_ENDIAN_BE8
>  		orr	r0, r0, #1 << 25	@ big-endian page tables
> @@ -914,7 +924,7 @@ proc_types:
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
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
