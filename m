From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 16 Apr 2012 12:28:15 +0200
Subject: [PATCH 2/2] ARM: Exynos4: update SYSMMU setup code for gen_pd
 power domain driver
In-Reply-To: <CAHQjnOMnxFvPGYxpvXTxKRU7aSOEKfcpOaBUnYikNwk=WRevbg@mail.gmail.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
 <1334154871-4756-3-git-send-email-m.szyprowski@samsung.com>
 <CAHQjnOMnxFvPGYxpvXTxKRU7aSOEKfcpOaBUnYikNwk=WRevbg@mail.gmail.com>
Message-ID: <009a01cd1bbb$a22c50e0$e684f2a0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday, April 16, 2012 12:10 PM KyongHo Cho wrote:

> On Wed, Apr 11, 2012 at 11:34 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > SYSMMU platform devices must be registered before setting up power
> > domains to let power domain driver to correctly register also SYSMMU
> > controller devices. This patch also registers SYSMMU controller devices
> > to respective power domains.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > ?arch/arm/mach-exynos/dev-sysmmu.c | ? ?6 +++++-
> > ?arch/arm/mach-exynos/pm_domains.c | ? 13 +++++++++++++
> > ?2 files changed, 18 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos/dev-sysmmu.c b/arch/arm/mach-exynos/dev-sysmmu.c
> > index c5b1ea3..3544638 100644
> > --- a/arch/arm/mach-exynos/dev-sysmmu.c
> > +++ b/arch/arm/mach-exynos/dev-sysmmu.c
> > @@ -271,4 +271,8 @@ static int __init init_sysmmu_platform_device(void)
> >
> > ? ? ? ?return 0;
> > ?}
> > -arch_initcall(init_sysmmu_platform_device);
> > +/*
> > + * SYSMMU platform devices must be registered before power domains
> > + * see pm_domain.c, which use arch_initcall()
> > + */
> > +core_initcall(init_sysmmu_platform_device);
> I don't understand why init_sysmmu_platform_device() must be called before
> exynos4_pm_init_power_domain()?
> 
> Other devices also added by an arch_initcall() function which calls
> mdesc->init_machine().
> I also was unable to find any reason to add devices before registering
> the devices to pm domain.

mdesc->init_machine is called before exynos4_pm_init_power_domain() from 
arch/arm/mach-exynos/pm_domain.c, although both are started from arch_initcall.
In this case the order of linking defines the order of calls.

exynos4_pm_init_power_domain() calls exynos_pm_add_dev_to_genpd() which in turn
checks for pdev->dev.bus. All devices which have not been registered yet on the
bus are simply skipped.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
