From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Mon, 24 Jul 2017 00:24:32 +0100
Subject: [linux-sunxi] [PATCH 2/5] arm: allwinner: a64: drop the dummy
 vcc3v3 regulator in Pine64 DT
In-Reply-To: <20170721203933.l4thb6hjc6elsnjw@flea>
References: <20170719161019.62133-1-icenowy@aosc.io>
 <20170719161019.62133-3-icenowy@aosc.io>
 <4e2c9486-9c0d-14e9-62e7-8642758c5472@arm.com>
 <7FACC99F-F900-437B-9642-741D7D980D25@aosc.io>
 <493424f1-6df3-ec19-a7cf-f76706cb2c51@arm.com>
 <20170721143858.3hufnu7v3ki6xmgf@flea>
 <0d30c993-a3a4-3923-b112-e65d1ea97cce@arm.com>
 <20170721203933.l4thb6hjc6elsnjw@flea>
Message-ID: <2b0358ba-e851-ba9d-f643-dd60138a0b55@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/07/17 21:39, Maxime Ripard wrote:

Hi Maxime,

sorry for causing some frustration on your side.
I am trying to answer to some of your comments. Just be aware that I am
leaving for holidays in a few hours (and trying to stay away as much
from computers as possible), so don't expect any replies in the next
three weeks.

> On Fri, Jul 21, 2017 at 04:08:42PM +0100, Andre Przywara wrote:
>> On 21/07/17 15:38, Maxime Ripard wrote:
>>> On Fri, Jul 21, 2017 at 02:02:18PM +0100, Andre Przywara wrote:
>>>> On 21/07/17 13:49, Icenowy Zheng wrote:
>>>>> ? 2017?7?21? GMT+08:00 ??8:45:39, Andre Przywara <andre.przywara@arm.com> ??:
>>>>>> On 19/07/17 17:10, Icenowy Zheng wrote:
>>>>>>> The Pine64 DT used to contain a dummy vcc3v3 regulator, in order to
>>>>>>> satisfy some device nodes when proper AXP803 regulator support is
>>>>>>> available. It's in fact the DCDC1 regulator of AXP803.
>>>>>>>
>>>>>>> Drop the dummy regulator, and fix the reference of this regulator to
>>>>>>> DCDC1.
>>>>>>
>>>>>> Do we really need to have this?
>>>>>> While I see that this is technically correct, it breaks older kernels,
>>>>>> which miss the AXP driver. So we can't use this DT for syncing it into
>>>>>> U-Boot anymore, while still expecting various kernels (for instance
>>>>>> from
>>>>>> distribution installers) to work via UEFI (for which U-Boot provides
>>>>>> the
>>>>>> DT). That would be a shame, because we start to see generic arm64
>>>>>> distribution installers to work out of the box.
>>>>>>
>>>>>> I see these solutions:
>>>>>> 1) We drop this patch, instead add a comment that technically it's
>>>>>> DCDC1. I believe we can't really turn off DCDC1 anyway.
>>>>>> 2) We keep theses patches, but don't sync them to U-Boot to have a
>>>>>> universal DT in there which works with every kernel.
>>>>>> 3) We keep these patches *and* sync them to U-Boot, but add the fixed
>>>>>> regulator back in via a U-Boot specific .dtsi "overlay" snippet. This
>>>>>> would take care of the parts that break compatibility. The end result
>>>>>> would be similar to 2), then.
>>>>>>
>>>>>> The easiest and most maintainable would be 1), but I am OK with 3) as
>>>>>> well, though I am not sure this won't get messy in the future and will
>>>>>> work for every change that we make.
>>>>>>
>>>>>> What do you think?
>>>>>
>>>>> 4) Do nothing.
>>>>>
>>>>> We only promise old DTs will run with newer kernel, but
>>>>> we don't promise newer DTs to run with old kernel.And
>>>>> U-Boot is intended to update less frequently than Linux.
>>>>>
>>>>> When updateing U-Boot, please update kernel as well.
>>>>
>>>> Which means you tie your firmware to a kernel. I know this is the old
>>>> embedded approach, but we should really get rid of this, as I don't see
>>>> how this will work nicely with the Pinebook, for instance (which is not
>>>> really "embedded" anymore).
>>>>
>>>> U-Boot sits on the SPI flash there, and you are expected to just run any
>>>> (not only Linux) distribution from a USB pen drive, for instance, with
>>>> that one firmware version, using UEFI. This already works today, but is
>>>> only sustainable if we have forward DT compatibility as well.
>>>
>>> We've been discussing this over and over and over again.
>>
>> Don't tell me ;-)
>> But apart from "We don't care" I haven't got a real solution out of this
>> discussion.

