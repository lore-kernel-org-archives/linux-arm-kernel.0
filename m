From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 Oct 2011 10:08:39 -0700
Subject: [RFC/PATCH v4 4/7] ARM: ARM11 MPCore: clean_dcache_area is not
	preempt safe
In-Reply-To: <1318945654-548-5-git-send-email-gdavis@mvista.com>
References: <1318004800-6525-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-5-git-send-email-gdavis@mvista.com>
Message-ID: <20111018170839.GD27515@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* gdavis at mvista.com <gdavis@mvista.com> [111018 06:13]:
> From: George G. Davis <gdavis@mvista.com>
> 
> If preemption and subsequent task migration occurs during calls to
> clean_dcache_area on ARM11 MPCore machines, global memory state
> can become inconsistent.  To prevent inconsistent memory state on
> these machines, disable preemption in callers of these functions
> around memory modifications and subsequent clean_dcache_area calls.

This one needs to be refreshed against what's queued in for-next as
Ohad has moved most of the iommu code into drivers. I've added
Ohad to Cc as well.

Regards,

Tony

> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: George G. Davis <gdavis@mvista.com>
> ---
>  arch/arm/plat-omap/iommu.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index 34fc31e..59836d1 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -1014,8 +1014,12 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
>  		err = -ENOMEM;
>  		goto err_pgd;
>  	}
> +	if (cache_ops_need_broadcast())
> +		preempt_disable();
>  	memset(p, 0, IOPGD_TABLE_SIZE);
>  	clean_dcache_area(p, IOPGD_TABLE_SIZE);
> +	if (cache_ops_need_broadcast())
> +		preempt_enable();
>  	obj->iopgd = p;
>  
>  	BUG_ON(!IS_ALIGNED((unsigned long)obj->iopgd, IOPGD_TABLE_SIZE));
> @@ -1069,7 +1073,13 @@ static struct platform_driver omap_iommu_driver = {
>  
>  static void iopte_cachep_ctor(void *iopte)
>  {
> +	if (cache_ops_need_broadcast())
> +		preempt_disable();
> +	/* FIXME: This will not work on ARM11 MPCore.
> +	 */
>  	clean_dcache_area(iopte, IOPTE_TABLE_SIZE);
> +	if (cache_ops_need_broadcast())
> +		preempt_enable();
>  }
>  
>  static int __init omap_iommu_init(void)
> -- 
> 1.7.4.4
> 
