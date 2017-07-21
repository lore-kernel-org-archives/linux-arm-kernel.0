From: agraf@suse.de (Alexander Graf)
Date: Fri, 21 Jul 2017 16:03:36 +0200
Subject: [linux-sunxi] [PATCH 2/5] arm: allwinner: a64: drop the dummy
 vcc3v3 regulator in Pine64 DT
In-Reply-To: <a03e16d6ce509ce9fe2723682bae4768@aosc.io>
References: <20170719161019.62133-1-icenowy@aosc.io>
 <20170719161019.62133-3-icenowy@aosc.io>
 <4e2c9486-9c0d-14e9-62e7-8642758c5472@arm.com>
 <7FACC99F-F900-437B-9642-741D7D980D25@aosc.io>
 <493424f1-6df3-ec19-a7cf-f76706cb2c51@arm.com>
 <a03e16d6ce509ce9fe2723682bae4768@aosc.io>
Message-ID: <ad39c6be-4dc0-27f9-3f19-2a5afbb1f9b5@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2017 03:51 PM, icenowy at aosc.io wrote:
> ? 2017-07-21 21:02?Andre Przywara ???
>> Hi,
>>
>> On 21/07/17 13:49, Icenowy Zheng wrote:
>>>
>>>
>>> ? 2017?7?21? GMT+08:00 ??8:45:39, Andre Przywara 
>>> <andre.przywara@arm.com> ??:
>>>> Hi,
>>>>
>>>> On 19/07/17 17:10, Icenowy Zheng wrote:
>>>>> The Pine64 DT used to contain a dummy vcc3v3 regulator, in order to
>>>>> satisfy some device nodes when proper AXP803 regulator support is
>>>>> available. It's in fact the DCDC1 regulator of AXP803.
>>>>>
>>>>> Drop the dummy regulator, and fix the reference of this regulator to
>>>>> DCDC1.
>>>>
>>>> Do we really need to have this?
>>>> While I see that this is technically correct, it breaks older kernels,
>>>> which miss the AXP driver. So we can't use this DT for syncing it into
>>>> U-Boot anymore, while still expecting various kernels (for instance
>>>> from
>>>> distribution installers) to work via UEFI (for which U-Boot provides
>>>> the
>>>> DT). That would be a shame, because we start to see generic arm64
>>>> distribution installers to work out of the box.
>>>>
>>>> I see these solutions:
>>>> 1) We drop this patch, instead add a comment that technically it's
>>>> DCDC1. I believe we can't really turn off DCDC1 anyway.
>>>> 2) We keep theses patches, but don't sync them to U-Boot to have a
>>>> universal DT in there which works with every kernel.
>>>> 3) We keep these patches *and* sync them to U-Boot, but add the fixed
>>>> regulator back in via a U-Boot specific .dtsi "overlay" snippet. This
>>>> would take care of the parts that break compatibility. The end result
>>>> would be similar to 2), then.
>>>>
>>>> The easiest and most maintainable would be 1), but I am OK with 3) as
>>>> well, though I am not sure this won't get messy in the future and will
>>>> work for every change that we make.
>>>>
>>>> What do you think?
>>>
>>> 4) Do nothing.
>>>
>>> We only promise old DTs will run with newer kernel, but
>>> we don't promise newer DTs to run with old kernel.And
>>> U-Boot is intended to update less frequently than Linux.
>>>
>>> When updateing U-Boot, please update kernel as well.
>>
>> Which means you tie your firmware to a kernel. I know this is the old
>> embedded approach, but we should really get rid of this, as I don't see
>> how this will work nicely with the Pinebook, for instance (which is not
>> really "embedded" anymore).
>> U-Boot sits on the SPI flash there, and you are expected to just run any
>> (not only Linux) distribution from a USB pen drive, for instance, with
>> that one firmware version, using UEFI. This already works today, but is
>> only sustainable if we have forward DT compatibility as well.
>
> Old firmware suit both old and new kernels, and for newer firmwares,
> use newer kernels.

Congratulations, you basically just broke any Linux distribution out 
there :).

> This is an intended behavior, and will exist not only on ARM if the
> firmware gains something new.

For new features it's some times required to update to new kernels. Once 
a platform is out in the market, that should really get limited to 
drivers though.


Alex
