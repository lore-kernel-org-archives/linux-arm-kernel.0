From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 12 Aug 2013 18:51:31 -0300
Subject: [PATCH v2 1/2] ARM: feroceon: Add suspend/resume operation
In-Reply-To: <1376144839-1985-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1376144839-1985-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1376144839-1985-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130812215130.GA7851@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Sat, Aug 10, 2013 at 11:27:18AM -0300, Ezequiel Garcia wrote:
> Add support for suspend/resume operations. The implemented procedures
> are identical to the ones for ARM926.
> 
> Cc: Assaf Hoffman <hoffman@marvell.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/Kconfig            |  2 +-
>  arch/arm/mm/proc-feroceon.S | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 98538e1..c57b437 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2198,7 +2198,7 @@ source "kernel/power/Kconfig"
>  
>  config ARCH_SUSPEND_POSSIBLE
>  	depends on !ARCH_S5PC100
> -	depends on CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || \
> +	depends on CPU_ARM920T || CPU_ARM926T || CPU_FEROCEON || CPU_SA1100 || \
>  		CPU_V6 || CPU_V6K || CPU_V7 || CPU_XSC3 || CPU_XSCALE || CPU_MOHAWK
>  	def_bool y
>  
> diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
> index d5146b9..db79b62 100644
> --- a/arch/arm/mm/proc-feroceon.S
> +++ b/arch/arm/mm/proc-feroceon.S
> @@ -514,6 +514,32 @@ ENTRY(cpu_feroceon_set_pte_ext)
>  #endif
>  	mov	pc, lr
>  
> +/* Suspend/resume support: taken from arch/arm/mm/proc-arm926.S */
> +.globl	cpu_feroceon_suspend_size
> +.equ	cpu_feroceon_suspend_size, 4 * 3
> +#ifdef CONFIG_ARM_CPU_SUSPEND
> +ENTRY(cpu_feroceon_do_suspend)
> +	stmfd	sp!, {r4 - r6, lr}
> +	mrc	p15, 0, r4, c13, c0, 0	@ PID
> +	mrc	p15, 0, r5, c3, c0, 0	@ Domain ID
> +	mrc	p15, 0, r6, c1, c0, 0	@ Control register
> +	stmia	r0, {r4 - r6}
> +	ldmfd	sp!, {r4 - r6, pc}
> +ENDPROC(cpu_feroceon_do_suspend)
> +
> +ENTRY(cpu_feroceon_do_resume)
> +	mov	ip, #0
> +	mcr	p15, 0, ip, c8, c7, 0	@ invalidate I+D TLBs
> +	mcr	p15, 0, ip, c7, c7, 0	@ invalidate I+D caches
> +	ldmia	r0, {r4 - r6}
> +	mcr	p15, 0, r4, c13, c0, 0	@ PID
> +	mcr	p15, 0, r5, c3, c0, 0	@ Domain ID
> +	mcr	p15, 0, r1, c2, c0, 0	@ TTB address
> +	mov	r0, r6			@ control register
> +	b	cpu_resume_mmu
> +ENDPROC(cpu_feroceon_do_resume)
> +#endif
> +
>  	.type	__feroceon_setup, #function
>  __feroceon_setup:
>  	mov	r0, #0
> -- 
> 1.8.1.5
> 

Any comments for this one?

If this is OK, then I'd like to add it in the tracking system
to be merged in either v3.12 or v3.13, and be able to introduce
suspend/resume later.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
