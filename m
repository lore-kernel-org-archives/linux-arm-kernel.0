From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 18 Jun 2013 11:48:27 +0200
Subject: [PATCH v2 36/38] ARM: EXYNOS: Use exynos_init_io() as map_io
 callback
In-Reply-To: <1b9d01ce6c07$47e42cf0$d7ac86d0$%kim@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
 <1371486863-12398-37-git-send-email-t.figa@samsung.com>
 <1b9d01ce6c07$47e42cf0$d7ac86d0$%kim@samsung.com>
Message-ID: <4330740.PWIY8H74Fa@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 of June 2013 18:36:16 Kukjin Kim wrote:
> Tomasz Figa wrote:
> > Since there is no board specific mapping needed on Exynos,
> > exynos_init_io() can be simplified and used as map_io callback for both
> > Exynos4 and Exynos5.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > 
> >  arch/arm/mach-exynos/common.c          | 5 +----
> >  arch/arm/mach-exynos/common.h          | 2 +-
> >  arch/arm/mach-exynos/mach-exynos4-dt.c | 7 +------
> >  arch/arm/mach-exynos/mach-exynos5-dt.c | 7 +------
> >  4 files changed, 4 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> > index 91d457f..561890f 100644
> > --- a/arch/arm/mach-exynos/common.c
> > +++ b/arch/arm/mach-exynos/common.c
> > @@ -351,15 +351,12 @@ int __init exynos_fdt_map_chipid(unsigned long node,
> > const char *uname,
> > 
> >   * register the standard cpu IO areas
> >   */
> > 
> > -void __init exynos_init_io(struct map_desc *mach_desc, int size)
> > +void __init exynos_init_io(void)
> > 
> >  {
> >  
> >  	debug_ll_io_init();
> >  	
> >  	of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
> > 
> > -	if (mach_desc)
> > -		iotable_init(mach_desc, size);
> > -
> > 
> >  	/* detect cpu id and rev. */
> >  	s5p_init_cpu(S5P_VA_CHIPID);
> > 
> > diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> > index 1c83f95..38d45fd 100644
> > --- a/arch/arm/mach-exynos/common.h
> > +++ b/arch/arm/mach-exynos/common.h
> > @@ -19,7 +19,7 @@ void exynos_init_time(void);
> > 
> >  extern unsigned long xxti_f, xusbxti_f;
> >  
> >  struct map_desc;
> > 
> > -void exynos_init_io(struct map_desc *mach_desc, int size);
> > +void exynos_init_io(void);
> > 
> >  void exynos4_restart(char mode, const char *cmd);
> >  void exynos5_restart(char mode, const char *cmd);
> >  void exynos_init_late(void);
> > 
> > diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-
> > exynos/mach-exynos4-dt.c
> > index df15726..0099c6c 100644
> > --- a/arch/arm/mach-exynos/mach-exynos4-dt.c
> > +++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
> > @@ -23,11 +23,6 @@
> > 
> >  #include "common.h"
> > 
> > -static void __init exynos4_dt_map_io(void)
> > -{
> > -	exynos_init_io(NULL, 0);
> > -}
> > -
> > 
> >  static void __init exynos4_dt_machine_init(void)
> >  {
> >  
> >  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > 
> > @@ -55,7 +50,7 @@ static void __init exynos4_reserve(void)
> > 
> >  DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device
> 
> Tree)")
> 
> >  	/* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
> >  	.smp		= smp_ops(exynos_smp_ops),
> > 
> > -	.map_io		= exynos4_dt_map_io,
> > +	.map_io		= exynos_init_io,
> > 
> >  	.init_early	= exynos_firmware_init,
> >  	.init_machine	= exynos4_dt_machine_init,
> >  	.init_late	= exynos_init_late,
> > 
> > diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-
> > exynos/mach-exynos5-dt.c
> > index 8777310..ab54770 100644
> > --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> > +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> > @@ -27,11 +27,6 @@
> > 
> >  static u64 dma_mask64 = DMA_BIT_MASK(64);
> >  static u64 dma_mask32 = DMA_BIT_MASK(32);
> > 
> > -static void __init exynos5_dt_map_io(void)
> > -{
> > -	exynos_init_io(NULL, 0);
> > -}
> > -
> > 
> >  static int exynos5440_platform_notifier(struct notifier_block *nb,
> >  
> >  				  unsigned long event, void *__dev)
> >  
> >  {
> > 
> > @@ -105,7 +100,7 @@ static void __init exynos5_reserve(void)
> > 
> >  DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
> >  
> >  	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
> >  	.smp		= smp_ops(exynos_smp_ops),
> > 
> > -	.map_io		= exynos5_dt_map_io,
> > +	.map_io		= exynos_init_io,
> > 
> >  	.init_machine	= exynos5_dt_machine_init,
> >  	.init_late	= exynos_init_late,
> >  	.init_time	= exynos_init_time,
> > 
> > --
> > 1.8.2.1
> 
> Looks good to me, but I think, this change has been submitted by Arnd even
> though you did split, so the author should be Arnd. As you know, it is very
> important. Let me fix this and some patches when I apply. If any problems,
> let me know.

Right, I've been applying those changes manually and forgot to change the 
author. Please fix patches 36-38 then.

Best regards,
Tomasz
