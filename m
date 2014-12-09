From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Dec 2014 20:28:20 +0000
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141209192517.GD3268@sonymobile.com>
References: <20141126233447.GD2872@sonymobile.com>
 <20141127190233.GF7712@sirena.org.uk>
 <CAJAp7OgBepNL6j4D6_MvXJ5PTRDUFNt6paskkP=q=h8W_YNP_Q@mail.gmail.com>
 <20141128201613.GB7712@sirena.org.uk>
 <5480CEEF.7000906@codeaurora.org>
 <20141208180635.GB3268@sonymobile.com>
 <20141208193935.GD11764@sirena.org.uk>
 <20141208205502.GC3268@sonymobile.com>
 <20141209181652.GG11764@sirena.org.uk>
 <20141209192517.GD3268@sonymobile.com>
Message-ID: <20141209202820.GK11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 11:25:18AM -0800, Bjorn Andersson wrote:
> On Tue 09 Dec 10:16 PST 2014, Mark Brown wrote:

> > I think having an idle state (or possibly just using the suspend state,
> > I'm still foggy if the two states are actually different) seems to make
> > sense?

> In 8974 we have LDO12 that have the following consumers:
>  csi
>  dsi
>  hdmi
>  edp
>  modem pll
>  pronto pll (wifi/bt)
>  krait-clock

> Each of these drivers will have a regulator object, upon which they can make
> requests on.

> The drivers for csi to pronto does not care about the state of the cpu - we
> want to output pixels even if the cpu is idle - so their requests (on their
> regulator *) must be aggregated towards the active state as well as the idle
> state.

Are they actually twiddling anything except enable, and I'm not sure
that this answers my question about suspend state either?

> The krait-clock should not affect the idle state.

> So the idle state enable property should be aggregated from csi to pronto
> enable properties. I.e. if they are all off, then the idle state should be off,
> otherwise it's on.

OK, so this is pointing back to the idea that we just want a way to
knock out this one consumer from the constraints when it's going idle
(you mention later on that other regulators need parameters other than
the enable changing).  Now, I seem to recall that the reason that this
is a problem is that you want to use this state changing stuff to
accelerate that transition.  This seems like something other regulators
can do which we don't really take advantage of yet except in that some
regualtors remember previous settings for voltage and can switch to them
quickly.

What this is *now* sounding like is that we need a way to say that this
one consumer is magic and we want to essentially tell the hardware about
settings with and without that consumer then the hardware will magically
switch between the two when the consumer is enabled and disabled.  Does
that sound about right?

> The switch-mode regulators also needs to aggregate voltage and mode - from a
> subset of the regulator objects/consumers.

We don't have any support at all for aggregating mode except via current
estimation which is unused and I'd be surprised if that works
usefully...

> > We already have an API for the suspend state, we just don't enable its
> > use in DT yet other than static configuration.  I'm not sure I see the
> > connection to the system state in the consumer API here - I thought this
> > was pretty much just setting the state when the device is turned off
> > which seems device specific?

> The suspend state (with the additional exposure in DT) allows us to specify a
> static configuration of the suspend state of a regulator. Here we see a need
> for the properties of that state to be aggregated from a subset of the
> regulator objects.

We already have a runtime API for specifying suspend state.  It doesn't
currently aggregate but that's a simple matter of programming.

> > > In our case, as most things change the both state (or active only if no
> > > both/sleep), the standard regulator api would have to affect the both state.
> > > Would we then have a separate api to modify the active state?

> > Why would we need to introduce a new API for the active state?

> It's just that I, possibly incorrectly, considered that to be the outlier and
> the one that would be the easiest to model separately.

I'm sorry, I'm just not getting this at all.

Can I please ask that people stop giving partial pictures of what's
going on?  There's a few reasons why this is all so hard to follow - one
of them is that the story is coming out in dribs and drabs so every time
I feel I understand what everyone is talking about everything shifts.

I really do fear that the bodge you're using at the minute with multiple
regulators has poor abstraction and is hence too fragile - it seems like
there's too much knowledge of the system spread around different drivers
and it's all vulnerable to changes in system integration which could
potentially be made per board.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141209/498255d9/attachment.sig>
