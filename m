From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Oct 2010 21:43:05 -0700
Subject: [alsa-devel] [PATCH 10/10] ASoC: SAMSUNG: Add Machine driver
	for S/PDIF PCM audio
In-Reply-To: <AANLkTincwL_nQAmu7Dcmht0FV43BiN7OoecE_60QJhS2@mail.gmail.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286194583-19937-1-git-send-email-sw.youn@samsung.com>
	<20101004224159.GA4972@opensource.wolfsonmicro.com>
	<AANLkTi=FHGw+qzL507K546vr8zEZgXBP3Mk=O__Rpd4H@mail.gmail.com>
	<AANLkTincwL_nQAmu7Dcmht0FV43BiN7OoecE_60QJhS2@mail.gmail.com>
Message-ID: <20101005044304.GA26509@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 05, 2010 at 11:19:35AM +0900, Jassi Brar wrote:
> On Tue, Oct 5, 2010 at 10:10 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> > On Tue, Oct 5, 2010 at 7:42 AM, Mark Brown

> >> I'd expect this to be with the other clock configuration code under
> >> arch/arm, especially as it's involving the EPLL which can have fairly
> >> wide usage - it seems better to make sure people working with other,
> >> non-audio, bits of the system are aware of the EPLL usage.

> > But that would have made us have EPLL manipulation in two places -
> > one in arch/arm/mach/board-init and other in ASoC Machine driver because
> > we would need to change the source clock's rate in runtime(using
> > callback pointers
> > for the purpose seemed too over the top).
> > If ASoC doesn't change EPLL, it doesn't matter to other devices, if it
> > does there
> > is currently no means for other drivers to know about it. So, we might just
> > as well move the EPLL related code to ASoC machine driver.

The reason I'm concerned about this is that I've had actual problems
with users of your out of tree BSPs getting confused by similar code
there.  Thinking about it some more it's not so much the fact that
the code is spread out as the fact that the the EPLL is so widely used
within the system that having one driver change it can easily disrupt
another subsystem in surprising ways.

Since the clock API currently doesn't have a good way of resolving this
perhaps a config option or something which masks the EPLL behaviour
controllable and leaves it alone by default?  That would show people how
to use this chip feature without affecting the other subsystems so
non-obviously.

> Btw, another important reason is that having EPLL manipulation in board-int
> would result in code-duplication on other SMDK platforms as most have the
> same clock routing options available in h/w and we want to use the same ASoC
> machine driver for SoCs whenever possible.

This doesn't seem such a big deal - you could create a shared file for
the code under arch/arm.
