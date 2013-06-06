From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 6 Jun 2013 13:39:26 -0400 (EDT)
Subject: [PATCH v2] ARM: errata: LoUIS bit field in CLIDR register is
 incorrect
In-Reply-To: <1370538602.3695.71.camel@linaro1.home>
References: <1370538602.3695.71.camel@linaro1.home>
Message-ID: <alpine.LFD.2.03.1306061338030.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Jun 2013, Jon Medhurst (Tixy) wrote:

> On Cortex-A9 before version r1p0, the LoUIS bit field of the CLIDR
> register returns zero when it should return one. This leads to cache
> maintenance operations which rely on this value to not function as
> intended, causing data corruption.
> 
> The workaround for this errata is to detect affected CPUs and correct
> the LoUIS value read.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Jon Medhurst <tixy@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>

This wouldn't hurt adding 'CC: stable at kernel.org' as well.


> ---
> 
> Changes in v2:
>  - Add config dependency on SMP
>  - Dropped selection of errata by vexpress
>  - Added Will's Acked-by
> 
>  arch/arm/Kconfig       |   10 ++++++++++
>  arch/arm/mm/cache-v7.S |    8 ++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 49d993c..239fa96 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1189,6 +1189,16 @@ config PL310_ERRATA_588369
>  	   is not correctly implemented in PL310 as clean lines are not
>  	   invalidated as a result of these operations.
>  
> +config ARM_ERRATA_643719
> +	bool "ARM errata: LoUIS bit field in CLIDR register is incorrect"
> +	depends on CPU_V7 && SMP
> +	help
> +	  This option enables the workaround for the 643719 Cortex-A9 (prior to
> +	  r1p0) erratum. On affected cores the LoUIS bit field of the CLIDR
> +	  register returns zero when it should return one. The workaround
> +	  corrects this value, ensuring cache maintenance operations which use
> +	  it behave as intended and avoiding data corruption.
> +
>  config ARM_ERRATA_720789
>  	bool "ARM errata: TLBIASIDIS and TLBIMVAIS operations can broadcast a faulty ASID"
>  	depends on CPU_V7
> diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> index 15451ee..05993ba 100644
> --- a/arch/arm/mm/cache-v7.S
> +++ b/arch/arm/mm/cache-v7.S
> @@ -92,6 +92,14 @@ ENTRY(v7_flush_dcache_louis)
>  	mrc	p15, 1, r0, c0, c0, 1		@ read clidr, r0 = clidr
>  	ALT_SMP(ands	r3, r0, #(7 << 21))	@ extract LoUIS from clidr
>  	ALT_UP(ands	r3, r0, #(7 << 27))	@ extract LoUU from clidr
> +#ifdef CONFIG_ARM_ERRATA_643719
> +	ALT_SMP(mrceq	p15, 0, r2, c0, c0, 0)	@ read main ID register
> +	ALT_UP(moveq	pc, lr)			@ LoUU is zero, so nothing to do
> +	biceq	r2, r2, #0x0000000f             @ clear minor revision number
> +	ldreq	r1, =0x410fc090                 @ ID of ARM Cortex A9 r0p?
> +	teqeq	r2, r1                          @ test for errata affected core and if so...
> +	orreqs	r3, #(1 << 21)			@   fix LoUIS value (and set flags state to 'ne')
> +#endif
>  	ALT_SMP(mov	r3, r3, lsr #20)	@ r3 = LoUIS * 2
>  	ALT_UP(mov	r3, r3, lsr #26)	@ r3 = LoUU * 2
>  	moveq	pc, lr				@ return if level == 0
> -- 
> 1.7.10.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
