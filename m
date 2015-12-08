From: balbi@ti.com (Felipe Balbi)
Date: Tue, 8 Dec 2015 08:20:45 -0600
Subject: [PATCH] usb: musb: dsps: handle the
 otg_state_a_wait_vrise_timeout case
In-Reply-To: <874mft9ukx.fsf@free-electrons.com>
References: <1440087153-31084-1-git-send-email-gregory.clement@free-electrons.com>
 <55D719B1.8010700@free-electrons.com> <87twrfsbed.fsf@free-electrons.com>
 <87d1wtf5ir.fsf@saruman.tx.rr.com> <87a8rde96m.fsf@free-electrons.com>
 <87poyiegc7.fsf@free-electrons.com> <87poyinjpc.fsf@saruman.tx.rr.com>
 <874mft9ukx.fsf@free-electrons.com>
Message-ID: <87h9jtm37m.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:
>>>> if it is the case then it didn't fix the issue I had.
>>>>
>>>> I activated the following debug line:
>>>>
>>>> [musb_hdrc]musb_interrupt =_ "** IRQ %s usb%04x tx%04x rx%04x\012"
>>>> [musb_dsps]dsps_interrupt =p "usbintr (%x) epintr(%x)\012"
>>>>
>>>> But I didn't get any interrupt while disconnecting the cable without any
>>>> device connected on it (whereas I got an interrupt when I connected it).
>>>>
>>>> Note that I applied this patch instead of the "usb: musb: dsps: handle
>>>> the otg_state_a_wait_vrise_timeout case", is what you had in mind ?
>>
>> yeah, that's what I had in mind. But your patch seems wrong :-)
>>
>> I tried writing a more correct version here and found 2 issues:
>>
>> a) bit 3 doesn't do anything :-p I cannot read IRQs from mentor's
>> registers
>>
>> b) when setting RESET_ISOLATION bit, reads of CTRL register hang. Note
>> that according to TRM, RESET_ISOLATION _must_ be set prior to a soft
>> reset and cleared afterwards. But right after setting RESET_ISOLATION,
>> if I try a read of CTRL, it'll hang forever.
>
> The datasheet seems not very coherent about it,
>
> on one side we have:
> "This bit should be set high prior to setting bit 0 and cleared after bit 0
> is cleared."
>
> and on the other side:
> "Both the soft_reset and soft_reset_isolation bits should be asserted
> simultaneously."
>
> The hang you saw could be explained by the following:
> "Setting only the soft_reset_isolation bit will cause all USB0 output
> signals to go to a known constant value via multiplexers.
> This will
> prevent future access to USB0."  page 2567

good catch. Setting them together makes the hang go away.

I still have the other problem, which is legacy IRQ reporting mode not
really working.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151208/d9555e81/attachment.sig>
