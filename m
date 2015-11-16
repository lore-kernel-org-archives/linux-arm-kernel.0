From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 16 Nov 2015 11:25:35 -0500
Subject: [PATCH V5 2/3] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <6159200.u9U0p8aIkU@wuerfel>
References: <1447620855-4974-1-git-send-email-okaya@codeaurora.org>
 <1447620855-4974-3-git-send-email-okaya@codeaurora.org>
 <6159200.u9U0p8aIkU@wuerfel>
Message-ID: <564A037F.602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2015 10:58 AM, Arnd Bergmann wrote:
>> The management driver is executed in hypervisor context and
>> > is the main management entity for all channels provided by
>> > the device.
> Sorry for asking this question so late, but can you explain what the
> point is behind this? It seems counterintuitive to me to have a
> DMA engine that is meant for speeding up memory-to-memory transfers
> when you run it in a virtual machine where you either need to go
> through a virtual IOMMU to set up page table entries, as that will
> likely cause more performance overhead than you could possibly
> gain, or you assume that all the guest memory is pinned, which
> in turn destroys a lot of the assumptions that we are making
> in KVM to have useful VM guests.
> 
> Where am I going wrong here?
> 

The behavior of HIDMA is not any different from PCIe. We are using
platform device pass through and giving the control of the entire HIDMA
device to the guest machine. Therefore, we don?t need to trap into host
machine for driver execution.

I agree with the fact that the pages need to be pinned for this to work.
Again, this is not any different from PCIe SRIOV passthrough.

Pinning guest removes use cases like ballooning/overcommit but that is a
choice for end user to make: whether he wants additional I/O performance
or wants higher memory utilization at the cost of lower I/O performance.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
