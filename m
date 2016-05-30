From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 30 May 2016 18:14:22 +0200
Subject: [PATCH v2 1/4] reset: Add support for the Amlogic Meson SoC
 Reset Controller
In-Reply-To: <m28tywhda8.fsf@baylibre.com>
References: <1464169758-26975-1-git-send-email-narmstrong@baylibre.com>
 <1464169758-26975-2-git-send-email-narmstrong@baylibre.com>
 <m2iny1h74c.fsf@baylibre.com> <1464260562.4109.77.camel@pengutronix.de>
 <m28tywhda8.fsf@baylibre.com>
Message-ID: <1464624862.3808.106.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

Am Donnerstag, den 26.05.2016, 11:42 -0700 schrieb Kevin Hilman:
[...]
> > Personally, I'd prefer if the driver could switch to only using
> > 	reset_control_reset(rstc);
> 
> Then what would happen if that same driver is used on platforms that
> have ->assert and ->deassert but no -reset?

If the implementer of the reset controller driver doesn't have enough
information about all connected devices to implement ->reset, then
_reset() has to return -ENOTSUPP, so this is not an option in the
general case.

> The bind I'm in is that I'm using an exsting network driver
> (stmicro/stmmac) which is used on a bunch of platforms and I dont' know
> what all those reset controllers are actually doing, so going and
> changing the driver seems problematic.

I see. It's all the more important that the API clearly states the
intended effects.

> > or, if the reset line needs to stay asserted during powerdown where the
> > reset controller supports it, but doesn't matter whert not, use:
> > 	ret = reset_control_deassert(rstc);
> > 	if (ret == -ENOTSUPP)
> > 		ret = reset_control_reset(rstc);
> >
> > We could add a helper reset_control_deassert_or_reset() for that.
> 
> IMO, that would be a useful helper function, but I still think that
> should be the default behavior of _deassert, otherwise it will still
> require changing all the drivers.

"All the drivers" makes me reconsider. If all drivers eventually,
reasonably could be changed to use reset_control_deassert_or_reset()
instead of reset_control_deassert(), there would be no reason not to
make _deassert() behave like you expect (well, except for the naming
issue).

One thing that has to be considered is that in the case of synchronous
resets there may be a significant difference in the behaviour of ->reset
and ->deassert: With ->deassert you could prime the reset line before
enabling clocks and letting the reset signal propagate. This is not
possible with ->reset, which could hang or have no effect at all with
the relevant clocks disabled. So it should be clearly documented that
anybody intending to make use of this must call reset_control_assert()
first and back off if that returns -ENOTSUPP.

regards
Philipp
