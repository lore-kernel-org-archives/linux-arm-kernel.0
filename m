From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 26 Jan 2010 13:00:57 +0000
Subject: [PATCH 2/3] ASoC: AC97: S3C: Add controller driver
In-Reply-To: <1b68c6791001260411u2b39d8actf35a0f3541fda92d@mail.gmail.com>
References: <1264485101-13782-1-git-send-email-jassisinghbrar@gmail.com>
	<1264485101-13782-2-git-send-email-jassisinghbrar@gmail.com>
	<20100126104723.GF15759@rakim.wolfsonmicro.main>
	<1b68c6791001260317k44893521vc0310ea35bac8ee1@mail.gmail.com>
	<20100126115258.GM15759@rakim.wolfsonmicro.main>
	<1b68c6791001260411u2b39d8actf35a0f3541fda92d@mail.gmail.com>
Message-ID: <20100126130057.GS15759@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 09:11:55PM +0900, jassi brar wrote:
> On Tue, Jan 26, 2010 at 8:52 PM, Mark Brown

> > That's not addressing the problem, though - the big issue is not
> > bringing up the AC97 link, it's the fact that you're doing an
> > uncontrolled cold reset. ?If we hit this code path it'll revert the
> > device registers to default which will upset the drivers for the CODEC
> > rather badly. ?There should be no possibility of that happening, if it
> > is happening it's something that callers really should know about.

> It should never be reached after the link is up and running. Only if something
> goes wrong at runtime, would the controller state be changed. And
> this is an attempt to recover from that failure. If the upper layer should
> know of such failure, then maybe we should not do it.
> I have never seen such runtime error though.

Sounds like the code should be changed to log and return an error if
that case is hit?

> 
> >> >> + ? ? ac_glbctrl = S3C_AC97_GLBCTRL_ACLINKON;
> >> >> + ? ? writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
> >> >> + ? ? msleep(1);

...

> I assume the ALSA definition of cold/warm reset is same as that of
> the AC97 controller. Anything remaining should be done only when necessary.
> For ex, the ALSA might want to leave controller after just cold/warm
> reset ... as
> the SoC manual says it's in low-power mode without the AC-link on.

A warm reset pretty much means "start the AC-link" - it's what you do to
exit low power mode and start clocking the link (which is mastered by
the CODEC), it doesn't have any other effect.  That's a big part of why
this is confusing, I'd expect a warm reset would also do any setup on
the controller side that was needed to cope with the clock restarting.

Due to the way AC97 is structured this stuff is all shared between the
controller and the CODECs on the bus.  It's not particularly pretty from
a software point of view at the minute.
