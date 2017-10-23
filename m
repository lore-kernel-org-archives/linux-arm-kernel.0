From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 23 Oct 2017 13:17:07 +0100
Subject: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
In-Reply-To: <A2975661238FB949B60364EF0F2C257439AFD88A@SHSMSX104.ccr.corp.intel.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
 <A2975661238FB949B60364EF0F2C257439AFD88A@SHSMSX104.ccr.corp.intel.com>
Message-ID: <7aaf9851-9546-f34d-1496-cbeea404abbd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/10/17 12:04, Liu, Yi L wrote:
>> +	idr_preload(GFP_KERNEL);
>> +	spin_lock(&iommu_process_lock);
>> +	pasid = idr_alloc_cyclic(&iommu_process_idr, process, domain->min_pasid,
>> +				 domain->max_pasid + 1, GFP_ATOMIC);
>> +	process->pasid = pasid;
> 
> [Liu, Yi L] If I'm understanding well, here is managing the pasid allocation in iommu
> layer instead of vendor iommu driver? Is there strong reason here? I think pasid
> management may be better within vendor iommu driver as pasid management
> could differ from vendor to vendor.

But that's the thing, we're trying to abstract PASID and process
management to have it in the core, because there shouldn't be many
differences from vendor to vendor. This way we have the allocation code in
one place and vendor drivers don't have to copy paste it from other drivers.

It's just a global number within a range, so I don't think vendors will
have many different ways of designing it.

Thanks,
Jean
