From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 30 Jan 2012 13:57:10 +0000
Subject: Building of arch/arm/plat-mxc/ssi-fiq.S failed w/ THUMB2 enabled?
In-Reply-To: <20120125143418.GG1068@n2100.arm.linux.org.uk>
References: <CAMPhdO_4NQUFB14eecTb3N4oQJa86ojSk8FUveqg+Lye5_jY+A@mail.gmail.com>
 <20111202102418.GT26618@pengutronix.de>
 <20120120115216.GK1068@n2100.arm.linux.org.uk>
 <20120120120003.GB2046@linaro.org>
 <20120123115923.GP5446@pengutronix.de>
 <CAKGA1b=cQ4n9TdWY0TM7OJMuzQcvERUbcshb_d4aBJsfn1pBug@mail.gmail.com>
 <20120125143418.GG1068@n2100.arm.linux.org.uk>
Message-ID: <CA+wbFdfUUk70=nr3C8gg40phH2JQ_4iH+tqVGFXMPSCQEiHLwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 2:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jan 25, 2012 at 08:06:03AM -0600, Matt Sealey wrote:
>> On Mon, Jan 23, 2012 at 5:59 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> > On Fri, Jan 20, 2012 at 12:00:03PM +0000, Dave Martin wrote:
>> >> On Fri, Jan 20, 2012 at 11:52:17AM +0000, Russell King - ARM Linux wrote:
>> >> > On Fri, Dec 02, 2011 at 11:24:18AM +0100, Uwe Kleine-K?nig wrote:
>> >> > > On Fri, Dec 02, 2011 at 06:01:08PM +0800, Eric Miao wrote:
>> >> > > > Hi Dave & Sascha,
>> >> > > >
>> >> > > > I checked the log of this file, found a THUMB2 related changes, yet
>> >> > > > I'm still having the failure below, can you help do a quick check?
>> >> > > the problem is that in Thumb most commands don't work with r8-r15
>> >> > > because there are only three bits used to encode them. This is
>> >> > > unfortunate as the other registers are not banked for FIQ.
>> >> > >
>> >> > > The best possibility I see is to save some unbanked registers to the
>> >> > > banked registers on entry and restore them on exception exit.
>> >> >
>> >> > Or always build this as ARM code.
>> >>
>> >> That should work, sure -- I prefer to keep the number of instances where
>> >> we need to do this to a minimum if we can, though.
>> >
>> > I vote for compiling this in ARM mode since it's a straight forward
>> > solution.
>> >
>> > Some background:
>> >
>> > The original reason for creating this code was that we did not have SDMA
>> > support at the time I wanted audio support. The FIQ code was a simple
>> > way to seperate audio and DMA support and to push them to mainline
>> > seperately. There is another reason for having this code though. The
>> > i.MX SSI port is quite broken in AC97 mode. Some AC97 codecs like the
>> > WM9712 always send data in slot 12 (IIRC it contains gpio status). The
>> > SSI unit always puts all valid slots into the data stream, so we end up
>> > having the audio rx data interleaved with the gpio status data. The FIQ
>> > code is used to skip the gpio status data (see /* dummy read to skip
>> > slot 12 */ in ssi-fiq.S).
>>
>> Okay so let's start with the thumb-isation of that code since it's
>> breaking thumb2 kernel builds for i.MX with
>> SSI audio (regardless of AC97 requirement).
>
> Well, there's two solutions to this:
>
> - we declare that it's obsolete now that SDMA support is in place.
> - we always build the code in ARM mode.
>
> I don't think the code should be converted to thumb, because that's going
> to involve finding some way to allocate some place for it to save registers
> and all that kind of thing - which for relocatable code isn't going to be
> nice to do. ?It's just easier to stick a .arm in there and be done with it.
> (Remembering that it won't run on T2-only CPUs. ?But then I doubt that it
> would get run on such CPUs.)

The Thumb-2 problems are not problems of register pressure -- it's
just down to uses of sp which are illegal in Thumb-2.  Fixing this is
straightforward: we just need to swap some registers.  The resulting
should function exactly the same in ARM as the original code.  Because
this only effects code running in FIQ mode, there is not ABI impact to
this.

However, if the code is inapplicable to v7 platform or later, I
suggest we just make is depend on !CONFIG_THUMB2_KERNEL, since v7
kernels cannot possibly include support for pre-v7 platforms anyway.
In that case, "fixing" this code would just be unnecessary churn.

I suggest the right thing is either to just add .arm (as per Russell's
suggestion) or to make this functionality depend on
!CONFIG_THUMB2_KERNEL and fix the imx Kconfigs not to erroneously
enable it on newer boards where it is inapplicable.  The latter route
might be beneficial in provoking people into fixing their Kconfigs not
to include that dead code for new boards.

Cheers
---Dave
