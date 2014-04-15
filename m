From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Apr 2014 09:50:40 +0200
Subject: [PATCH v2 07/12] ARM: hisi: add hip04 SoC support
In-Reply-To: <CAD6h2NSJ5MvSbLw8kGkbNmy1UYXb+LDKYp9hfG1YEswFNDkOrQ@mail.gmail.com>
References: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
 <4584675.BJyVXFoGau@wuerfel>
 <CAD6h2NSJ5MvSbLw8kGkbNmy1UYXb+LDKYp9hfG1YEswFNDkOrQ@mail.gmail.com>
Message-ID: <90100568.4DTyQlJ7Rj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 April 2014 15:02:10 Haojian Zhuang wrote:
> On 8 April 2014 19:10, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 08 April 2014 16:00:47 Haojian Zhuang wrote:
> >> diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
> >> index 741faf3..10a605f 100644
> >> --- a/arch/arm/mach-hisi/hisilicon.c
> >> +++ b/arch/arm/mach-hisi/hisilicon.c
> >> @@ -14,6 +14,7 @@
> >>  #include <linux/clk-provider.h>
> >>  #include <linux/clocksource.h>
> >>  #include <linux/irqchip.h>
> >> +#include <linux/memblock.h>
> >>  #include <linux/of_address.h>
> >>  #include <linux/of_platform.h>
> >>
> >> @@ -88,3 +89,21 @@ DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
> >>       .smp            = smp_ops(hi3xxx_smp_ops),
> >>       .restart        = hi3xxx_restart,
> >>  MACHINE_END
> >> +
> >> +static const char *hip04_compat[] __initconst = {
> >> +     "hisilicon,hip04-d01",
> >> +     NULL,
> >> +};
> >> +
> >> +static void __init hip04_reserve(void)
> >> +{
> >> +     memblock_reserve(HIP04_BOOTWRAPPER_PHYS, HIP04_BOOTWRAPPER_SIZE);
> >> +}
> >
> > Can you explain why you do this? Shouldn't that memory just be listed
> > in the DT?
> 
> In current implementation, boot code of secondary CPUs are stored in the memory
> of HIP04_BOOTWRAPPER_PHYS.
> 
> If the bootwrapper could be removed, we need to refresh the code on booting
> up secondary CPU.

What I meant was that you should not call memblock_reserve() from an early
function here, but instead pass correct data through the DT so you don't
have to. You can reserve the memory in DT.

If changing the boot code is an option, you might consider just using the
standard PSCI interface. That is definitely the recommended approach, although
I don't know how that interacts with MCPM

> >> +DT_MACHINE_START(HIP04, "Hisilicon HiP04 (Flattened Device Tree)")
> >> +     .dt_compat      = hip04_compat,
> >> +#ifdef CONFIG_MCPM
> >> +     .smp_init       = smp_init_ops(hip04_smp_init_ops),
> >> +#endif
> >> +     .reserve        = hip04_reserve,
> >> +MACHINE_END
> >
> > I think the #ifdef is not needed here, you already hide hip04_smp_init_ops
> > if CONFIG_SMP is disabled, and SMP implies MCPM based on your Kconfig.
> >
> 
> If I build only ARCH_HI3xxx without ARCH_HIP04, CONFIG_MCPM won't be
> selected. Then I'll meet the build error.

I would rather see an #ifdef ARCH_HIP04 around the HIP04 code then.
You could also just use separate files for HI3xxx and HIP04, since
there is nothing shared between the two anyway.

	Arnd
