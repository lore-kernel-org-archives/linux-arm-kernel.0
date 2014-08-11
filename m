From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 11 Aug 2014 19:33:56 +0200
Subject: [RFC PATCH v3] reset: Add a defer reset object to send board
 specific reset
In-Reply-To: <1407507789.3354.20.camel@paszta.hi.pengutronix.de>
References: <1403098673-3058-1-git-send-email-houcheng@gmail.com>
 <CACRpkdYfu8HmVCkn9JFh+YP5OPdr8o9nTfoCnkJ7SSpGoenQUg@mail.gmail.com>
 <20140708080535.GJ13423@lukather>
 <CACRpkdbFPAsu1gE-AVyD=-RxyE7mUJPSbFga7HLh0mxjE-mQuQ@mail.gmail.com>
 <1407507789.3354.20.camel@paszta.hi.pengutronix.de>
Message-ID: <20140811173356.GN15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 08, 2014 at 04:23:09PM +0200, Philipp Zabel wrote:
> Am Dienstag, den 08.07.2014, 11:38 +0200 schrieb Linus Walleij:
> > On Tue, Jul 8, 2014 at 10:05 AM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> > > On Tue, Jul 08, 2014 at 09:52:03AM +0200, Linus Walleij wrote:
> > >> On Wed, Jun 18, 2014 at 3:37 PM, Houcheng Lin <houcheng@gmail.com> wrote:
> > >>
> > >> > The Problem
> > >> > -----------
> > >> > The reset signal on a hardware board is send either:
> > >> >     - during machine initialization
> > >> >     - during bus master's initialization
> > >>
> > >> I just thought about this a bit, since there isn't already a generic GPIO
> > >> reset driver, just call this drivers/reset/reset-gpio.c and make the
> > >> ability to deferral just a configuration detail of the GPIO reset driver.
> > >
> > > Philipp has been working on one for quite some time. See
> > > http://www.spinics.net/lists/arm-kernel/msg321927.html
> > >
> > > However, it seems to progress slowly, and we don't seem to be able to
> > > reach a consensus here.
> 
> Mostly because Maxime and I seem to have a completely different opinion
> and nobody else argued one way or the other.

Yep, mostly because I don't see how a generic approach can work.

The existing reset-gpios property only provide the gpio to use, but
some informations are encoded in the driver, such as the reset
duration, or a reset sequence if any.

How do you plan on giving that information to your generic driver?

The only solution I can think of would be to add an extra property
that your code would parse. But then, you break the existing DT
bindings.

And if we're going to break those bindings, at least do it in a way
consistent with reset bindings.

Plus, your approach doesn't cover the weird corner cases such as:
  - reset-gpio
  - wlf,reset-gpios
  - phy-reset-gpios
  - snps,reset-gpio
  - the drivers that need several gpio and expect the reset one as a
    positional argument.
  - etc.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140811/8b38b659/attachment.sig>
