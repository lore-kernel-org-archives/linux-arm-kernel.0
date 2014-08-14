From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 14 Aug 2014 11:36:38 +0200
Subject: [RFC PATCH v3] reset: Add a defer reset object to send board
 specific reset
In-Reply-To: <20140811173356.GN15297@lukather>
References: <1403098673-3058-1-git-send-email-houcheng@gmail.com>
 <CACRpkdYfu8HmVCkn9JFh+YP5OPdr8o9nTfoCnkJ7SSpGoenQUg@mail.gmail.com>
 <20140708080535.GJ13423@lukather>
 <CACRpkdbFPAsu1gE-AVyD=-RxyE7mUJPSbFga7HLh0mxjE-mQuQ@mail.gmail.com>
 <1407507789.3354.20.camel@paszta.hi.pengutronix.de>
 <20140811173356.GN15297@lukather>
Message-ID: <1408008998.4035.43.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Am Montag, den 11.08.2014, 19:33 +0200 schrieb Maxime Ripard:
> > Mostly because Maxime and I seem to have a completely different opinion
> > and nobody else argued one way or the other.
> 
> Yep, mostly because I don't see how a generic approach can work.
> 
> The existing reset-gpios property only provide the gpio to use, but
> some informations are encoded in the driver, such as the reset
> duration, or a reset sequence if any.

The driver should provide the duration. I'd really like to see an
example where sequencing is necessary.
I agree that as soon as things get significantly more complicated than
pulsing a single GPIO, the reset-gpios binding is too limited.
Still, I'm not happy to mandate a separate gpio reset device for each
reset line if most devices are simple enough for it to work without.
What about using reset-gpios for the majority of simple cases and have a
separate gpio-reset-sequencer driver when multiple GPIO resets have to
be timed?

> How do you plan on giving that information to your generic driver?
> 
> The only solution I can think of would be to add an extra property
> that your code would parse. But then, you break the existing DT
> bindings.
>
> And if we're going to break those bindings, at least do it in a way
> consistent with reset bindings.

For the backwards compatibility case, the driver already has to provide
the duration. I don't want to break the existing bindings at all.

> Plus, your approach doesn't cover the weird corner cases such as:
>   - reset-gpio
>   - wlf,reset-gpios
>   - phy-reset-gpios
>   - snps,reset-gpio
>   - the drivers that need several gpio and expect the reset one as a
>     positional argument.
>   - etc.

Those are just an issue of the implementation I posted earlier because
gpiod_get doesn't support custom names other than %s-gpios. This could
be extended and handled just as well if deemed necessary.

regards
Philipp
