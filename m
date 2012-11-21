From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Nov 2012 10:50:03 -0800
Subject: [PATCH v5 4/5] iommu/omap: adapt to runtime pm
In-Reply-To: <1353373552-16039-5-git-send-email-omar.luna@linaro.org>
References: <1353373552-16039-1-git-send-email-omar.luna@linaro.org>
 <1353373552-16039-5-git-send-email-omar.luna@linaro.org>
Message-ID: <20121121185002.GB18567@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Omar Ramirez Luna <omar.luna@linaro.org> [121119 17:08]:
> Use runtime PM functionality interfaced with hwmod enable/idle
> functions, to replace direct clock operations and sysconfig
> handling.
> 
> Due to reset sequence, pm_runtime_[get|put]_sync must be used, to
> avoid possible operations with the module under reset. Because of
> this and given that the driver uses spin_locks to protect their
> critical sections, we must use pm_runtime_irq_safe in order for the
> runtime ops to be happy, otherwise might_sleep_if checks in runtime
> framework will complain.
> 
> The remaining pm_runtime out of iommu_enable and iommu_disable
> corresponds to paths that can be accessed through debugfs, some of
> them doesn't work if the module is not enabled first, but in future
> if the mmu is idled withouth freeing, these are needed to debug.
> 
> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
> ---
>  arch/arm/mach-omap2/omap-iommu.c         |    1 -
>  drivers/iommu/omap-iommu.c               |   40 ++++++++++++++---------------
>  drivers/iommu/omap-iommu.h               |    3 --
>  drivers/iommu/omap-iommu2.c              |   17 ------------
>  include/linux/platform_data/iommu-omap.h |    1 -
>  5 files changed, 19 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
> index 02726a6..7642fc4 100644
> --- a/arch/arm/mach-omap2/omap-iommu.c
> +++ b/arch/arm/mach-omap2/omap-iommu.c
> @@ -31,7 +31,6 @@ static int __init omap_iommu_dev_init(struct omap_hwmod *oh, void *unused)
>  		return -ENOMEM;
>  
>  	pdata->name = oh->name;
> -	pdata->clk_name = oh->main_clk;
>  	pdata->nr_tlb_entries = a->nr_tlb_entries;
>  	pdata->da_start = a->da_start;
>  	pdata->da_end = a->da_end;

The runtime PM related changes would be good to be checked
by Kevin, added him to cc. For the arch/arm/mach-omap2/ change above:

Acked-by: Tony Lindgren <tony@atomide.com>
