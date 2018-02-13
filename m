From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 13 Feb 2018 12:58:56 +0000
Subject: [PATCH 29/37] iommu/arm-smmu-v3: Add stall support for platform
 devices
In-Reply-To: <5A824359.1080005@huawei.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-30-jean-philippe.brucker@arm.com>
 <5A824359.1080005@huawei.com>
Message-ID: <f8005429-8e51-fe54-17f8-820543883ce9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13/02/18 01:46, Xu Zaibo wrote:
> Hi,
> 
> On 2018/2/13 2:33, Jean-Philippe Brucker wrote:
>> The SMMU provides a Stall model for handling page faults in platform
>> devices. It is similar to PCI PRI, but doesn't require devices to have
>> their own translation cache. Instead, faulting transactions are parked and
>> the OS is given a chance to fix the page tables and retry the transaction.
>>
>> Enable stall for devices that support it (opt-in by firmware). When an
>> event corresponds to a translation error, call the IOMMU fault handler. If
>> the fault is recoverable, it will call us back to terminate or continue
>> the stall.
>>
>> Note that this patch tweaks the iommu_fault_event and page_response_msg to
>> extend the fault id field. Stall uses 16 bits of IDs whereas PCI PRI only
>> uses 9.
> For PCIe devices without ATC,  can they use this Stall model?

Unfortunately no, Stall it is incompatible with PCI. Timing constraints in
PCI prevent from stalling transactions in the IOMMU.

Thanks,
Jean
