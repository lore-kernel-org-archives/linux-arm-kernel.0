From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 07 Mar 2014 14:04:16 +0100
Subject: [PATCH v2 03/11] ARM: exynos: Move to generic power domain
 bindings
In-Reply-To: <53174EB5.1090803@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
 <1713847.uSatLFRtJj@amdc1032> <53174EB5.1090803@gmail.com>
Message-ID: <19118595.DYTBeEpFjL@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wednesday, March 05, 2014 05:20:05 PM Tomasz Figa wrote:
> Hi Bartek,
> 
> On 05.03.2014 17:15, Bartlomiej Zolnierkiewicz wrote:
> >
> > Hi Tomek,
> >
> > On Monday, March 03, 2014 05:02:08 PM Tomasz Figa wrote:
> >> This patch moves Exynos power domain code to use the new generic power
> >> domain look-up framework introduced by previous patch, allowing the new
> >> code to be compiled with CONFIG_ARCH_EXYNOS selected as well.
> >>
> >> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> >> ---
> >>   .../bindings/arm/exynos/power_domain.txt           | 12 ++--
> >>   arch/arm/mach-exynos/pm_domains.c                  | 80 +---------------------
> >>   kernel/power/Kconfig                               |  2 +-
> >>   3 files changed, 7 insertions(+), 87 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> >> index 5216b41..60f26a8 100644
> >> --- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> >> +++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> >> @@ -8,6 +8,8 @@ Required Properties:
> >>       * samsung,exynos4210-pd - for exynos4210 type power domain.
> >>   - reg: physical base address of the controller and length of memory mapped
> >>       region.
> >> +- #power-domain-cells: number of cells in power domain specifier;
> >> +    must be 0.
> >>
> >>   Node of a device using power domains must have a samsung,power-domain property
> >>   defined with a phandle to respective power domain.
> >> @@ -17,12 +19,8 @@ Example:
> >>   	lcd0: power-domain-lcd0 {
> >>   		compatible = "samsung,exynos4210-pd";
> >>   		reg = <0x10023C00 0x10>;
> >> +		#power-domain-cells = <0>;
> >>   	};
> >>
> >> -Example of the node using power domain:
> >> -
> >> -	node {
> >> -		/* ... */
> >> -		samsung,power-domain = <&lcd0>;
> >> -		/* ... */
> >> -	};
> >> +See Documentation/devicetree/bindings/power/power_domain.txt for description
> >> +of consumer-side bindings.
> >> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> >> index 8fd2488..48ee6c9 100644
> >> --- a/arch/arm/mach-exynos/pm_domains.c
> >> +++ b/arch/arm/mach-exynos/pm_domains.c
> >> @@ -75,78 +75,6 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
> >>   	return exynos_pd_power(domain, false);
> >>   }
> >>
> >> -static void exynos_add_device_to_domain(struct exynos_pm_domain *pd,
> >> -					 struct device *dev)
> >> -{
> >> -	int ret;
> >> -
> >> -	dev_dbg(dev, "adding to power domain %s\n", pd->pd.name);
> >> -
> >> -	while (1) {
> >> -		ret = pm_genpd_add_device(&pd->pd, dev);
> >> -		if (ret != -EAGAIN)
> >> -			break;
> >> -		cond_resched();
> >> -	}
> >> -
> >> -	pm_genpd_dev_need_restore(dev, true);
> >> -}
> >> -
> >> -static void exynos_remove_device_from_domain(struct device *dev)
> >> -{
> >> -	struct generic_pm_domain *genpd = dev_to_genpd(dev);
> >> -	int ret;
> >> -
> >> -	dev_dbg(dev, "removing from power domain %s\n", genpd->name);
> >> -
> >> -	while (1) {
> >> -		ret = pm_genpd_remove_device(genpd, dev);
> >> -		if (ret != -EAGAIN)
> >> -			break;
> >> -		cond_resched();
> >> -	}
> >> -}
> >> -
> >> -static void exynos_read_domain_from_dt(struct device *dev)
> >> -{
> >> -	struct platform_device *pd_pdev;
> >> -	struct exynos_pm_domain *pd;
> >> -	struct device_node *node;
> >> -
> >> -	node = of_parse_phandle(dev->of_node, "samsung,power-domain", 0);
> >
> > This removes "samsung,power-domain" phandle handling but I cannot find
> > in your patch series updates to existing EXYNOS dts files converting
> > them to use the new "power-domain" property.  Am I missing something?
> 
> Patch 01/11 adds generic parsing code along with fallback to the legacy 
> "samsung,power-domain" property, if the generic one is not present, as 
> it was pretty straightforward to implement it there.

Ah, silly me, I should have looked more closely at patch #1.  Anyway,
I tested your patchset on Exynos4412 Trats2 target and it works fine
(BTW it also seems that your patchset fixed the issue of device not
being removed from power domain on ->probe failure).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
