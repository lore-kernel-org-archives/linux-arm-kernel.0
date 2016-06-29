From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 29 Jun 2016 08:12:21 +0200
Subject: [PATCH v2 2/2] ARM: at91: pm: switch to the PIE infrastructure
In-Reply-To: <1467153886-21144-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1467153886-21144-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1467153886-21144-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <2349417.jWuiI2GXql@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 June 2016 00:44:46, Alexandre Belloni wrote:
> Using the PIE infrastructure allows to write the whole suspend/resume
> functions in C instead of assembly.
> 
> The only remaining assembly instruction is wfi for armv5
> It makes the code shorter and clearer.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/mach-at91/Kconfig       |   1 +
>  arch/arm/mach-at91/Makefile      |   2 +-
>  arch/arm/mach-at91/pm.c          |  31 ++--
>  arch/arm/mach-at91/pm/.gitignore |   2 +
>  arch/arm/mach-at91/pm/Makefile   |   3 +
>  arch/arm/mach-at91/pm/atmel_pm.c |  97 +++++++++++
>  arch/arm/mach-at91/pm_suspend.S  | 338
> [...]
> --- /dev/null
> +++ b/arch/arm/mach-at91/pm/atmel_pm.c
> @@ -0,0 +1,97 @@
> +#include <linux/io.h>
> +#include <linux/clk/at91_pmc.h>
> +#include <linux/mfd/syscon/atmel-mc.h>
> +#include <linux/pie.h>
> +#include "../pm.h"
> +
> +#define	SRAMC_SELF_FRESH_ACTIVE		0x01
> +#define	SRAMC_SELF_FRESH_EXIT		0x00
> +
> +static void at91_sramc_self_refresh(unsigned int is_active,
> +				    unsigned int memtype,
> +				    void __iomem *sdramc_base,
> +				    void __iomem *sdramc_base1)
> +{
> +	static unsigned int lpr, mdr, lpr1, mdr1;
> +
> +	switch (memtype) {
> +	case AT91_MEMCTRL_MC:
> +	/*
> +	 * at91rm9200 Memory controller
> +	 */
> +		if (is_active)
> +			__raw_writel(1, sdramc_base + AT91_MC_SDRAMC_SRR);
> +		break;
> +
> +	case AT91_MEMCTRL_DDRSDR:
> +		if (is_active) {
> +			mdr = __raw_readl(sdramc_base + AT91_DDRSDRC_MDR);
> +			lpr = __raw_readl(sdramc_base + AT91_DDRSDRC_LPR);
> +
> +			if ((mdr & AT91_DDRSDRC_MD) == AT91_DDRSDRC_MD_LOW_POWER_DDR)
> +				__raw_writel((mdr & ~AT91_DDRSDRC_MD) |
> +					     AT91_DDRSDRC_MD_DDR2, sdramc_base +
> +					     AT91_DDRSDRC_MDR);
> +			__raw_writel((lpr & ~AT91_DDRSDRC_LPCB) |
> +				     AT91_DDRSDRC_LPCB_SELF_REFRESH, sdramc_base
> +				     + AT91_DDRSDRC_LPR);
> +
> +			if (sdramc_base1) {
> +				mdr1 = __raw_readl(sdramc_base1 + AT91_DDRSDRC_MDR);
> +				lpr1 = __raw_readl(sdramc_base1 + AT91_DDRSDRC_LPR);
> +				if ((mdr1 & AT91_DDRSDRC_MD) == 
AT91_DDRSDRC_MD_LOW_POWER_DDR)
> +					__raw_writel((mdr1 & ~AT91_DDRSDRC_MD) |
> +						     AT91_DDRSDRC_MD_DDR2,
> +						     sdramc_base1 +
> +						     AT91_DDRSDRC_MDR);
> +				__raw_writel((lpr1 & ~AT91_DDRSDRC_LPCB) |
> +					     AT91_DDRSDRC_LPCB_SELF_REFRESH,
> +					     sdramc_base1 + AT91_DDRSDRC_LPR);
> +			}
> +		} else {
> +			__raw_writel(mdr, sdramc_base + AT91_DDRSDRC_MDR);
> +			__raw_writel(lpr, sdramc_base + AT91_DDRSDRC_LPR);
> +			if (sdramc_base1) {
> +				__raw_writel(mdr, sdramc_base1 + AT91_DDRSDRC_MDR);
> +				__raw_writel(lpr, sdramc_base1 + AT91_DDRSDRC_LPR);
> +			}
> +		}
> +		break;
> +
> +	case AT91_MEMCTRL_SDRAMC:
> +		if (is_active) {
> +			lpr = __raw_readl(sdramc_base + AT91_SDRAMC_LPR);
> +
> +			__raw_writel((lpr & ~AT91_SDRAMC_LPCB) |
> +				     AT91_SDRAMC_LPCB_SELF_REFRESH, sdramc_base
> +				     + AT91_SDRAMC_LPR);
> +		} else {
> +			__raw_writel(lpr, sdramc_base + AT91_SDRAMC_LPR);
> +		}
> +		break;
> +	}
> +}
> +
> +void atmel_pm_suspend(void __iomem *pmc, void __iomem *ramc0,
> +		      void __iomem *ramc1, int memctrl)
> +{
> +	int memtype, pm_mode;
> +
> +	memtype = memctrl & AT91_PM_MEMTYPE_MASK;
> +	pm_mode = (memctrl >> AT91_PM_MODE_OFFSET) & AT91_PM_MODE_MASK;
> +
> +	dsb();
> +
> +	at91_sramc_self_refresh(1, memtype, ramc0, ramc1);
> +
> +#if defined(CONFIG_CPU_V7)
> +	dsb();
> +	wfi();
> +#else
> +	asm volatile ("mcr	p15, 0, %0, c7, c0, 4" \
> +		      : : "r" (0) : "memory");
> +#endif

Why not defining wfi() for __LINUX_ARM_ARCH__ < 7 as it is done for dsb() and 
friends in arch/arm/include/asm/barrier.h? So you can get rid of that #if 
completly.

> +	at91_sramc_self_refresh(0, memtype, ramc0, ramc1);
> +}
> +EXPORT_PIE_SYMBOL(atmel_pm_suspend);


Best regards,
Alexander
