From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Dec 2014 12:59:51 +0000
Subject: [PATCH 1/4] regulator: core: Support trying to get close to a
 certain voltage
In-Reply-To: <CAD=FV=W1r2MXNHXTRiO1pBPWurvgqq+dSoOPgpSJ_zAbpU7T4Q@mail.gmail.com>
References: <1418245085-9754-1-git-send-email-dianders@chromium.org>
 <20141210235347.GT11764@sirena.org.uk>
 <CAHNYxRy2t0OVj-+CqQFOfj0zWAGG0j8rmd8SxdNWgBMA2iAfXQ@mail.gmail.com>
 <20141211123106.GU11764@sirena.org.uk>
 <CAD=FV=U4RFYx9NXOACrXJZK2bKkosyYnmTZRHkXuaSz-FS9kNQ@mail.gmail.com>
 <20141211170934.GZ11764@sirena.org.uk>
 <CAD=FV=WBAuF0+BVMG9rp53Zt851Ou0kZ6xgTe9mjmgxyugWteg@mail.gmail.com>
 <20141212002410.GB11764@sirena.org.uk>
 <CAD=FV=W1r2MXNHXTRiO1pBPWurvgqq+dSoOPgpSJ_zAbpU7T4Q@mail.gmail.com>
Message-ID: <20141212125951.GE11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 07:31:43PM -0800, Doug Anderson wrote:
> On Thu, Dec 11, 2014 at 4:24 PM, Mark Brown <broonie@kernel.org> wrote:

> > I mean the latter - what happens if more than one consumer is trying to
> > use the regulator?  This is IIRC why _set_voltage_tol() uses the cheap
> > and nasty implementation it does.

> Ah, I see.  I don't think I've ever encountered a case where there
> were two consumers for a regulator that actually requested voltages...

> ...but isn't regulator_set_voltage_tol() broken there?  If you have
> two clients, A and B and a regulator that can go 1.0V to 5.0V in .05V
> increments:

> A requests 1.8V +/- .1V.  We get 1.8V
> B requests 1.7V +/- .05V.

> The above could be achievable with a voltage of 1.75V but it won't
> work with the current regulator_set_voltage_tol() I think.

Yeah, it's not perfect but it'll work most of the time.

> > There's also the potential
> > performance considerations for the DVS type applications now I think
> > about it.

> Iterating through voltages is really that slow?  If so, perhaps we
> could add some caching to keep track of what voltage we actually got
> last time...  I could also add an optimization to try the exact
> requested voltage right away...

Applications like DVS get pretty performance sensitive and for a
regulator with high resolution if you're trying to hit a voltage at the
top of the range you could be iterating over a hundred or more values.
Perhaps doing something based on the various factorings out of the
voltage mapping would do the trick, add a new op for getting to the
closest voltage?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141212/c79e5710/attachment.sig>
