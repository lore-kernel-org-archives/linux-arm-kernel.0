From: cjb@laptop.org (Chris Ball)
Date: Tue, 05 Jun 2012 13:25:28 -0400
Subject: [PATCH 2/2] ARM: mmp: fix missing cascade_irq in irq handler
In-Reply-To: <1338890114-22902-2-git-send-email-haojian.zhuang@gmail.com>
 (Haojian Zhuang's message of "Tue, 5 Jun 2012 17:55:14 +0800")
References: <1338890114-22902-1-git-send-email-haojian.zhuang@gmail.com>
 <1338890114-22902-2-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <87pq9dacxj.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 05 2012, Haojian Zhuang wrote:
> While supporting board in non-DT mode, icu_data[i]->cascade_irq isn't
> assigned with correct value.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  arch/arm/mach-mmp/irq.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/irq.c b/arch/arm/mach-mmp/irq.c
> index fcfe0e3..e60c7d9 100644
> --- a/arch/arm/mach-mmp/irq.c
> +++ b/arch/arm/mach-mmp/irq.c
> @@ -241,6 +241,7 @@ void __init mmp2_init_icu(void)
>  	icu_data[1].clr_mfp_irq_base = IRQ_MMP2_PMIC_BASE;
>  	icu_data[1].clr_mfp_hwirq = IRQ_MMP2_PMIC - IRQ_MMP2_PMIC_BASE;
>  	icu_data[1].nr_irqs = 2;
> +	icu_data[1].cascade_irq = 4;
>  	icu_data[1].virq_base = IRQ_MMP2_PMIC_BASE;
>  	icu_data[1].domain = irq_domain_add_legacy(NULL, icu_data[1].nr_irqs,
>  						   icu_data[1].virq_base, 0,
> @@ -249,6 +250,7 @@ void __init mmp2_init_icu(void)
>  	icu_data[2].reg_status = mmp_icu_base + 0x154;
>  	icu_data[2].reg_mask = mmp_icu_base + 0x16c;
>  	icu_data[2].nr_irqs = 2;
> +	icu_data[2].cascade_irq = 5;
>  	icu_data[2].virq_base = IRQ_MMP2_RTC_BASE;
>  	icu_data[2].domain = irq_domain_add_legacy(NULL, icu_data[2].nr_irqs,
>  						   icu_data[2].virq_base, 0,
> @@ -257,6 +259,7 @@ void __init mmp2_init_icu(void)
>  	icu_data[3].reg_status = mmp_icu_base + 0x180;
>  	icu_data[3].reg_mask = mmp_icu_base + 0x17c;
>  	icu_data[3].nr_irqs = 3;
> +	icu_data[3].cascade_irq = 9;
>  	icu_data[3].virq_base = IRQ_MMP2_KEYPAD_BASE;
>  	icu_data[3].domain = irq_domain_add_legacy(NULL, icu_data[3].nr_irqs,
>  						   icu_data[3].virq_base, 0,
> @@ -265,6 +268,7 @@ void __init mmp2_init_icu(void)
>  	icu_data[4].reg_status = mmp_icu_base + 0x158;
>  	icu_data[4].reg_mask = mmp_icu_base + 0x170;
>  	icu_data[4].nr_irqs = 5;
> +	icu_data[4].cascade_irq = 17;
>  	icu_data[4].virq_base = IRQ_MMP2_TWSI_BASE;
>  	icu_data[4].domain = irq_domain_add_legacy(NULL, icu_data[4].nr_irqs,
>  						   icu_data[4].virq_base, 0,
> @@ -273,6 +277,7 @@ void __init mmp2_init_icu(void)
>  	icu_data[5].reg_status = mmp_icu_base + 0x15c;
>  	icu_data[5].reg_mask = mmp_icu_base + 0x174;
>  	icu_data[5].nr_irqs = 15;
> +	icu_data[5].cascade_irq = 35;
>  	icu_data[5].virq_base = IRQ_MMP2_MISC_BASE;
>  	icu_data[5].domain = irq_domain_add_legacy(NULL, icu_data[5].nr_irqs,
>  						   icu_data[5].virq_base, 0,
> @@ -281,6 +286,7 @@ void __init mmp2_init_icu(void)
>  	icu_data[6].reg_status = mmp_icu_base + 0x160;
>  	icu_data[6].reg_mask = mmp_icu_base + 0x178;
>  	icu_data[6].nr_irqs = 2;
> +	icu_data[6].cascade_irq = 51;
>  	icu_data[6].virq_base = IRQ_MMP2_MIPI_HSI1_BASE;
>  	icu_data[6].domain = irq_domain_add_legacy(NULL, icu_data[6].nr_irqs,
>  						   icu_data[6].virq_base, 0,
> @@ -289,6 +295,7 @@ void __init mmp2_init_icu(void)
>  	icu_data[7].reg_status = mmp_icu_base + 0x188;
>  	icu_data[7].reg_mask = mmp_icu_base + 0x184;
>  	icu_data[7].nr_irqs = 2;
> +	icu_data[7].cascade_irq = 55;
>  	icu_data[7].virq_base = IRQ_MMP2_MIPI_HSI0_BASE;
>  	icu_data[7].domain = irq_domain_add_legacy(NULL, icu_data[7].nr_irqs,
>  						   icu_data[7].virq_base, 0,

Thanks -- this patch fixes the boot crash regression that's present in
3.5-rc1 on our board:

Tested-by: Chris Ball <cjb@laptop.org>

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
