From: ashok.raj@intel.com (Raj, Ashok)
Date: Wed, 25 Oct 2017 11:05:47 -0700
Subject: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
In-Reply-To: <7aaf9851-9546-f34d-1496-cbeea404abbd@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
 <A2975661238FB949B60364EF0F2C257439AFD88A@SHSMSX104.ccr.corp.intel.com>
 <7aaf9851-9546-f34d-1496-cbeea404abbd@arm.com>
Message-ID: <20171025180546.GA12356@otc-nc-03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean

On Mon, Oct 23, 2017 at 01:17:07PM +0100, Jean-Philippe Brucker wrote:
> On 23/10/17 12:04, Liu, Yi L wrote:
> >> +	idr_preload(GFP_KERNEL);
> >> +	spin_lock(&iommu_process_lock);
> >> +	pasid = idr_alloc_cyclic(&iommu_process_idr, process, domain->min_pasid,
> >> +				 domain->max_pasid + 1, GFP_ATOMIC);
> >> +	process->pasid = pasid;
> > 
> > [Liu, Yi L] If I'm understanding well, here is managing the pasid allocation in iommu
> > layer instead of vendor iommu driver? Is there strong reason here? I think pasid
> > management may be better within vendor iommu driver as pasid management
> > could differ from vendor to vendor.
> 
> But that's the thing, we're trying to abstract PASID and process
> management to have it in the core, because there shouldn't be many
> differences from vendor to vendor. This way we have the allocation code in
> one place and vendor drivers don't have to copy paste it from other drivers.

I think this makes sense for the native case and also in the vIOMMU
if the PASID tables and allocation are completely managed by the guest.

If the vIOMMU requires any co-ordination in how the PASID's are allocated
for guest devices there might need to be some control on how these are 
allocated that ultimately need to be managed by VMM/Physical IOMMU. For 
instance if the PASID space is sparse for e.g

if we make the PASID allocation as one of the ops, the IOMMU implementation
will choose the default function, or if it choose a differnt mechanism it would
have that flexibility.

Does this make sense?

Cheers,
Ashok

> 
> It's just a global number within a range, so I don't think vendors will
> have many different ways of designing it.
> 
> Thanks,
> Jean
> 
> 
> 
> 
