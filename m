From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Jan 2016 17:32:06 +0000
Subject: [PATCH V12 3/7] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <56992987.5080603@codeaurora.org>
References: <1452523550-8920-1-git-send-email-okaya@codeaurora.org>
 <1452523550-8920-4-git-send-email-okaya@codeaurora.org>
 <20160115145629.GI3262@leverpostej> <56990C40.4050407@codeaurora.org>
 <20160115152257.GK3262@leverpostej> <56992987.5080603@codeaurora.org>
Message-ID: <56992D16.6070800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/16 17:16, Sinan Kaya wrote:
>>>> This doesn't seem to tie into KVM or VFIO, and as far as I can tell
>>>> there's no mechanism for associating channels with a particular virtual
>>>> address space (i.e. no configuration of an external or internal IOMMU),
>>>> nor pinning of guest pages to allow for DMA to occur safely.
>>>
>>> I'm using VFIO platform driver for this purpose. VFIO platform driver is 
>>> capable of assigning any platform device to a guest machine with this driver. 
>>
>> Typically VFIO-platform also comes with a corresponding reset driver.
>> You don't need one?
> 
> The HIDMA channel driver resets the channel before using it. That's why, I never
> bothered with writing a reset driver on the hypervisor.
> 
>>
>>> You just unbind the HIDMA channel driver from the hypervisor and bind to vfio
>>> driver using the very same approach you'd use with PCIe. 
>>>
>>> Of course, this all assumes the presence of an IOMMU driver on the system. VFIO
>>> driver uses the IOMMU driver to create the mappings. 
>>
>> No IOMMU was described in the DT binding. It sounds like you'd need an
>> optional (not present in the guest) iommus property per-channel
> 
> You are right. I missed that part. I'll update the device-tree binding documentation.
> 
>>
>>> The mechanism used here is not different from VFIO PCI from user perspective.
>>>
>>>>
>>>> Given that, I'm at a loss as to how this would be used in a hypervisor
>>>> context. What am I missing?
>>>>
>>>> Are there additional patches, or do you have some userspace that works
>>>> with this in some limited configuration?
>>>
>>> No, these are the only patches. We have one patch for the QEMU but from kernel
>>> perspective this is it. 
>>
>> Do you have a link to that? Seeing it would help to ease my concerns.
> 
> The QEMU driver has not been posted yet. As far as I know, it just discovers the memory
> resources on the platform object and creates mappings for the guest machine only. 
> 
> Shanker Donthineni and Vikram Sethi will post the QEMU patch later.

Then may I suggest you both synchronize your submissions? I'd really
like to hear from the QEMU maintainers that they are satisfied with that
side of the story as well.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
