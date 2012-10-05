From: tony@atomide.com (Tony Lindgren)
Date: Fri, 5 Oct 2012 13:08:22 -0700
Subject: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in
 HYP mode
In-Reply-To: <1347036934-8519-3-git-send-email-marc.zyngier@arm.com>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
 <1347036934-8519-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20121005200822.GQ3874@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Marc Zyngier <marc.zyngier@arm.com> [120907 10:04]:
> From: Dave Martin <dave.martin@linaro.org>
> 
> This patch does two things:
> 
>   * Ensure that asynchronous aborts are masked at kernel entry.
>     The bootloader should be masking these anyway, but this reduces
>     the damage window just in case it doesn't.
> 
>   * Enter svc mode via exception return to ensure that CPU state is
>     properly serialised.  This does not matter when switching from
>     an ordinary privileged mode ("PL1" modes in ARMv7-AR rev C
>     parlance), but it potentially does matter when switching from a
>     another privileged mode such as hyp mode.
> 
> This should allow the kernel to boot safely either from svc mode or
> hyp mode, even if no support for use of the ARM Virtualization
> Extensions is built into the kernel.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Just bisected this down in linux-next for breaking booting of
my omap2420 ARMv6 based n8x0..

> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -83,8 +83,12 @@ ENTRY(stext)
>   THUMB(	.thumb			)	@ switch to Thumb now.
>   THUMB(1:			)
>  
> -	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
> -						@ and irqs disabled
> +#ifdef CONFIG_ARM_VIRT_EXT
> +	bl	__hyp_stub_install
> +#endif
> +	@ ensure svc mode and all interrupts masked
> +	safe_svcmode_maskall r9
> +
>  	mrc	p15, 0, r9, c0, c0		@ get processor id
>  	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
>  	movs	r10, r5				@ invalid processor (r5=0)?

..and looks like undoing this part fixes it. Any ideas?

I quickly tried disabling ARCH_OMAP3 and ARCH_OMAP4 so it's
ARMv6 but that does not help.

Regards,

Tony
