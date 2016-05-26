From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 26 May 2016 13:02:42 +0200
Subject: [PATCH v2 1/4] reset: Add support for the Amlogic Meson SoC
 Reset Controller
In-Reply-To: <m2iny1h74c.fsf@baylibre.com>
References: <1464169758-26975-1-git-send-email-narmstrong@baylibre.com>
 <1464169758-26975-2-git-send-email-narmstrong@baylibre.com>
 <m2iny1h74c.fsf@baylibre.com>
Message-ID: <1464260562.4109.77.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

Am Mittwoch, den 25.05.2016, 19:42 -0700 schrieb Kevin Hilman:
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
> > This patch adds the platform driver for the Amlogic Meson SoC Reset
> > Controller.
> >
> > The Meson8b and GXBB SoCs are supported.
> >
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Maybe a question for Philipp, but when testog this version with the
> stmmac ethernet driver on the Amlogic boards, I noticed that ->reset was
> never getting called.
> 
> Turns out, the stmmac driver only uses reset_control_assert() and
> reset_control_deassert(), both of which return -ENOTSUPP since this
> driver doesn't provide ->assert or ->deassert, so the driver's ->reset()
> never gets called.
> 
> I haven't looked into the reset framework in detail, but if there's only
> a ->reset hook, I kind of expected that reset_control_deassert() would
> use that instead of returning -ENOTSUPP.
> 
> If not, what's the proper way of handling hardware that only supports a
> write-only reset pulse?  Should users of reset_control_* be adapted to
> check if ->deassert returns -ENOTSUPP and call ->reset?

I initially came up with this for i.MX6, which has a reset controller
that just like the Meson ones doesn't support manual assertion and
deassertion of the reset line.
My assumption then was that reset() is the default for all devices that
just need their internal state to be reset at some point. I didn't
expect the clock-like usage of manual deassert()/assert() for power
management to become so common.
So assert() and deassert() return -ENOTSUPP if the reset controller
doesn't support manually asserting or deasserting the reset line.

Of course you can argue that after a reset() pulse the reset line is
deasserted, and if you instead interpret the API in terms of expected
outcome, that would be similar to the state after call to deassert()
(iff the line was asserted before).
That would blur the line between reset() and deassert() somewhat, and in
my opinion having a call to deassert() first doing the exact opposite
isn't good nomenclature.
Personally, I'd prefer if the driver could switch to only using
	reset_control_reset(rstc);
or, if the reset line needs to stay asserted during powerdown where the
reset controller supports it, but doesn't matter whert not, use:
	ret = reset_control_deassert(rstc);
	if (ret == -ENOTSUPP)
		ret = reset_control_reset(rstc);

We could add a helper reset_control_deassert_or_reset() for that.

regards
Philipp
