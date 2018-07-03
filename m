From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 3 Jul 2018 11:34:45 -0400
Subject: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <20180703135956.GA18639@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
 <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
 <2640af5e-f00f-d814-425d-78ac57714f6d@codeaurora.org>
 <bd04c9d1-6dfe-3071-69f9-beb0d649b6c0@codeaurora.org>
 <20180703135956.GA18639@wunner.de>
Message-ID: <42e72f83-3b24-f7ef-e5bc-290fae99259a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/3/2018 9:59 AM, Lukas Wunner wrote:
> On Tue, Jul 03, 2018 at 09:31:24AM -0400, Sinan Kaya wrote:
>> Issue is observing hotplug link down event in the middle of AER recovery
>> as in my previous reply.
>>
>> If we mask hotplug interrupts before secondary bus reset via my patch,
>> then hotplug driver will not observe both link up and link down interrupts.
>>
>> If we don't mask hotplug interrupts, we have a race condition.
> 
> I assume that a bus reset not only causes a link and presence event but
> also clears the Presence Detect State bit in the Slot Status register
> and the Data Link Layer Link Active bit in the Link Status register
> momentarily.
> 
> pciehp may access those two bits concurrently to the AER driver
> performing a slot reset.  So it may not be sufficient to mask
> the interrupt.
> 
> I've posted this patch to address the issue:
> https://patchwork.ozlabs.org/patch/930391/

Very interesting!

I missed this completely.

I know for a fact that bus reset clears the Data Link Layer Active bit
as soon as link goes down. It gets set again following link up.

Presence detect depends on the HW implementation. 

QDT root ports don't change presence detect for instance since nobody
actually removed the card.

If an implementation supports in-band presence detect, the answer is yes.
As soon as the link goes down, presence detect bit will get cleared until
recovery.

It sounds like we need to update your lock change with my proposal.

lock() in mask_irq() and unlock() in unmask_irq()

> 
> Thanks,
> 
> Lukas
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
