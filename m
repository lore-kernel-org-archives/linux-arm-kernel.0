From: poza@codeaurora.org (poza at codeaurora.org)
Date: Tue, 03 Jul 2018 19:40:46 +0530
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
Message-ID: <1658f1759864e22fed4273a22d501a8e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-03 19:29, Lukas Wunner wrote:
> On Tue, Jul 03, 2018 at 09:31:24AM -0400, Sinan Kaya wrote:
>> Issue is observing hotplug link down event in the middle of AER 
>> recovery
>> as in my previous reply.
>> 
>> If we mask hotplug interrupts before secondary bus reset via my patch,
>> then hotplug driver will not observe both link up and link down 
>> interrupts.
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

Was just wondering that you are protecting Presence Detect State bit 
with reset_lock, mainly in pciehp_ist
but with hotplug interrupt disabled, is there another way that it 
hotplug code gets activated ?

> 
> I've posted this patch to address the issue:
> https://patchwork.ozlabs.org/patch/930391/
> 
> Thanks,
> 
> Lukas
