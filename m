From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 16 Nov 2017 15:03:00 +0000
Subject: [RFCv2 PATCH 31/36] iommu/arm-smmu-v3: Add support for PCI ATS
In-Reply-To: <BLUPR0201MB150565029F9260A528739ACBA52E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-32-jean-philippe.brucker@arm.com>
 <BLUPR0201MB150565029F9260A528739ACBA52E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
Message-ID: <673fda01-2ae0-87e4-637e-fe27096b6be0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bharat,

On 16/11/17 14:19, Bharat Kumar Gogada wrote:
> Hi Jean,
> 
> +static size_t
> +arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
> +			unsigned long iova, size_t size)
> +{
> +	unsigned long flags;
> +	struct arm_smmu_cmdq_ent cmd;
> +	struct arm_smmu_master_data *master;
> +
> +	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
> +
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_for_each_entry(master, &smmu_domain->devices, list)
> +		arm_smmu_atc_inv_master(master, &cmd);
> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> +
> +	return size;
> +}
> +
>  /* IOMMU API */
>  static bool arm_smmu_capable(enum iommu_cap cap)  { @@ -2361,6 +2506,8 @@ static void arm_smmu_detach_dev(struct device *dev)
>  		__iommu_process_unbind_dev_all(&smmu_domain->domain, dev);
>  
>  	if (smmu_domain) {
> +		arm_smmu_atc_inv_master_all(master, 0);
> +
> In BIND flow, when VFIO_IOMMU_UNBIND is invoked invalidation is sent on allocated PASID for this application.
> When vfio group fd is closed after UNBIND,  arm_smmu_detach_dev is invoked now invalidation is being sent on ssid zero.
> Why  invalidation needs to be sent on ssid zero ?

It's possible to use bind/unbind and map/unmap APIs at the same time on a
domain. map/unmap modifies non-ssid mappings as usual, for context
descriptor 0. Note that SSID 0 is converted to "no SSID" by
arm_smmu_atc_inv_to_cmd.

That said, I think VFIO cleans all DMA mappings when the VFIO group fd is
closed, which will send individual ATC invalidation for each mapping. But
VFIO may not be the only user of this API, and future users may be less
careful. It's safer to send this global invalidation whenever we detach
the domain, to ensure we're not leaving stale ATC entries for the next user.

Thanks,
Jean
