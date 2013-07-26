From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Jul 2013 18:10:31 +0200
Subject: [PATCH v6 05/11] irqchip: mmp: avoid to include irqs head file
In-Reply-To: <1374833133-21119-6-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
 <1374833133-21119-6-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <201307261810.32069.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 July 2013, Haojian Zhuang wrote:
> Since <mach/irqs.h> in irq-mmp.c blocks the multiplatform build,
> remove it instead.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  drivers/irqchip/irq-mmp.c | 45 +++++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)

The intention behind this patch is good, but I think the implementation is
bad, since the platform still relies on specific hardcoded values for
the base irq numbers. As long as this is the case, you should use the
constants.

> @@ -249,7 +247,7 @@ void __init icu_init_irq(void)
>  /* MMP2 (ARMv7) */
>  void __init mmp2_init_icu(void)
>  {
> -	int irq;
> +	int irq, end;
>  
>  	max_icu_nr = 8;
>  	mmp_icu_base = ioremap(0xd4282000, 0x1000);
> @@ -263,11 +261,12 @@ void __init (void)
>  						   &icu_data[0]);
>  	icu_data[1].reg_status = mmp_icu_base + 0x150;
>  	icu_data[1].reg_mask = mmp_icu_base + 0x168;
> -	icu_data[1].clr_mfp_irq_base = IRQ_MMP2_PMIC_BASE;
> -	icu_data[1].clr_mfp_hwirq = IRQ_MMP2_PMIC - IRQ_MMP2_PMIC_BASE;
> +	icu_data[1].clr_mfp_irq_base = icu_data[0].virq_base +
> +				icu_data[0].nr_irqs;
> +	icu_data[1].clr_mfp_hwirq = 1;		/* offset to IRQ_MMP2_PMIC_BASE */
>  	icu_data[1].nr_irqs = 2;
>  	icu_data[1].cascade_irq = 4;
> -	icu_data[1].virq_base = IRQ_MMP2_PMIC_BASE;
> +	icu_data[1].virq_base = icu_data[0].virq_base + icu_data[0].nr_irqs;
>  	icu_data[1].domain = irq_domain_add_legacy(NULL, icu_data[1].nr_irqs,
>  						   icu_data[1].virq_base, 0,
>  						   &irq_domain_simple_ops,


I'd suggest passing IRQ_MMP2_PMIC_BASE and the other constants from the caller
and changing the prototype accordingly so you can do

	mmp2_init_icu(0, IRQ_MMP2_PMIC_BASE, IRQ_MMP2_RTC_BASE, IRQ_MMP2_KEYPAD_BASE,
			 IRQ_MMP2_TWSI_BASE, IRQ_MMP2_MISC_BASE, IRQ_MMP2_MIPI_HSI1_BASE,
			 IRQ_MMP2_MIPI_HSI0_BASE);

	Arnd
