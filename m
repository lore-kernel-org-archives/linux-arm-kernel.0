From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 22 Mar 2010 13:06:04 +0000
Subject: [PATCH 1/6] ASoC: split pxa ssp for reusing code
In-Reply-To: <771cded01003220458i5a2c6860i278dd8edf72d1150@mail.gmail.com>
References: <771cded01003190851w2bb94ca2w1faf2a5fffa11794@mail.gmail.com>
	<20100320170049.GB1549@opensource.wolfsonmicro.com>
	<771cded01003220458i5a2c6860i278dd8edf72d1150@mail.gmail.com>
Message-ID: <20100322130604.GA1379@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 22, 2010 at 07:58:49AM -0400, Haojian Zhuang wrote:
> On Sat, Mar 20, 2010 at 1:00 PM, Mark Brown

> > Like I keep saying the SSP port configuration is really rather fragile
> > (in part due to the documentation issues) so forking this code seems
> > like it's going to be painful in the long run.

> I don't want to merge hw_params() between pxa2xx and pxa168 together.
> Because I won't change pxa2xx function code. In my zylonite platform,

Why not?  Like I say, this seems like a really retrograde step for long
term support - it means having more drivers to maintain.  The existing
PXA2xx code is very much a work in progress as it is and having to deal
with two copies of it doesn't fill me with great joy.

If there were some substantial difference in the hardware it'd be worth
forking but I'm just not seeing any such difference showing up in the
code for the actual port (as opposed to the clocks behind it).

> sound can't work with 2.6.34-rc1 kernel. If I change pxa2xx
> functionality code, I can not verify it. I need to check why sound
> can't work on zylonite first. I'm planning to follow this after this
> change set.

I'd test but unfortunately my Zylonite doesn't boot with mainline and
the patch I used to apply to get it to do so has bitrotted :(  In any
case, the key audio there is the AC97 which should be independant of the
SSP port anyway.

> >> +/*
> >> + * pxa2xx-ssp.c ?-- ?ALSA Soc Audio Layer
> >> + *

> > I'm not a big fan of the naming here since this also covers PXA3xx
> > devices. ?Is there some general term for the non-MMP processors which
> > could be used - I'm not aware of one but I might've missed something?

> pxa2xx is enough. Actually there's no general term for the non-MMP
> processors. The silicon behavior on SSP is defferent one by one. In
> PXA910, we will use SQU as DMA. In PXA168, we will use another clock
> system. In PXA968, we will use ABU in SSP. The difference between
> pxa2xx and pxa3xx is so small. PXA168 and PXA910 is MMP processors.
> PXA968 is non-MMP processors.

Feh, I guess.  Get your marketing department to make up some shiny
names for the different device classes :)
