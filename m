From: broonie@kernel.org (Mark Brown)
Date: Sun, 1 Sep 2013 12:51:16 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130901085121.GO6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de>
 <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk>
 <5222562B.8010001@metafoo.de>
 <20130901064216.GN6617@n2100.arm.linux.org.uk>
 <5222EFE5.3010306@metafoo.de>
 <20130901085121.GO6617@n2100.arm.linux.org.uk>
Message-ID: <20130901115116.GB3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 01, 2013 at 09:51:21AM +0100, Russell King - ARM Linux wrote:
> On Sun, Sep 01, 2013 at 09:42:29AM +0200, Lars-Peter Clausen wrote:

> > * With non-DPCM ASoC it is possible to have two DAIs if they are not used at
> > the same time (which is what I recommend you implement first, before trying
> > to get DPCM running).

> If you'd look at my other responses, you'll see that this is what I tried
> back in May, and I was unhappy about that solution because:

> 1. there is no guarantee that they couldn't be used at the same time.
> 2. this results in two entirely separate "CPU DAI"s, each with their
>    own independent sample rate/format settings, which if they happen
>    to be used together will result in fighting over the same register(s).

These aren't issues for either/or, the whole point here is that the
machine driver will be limited to only connecting one of the DAIs so
there will be no way for userspace to interact with the unused DAI.  As
Lars-Peter says you can add explicit checks for this in the code if you
are concerned about system integrators getting this wrong.

> Moreover, this results in a completely different set of changes to the
> driver which are in an opposing direction to the DPCM approach.

Like Lars-Peter says it really, really shouldn't be - what moving to
DPCM should be doing with this code is mostly moving the code around a
bit to pull the bits that are shared into a front end DAI.  The most
substantial change should be handling the enables but that shouldn't
take much code at all, your curent patch does it in 35 lines and I'd not
expect it to be much different in a DPCM world.

> > And I'm sure people are willing to help
> > you figure out the parts you don't understand yet if you ask _nicely_.

> Can you then please explain why when I ask for help understanding DAPM
> in a "nice" way, the response I get is just "it's just a graph walk"
> and no further technical details?

Ask more detailed questions and engage in a discussion; the reason you
keep on getting the same responses is that you tend to repeat the same
requests a lot.  Something like "I understand the big picture but I am
trying to do X and need to know Y because Z" (with all of X, Y and Z
being important) is usually a good approach.

The public interface for DAPM is that the widgets get created with
sensible types and hooked up together then powered up as needed, if
something needs to know specifics of that process like exactly when a
given register will be written that's a worrying implementation detail.

> | DAPM is a set of "widgets" representing various components of an
> | audio system.  The widgets are linked together by a graph.  Each
> | widget lives in a context - cpu, platform or codec.  Some bindings
> | only happen within a context, others cross contexts (so linking the
> | CPU audio stream to the codec for example)

This last statement is not the case; you can see the route connecting
code in snd_soc_dapm_add_route() - there is no case in which it will
only try to match within a single context.

As I have said to you without more information it is hard to tell what
problems you are seeing when you are trying this.  It could be a case of
trying to create routes before the widgets are added, or it could be a
case of trying to create inter device links with widgets with globally
duplicated names (though that would give wrong routes rather than no
routes so I suspect sequencing).

> > I mean I don't come to you either if I have a new ARM SoC that's not
> > supported yet and demand that you implement support for it and exclaim
> > that the ARM port sucks because it doesn't support that SoC yet.

> If you come to me and ask about something in ARM, then you will most
> likely get something more than a few words explaining a big chunk of
> code - a bit like the oops report I disected last night and provided
> full reasoning of the conclusion that I came to (SDRAM failure /
> hardware fault on bit 8 of the SDRAM data bus.)

The bit about the way in which support is requested is important here -
it really can make a really big difference how one asks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130901/a6759ac6/attachment.sig>