I just see that "We don't care" might be (mis-)understood as offensive,
apologies for that. What I meant is that in the past there was no answer
to the problem of how to handle *multiple* kernels with *one* DTB
provided by *firmware*. I consider this approach actually the actual
(original) DT use case, though I see that for many ARM platforms this
was never adopted this way.
So "We don't care" referred to the problem being dismissed as being a
real issue, which I find quite sad.

> You're looking for a solution to an industry-wide problem, without
> fixing the industry first. Make the thousands-engineers companies
> heavily involved in mainlining their stuff (you know, the Qualcomm,
> Mediatek [1], Microchip [2], Marvell [3], Rockchip, you name it)
> comply with these arbitrarily made up rules.
> 
> And then the handful people working on their spare time will follow.

I see that this is indeed part of a bigger discussion, but I am not sure
this should prevent me from commenting on this and pointing to the problems.
And by providing possible solutions I was hoping for being not too pesky.

>>> You're using the pinebook as an example, fine.
>>
>> I believe the current approach for supporting Allwinner boards is rooted
>> in some embedded world, where shipping firmware together with some
>> kernel is standard, especially if there is no on-board storage anyway.
>>
>> But the Pinebook is clearly not embedded and comes with SPI flash to
>> boot from, so people might expect to install some Linux distribution on it.
>> And with the UEFI support in U-Boot we have a good solution for this
>> (check the debian-testing arm64 installer), and so far this works: every
>> extension we did to the DT was still fine with older kernels - this
>> particular feature might not work (say Ethernet in kernels < 2.13-rc1),
>> but at least it doesn't hurt or introduces regressions.
> 
> Unless $distribution put some man power in supporting and mainlining
> whatever they are interested in, yeah, I don't care what they think is
> best. We're not their slaves.

To be honest I don't see how distributions would be involved in this, in
a "real computers" world there certainly aren't. Here they just rely on
standard firmware interfaces to boot and find device descriptions,
without being required for explicitly support or spoon-feed particular
systems.
I understand that because of the lack of alternatives (for boards
without any on-board storage) some distributions took care of providing
firmware and device descriptions for selected (ARM based) boards, but my
impression is also that this was never really loved by them. Also this
has the nasty implication of duplicating a lot of effort.
For ARM64 it seems like most distributions never adopted this scheme,
instead relying on UEFI and firmware provided DTBs, for instance.

> And what would distributions think if we're all just tired of this and
> just quit? How would they feel about having to use a 4 years old
> kernel, without any security updates, rigged with bugs and mostly
> unmaintained?
> 
> It's really time to get serious about this. Some of our most important
> contributors already quit because of the sh*t we take every day, I've
> thought about quitting several times in the last year. And yet, you
> regularly criticize whatever we do on our evenings without real
> documentation (adding your fair shair to the pile we take), want to
> put more maintainance burden on us, all of that without contributing
> anything significant else than "rules" that no-one else comply with?

I am not really sure what to answer here, my intention actually was to
decrease a lot of the maintenance burden we currently have (for instance
being required to add a lot of explicit kernel code for each now SoC).
And I was hoping that with the advent of the new ARM64 architecture we
could seize the chance of changing some things.

> Be reasonable for a minute.
> 
> I did that once, because it seemed important to some people at the
> moment. It just gave us more ugly hacks, and just made our lives
> harder.
> 
>>> Please give me the full documented, reviewed and acked-by binding
>>> for all the features the pinebook has.
>>>
>>> If you can't, this discussion is pointless, since you will expect
>>> changes in the DT.
>>
>> It's not about *changes* per se, it's about breaking compatibility,
>> which can be avoided.
>> As long as we just *add* features (DE2/HDMI, for instance) and don't
>> introduce regressions, touching the DT is fine.
>>
>> And yes: I expect some hiccups with this, but also would hope for
>> finding some solutions (like the ones sketched in my original email).
> 
> I'm going to merge this patch unless I can see a written rule
> somewhere in our device tree documentation that prevent me from doing
> so.

I see that many more server oriented ARM64 platforms (AMD Seattle,
Cavium ThunderX, APM XGene) actually provide their DTs in firmware and
rely on stability there. But yes, I see that this is not really
documented, and I think this was considered a per-platform decision in
the past. Hopefully we actually see some more generic DT discussions and
documentation in the near future.

And merging this patch is a fair decision as a maintainer, though you
could have used fewer words to say this ;-)

Cheers,
Andre.
