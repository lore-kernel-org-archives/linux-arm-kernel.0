From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 2 Mar 2018 16:19:31 +0000
Subject: [PATCH 03/37] iommu/sva: Manage process address spaces
In-Reply-To: <5A97A324.9050605@linux.intel.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
 <5A97A324.9050605@linux.intel.com>
Message-ID: <087d3daa-5b63-038b-a81e-92ab752fdd26@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/18 06:52, Lu Baolu wrote:
> Can the pasid management code be moved into a common library?
> PASID is not stick to SVA. An IOMMU model device could be designed
> to use PASID for second level translation (classical DMA translation)
> as well.

What do you mean by second level translation? Do you see a use-case with
nesting translation within the host?

I agree that PASID + classical DMA is desirable. A device driver would
allocate PASIDs and perform iommu_sva_map(domain, pasid, iova, pa, size,
prot) and iommu_sva_unmap(domain, pasid, iova, size). I'm hoping that we
can also augment the DMA API with PASIDs, and that a driver can use both
shared and private contexts simultaneously. So that it can use a few
PASIDs for management purpose, and assign the rest to userspace.

The intent is for iommu-sva.c to be this common library. Work for
"private" PASID allocation is underway, see Jordan Crouse's series
posted last week https://www.spinics.net/lists/arm-kernel/msg635857.html

Thanks,
Jean
