From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 21 Jul 2017 23:10:26 +0800
Subject: [linux-sunxi] [PATCH 2/5] arm: allwinner: a64: drop the dummy
 vcc3v3 regulator in Pine64 DT
In-Reply-To: <0d30c993-a3a4-3923-b112-e65d1ea97cce@arm.com>
References: <20170719161019.62133-1-icenowy@aosc.io>
 <20170719161019.62133-3-icenowy@aosc.io>
 <4e2c9486-9c0d-14e9-62e7-8642758c5472@arm.com>
 <7FACC99F-F900-437B-9642-741D7D980D25@aosc.io>
 <493424f1-6df3-ec19-a7cf-f76706cb2c51@arm.com>
 <20170721143858.3hufnu7v3ki6xmgf@flea>
 <0d30c993-a3a4-3923-b112-e65d1ea97cce@arm.com>
Message-ID: <7F9AC1B3-5F96-4B77-B87B-A12723473496@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?7?21? GMT+08:00 ??11:08:42, Andre Przywara <andre.przywara@arm.com> ??:
>Hi,
>
>On 21/07/17 15:38, Maxime Ripard wrote:
>> On Fri, Jul 21, 2017 at 02:02:18PM +0100, Andre Przywara wrote:
>>> Hi,
>>>
>>> On 21/07/17 13:49, Icenowy Zheng wrote:
>>>>
>>>>
>>>> ? 2017?7?21? GMT+08:00 ??8:45:39, Andre Przywara
><andre.przywara@arm.com> ??:
>>>>> Hi,
>>>>>
>>>>> On 19/07/17 17:10, Icenowy Zheng wrote:
>>>>>> The Pine64 DT used to contain a dummy vcc3v3 regulator, in order
>to
>>>>>> satisfy some device nodes when proper AXP803 regulator support is
>>>>>> available. It's in fact the DCDC1 regulator of AXP803.
>>>>>>
>>>>>> Drop the dummy regulator, and fix the reference of this regulator
>to
>>>>>> DCDC1.
>>>>>
>>>>> Do we really need to have this?
>>>>> While I see that this is technically correct, it breaks older
>kernels,
>>>>> which miss the AXP driver. So we can't use this DT for syncing it
>into
>>>>> U-Boot anymore, while still expecting various kernels (for
>instance
>>>>> from
>>>>> distribution installers) to work via UEFI (for which U-Boot
>provides
>>>>> the
>>>>> DT). That would be a shame, because we start to see generic arm64
>>>>> distribution installers to work out of the box.
>>>>>
>>>>> I see these solutions:
>>>>> 1) We drop this patch, instead add a comment that technically it's
>>>>> DCDC1. I believe we can't really turn off DCDC1 anyway.
>>>>> 2) We keep theses patches, but don't sync them to U-Boot to have a
>>>>> universal DT in there which works with every kernel.
>>>>> 3) We keep these patches *and* sync them to U-Boot, but add the
>fixed
>>>>> regulator back in via a U-Boot specific .dtsi "overlay" snippet.
>This
>>>>> would take care of the parts that break compatibility. The end
>result
>>>>> would be similar to 2), then.
>>>>>
>>>>> The easiest and most maintainable would be 1), but I am OK with 3)
>as
>>>>> well, though I am not sure this won't get messy in the future and
>will
>>>>> work for every change that we make.
>>>>>
>>>>> What do you think?
>>>>
>>>> 4) Do nothing.
>>>>
>>>> We only promise old DTs will run with newer kernel, but
>>>> we don't promise newer DTs to run with old kernel.And
>>>> U-Boot is intended to update less frequently than Linux.
>>>>
>>>> When updateing U-Boot, please update kernel as well.
>>>
>>> Which means you tie your firmware to a kernel. I know this is the
>old
>>> embedded approach, but we should really get rid of this, as I don't
>see
>>> how this will work nicely with the Pinebook, for instance (which is
>not
>>> really "embedded" anymore).
>>>
>>> U-Boot sits on the SPI flash there, and you are expected to just run
>any
>>> (not only Linux) distribution from a USB pen drive, for instance,
>with
>>> that one firmware version, using UEFI. This already works today, but
>is
>>> only sustainable if we have forward DT compatibility as well.
>> 
>> We've been discussing this over and over and over again.
>
>Don't tell me ;-)
>But apart from "We don't care" I haven't got a real solution out of
>this
>discussion.
>
>> You're using the pinebook as an example, fine.
>
>I believe the current approach for supporting Allwinner boards is
>rooted
>in some embedded world, where shipping firmware together with some
>kernel is standard, especially if there is no on-board storage anyway.
>
>But the Pinebook is clearly not embedded and comes with SPI flash to
>boot from, so people might expect to install some Linux distribution on
>it.

In fact current version of Pinebook has no SPI Flash.

>And with the UEFI support in U-Boot we have a good solution for this
>(check the debian-testing arm64 installer), and so far this works:
>every
>extension we did to the DT was still fine with older kernels - this
>particular feature might not work (say Ethernet in kernels < 2.13-rc1),
>but at least it doesn't hurt or introduces regressions.
>
>> Please give me the full documented,
>> reviewed and acked-by binding for all the features the pinebook has.
>> 
>> If you can't, this discussion is pointless, since you will expect
>> changes in the DT.
>
>It's not about *changes* per se, it's about breaking compatibility,
>which can be avoided.
>As long as we just *add* features (DE2/HDMI, for instance) and don't
>introduce regressions, touching the DT is fine.
>
>And yes: I expect some hiccups with this, but also would hope for
>finding some solutions (like the ones sketched in my original email).
>
>Cheers,
>Andre.
