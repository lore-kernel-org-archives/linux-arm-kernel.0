From: broonie@kernel.org (Mark Brown)
Date: Mon, 1 Jul 2013 13:51:13 +0100
Subject: [PATCH 2/4] ASoC: sgtl5000: defer the probe if clock is not found
In-Reply-To: <20130701113310.GA24642@n2100.arm.linux.org.uk>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <1372666571-17276-3-git-send-email-shawn.guo@linaro.org>
 <20130701094525.GY27646@sirena.org.uk>
 <20130701113310.GA24642@n2100.arm.linux.org.uk>
Message-ID: <20130701125113.GK27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 12:33:10PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 01, 2013 at 10:45:25AM +0100, Mark Brown wrote:

> > Why not fix this in the clock API - the same logic is going to apply to
> > a great proportion of clocks?

> It's not ever clear whether a missing clock is because it's just not
> provided or whether it's because it hasn't been registered yet.  The
> decision to defer on missing resources is something which a _driver_
> using the resource should make, not the subsystem providing the
> resource - because the driver should know better whether that resource
> is optional, whether it can continue to initialise without it and maybe
> try again later, or whether it does need to defer.

Given how common it is to have a hard requirement for a clock I think we
should at least have a helper which implements deferral, even if it's
not part of the default request function, since so many drivers ought to
be using it.  Doing this in by default doesn't prevent the driver
overriding, though - the driver can choose to squash down the PROBE_DEFER
into a fatal error.

One nice thing you can sometimes do here in the DT case is to have the
subsystem tell the driver the difference between "this clock is mapped
but not yet registered" and "this clock is not physically present"
though there's never any guarantee that the provided resource will
actually load.  I don't think the idiom for the clock API is to provide
every single clock in DT though so that might not be doable.

> Take for instance a video driver. :)  It may be that it can't do all
> resolutions, but it can do some without an external clock, so it may
> decide that it can initialise without the external clock and allow one
> of the possible modes to be set - and when the external clock does
> appear, it can then allow the other modes.

Yes, that's the sort of case where you do definitely want to just carry
on (though there is then some vulnerability to changes in init ordering
with things like modular kernels).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130701/34be7eea/attachment.sig>
