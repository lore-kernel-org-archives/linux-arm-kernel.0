From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 15 Feb 2017 13:51:31 +0200
Subject: [PATCH v13 06/12] usb: xhci: use bus->sysdev for DMA configuration
In-Reply-To: <2a3d2d65-e531-aaca-d5a1-a71f818cec61@ti.com>
References: <1486776443-2280-1-git-send-email-peter.chen@nxp.com>
 <1486776443-2280-7-git-send-email-peter.chen@nxp.com>
 <e532a212-cd15-ab42-6188-fc11a12633af@ti.com>
 <CAK8P3a1D1v=LXrW=-t-fRJjbo_C6OpSuoqiGuZPOaBzQYCT-kA@mail.gmail.com>
 <cb7182c6-0236-26f2-4f96-9bc001994728@ti.com>
 <CAK8P3a22f=sQXt+3-PeAuBFQN7_4iXDQhu41teExd6bxJXxDAQ@mail.gmail.com>
 <20170215013514.GA6579@b29397-desktop>
 <cb3ee971-6d97-fff1-64f7-1b527559b047@ti.com>
 <20170215085127.GA26227@b29397-desktop>
 <2a3d2d65-e531-aaca-d5a1-a71f818cec61@ti.com>
Message-ID: <87mvdnoenw.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Roger Quadros <rogerq@ti.com> writes:
>>>>>>>> Why are we using sysdev to read DT property? We should be using the
>>>>>>>> XHCI device (&pdev->dev) here, no?
>>>>>>>
>>>>>>> If I remember correctly, this is one of the cases where pdev does not
>>>>>>> have a device node attached to it because it was created by the driver
>>>>>>> of the parent device on the fly in case of dwc3. When you have a pure xhci
>>>>>>> device in DT, the two pointers are the same.
>>>>>>
>>>>>> From drivers/usb/dwc3/host.c
>>>>>>
>>>>>>>         if (dwc->usb3_lpm_capable) {
>>>>>>>                 props[0].name = "usb3-lpm-capable";
>>>>>>>                 ret = platform_device_add_properties(xhci, props);
>>>>>>>                 if (ret) {
>>>>>>>                         dev_err(dwc->dev, "failed to add properties to xHCI\n");
>>>>>>>                         goto err1;
>>>>>>>                 }
>>>>>>>         }
>>>>>>
>>>>>> So it is setting the usb3-lpm-capable property into the xhci platform device
>>>>>> and we should be reading the property from there.
>>>>
>>>> Why dwc3 needs another "snps,usb3_lpm_capable"? Why not using
>>>> "usb3-lpm-capable" at firmware directly?
>>>
>>> dwc3 is not setting "snps,usb3_lpm_capable" but "usb3-lpm-capable" for the
>>> xhci platform device.
>>>
>>> What did you mean by firmware? Did you mean something like BIOS?
>>> At least TI platforms don't use any firmware like BIOS. So dwc3 driver
>>> needs to create a platform device for xhci on the fly and set the DT properties.
>>>
>> 
>> By readying code, the dwc3 calls dwc3_get_properties to set
>> dwc->usb3_lpm_capable, and at dwc3/host.c, it sets property
>> "usb3-lpm-capable" according to this flag, why not let common
>> code xhci-plat.c to get this property from sysdev which is DT
>> nodes for dwc3?
>> 
>
> Felipe, any comments?

Won't work. We have quirk flags which are based on DWC3's revision which
is not accessible by xhci-plat. Also, we can't call
device_add_property() because it's not really *adding*. It's *setting*,
meaning that we would loose all other properties.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170215/7d9ebdc2/attachment.sig>
