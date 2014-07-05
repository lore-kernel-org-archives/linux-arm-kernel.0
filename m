From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 05 Jul 2014 12:04:10 +0530
Subject: [PATCH v5 2/5] ARM: EXYNOS: Refactored code for using PMU address
 via DT
In-Reply-To: <53B18E24.70809@samsung.com>
References: <1403705032-14835-1-git-send-email-pankaj.dubey@samsung.com>
 <1403705032-14835-3-git-send-email-pankaj.dubey@samsung.com>
 <53B18E24.70809@samsung.com>
Message-ID: <001c01cf981b$25138950$6f3a9bf0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Monday, June 30, 2014 Tomasz Figa wrote:
> Hi Pankaj,
> 
> This looks much better now, but please see my comments inline.
> 
> On 25.06.2014 16:03, Pankaj Dubey wrote:
> > Under "arm/mach-exynos" many files are using PMU register offsets.
> > Since we have added support for accessing PMU base address via DT, now
> > we can remove PMU mapping from exynosX_iodesc. Let's convert all these
> > access using iomapped address.
> > This will help us in removing static mapping of PMU base address as
> > well as help in reducing dependency over machine header files.
> > Thus helping for migration of PMU implementation from machine to
> > driver folder which can be reused for ARM64 bsed SoC.
> 
> [snip]
> 
> > @@ -152,7 +142,7 @@ static void exynos_restart(enum reboot_mode mode,
> > const char *cmd)  {
> >  	struct device_node *np;
> >  	u32 val = 0x1;
> > -	void __iomem *addr = EXYNOS_SWRESET;
> > +	void __iomem *addr = NULL;
> 
> Instead of initializing this variable to NULL, pmu_base_addr +
> EXYNOS_SWRESET could be used instead.

OK.

> 
> >
> >  	if (of_machine_is_compatible("samsung,exynos5440")) {
> >  		u32 status;
> > @@ -165,9 +155,9 @@ static void exynos_restart(enum reboot_mode mode,
> const char *cmd)
> >  		val = __raw_readl(addr);
> >
> >  		val = (val & 0xffff0000) | (status & 0xffff);
> > -	}
> > -
> > -	__raw_writel(val, addr);
> > +		__raw_writel(val, addr);
> > +	} else
> > +		__raw_writel(val, pmu_base_addr + EXYNOS_SWRESET);
> 
> The above would allow this code to be left unchanged.
> 
> >  }
> >
> 
> [snip]
> 
> > diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> > index f127c0c..519aefe 100644
> > --- a/arch/arm/mach-exynos/pm.c
> > +++ b/arch/arm/mach-exynos/pm.c
> > @@ -37,6 +37,9 @@
> >  #include "regs-pmu.h"
> >  #include "regs-sys.h"
> >
> > +#define pmu_raw_writel(val, offset) \
> > +		__raw_writel(val, pmu_base_addr + offset)
> 
> Please make this static inline.
> 

OK.

> > +
> >  /**
> >   * struct exynos_wkup_irq - Exynos GIC to PMU IRQ mapping
> >   * @hwirq: Hardware IRQ signal of the GIC @@ -111,7 +114,7 @@ static
> > int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
> >   */
> >  void exynos_cpu_power_down(int cpu)
> >  {
> > -	__raw_writel(0, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
> > +	pmu_raw_writel(0, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
> >  }
> >
> >  /**
> > @@ -122,8 +125,8 @@ void exynos_cpu_power_down(int cpu)
> >   */
> >  void exynos_cpu_power_up(int cpu)
> >  {
> > -	__raw_writel(S5P_CORE_LOCAL_PWR_EN,
> > -		     EXYNOS_ARM_CORE_CONFIGURATION(cpu));
> > +	pmu_raw_writel(S5P_CORE_LOCAL_PWR_EN,
> > +			EXYNOS_ARM_CORE_CONFIGURATION(cpu));
> >  }
> >
> >  /**
> > @@ -133,7 +136,7 @@ void exynos_cpu_power_up(int cpu)
> >   */
> >  int exynos_cpu_power_state(int cpu)
> >  {
> > -	return (__raw_readl(EXYNOS_ARM_CORE_STATUS(cpu)) &
> > +	return (__raw_readl(pmu_base_addr +
> EXYNOS_ARM_CORE_STATUS(cpu)) &
> >  			S5P_CORE_LOCAL_PWR_EN);
> 
> __raw_readl()s could be replaced with pmu_raw_readl()s too.
> 

OK, will update all these. 

> Best regards,
> Tomasz

Thanks,
Pankaj Dubey
