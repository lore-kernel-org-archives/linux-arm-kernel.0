From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 03 Dec 2012 14:25:22 -0500 (EST)
Subject: [PATCH 1/3] ARM: nommu: allow unaligned accesses on ARMv6+
 processors
In-Reply-To: <1354557403-20386-1-git-send-email-will.deacon@arm.com>
References: <1354557403-20386-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.02.1212031424430.6589@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Dec 2012, Will Deacon wrote:

> Commit 8428e84d ("ARM: 7150/1: Allow kernel unaligned accesses on ARMv6+
> processors") unconditionally clears SCTLR.A for ARMv6+ processors, since
> newer toolchains assume that unaligned memory accesses will not fault
> for these cores.
> 
> This patch adds the corresponding change for nommu kernel builds.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Identical to Armando's recent patch but included here for completeness.

For patches 1 to 3:

Acked-by: Nicolas Pitre <nico@linaro.org>

> 
>  arch/arm/kernel/head-nommu.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> index 278cfc1..2c228a0 100644
> --- a/arch/arm/kernel/head-nommu.S
> +++ b/arch/arm/kernel/head-nommu.S
> @@ -68,7 +68,7 @@ __after_proc_init:
>  	 * CP15 system control register value returned in r0 from
>  	 * the CPU init function.
>  	 */
> -#ifdef CONFIG_ALIGNMENT_TRAP
> +#if defined(CONFIG_ALIGNMENT_TRAP) && __LINUX_ARM_ARCH__ < 6
>  	orr	r0, r0, #CR_A
>  #else
>  	bic	r0, r0, #CR_A
> -- 
> 1.8.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
