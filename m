From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 07 Dec 2015 21:37:34 +0100
Subject: [PATCH v2 2/3] soc: dove: add legacy support to PMU driver
In-Reply-To: <E1a5j6Q-000879-GO@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Sun, 06 Dec 2015 23:52:26 +0000")
References: <E1a5j6Q-000879-GO@rmk-PC.arm.linux.org.uk>
Message-ID: <87r3iy9er5.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
 
 On lun., d?c. 07 2015, Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> Add support for legacy non-DT Dove to the PMU driver, so that we can
> transition the legacy support over.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Applied on mvebu/soc (and fixed a conflict in drivers/soc/Makefile)

Thanks,

Gregory

> ---
> This is a re-post of a previous patch, except I've split it into two to
> make the eventual removal of legacy Dove easier, as I believe Arnd will
> have some patches which touch legacy Dove which will conflict.  This
> makes it possible to revert this when the legacy Dove code is removed.
>
>  drivers/soc/Makefile         |  1 +
>  drivers/soc/dove/pmu.c       | 43 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/soc/dove/pmu.h | 18 ++++++++++++++++++
>  3 files changed, 62 insertions(+)
>
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 0b12d777d3c4..c99192f30679 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -2,6 +2,7 @@
>  # Makefile for the Linux Kernel SOC specific device drivers.
>  #
>  
> +obj-$(CONFIG_ARCH_DOVE)		+= dove/
>  obj-$(CONFIG_MACH_DOVE)		+= dove/
>  obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
>  obj-$(CONFIG_ARCH_QCOM)		+= qcom/
> diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
> index 052aecf29893..429e32cab55a 100644
> --- a/drivers/soc/dove/pmu.c
> +++ b/drivers/soc/dove/pmu.c
> @@ -305,6 +305,49 @@ static int __init dove_init_pmu_irq(struct pmu_data *pmu, int irq)
>  	return 0;
>  }
>  
> +int __init dove_init_pmu_legacy(const struct dove_pmu_initdata *initdata)
> +{
> +	const struct dove_pmu_domain_initdata *domain_initdata;
> +	struct pmu_data *pmu;
> +	int ret;
> +
> +	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
> +	if (!pmu)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&pmu->lock);
> +	pmu->pmc_base = initdata->pmc_base;
> +	pmu->pmu_base = initdata->pmu_base;
> +
> +	pmu_reset_init(pmu);
> +	for (domain_initdata = initdata->domains; domain_initdata->name;
> +	     domain_initdata++) {
> +		struct pmu_domain *domain;
> +
> +		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> +		if (domain) {
> +			domain->pmu = pmu;
> +			domain->pwr_mask = domain_initdata->pwr_mask;
> +			domain->rst_mask = domain_initdata->rst_mask;
> +			domain->iso_mask = domain_initdata->iso_mask;
> +			domain->base.name = domain_initdata->name;
> +
> +			__pmu_domain_register(domain, NULL);
> +		}
> +	}
> +	pm_genpd_poweroff_unused();
> +
> +	ret = dove_init_pmu_irq(pmu, initdata->irq);
> +	if (ret)
> +		pr_err("dove_init_pmu_irq() failed: %d\n", ret);
> +
> +	if (pmu->irq_domain)
> +		irq_domain_associate_many(pmu->irq_domain, IRQ_DOVE_PMU_START,
> +					  0, NR_PMU_IRQS);
> +
> +	return 0;
> +}
> +
>  /*
>   * pmu: power-manager at d0000 {
>   *	compatible = "marvell,dove-pmu";
> diff --git a/include/linux/soc/dove/pmu.h b/include/linux/soc/dove/pmu.h
> index 9c99f84bcc0e..431dfac595e7 100644
> --- a/include/linux/soc/dove/pmu.h
> +++ b/include/linux/soc/dove/pmu.h
> @@ -1,6 +1,24 @@
>  #ifndef LINUX_SOC_DOVE_PMU_H
>  #define LINUX_SOC_DOVE_PMU_H
>  
> +#include <linux/types.h>
> +
> +struct dove_pmu_domain_initdata {
> +	u32 pwr_mask;
> +	u32 rst_mask;
> +	u32 iso_mask;
> +	const char *name;
> +};
> +
> +struct dove_pmu_initdata {
> +	void __iomem *pmc_base;
> +	void __iomem *pmu_base;
> +	int irq;
> +	const struct dove_pmu_domain_initdata *domains;
> +};
> +
> +int dove_init_pmu_legacy(const struct dove_pmu_initdata *);
> +
>  int dove_init_pmu(void);
>  
>  #endif
> -- 
> 2.1.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
