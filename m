From: bharatku@xilinx.com (Bharat Kumar Gogada)
Date: Fri, 17 Nov 2017 06:11:17 +0000
Subject: [RFCv2 PATCH 31/36] iommu/arm-smmu-v3: Add support for PCI ATS
In-Reply-To: <673fda01-2ae0-87e4-637e-fe27096b6be0@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-32-jean-philippe.brucker@arm.com>
 <BLUPR0201MB150565029F9260A528739ACBA52E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <673fda01-2ae0-87e4-637e-fe27096b6be0@arm.com>
Message-ID: <BLUPR0201MB1505BC86D3838D13F38665E7A52F0@BLUPR0201MB1505.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

It's possible to use bind/unbind and map/unmap APIs at the same time on a domain. map/unmap modifies non-ssid mappings as usual, for context descriptor 0. Note that SSID 0 is converted to "no SSID" by arm_smmu_atc_inv_to_cmd.

That said, I think VFIO cleans all DMA mappings when the VFIO group fd is closed, which will send individual ATC invalidation for each mapping. But VFIO may not be the only user of this API, and future users may be less careful. It's safer to send this global invalidation whenever we detach the domain, to ensure we're not leaving stale ATC entries for the next user.

Thanks Jean, I see that currently vfio_group_fops_open does not allow multiple instances. 
If a device supports multiple PASID there might be different applications running parallel. 
So why is multiple instances restricted ?

Regards,
Bharat
