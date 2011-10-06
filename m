From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 06 Oct 2011 15:30:57 +0900
Subject: [PATCH 5/7] ARM: EXYNOS4: Add support external GIC
In-Reply-To: <4E8C61C4.9090709@arm.com>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
	<1308555258-4322-6-git-send-email-chaos.youn@samsung.com>
	<4E8C61C4.9090709@arm.com>
Message-ID: <00ec01cc83f1$81f84430$85e8cc90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier wrote:
> 
> Hi Changhwan,
> 
Hi Marc,

(Cc'ed Will Deacon and Russell King)

> On 20/06/11 08:34, Changhwan Youn wrote:
> > For full support of power modes, this patch adds implementation
> > external GIC on EXYNOS4.
> >
> > External GIC of Exynos4 cannot support register banking so
> > several interrupt related code for CPU1 should be different
> > from that of CPU0.
> 
> I just realized that patch has made it to mainline... Unfortunately, it
> seems quite broken to me:
> 
> > Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> > ---
> >  arch/arm/mach-exynos4/cpu.c                      |   10 ++++++++
> >  arch/arm/mach-exynos4/include/mach/entry-macro.S |    5 ++++
> >  arch/arm/mach-exynos4/include/mach/map.h         |    1 +
> >  arch/arm/mach-exynos4/platsmp.c                  |   27
> +++++++++++++++++++++-
> >  4 files changed, 42 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
> > index fa33294..40a866c 100644
> > --- a/arch/arm/mach-exynos4/cpu.c
> > +++ b/arch/arm/mach-exynos4/cpu.c
> > @@ -16,6 +16,7 @@
> >
> >  #include <asm/proc-fns.h>
> >  #include <asm/hardware/cache-l2x0.h>
> > +#include <asm/hardware/gic.h>
> >
> >  #include <plat/cpu.h>
> >  #include <plat/clock.h>
> > @@ -159,11 +160,20 @@ void __init exynos4_init_clocks(int xtal)
> >  	exynos4_setup_clocks();
> >  }
> >
> > +static void exynos4_gic_irq_eoi(struct irq_data *d)
> > +{
> > +	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> > +
> > +	gic_data->cpu_base = S5P_VA_GIC_CPU +
> > +			    (EXYNOS4_GIC_BANK_OFFSET *
> smp_processor_id());
> 
> Here, you're overwriting a field that is shared among *all* the
> interrupts in the system.  What if an interrupt comes up on another CPU?
> If you look at the implementation of gic_eoi_irq(), you'll definitely
> see the race.
> 
Hmm...as you can see in git log, the EXYNOS4210 cannot support register
banking in GIC so this is needed.

> > +}
> > +
> >  void __init exynos4_init_irq(void)
> >  {
> >  	int irq;
> >
> >  	gic_init(0, IRQ_LOCALTIMER, S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
> > +	gic_arch_extn.irq_eoi = exynos4_gic_irq_eoi;
> 
> And here you're abusing the GIC extension feature.
> 
I think gic_arch_extn.irq_eoi can be overwritten in each architecture to
support own specific extensions like in the EXYNOS4 case.

> I've also had a look at -next, and this has been extended further to
> support 4412. The problem with that is without banking, you're painfully
> working around the GIC driver. At that stage, I wonder if you wouldn't
> be better off with a separate driver instead of abusing the existing
one...
> 
Well, in this case, you mean separate driver is better to us even though
there is a gic driver in arch/arm/common? I don't think so because separate
driver will probably have many duplicated codes and if common gic driver can
support every silicons which have different version's gic it's better to us
and should do.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
