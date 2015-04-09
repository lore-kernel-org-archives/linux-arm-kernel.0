From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 9 Apr 2015 18:17:48 +0100
Subject: [PATCH 4/7] ARM: cache-v7: optimise branches in
 v7_flush_cache_louis
In-Reply-To: <20150409082116.GV12732@n2100.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
 <E1YdzFA-0008Cr-Ku@rmk-PC.arm.linux.org.uk>
 <2570741.Vc3c6Ovx3m@wuerfel>
 <20150409082116.GV12732@n2100.arm.linux.org.uk>
Message-ID: <20150409171748.GI23861@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 09:21:16AM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 09, 2015 at 10:13:06AM +0200, Arnd Bergmann wrote:
> > On Friday 03 April 2015 11:54:32 Russell King wrote:
> > > diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> > > index 5b5d0c00bca7..793d061b4dce 100644
> > > --- a/arch/arm/mm/cache-v7.S
> > > +++ b/arch/arm/mm/cache-v7.S
> > > @@ -93,17 +93,18 @@ ENTRY(v7_flush_dcache_louis)
> > >  ALT_SMP(mov	r3, r0, lsr #20)		@ move LoUIS into position
> > >  ALT_UP(	mov	r3, r0, lsr #26)		@ move LoUU into position
> > >  	ands	r3, r3, #7 << 1 		@ extract LoU*2 field from clidr
> > > +	bne	start_flush_levels		@ LoU != 0, start flushing
> > >  #ifdef CONFIG_ARM_ERRATA_643719
> > > -	ALT_SMP(mrceq	p15, 0, r2, c0, c0, 0)	@ read main ID register
> > > -	ALT_UP(reteq	lr)			@ LoUU is zero, so nothing to do
> > > -	movweq	r1, #:lower16:0x410fc090	@ ID of ARM Cortex A9 r0p?
> > > -	movteq	r1, #:upper16:0x410fc090
> > > -	biceq	r2, r2, #0x0000000f             @ clear minor revision number
> > > -	teqeq	r2, r1                          @ test for errata affected core and if so...
> > > -	moveqs	r3, #1 << 1			@   fix LoUIS value (and set flags state to 'ne')
> > > +ALT_SMP(mrc	p15, 0, r2, c0, c0, 0)		@ read main ID register
> > > +ALT_UP(	ret	lr)				@ LoUU is zero, so nothing to do
> > > +	movw	r1, #:lower16:0x410fc090	@ ID of ARM Cortex A9 r0p?
> > 
> > With this in linux-next, I get a build failure on randconfig kernels with
> > THUMB2_KERNEL enabled:
> > 
> > arch/arm/mm/cache-v7.S: Assembler messages:
> > arch/arm/mm/cache-v7.S:99: Error: ALT_UP() content must assemble to exactly 4 bytes
> > 
> > Any idea for a method that will work with all combinations of SMP/UP
> > and ARM/THUMB? The best I could come up with was to add an extra 'mov r0,r0',
> > but that gets rather ugly as you then have to do it only for THUMB2.
> 
> How about we make ALT_UP() add the additional padding?  Something like
> this maybe?
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index f67fd3afebdf..79f421796aab 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -237,6 +237,9 @@
>  	.pushsection ".alt.smp.init", "a"			;\
>  	.long	9998b						;\
>  9997:	instr							;\
> +	.if . - 9997b == 2					;\
> +		nop						;\
> +	.endif
>  	.if . - 9997b != 4					;\
>  		.error "ALT_UP() content must assemble to exactly 4 bytes";\
>  	.endif							;\

I wonder whether, as a general rule, it's better to use the 4-byte wide
instruction where possible instead of the additional nop. Anyway, this
could be left with the ALT_* macros user.

-- 
Catalin
