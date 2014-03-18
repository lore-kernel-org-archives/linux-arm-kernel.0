From: pullip.cho@samsung.com (Cho KyongHo)
Date: Tue, 18 Mar 2014 19:52:10 +0900
Subject: [PATCH v11 13/27] iommu/exynos: support for device tree
In-Reply-To: <53230695.9080606@samsung.com>
References: <20140314140935.e0652b58ce16591b54d0e10b@samsung.com>
 <53230695.9080606@samsung.com>
Message-ID: <20140318195210.14c953a70498f634032f35b7@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Mar 2014 14:39:33 +0100, Tomasz Figa wrote:
> Hi KyongHo,
> 
> On 14.03.2014 06:09, Cho KyongHo wrote:
> > This commit adds device tree support for System MMU.
> >
> > Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> > ---
> >   drivers/iommu/Kconfig        |    5 ++---
> >   drivers/iommu/exynos-iommu.c |   21 +++++++++++++++++----
> >   2 files changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index df56e4c..22af807 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -178,16 +178,15 @@ config TEGRA_IOMMU_SMMU
> >
> >   config EXYNOS_IOMMU
> >   	bool "Exynos IOMMU Support"
> > -	depends on ARCH_EXYNOS && EXYNOS_DEV_SYSMMU
> > +	depends on ARCH_EXYNOS
> >   	select IOMMU_API
> > +	default n
> >   	help
> >   	  Support for the IOMMU(System MMU) of Samsung Exynos application
> 
> nit: There should be a white space before the opening parenthesis.
> 
Ok. :)

> >   	  processor family. This enables H/W multimedia accellerators to see
> 
> typo: s/accellerators/accelerators/
> 

Ok.

> >   	  non-linear physical memory chunks as a linear memory in their
> >   	  address spaces
> >
> > -	  If unsure, say N here.
> > -
> >   config EXYNOS_IOMMU_DEBUG
> >   	bool "Debugging log for Exynos IOMMU"
> >   	depends on EXYNOS_IOMMU
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index 33b424d..34feb04 100644
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> > @@ -26,6 +26,7 @@
> >   #include <linux/list.h>
> >   #include <linux/memblock.h>
> >   #include <linux/export.h>
> > +#include <linux/of.h>
> >
> >   #include <asm/cacheflush.h>
> >   #include <asm/pgtable.h>
> > @@ -497,7 +498,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
> >   	read_unlock_irqrestore(&data->lock, flags);
> >   }
> >
> > -static int exynos_sysmmu_probe(struct platform_device *pdev)
> > +static int __init exynos_sysmmu_probe(struct platform_device *pdev)
> >   {
> >   	int irq, ret;
> >   	struct device *dev = &pdev->dev;
> > @@ -557,11 +558,23 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
> >   	return 0;
> >   }
> >
> > -static struct platform_driver exynos_sysmmu_driver = {
> > -	.probe		= exynos_sysmmu_probe,
> > -	.driver		= {
> > +#ifdef CONFIG_OF
> > +static struct of_device_id sysmmu_of_match[] __initconst = {
> > +	{ .compatible	= "samsung,sysmmu-v1", },
> > +	{ .compatible	= "samsung,sysmmu-v2", },
> > +	{ .compatible	= "samsung,sysmmu-v3.1", },
> > +	{ .compatible	= "samsung,sysmmu-v3.2", },
> > +	{ .compatible	= "samsung,sysmmu-v3.3", },
> 
> Do you need all these compatible strings? I mean, are there any 
> implementation differences that can't be identified by reading IP 
> registers, such as REG_MMU_VERSION?
> 

Unfortunately, there is a SoC which overrides REG_MMU_VERSION with
a value for RTL designers and it is not related to System MMU
versions.

Thank you.

KyongHo
