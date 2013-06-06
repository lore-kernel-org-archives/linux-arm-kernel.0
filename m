From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 06 Jun 2013 16:34:48 +0100
Subject: [PATCH] ARM: errata: LoUIS bit field in CLIDR register is
 incorrect
In-Reply-To: <20130606150156.GF16794@mudshark.cambridge.arm.com>
References: <1370527112.3695.47.camel@linaro1.home>
 <20130606150156.GF16794@mudshark.cambridge.arm.com>
Message-ID: <1370532888.3500.11.camel@computer5.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-06-06 at 16:01 +0100, Will Deacon wrote:
> On Thu, Jun 06, 2013 at 02:58:32PM +0100, Jon Medhurst (Tixy) wrote:
> > On Cortex-A9 before version r1p0, the LoUIS bit field of the CLIDR
> > register returns zero when it should return one. This leads to cache
> > maintenance operations which rely on this value to not function as
> > intended, causing data corruption.
> > 
> > The workaround for this errata is to detect affected CPUs and correct
> > the LoUIS value read.
> > 
> > We also selected this workaround in CONFIG_ARCH_VEXPRESS_CA9X4 as that
> > platform is affected by the errata and as a consequence was suffering
> > reboot and shutdown crashes since the cpu hotplug changes introduced in
> > Linux 3.10. (Commit bca7a5a04933 "ARM: cpu hotplug: remove majority of
> > cache flushing from platforms")
> > 
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > ---
> >  arch/arm/Kconfig               |   10 ++++++++++
> >  arch/arm/mach-vexpress/Kconfig |    1 +
> >  arch/arm/mm/cache-v7.S         |    8 ++++++++
> >  3 files changed, 19 insertions(+)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 49d993c..1cd577c 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1189,6 +1189,16 @@ config PL310_ERRATA_588369
> >  	   is not correctly implemented in PL310 as clean lines are not
> >  	   invalidated as a result of these operations.
> >  
> > +config ARM_ERRATA_643719
> > +	bool "ARM errata: LoUIS bit field in CLIDR register is incorrect"
> > +	depends on CPU_V7
> 
> You could add an SMP dependency here too.

OK.

> > +	help
> > +	  This option enables the workaround for the 643719 Cortex-A9 (prior to
> > +	  r1p0) erratum. On affected cores the LoUIS bit field of the CLIDR
> > +	  register returns zero when it should return one. The workaround
> > +	  corrects this value, ensuring cache maintenance operations which use
> > +	  it behave as intended and avoiding data corruption.
> > +
> >  config ARM_ERRATA_720789
> >  	bool "ARM errata: TLBIASIDIS and TLBIMVAIS operations can broadcast a faulty ASID"
> >  	depends on CPU_V7
> > diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> > index 5907e10..fe637e9 100644
> > --- a/arch/arm/mach-vexpress/Kconfig
> > +++ b/arch/arm/mach-vexpress/Kconfig
> > @@ -56,5 +56,6 @@ config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
> >  
> >  config ARCH_VEXPRESS_CA9X4
> >  	bool "Versatile Express Cortex-A9x4 tile"
> > +	select ARM_ERRATA_643719
> 
> We don't do this for any other workarounds, so I'd suggest either dropping
> this or having a separate patch adding all of those that are required.

Not quite sure by what you mean by 'all of those that are required'. All
the errata required for vexpress? Or all platforms which require the
errata workaround?

If we don't enable the workaround in the Kconfig, then do we just add it
to the vexpress_defconfig and hope people notice? Or, as we have
ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA, we could select it in there?

Finally, whilst I'm asking questions ;-) I was hoping to fix a
regression that slipped into 3.10, is this late -rc material or will it
end up waiting for 3.11?

> 
> >  endmenu
> > diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> > index 15451ee..05993ba 100644
> > --- a/arch/arm/mm/cache-v7.S
> > +++ b/arch/arm/mm/cache-v7.S
> > @@ -92,6 +92,14 @@ ENTRY(v7_flush_dcache_louis)
> >  	mrc	p15, 1, r0, c0, c0, 1		@ read clidr, r0 = clidr
> >  	ALT_SMP(ands	r3, r0, #(7 << 21))	@ extract LoUIS from clidr
> >  	ALT_UP(ands	r3, r0, #(7 << 27))	@ extract LoUU from clidr
> > +#ifdef CONFIG_ARM_ERRATA_643719
> > +	ALT_SMP(mrceq	p15, 0, r2, c0, c0, 0)	@ read main ID register
> > +	ALT_UP(moveq	pc, lr)			@ LoUU is zero, so nothing to do
> > +	biceq	r2, r2, #0x0000000f             @ clear minor revision number
> > +	ldreq	r1, =0x410fc090                 @ ID of ARM Cortex A9 r0p?
> > +	teqeq	r2, r1                          @ test for errata affected core and if so...
> > +	orreqs	r3, #(1 << 21)			@   fix LoUIS value (and set flags state to 'ne')
> > +#endif
> >  	ALT_SMP(mov	r3, r3, lsr #20)	@ r3 = LoUIS * 2
> >  	ALT_UP(mov	r3, r3, lsr #26)	@ r3 = LoUU * 2
> >  	moveq	pc, lr				@ return if level == 0
> 
> This part looks good to me:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>

-- 
Tixy
