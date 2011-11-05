From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 05 Nov 2011 11:59:46 -0400 (EDT)
Subject: [PATCH] ARM: Allow kernel unaligned accesses on ARMv6+ processors
In-Reply-To: <1320489687-9642-1-git-send-email-catalin.marinas@arm.com>
References: <1320489687-9642-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <alpine.LFD.2.02.1111051158010.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 5 Nov 2011, Catalin Marinas wrote:

> Recent gcc versions generate unaligned accesses by default on ARMv6 and
> later processors. This patch ensures that the SCTLR.A bit is always
> cleared on such processors to avoid kernel traping before
> alignment_init() is called.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: John Linn <John.Linn@xilinx.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/kernel/head.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index a400a4d..1768db2 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -394,7 +394,7 @@ __secondary_data:
>   *  r13 = *virtual* address to jump to upon completion
>   */
>  __enable_mmu:
> -#ifdef CONFIG_ALIGNMENT_TRAP
> +#if defined(CONFIG_ALIGNMENT_TRAP) && __LINUX_ARM_ARCH__ < 6
>  	orr	r0, r0, #CR_A
>  #else
>  	bic	r0, r0, #CR_A
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
