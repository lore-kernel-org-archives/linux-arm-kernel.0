From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sun, 01 Sep 2013 12:08:37 +0200
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130901085121.GO6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk> <5222562B.8010001@metafoo.de>
 <20130901064216.GN6617@n2100.arm.linux.org.uk> <5222EFE5.3010306@metafoo.de>
 <20130901085121.GO6617@n2100.arm.linux.org.uk>
Message-ID: <52231225.8080704@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2013 10:51 AM, Russell King - ARM Linux wrote:
> On Sun, Sep 01, 2013 at 09:42:29AM +0200, Lars-Peter Clausen wrote:
>> Lets try to wrap up the situation:
>>
>> * The hardware has one audio stream, but two DAIs, one for SPDIF one for
>> I2S. The same audio stream is sent to both DAIs at the same time (It is
>> possible though to disable one or both of the DAIs).
> 
> More or less.  To be more clear: audio DMA commences when either one or
> both outputs are enabled, and stops when both are disabled.
> 
> This is why either only one can be enabled, or if both are to be enabled,
> both enable bits must be set in one register write, and when disabled,
> both bits must be cleared in one register write.
> 
> So, lets say for argument sake that you wanted to go from disabled to a
> single output, then to dual output, back to single output, and finally
> back to disabled.  You would need this sequence:
> 
> - enable single output
> ...
> - disable single output
> - wait for audio unit to indicate not busy
> - enable both outputs
> ...
> - disable both outputs
> - wait for audio unit to indicate not busy
> - enable single output
> ...
> - disable single output
> - wait for audio unit to indicate not busy
> 
>> * This is something new and not supported by classical ASoC.
>>
>> * DPCM has support for this, but DPCM is still new, unstable,
>> under-documented and apparently has a couple of bugs.
>>
>> * With non-DPCM ASoC it is possible to have two DAIs if they are not used at
>> the same time (which is what I recommend you implement first, before trying
>> to get DPCM running).
> 
> If you'd look at my other responses, you'll see that this is what I tried
> back in May, and I was unhappy about that solution because:
> 
> 1. there is no guarantee that they couldn't be used at the same time.
> 2. this results in two entirely separate "CPU DAI"s, each with their
>    own independent sample rate/format settings, which if they happen
>    to be used together will result in fighting over the same register(s).

I know, but you can make it policy that only one of them may be used at a
time. Furthermore you can add a check to the startup() callback to return an
error, if the other DAI is active.

>
> Moreover, this results in a completely different set of changes to the
> driver which are in an opposing direction to the DPCM approach.
> 

I think the patch is actually going to be maybe a 100 lines or so and it
gives you something to work with and unlike your current approach is not
trying to work around the framework. Then you can add the other patches
adding the SPDIF controls on top of it. Once that's done you can concentrate
on trying to get DPCM running.

>> I still don't know if you actually need to feature of being able to output
>> the same audio signal to both DAIs, do you have such a board?
> 
> This board has the SPDIF connected to a TOSlink and a HDMI transmitter.
> It also has the I2S connected only to the HDMI transmitter, though it's
> common at the moment to only use the SPDIF output to drive them both.

Ok, so things will work fine with the either/or approach for now.

[...]
>> But even then
>> I still recommend to first get the non-DPCM either/or approach implemented
>> and once that's working try to get DPCM running. Which probably involves
>> fixing some of the DPCM issues in the core. As I said sending the same audio
>> streams to two DAIs is something new and if there was no DPCM yet you'd need
>> to add support for sending the same stream to multiple DAIs. So either way
>> you'd have to get your hands dirty.
> 
> Could you comment on the patch which creates the two front-end DAIs which
> I sent in a different sub-thread - the one which I indicated was from back
> in May time.  It isn't quite suitable for submission because the base it
> applies to has changed since then, but it should be sufficient to give an
> idea of the solution I was trying to implement there.

The patch looks OK, except for maybe the way the names for the DAIs are
created. That probably something that's better handled in the core in a
generic way.

- Lars
