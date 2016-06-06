From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 6 Jun 2016 13:47:21 +0100
Subject: [PATCH 2/2] arm-smmu: Add possibillity to mask streamIDs
In-Reply-To: <1464640806-3942-3-git-send-email-thommyj@gmail.com>
References: <1464640806-3942-1-git-send-email-thommyj@gmail.com>
 <1464640806-3942-3-git-send-email-thommyj@gmail.com>
Message-ID: <575570D9.6030700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/16 21:40, Thommy Jakobsson wrote:
> Use DT bindings to allow masks to be added for a masters streamIDs. This
> is necessary for devices that have multiple IDs, or use dynamic signals to
> build up the ID. For example the ZynqMPSoC that mirrors 6bits from the
> AXI ID into the streamid.

That rationale doesn't hold, since "necessary" is clearly untrue - 
devices with multiple IDs work just fine even with the current behaviour 
of the driver provided there are sufficient SMRs. The third option of 
generating a mask dynamically from a set of IDs is also perfectly 
possible (which reminds me I must dig up the code I prototyped a while 
back...), although an explicitly specified mask can still be beneficial 
for optimal allocation in certain cases (by being able to express the 
non-existence of IDs outside the set).

> Signed-off-by: Thommy Jakobsson <thommyj@gmail.com>
> ---
>   drivers/iommu/arm-smmu.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 9345a3f..14438f8 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -305,6 +305,7 @@ struct arm_smmu_smr {
>   struct arm_smmu_master_cfg {
>   	int				num_streamids;
>   	u16				streamids[MAX_MASTER_STREAMIDS];
> +	u16				streammasks[MAX_MASTER_STREAMIDS];
>   	struct arm_smmu_smr		*smrs;
>   };
>
> @@ -554,6 +555,38 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
>   	return insert_smmu_master(smmu, master);
>   }
>
> +static int register_smmu_master_mask(struct arm_smmu_device *smmu,
> +				     struct device *dev,
> +				     struct of_phandle_args *masterspec)
> +{
> +	int i;
> +	struct arm_smmu_master *master;
> +
> +	master = find_smmu_master(smmu, masterspec->np);
> +	if (!master) {
> +		dev_err(dev,
> +			"mask phandle to %s, but no ID registred\n",
> +			masterspec->np->name);
> +		return -EINVAL;
> +	}
> +
> +	if (masterspec->args_count != master->cfg.num_streamids) {
> +		dev_err(dev,
> +			"Different number of ids %d and masks %d not supported for master device %s\n",

But this directly contradicts the example in the binding doc? (Which 
incidentally wasn't sent to the devicetree mailing list.)

> +			master->cfg.num_streamids,
> +			masterspec->args_count,
> +			masterspec->np->name);
> +		return -ENOSPC;
> +	}
> +
> +	for (i = 0; i < master->cfg.num_streamids; ++i) {
> +		u16 streammask = masterspec->args[i];
> +
> +		master->cfg.streamids[i] = streammask;

What if the DT is wrong and the SMMU doesn't support stream matching at 
all, or the mask uses unimplemented SMR bits? Bogus stream IDs or stream 
match conflicts are annoyingly subtle to debug.

> +	}
> +	return 0;
> +}
> +
>   static struct arm_smmu_device *find_smmu_for_device(struct device *dev)
>   {
>   	struct arm_smmu_device *smmu;
> @@ -1106,7 +1139,7 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
>
>   		smrs[i] = (struct arm_smmu_smr) {
>   			.idx	= idx,
> -			.mask	= 0, /* We don't currently share SMRs */
> +			.mask	= cfg->streammasks[i],
>   			.id	= cfg->streamids[i],
>   		};
>   	}
> @@ -1972,6 +2005,17 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>
>   	dev_notice(dev, "registered %d master devices\n", i);
>
> +	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters-mask",
> +					   "#stream-id-cells", i,
> +					   &masterspec)) {
> +		err = register_smmu_master_mask(smmu, dev, &masterspec);
> +		if (err) {
> +			dev_err(dev, "failed to add mask for%s\n",
> +				masterspec.np->name);
> +			goto out_put_masters;
> +		}
> +
> +	}
>   	kfree(masterspec);
>
>   	parse_driver_options(smmu);
>

Either way, if you insist on wanting to build on the legacy binding that 
doesn't work for PCI, can't integrate with DMA mapping, and everyone 
else would rather get away from in favour of the generic IOMMU 
bindings[1], there's still no need for yet another binding to support. 
You can easily extend "mmu-masters" to encode an SMR mask in the upper 
halfword of a cell without ambiguity and without breaking compatibility 
with existing DTs.

Robin.

[1]The latest of many attempts being mine: 
http://thread.gmane.org/gmane.linux.kernel.iommu/12454
