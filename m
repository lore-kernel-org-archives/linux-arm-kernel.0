From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 27 Mar 2017 12:05:47 +0100
Subject: [RFC PATCH 21/30] iommu/arm-smmu-v3: Handle device faults from PRI
In-Reply-To: <0b3e3ddd-acc3-5ba7-639f-5c9192da57c3@gmail.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-22-jean-philippe.brucker@arm.com>
 <8520D5D51A55D047800579B0941471982640F43C@XAP-PVEXMBX02.xlnx.xilinx.com>
 <0b3e3ddd-acc3-5ba7-639f-5c9192da57c3@gmail.com>
Message-ID: <132394da-38e9-1722-833e-88303463ca4c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Valmiki,

On 25/03/17 05:16, valmiki wrote:
>> When we receive a PRI Page Request (PPR) from the SMMU, it contains a
>> context identifier SID:SSID, an IOVA and the requested access flags.
>>
>> Search the domain corresponding to SID:SSID, and call handle_mm_fault on
>> its mm. If memory management is able to fix the fault, we ask the device
>> to retry the access with a PRI_SUCCESS message. Otherwise send PRI_FAIL.
>>
> Hi Jean,
> 
> I need some clarification. Page fault handling is already part of MMU.
> When PRI requested page results in page fault, smmu is going to invoke
> handle_mm_fault which is part of memory management unit ?

Yes, the SMMU driver calls into the memory management code.

> If so this functionality is yet to be added in SMMU driver ?
>
> Because i haven't seen this API being called in your patches.

This patch implements the fault handling part:

(1) A PRI Page Request (PPR) is received by arm_smmu_handle_ppr. It is
    forwarded to work queue fault_queue
(2) The PPR is handled by arm_smmu_handle_fault, which calls
    _arm_smmu_handle_fault, which calls arm_smmu_handle_mm_fault and
    finally handle_mm_fault.
(3) We send a response via arm_smmu_fault_reply

Thanks,
Jean-Philippe
