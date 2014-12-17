From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 17 Dec 2014 14:20:09 +0000
Subject: [PATCH] ARM: shmobile: r8a7740: Instantiate GIC from C board
 code in legacy builds
In-Reply-To: <1418823642-28154-1-git-send-email-geert+renesas@glider.be>
References: <1418823642-28154-1-git-send-email-geert+renesas@glider.be>
Message-ID: <54919119.8030208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/12/14 13:40, Geert Uytterhoeven wrote:
> As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
> domain."), armadillo-legacy hangs during boot with:
> 
>      sh-tmu.0: ch0: used for clock events
>      sh-tmu.0: ch0: used for periodic clock events
>      sh-tmu.0: ch0: failed to request irq 230
>      sh-tmu.0: ch1: used as clock source
>      sh-cmt-48.1: ch0: failed to request irq 90
>      sh-cmt-48.1: ch0: registration failed
>     earlytimer: unable to probe sh-cmt-48 early.
>     Calibrating delay loop...
> 
> This happens because the IRQ numbers of the GIC are now virtual, and no
> longer match the hardcoded hardware IRQ numbers in the platform board
> code.
> To fix this, instantiate the GIC from platform board code when compiling
> a legacy kernel, like is done on sh73a0 for kzm9g-legacy.

Ah, that explains why kzm9g-legacy didn't explode in -next...

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/mach-shmobile/setup-r8a7740.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
> index 79ad93dfdae4ee70..d191cf4197313482 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7740.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7740.c
> @@ -800,7 +800,14 @@ void __init r8a7740_init_irq_of(void)
>  	void __iomem *intc_msk_base = ioremap_nocache(0xe6900040, 0x10);
>  	void __iomem *pfc_inta_ctrl = ioremap_nocache(0xe605807c, 0x4);
>  
> +#ifdef CONFIG_ARCH_SHMOBILE_LEGACY
> +	void __iomem *gic_dist_base = ioremap_nocache(0xc2800000, 0x1000);
> +	void __iomem *gic_cpu_base = ioremap_nocache(0xc2000000, 0x1000);
> +
> +	gic_init(0, 29, gic_dist_base, gic_cpu_base);
> +#else
>  	irqchip_init();
> +#endif
>  
>  	/* route signals to GIC */
>  	iowrite32(0x0, pfc_inta_ctrl);
> 

Hopefully we'll be able to move away from this kind of thing at some
point. Until then:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
