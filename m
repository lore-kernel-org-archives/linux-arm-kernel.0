From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sun, 01 Sep 2013 09:42:29 +0200
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130901064216.GN6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk> <5222562B.8010001@metafoo.de>
 <20130901064216.GN6617@n2100.arm.linux.org.uk>
Message-ID: <5222EFE5.3010306@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2013 08:42 AM, Russell King - ARM Linux wrote:
> [...]
> 21:07 < rmk> well, someone needs to come up with a fix for these duplicated widgets, and that's not me.
> 21:07 < rmk> because... at the moment... asoc is completely useless for this hardware
> 
> The reason for my last couple of lines there is not that I'm being
> difficult - I really don't know what the correct fix for the duplicated

Well then say it that way. "I don't quite understand how this works yet and
am unable to fix this myself can you help me figure it out". But maybe it is
a cultural thing, who knows.

Lets try to wrap up the situation:

* The hardware has one audio stream, but two DAIs, one for SPDIF one for
I2S. The same audio stream is sent to both DAIs at the same time (It is
possible though to disable one or both of the DAIs).

* This is something new and not supported by classical ASoC.

* DPCM has support for this, but DPCM is still new, unstable,
under-documented and apparently has a couple of bugs.

* With non-DPCM ASoC it is possible to have two DAIs if they are not used at
the same time (which is what I recommend you implement first, before trying
to get DPCM running).

I still don't know if you actually need to feature of being able to output
the same audio signal to both DAIs, do you have such a board? But even then
I still recommend to first get the non-DPCM either/or approach implemented
and once that's working try to get DPCM running. Which probably involves
fixing some of the DPCM issues in the core. As I said sending the same audio
streams to two DAIs is something new and if there was no DPCM yet you'd need
to add support for sending the same stream to multiple DAIs. So either way
you'd have to get your hands dirty. And I'm sure people are willing to help
you figure out the parts you don't understand yet if you ask _nicely_. I
mean I don't come to you either if I have a new ARM SoC that's not supported
yet and demand that you implement support for it and exclaim that the ARM
port sucks because it doesn't support that SoC yet.

- Lars
