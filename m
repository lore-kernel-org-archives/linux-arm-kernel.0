From: balbi@ti.com (Felipe Balbi)
Date: Tue, 8 Dec 2015 09:16:59 -0600
Subject: [PATCH] usb: musb: dsps: handle the
 otg_state_a_wait_vrise_timeout case
In-Reply-To: <5666EC67.7000203@ti.com>
References: <1440087153-31084-1-git-send-email-gregory.clement@free-electrons.com>
 <55D719B1.8010700@free-electrons.com> <87twrfsbed.fsf@free-electrons.com>
 <87d1wtf5ir.fsf@saruman.tx.rr.com> <87a8rde96m.fsf@free-electrons.com>
 <87poyiegc7.fsf@free-electrons.com> <87poyinjpc.fsf@saruman.tx.rr.com>
 <874mft9ukx.fsf@free-electrons.com> <87h9jtm37m.fsf@saruman.tx.rr.com>
 <5666E9BE.5070907@ti.com> <87egexm2jr.fsf@saruman.tx.rr.com>
 <5666EC67.7000203@ti.com>
Message-ID: <878u55m0lw.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Bin Liu <b-liu@ti.com> writes:
>>>>> "This bit should be set high prior to setting bit 0 and cleared after bit 0
>>>>> is cleared."
>>>>>
>>>>> and on the other side:
>>>>> "Both the soft_reset and soft_reset_isolation bits should be asserted
>>>>> simultaneously."
>>>>>
>>>>> The hang you saw could be explained by the following:
>>>>> "Setting only the soft_reset_isolation bit will cause all USB0 output
>>>>> signals to go to a known constant value via multiplexers.
>>>>> This will
>>>>> prevent future access to USB0."  page 2567
>>>>
>>>> good catch. Setting them together makes the hang go away.
>>>>
>>>> I still have the other problem, which is legacy IRQ reporting mode not
>>>> really working.
>>>>
>>>
>>> I never tried to change the IRQ mapping. The 8 MUSB interrupt will be
>>> the same no matter where they are reported from. What do you expect when
>>> switch to the MUSB IRQ reporting mode?
>>
>> read events from MUSB's registers instead of TI's :-) so, MUSB_INTRUSB,
>> MUSB_INTRRX and MUSB_INTRTX.
>>
> I meant you expect to see any different event when switch to MUSB IRQ 
> mode? The TI wrapper just reports the same 8 interrupt events. I don't 
> think you would get any difference.

still valid to make sure ;-)

> BTY, I think I miss some context here. This Gregory's patch is trying to 
> fix the OTG state machine problem in musb_dsps, which is replicated with 
> a cable without a device connected. But it also mentions about 
> non-compliant MSC devices. How are the thumb drives related to this OTG 
> state issue?

the problem seems to be caused by the missing disconnect IRQ. Not really
missing, but taking seconds to trigger.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151208/6c125675/attachment.sig>
