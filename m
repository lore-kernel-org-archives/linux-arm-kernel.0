From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 08 Jun 2015 09:51:16 +0200
Subject: [PATCH v2 0/4] VFIO platform reset
In-Reply-To: <1433538892.2477.24.camel@freescale.com>
References: <1433516792-16397-1-git-send-email-eric.auger@linaro.org>	
 <CAL_JsqK4dm_Kmoys6+qxJrwFpo0K3gatVQxZiNPoWCduQKqj8w@mail.gmail.com>
 <1433538892.2477.24.camel@freescale.com>
Message-ID: <55754974.1020207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob, Scott,
On 06/05/2015 11:14 PM, Scott Wood wrote:
> On Fri, 2015-06-05 at 13:05 -0500, Rob Herring wrote:
>> On Fri, Jun 5, 2015 at 10:06 AM, Eric Auger <eric.auger@linaro.org> 
>> wrote:
>>> In situations where the userspace driver is stopped abnormally and 
>>> the
>>> VFIO platform device is released, the assigned HW device currently 
>>> is
>>> left running. As a consequence the HW device might continue 
>>> issuing IRQs
>>> and performing DMA accesses.
>>>
>>> On release, no physical IRQ handler is setup anymore. Also the DMA 
>>> buffers
>>> are unmapped leading to IOMMU aborts. So there is no serious 
>>> consequence.
>>>
>>> However when assigning that HW device again to another userspace 
>>> driver,
>>> this latter might face some unexpected IRQs and DMA accesses, 
>>> which are
>>> the result of the previous assignment.
>>
>> In general, shouldn't it just be a requirement that the drivers 
>> handle
>> this condition. You have the same problem with firmware/bootloaders
>> leaving h/w not in reset state or kexec'ing to a new kernel.
> 
> It's not the same situation.  Firmware may leave HW in a non-reset 
> state but it must not leave the HW doing DMA; there's nothing the OS 
> could do about that as the OS could get corrupted before the driver 
> has a chance to run (this is not fun to debug).  Leaving interrupts 
> potentially asserted would be bad as well, especially if the interrupt 
> is shared.
> 
> Likewise, with normal kexec drivers are supposed to quiesce the 
> hardware first -- and with kdump, the affected DMA buffers are never 
> reused.
> 
> In order for the driver to handle this, it would need to reset/quiesce 
> the device itself before enabling an IOMMU mapping.  How would that 
> work for virtualization scenarios where the guest does not see any 
> IOMMU, and all vfio mappings are handled by QEMU or equivalent?

This is also my understanding. In a KVM virtualization use case, the
guest potentially could be corrupted by previously set DMA accesses
before getting the chance to stop DMA/IRQs.

Thanks for your interest.

Best Regards

Eric
> 
> -Scott
> 
