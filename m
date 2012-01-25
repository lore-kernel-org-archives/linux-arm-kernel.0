From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 25 Jan 2012 08:06:03 -0600
Subject: Building of arch/arm/plat-mxc/ssi-fiq.S failed w/ THUMB2 enabled?
In-Reply-To: <20120123115923.GP5446@pengutronix.de>
References: <CAMPhdO_4NQUFB14eecTb3N4oQJa86ojSk8FUveqg+Lye5_jY+A@mail.gmail.com>
 <20111202102418.GT26618@pengutronix.de>
 <20120120115216.GK1068@n2100.arm.linux.org.uk>
 <20120120120003.GB2046@linaro.org> <20120123115923.GP5446@pengutronix.de>
Message-ID: <CAKGA1b=cQ4n9TdWY0TM7OJMuzQcvERUbcshb_d4aBJsfn1pBug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 5:59 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, Jan 20, 2012 at 12:00:03PM +0000, Dave Martin wrote:
>> On Fri, Jan 20, 2012 at 11:52:17AM +0000, Russell King - ARM Linux wrote:
>> > On Fri, Dec 02, 2011 at 11:24:18AM +0100, Uwe Kleine-K?nig wrote:
>> > > On Fri, Dec 02, 2011 at 06:01:08PM +0800, Eric Miao wrote:
>> > > > Hi Dave & Sascha,
>> > > >
>> > > > I checked the log of this file, found a THUMB2 related changes, yet
>> > > > I'm still having the failure below, can you help do a quick check?
>> > > the problem is that in Thumb most commands don't work with r8-r15
>> > > because there are only three bits used to encode them. This is
>> > > unfortunate as the other registers are not banked for FIQ.
>> > >
>> > > The best possibility I see is to save some unbanked registers to the
>> > > banked registers on entry and restore them on exception exit.
>> >
>> > Or always build this as ARM code.
>>
>> That should work, sure -- I prefer to keep the number of instances where
>> we need to do this to a minimum if we can, though.
>
> I vote for compiling this in ARM mode since it's a straight forward
> solution.
>
> Some background:
>
> The original reason for creating this code was that we did not have SDMA
> support at the time I wanted audio support. The FIQ code was a simple
> way to seperate audio and DMA support and to push them to mainline
> seperately. There is another reason for having this code though. The
> i.MX SSI port is quite broken in AC97 mode. Some AC97 codecs like the
> WM9712 always send data in slot 12 (IIRC it contains gpio status). The
> SSI unit always puts all valid slots into the data stream, so we end up
> having the audio rx data interleaved with the gpio status data. The FIQ
> code is used to skip the gpio status data (see /* dummy read to skip
> slot 12 */ in ssi-fiq.S).

Okay so let's start with the thumb-isation of that code since it's
breaking thumb2 kernel builds for i.MX with
SSI audio (regardless of AC97 requirement).

Freescale's older BSPs implemented AC97 and I2S audio mode seperately
(duplicating code but.. that can
be fixed) to set up different DAIs so it's not impossible to consider
that the different SSI modes could be
made fairly modular based on some kind of internal core subsystem..?
Later though, right? :)

I can officially say that I don't care, as long as it builds in Thumb2
mode, and audio plays.. for now. Dave's
patch seems to work, can we upstream it?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
