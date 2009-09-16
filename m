From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 16 Sep 2009 12:02:46 +0100
Subject: [PATCH 03/10] S3C64XX I2S: Codec Clock Gating Option
In-Reply-To: <1b68c6790909151837x35cc7171y42c6a612975052ee@mail.gmail.com>
References: <1253008955-10505-1-git-send-email-jassi.brar@samsung.com>
	<20090915104417.GF22878@rakim.wolfsonmicro.main>
	<1b68c6790909151837x35cc7171y42c6a612975052ee@mail.gmail.com>
Message-ID: <20090916110246.GD3589@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2009 at 10:37:09AM +0900, jassi brar wrote:
> On Tue, Sep 15, 2009 at 7:44 PM, Mark Brown

> > In terms of functionality it might be clearer to describe what's going
> > on here as switching the function of CDCLK from being an input to being
> > an output. ?The actual implementation appears to be done by gating the
> > output of the internal clock signal to the CDCLK pin but in terms of
> > what the user can see externally the clock isn't gated, it's still
> > active but it changed direction.

> The bit IISMOD[12], if cleared, gates the RCLK towards  the Xi2sCDCLK.
> If this bit is set, it simply disconnects the RCLK and Xi2sCDCLK.

This is an implementation detail; it does this gating internally in
order to allow the pin to be used as an input.  The potential confusion
here is that the user visible CDCLK can still have a live signal on it,
the thing that's been disconnected is an internal signal which can be
used to drive it.  If you say it's gated that suggests that the signal
is stopped completely.

> >> + ? ? case S3C64XX_CODCLKSRC_INT:
> >> + ? ? ? ? ? ? iismod &= ~S3C64XX_IISMOD_CDCLK_EXT;
> >> + ? ? ? ? ? ? break;

> >> + ? ? case S3C64XX_CODCLKSRC_EXT:
> >> + ? ? ? ? ? ? iismod |= S3C64XX_IISMOD_CDCLK_EXT;
> >> + ? ? ? ? ? ? break;

> > This should really be done using the direction parameter - clk_id should
> > specify that CDCLK should be used and the direction parameter be used to
> > say if it's an input or output.

> Again, the patch aims to simply fit in the place. For the current
> state and design of our driver this change is least intrusive and most
> simple.

There's no meaningful extra effort required to do this properly and
given that all this patch does is implement an external interface it's
better to just get it right rather than spend the effort on fixups (and
merge issues).

In general, the wider the impact of your changes the more important it
is to get them right.
