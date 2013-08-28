From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 28 Aug 2013 13:44:51 +0200
Subject: [PATCH 1/2] ARM: Dove: Add the audio devices in DT
In-Reply-To: <20130828131548.0009d613@skate>
References: <20130828113459.48ecbb34@armhf> <521DCD33.2070008@gmail.com>
 <20130828121943.1c8327ca@skate> <521DD057.4040208@gmail.com>
 <20130828131548.0009d613@skate>
Message-ID: <521DE2B3.9050508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/13 13:15, Thomas Petazzoni wrote:
> On Wed, 28 Aug 2013 12:26:31 +0200, Sebastian Hesselbarth wrote:
>>>> as Mark Brown already took the bindings patch for above generic
>>>> compatible, how are we going to discriminate different
>>>> implementations/features of Dove, Kirkwood, and Armada 370?
>>>
>>> I agree that mvebu-audio is not a really good compatible string. It
>>> should use the first SoC that introduced the IP block, so that if
>>> future SOCs have variations, we can introduce separate compatible
>>> strings.
>>>
>>> So for now, the compatible string should be kirkwood-audio.
>>
>> Unfortunately, mvebu-audio has already been taken by Mark. Also, we
>> know the differences for the three SoCs now and should have a compatible
>> for each (and maybe mvebu-audio for fallback).
>
> For 3.12, right? So 3.12 hasn't been released yet, so it's still time
> to fix this.

I guess, yes.

>> Also, we'll need to distinguish between the different audio controllers
>> on a single SoC, i.e. i2s0 and i2s1. I suggest checking the (phys) reg
>> base passed.
>
> For what reason does the driver needs to know whether it's the instance
> 0 or instance 1 ? If it's needed for some specific reason, then there
> should probably be something like marvell,i2s-channel-id = <0> and
> marvell,i2s-channel-id = <1>.

On Dove, audio1 has SPDIF out, audio0 hasn't. Russell also mentioned to
get rid of "i2s" and use "audio" instead. Most SoC's controllers are
i2s only but as soon as SPDIF comes into play, it is a different
interface protocol.

I am fine with having a "marvell,channel-id" (no "i2s") to discriminate
the instances, although reg offset should be sufficient.

Jean-Francois: Can you please also rename the DT nodes to "audio0" and
"audio1" instead?

Sebastian
