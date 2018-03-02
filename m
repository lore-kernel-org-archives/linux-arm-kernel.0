From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 2 Mar 2018 16:42:25 +0000
Subject: [PATCH 03/37] iommu/sva: Manage process address spaces
In-Reply-To: <cd4d7a98-e45e-7066-345f-52d8eef926a2@amd.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
 <5A97A324.9050605@linux.intel.com>
 <cd4d7a98-e45e-7066-345f-52d8eef926a2@amd.com>
Message-ID: <ebd22a3b-8507-8fd1-3efb-357931613c47@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/18 08:04, Christian K?nig wrote:
> Am 01.03.2018 um 07:52 schrieb Lu Baolu:
>> Hi Jean,
>>
>> On 02/13/2018 02:33 AM, Jean-Philippe Brucker wrote:
>>> [SNIP]
>>> +	pasid = idr_alloc_cyclic(&iommu_pasid_idr, io_mm, dev_param->min_pasid,
>>> +				 dev_param->max_pasid + 1, GFP_ATOMIC);
>> Can the pasid management code be moved into a common library?
>> PASID is not stick to SVA. An IOMMU model device could be designed
>> to use PASID for second level translation (classical DMA translation)
>> as well.
> 
> Yeah, we have the same problem on amdgpu.
> 
> We assign PASIDs to clients even when IOMMU isn't present in the system 
> just because we need it for debugging.
> 
> E.g. when the hardware detects that some shader program is doing 
> something nasty we get the PASID in the interrupt and could for example 
> use it to inform the client about the fault.

This seems like a new requirement altogether, and a bit outside the
scope of this series to be honest. Is the client userspace in this
context? I guess it would be mostly for prototyping then? Otherwise you
probably don't want to hand GPU contexts to userspace without an IOMMU
isolating them?

If you don't need mm tracking/sharing or iommu_map/unmap, then maybe an
IDR private to the GPU driver would be enough? If you do need mm
tracking, I suppose we could modify iommu_sva_bind() to allocate and
track io_mm even if the given device doesn't have an IOMMU, but it seems
a bit backward.

Thanks,
Jean
