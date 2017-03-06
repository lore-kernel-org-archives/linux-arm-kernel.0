From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 6 Mar 2017 11:14:51 +0000
Subject: [RFC PATCH 00/30] Add PCIe SVM support to ARM SMMUv3
In-Reply-To: <A2975661238FB949B60364EF0F2C2574390186B8@shsmsx102.ccr.corp.intel.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <A2975661238FB949B60364EF0F2C2574390186B8@shsmsx102.ccr.corp.intel.com>
Message-ID: <20170306111451.GA28804@e106794-lin.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yi,

On 06/03/17 08:20, Liu, Yi L wrote:
> 
> 
>> -----Original Message-----
>> From: iommu-bounces at lists.linux-foundation.org [mailto:iommu-
>> bounces at lists.linux-foundation.org] On Behalf Of Jean-Philippe Brucker
>> Sent: Tuesday, February 28, 2017 3:54 AM
>> Cc: Shanker Donthineni <shankerd@qti.qualcomm.com>; kvm at vger.kernel.org;
>> Catalin Marinas <catalin.marinas@arm.com>; Sinan Kaya
>> <okaya@qti.qualcomm.com>; Will Deacon <will.deacon@arm.com>;
>> iommu at lists.linux-foundation.org; Harv Abdulhamid <harba@qti.qualcomm.com>;
>> linux-pci at vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>; David
>> Woodhouse <dwmw2@infradead.org>; linux-arm-kernel at lists.infradead.org; Nate
>> Watterson <nwatters@qti.qualcomm.com>
>> Subject: [RFC PATCH 00/30] Add PCIe SVM support to ARM SMMUv3
>>
>> Hi,
>>
>> This series adds support for PCI ATS, PRI and PASID extensions to the
>> SMMUv3 driver. In systems that support it, it is now possible for some high-end
>> devices to perform DMA into process address spaces. Page tables are shared
>> between MMU and SMMU; page faults from devices are recoverable and handled by
>> the mm subsystem.
>>
>> We propose an extension to the IOMMU API that unifies existing SVM
>> implementations (AMD, Intel and ARM) in patches 22 and 24. Nothing is set in stone,
>> the goal is to start discussions and find an intersection between implementations.
>>
>> We also propose a VFIO interface in patches 29 and 30, that allows userspace device
>> drivers to make use of SVM. It would also serve as example implementation for
>> other device drivers.
>>
>> Overview of the patches:
>>
>> * 1 and 2 prepare the SMMUv3 structures for ATS,
>> * 3 to 5 enable ATS for devices that support it.
>> * 6 to 10 prepare the SMMUv3 structures for PASID and PRI. Patch 9,
>>   in particular, provides details on the structure requirements.
>> * 11 introduces an interface for sharing ASIDs on ARM64,
>> * 12 to 17 add more infrastructure for sharing page tables,
>> * 18 and 19 add minor helpers to PCI,
>> * 20 enables PASID in devices that support it,
> 
> Jean, supposedly, you will introduce a PASID management mechanism in
> SMMU v3 driver. Here I have a question about PASID management on ARM.
> Will there be a system wide PASID table? Or there is equivalent implementation.

Yes the SMMUv3 driver allocates and manages PASIDs. In this series I
implemented one PASID table for each device (for simplicity), but as
explained in my reply on patch 22, I'd like to introduce a PASID table
for each IOMMU domain in the next version.

Thanks,
Jean-Philippe
