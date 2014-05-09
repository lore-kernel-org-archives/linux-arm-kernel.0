From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 09 May 2014 11:14:49 +0900
Subject: [PATCHv5] ARM: EXYNOS: Support secondary CPU boot of Exynos4212
In-Reply-To: <5369B88E.9030901@samsung.com>
References: <1398735462-1938-1-git-send-email-cw00.choi@samsung.com>
 <5369B88E.9030901@samsung.com>
Message-ID: <034d01cf6b2c$748bdd50$5da397f0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chanwoo Choi wrote:
> 
> Dear Kukjin,
> 
> Could you please pick this patch?
> 
I've applied.

Thanks,
Kukjin

> Best Regards,
> Chanwoo Choi
> 
> On 04/29/2014 10:37 AM, Chanwoo Choi wrote:
> > From: Kyungmin Park <kyungmin.park@samsung.com>
> >
> > This patch fix the offset of CPU boot address and change parameter of
> smc call
> > of SMC_CMD_CPU1BOOT command for Exynos4212.
> >
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> > ---
> > Changes from v4:
> > - Post only this patch separated from following patchset[1]
> > [1] https://lkml.org/lkml/2014/4/24/873
> >
> >  arch/arm/mach-exynos/firmware.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-
> exynos/firmware.c
> > index 932129e..aa01c42 100644
> > --- a/arch/arm/mach-exynos/firmware.c
> > +++ b/arch/arm/mach-exynos/firmware.c
> > @@ -18,6 +18,8 @@
> >
> >  #include <mach/map.h>
> >
> > +#include <plat/cpu.h>
> > +
> >  #include "smc.h"
> >
> >  static int exynos_do_idle(void)
> > @@ -28,13 +30,24 @@ static int exynos_do_idle(void)
> >
> >  static int exynos_cpu_boot(int cpu)
> >  {
> > +	/*
> > +	 * The second parameter of SMC_CMD_CPU1BOOT command means CPU id.
> > +	 * But, Exynos4212 has only one secondary CPU so second parameter
> > +	 * isn't used for informing secure firmware about CPU id.
> > +	 */
> > +	if (soc_is_exynos4212())
> > +		cpu = 0;
> > +
> >  	exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
> >  	return 0;
> >  }
> >
> >  static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
> >  {
> > -	void __iomem *boot_reg = S5P_VA_SYSRAM_NS + 0x1c + 4*cpu;
> > +	void __iomem *boot_reg = S5P_VA_SYSRAM_NS + 0x1c;
> > +
> > +	if (!soc_is_exynos4212())
> > +		boot_reg += 4*cpu;
> >
> >  	__raw_writel(boot_addr, boot_reg);
> >  	return 0;
> >
