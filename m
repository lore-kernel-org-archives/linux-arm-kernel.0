From: Jean-Philippe.Brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 29 Jul 2016 15:46:55 +0100
Subject: [PATCH v4 6/8] iommu/arm-smmu: Implement of_xlate() for SMMUv3
In-Reply-To: <925b054b1e96dc83c0b1dc9607785d0346187366.1467388950.git.robin.murphy@arm.com>
References: <cover.1467388950.git.robin.murphy@arm.com>
 <925b054b1e96dc83c0b1dc9607785d0346187366.1467388950.git.robin.murphy@arm.com>
Message-ID: <20160729144655.GA3359@e106794-lin.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Very sorry about the delay, I forgot about this minor comment, below

On Fri, Jul 01, 2016 at 05:50:15PM +0100, Robin Murphy wrote:
> Now that we can properly describe the mapping between PCI RIDs and
> stream IDs via "iommu-map", and have it fed it to the driver
> automatically via of_xlate(), rework the SMMUv3 driver to benefit from
> that, and get rid of the current misuse of the "iommus" binding.
> 
> Since having of_xlate wired up means that masters will now be given the
> appropriate DMA ops, we also need to make sure that default domains work
> properly. This necessitates dispensing with the "whole group at a time"
> notion for attaching to a domain, as devices which share a group get
> attached to the group's default domain one by one as they are initially
> probed.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v4: Add explicit device probe in of_init callback.
> 
>  drivers/iommu/arm-smmu-v3.c | 278 +++++++++++++++++++-------------------------
>  1 file changed, 121 insertions(+), 157 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 94b68213c50d..fb438664b9f0 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
[...]
> @@ -1800,94 +1752,74 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
>  	return sid < limit;
>  }
>  
> +static struct iommu_ops arm_smmu_ops;
> +
>  static int arm_smmu_add_device(struct device *dev)
>  {
>  	int i, ret;
> -	u32 sid, *sids;
> -	struct pci_dev *pdev;
> -	struct iommu_group *group;
> -	struct arm_smmu_group *smmu_group;
>  	struct arm_smmu_device *smmu;
> +	struct arm_smmu_master_data *master;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec(dev);
> +	struct iommu_group *group;
>  
> -	/* We only support PCI, for now */
> -	if (!dev_is_pci(dev))
> +	if (!fwspec || fwspec->iommu_ops != &arm_smmu_ops)
>  		return -ENODEV;
> -
> -	pdev = to_pci_dev(dev);
> -	group = iommu_group_get_for_dev(dev);
> -	if (IS_ERR(group))
> -		return PTR_ERR(group);
> -
> -	smmu_group = iommu_group_get_iommudata(group);
> -	if (!smmu_group) {
> -		smmu = arm_smmu_get_for_pci_dev(pdev);
> -		if (!smmu) {
> -			ret = -ENOENT;
> -			goto out_remove_dev;
> -		}
> -
> -		smmu_group = kzalloc(sizeof(*smmu_group), GFP_KERNEL);
> -		if (!smmu_group) {
> -			ret = -ENOMEM;
> -			goto out_remove_dev;
> -		}
> -
> -		smmu_group->ste.valid	= true;
> -		smmu_group->smmu	= smmu;
> -		iommu_group_set_iommudata(group, smmu_group,
> -					  __arm_smmu_release_pci_iommudata);
> +	/*
> +	 * We _can_ actually withstand dodgy bus code re-calling add_device()
> +	 * without an intervening remove_device()/of_xlate() sequence, but
> +	 * we're not going to do so quietly...
> +	 */
> +	if (WARN_ON_ONCE(fwspec->iommu_priv)) {
> +		master = fwspec->iommu_priv;
> +		smmu = master->smmu;
>  	} else {
> -		smmu = smmu_group->smmu;
> +		smmu = arm_smmu_get_by_node(fwspec->iommu_np);
> +		if (!smmu)
> +			return -ENODEV;
> +		master = kzalloc(sizeof(*master), GFP_KERNEL);
> +		if (!master)
> +			return -ENOMEM;
> +
> +		master->smmu = smmu;
> +		fwspec->iommu_priv = master;

It's probably best to initialise master->ste.bypass = true here, to
reflect the initial state of STEs. Otherwise attach_dev always calls
detach_dev first for nothing.

Apart from that, this version works fine with my twisted setup. Note
that we might have to add a master->fwspec reference in the future, to
access those SIDs from various places. If I understood correctly, it
should be fine as those objects have the same lifetime after the
add_device call.

Thanks,
Jean-Philippe
