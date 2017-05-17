From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 17 May 2017 12:04:30 -0500
Subject: [PATCH 1/3] iommu: of: Fix check for returning EPROBE_DEFER
In-Reply-To: <1495020609-13397-1-git-send-email-sricharan@codeaurora.org>
References: <1495020609-13397-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <20170517170430.GD31462@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 05:00:07PM +0530, Sricharan R wrote:
> Now with iommu probe deferral, we return -EPROBE_DEFER
> for master's that are connected to an iommu which is not

s/master's/masters/

s/iommu/IOMMU/ in your English text (changelogs and comments).  That seems
to be the convention, based on "git log drivers/iommu/of_iommu.c"

> probed yet, but going to get probed, so that we can attach
> the correct dma_ops. So while trying to defer the probe of
> the master, check if the of_iommu node that it is connected
> to is marked in DT as 'status=disabled', then the iommu is never
> is going to get probed. So simply return NULL and let the master
> work without an iommu.
> 
> Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred probing or error")
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Will Deacon <will.deacon@arm.com>
> Tested-by: Magnus Damn <magnus.damn@gmail.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/iommu/of_iommu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 9f44ee8..e6e9bec 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -118,6 +118,7 @@ static bool of_iommu_driver_present(struct device_node *np)
>  
>  	ops = iommu_ops_from_fwnode(fwnode);
>  	if ((ops && !ops->of_xlate) ||
> +	    !of_device_is_available(iommu_spec->np) ||
>  	    (!ops && !of_iommu_driver_present(iommu_spec->np)))
>  		return NULL;
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
