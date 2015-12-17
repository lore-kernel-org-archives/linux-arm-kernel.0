From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 17 Dec 2015 07:17:42 +0200
Subject: [PATCH v2 2/8] irq: bcm2836: Add SMP support for the 2836
In-Reply-To: <1450310115-22163-3-git-send-email-eric@anholt.net>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
 <1450310115-22163-3-git-send-email-eric@anholt.net>
Message-ID: <20151217051742.GV2318@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Wed, Dec 16, 2015 at 03:55:09PM -0800, Eric Anholt wrote:
> @@ -226,6 +228,26 @@ static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
>  	.xlate = irq_domain_xlate_onecell
>  };
>  
> +#ifdef CONFIG_SMP

Why not put this section under the existing '#ifdef CONFIG_SMP' just a few 
lines above?

> +int __init bcm2836_smp_boot_secondary(unsigned int cpu,
> +				      struct task_struct *idle)
> +{
> +	unsigned long secondary_startup_phys =
> +		(unsigned long)virt_to_phys((void *)secondary_startup);
> +
> +	dsb();
> +	writel(secondary_startup_phys,
> +	       intc.base + LOCAL_MAILBOX3_SET0 + 16 * cpu);
> +
> +	return 0;
> +}
> +
> +static const struct smp_operations bcm2836_smp_ops __initconst = {
> +	.smp_boot_secondary	= bcm2836_smp_boot_secondary,
> +};
> +
> +#endif

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
