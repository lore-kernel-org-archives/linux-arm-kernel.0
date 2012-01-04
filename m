From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 04 Jan 2012 14:34:27 -0500 (EST)
Subject: [PATCH] ARM: LPAE: Check the CPU support for the long descriptor
 format
In-Reply-To: <1325696652-27367-1-git-send-email-catalin.marinas@arm.com>
References: <1325696652-27367-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <alpine.LFD.2.02.1201041433110.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Jan 2012, Catalin Marinas wrote:

> This patch adds a check for the presence of the LPAE feature during the
> CPU initialisation. If not present, it reports an error when
> CONFIG_DEBUG_LL is enabled.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/kernel/head.S |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 54fa641..b26291c 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -99,6 +99,14 @@ ENTRY(stext)
>   THUMB( it	eq )		@ force fixup-able long branch encoding
>  	beq	__error_p			@ yes, error 'p'
>  
> +#ifdef CONFIG_ARM_LPAE
> +	mrc	p15, 0, r3, c0, c1, 4		@ read ID_MMFR0
> +	and	r3, r3, #0xf			@ extract VMSA support
> +	cmp	r3, #5				@ long-descriptor translation table format?
> + THUMB( it	lo )				@ force fixup-able long branch encoding
> +	blo	__error_p			@ only classic page table format
> +#endif
> +
>  #ifndef CONFIG_XIP_KERNEL
>  	adr	r3, 2f
>  	ldmia	r3, {r4, r8}
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
