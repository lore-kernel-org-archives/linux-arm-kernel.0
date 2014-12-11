From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 11 Dec 2014 14:36:54 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141209202820.GK11764@sirena.org.uk>
References: <20141127190233.GF7712@sirena.org.uk>
 <CAJAp7OgBepNL6j4D6_MvXJ5PTRDUFNt6paskkP=q=h8W_YNP_Q@mail.gmail.com>
 <20141128201613.GB7712@sirena.org.uk>
 <5480CEEF.7000906@codeaurora.org>
 <20141208180635.GB3268@sonymobile.com>
 <20141208193935.GD11764@sirena.org.uk>
 <20141208205502.GC3268@sonymobile.com>
 <20141209181652.GG11764@sirena.org.uk>
 <20141209192517.GD3268@sonymobile.com>
 <20141209202820.GK11764@sirena.org.uk>
Message-ID: <20141211223653.GE3268@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 09 Dec 12:28 PST 2014, Mark Brown wrote:

> On Tue, Dec 09, 2014 at 11:25:18AM -0800, Bjorn Andersson wrote:
> > On Tue 09 Dec 10:16 PST 2014, Mark Brown wrote:
> 
> > > I think having an idle state (or possibly just using the suspend state,
> > > I'm still foggy if the two states are actually different) seems to make
> > > sense?
> 
> > In 8974 we have LDO12 that have the following consumers:
> >  csi
> >  dsi
> >  hdmi
> >  edp
> >  modem pll
> >  pronto pll (wifi/bt)
> >  krait-clock
> 
> > Each of these drivers will have a regulator object, upon which they can make
> > requests on.
> 
> > The drivers for csi to pronto does not care about the state of the cpu - we
> > want to output pixels even if the cpu is idle - so their requests (on their
> > regulator *) must be aggregated towards the active state as well as the idle
> > state.
> 
> Are they actually twiddling anything except enable, and I'm not sure
> that this answers my question about suspend state either?
> 

Yes, for the switch-mode regulators there's different enable state, voltage and
mode.

> > The krait-clock should not affect the idle state.
> 
> > So the idle state enable property should be aggregated from csi to pronto
> > enable properties. I.e. if they are all off, then the idle state should be off,
> > otherwise it's on.
> 
> OK, so this is pointing back to the idea that we just want a way to
> knock out this one consumer from the constraints when it's going idle
> (you mention later on that other regulators need parameters other than
> the enable changing).  Now, I seem to recall that the reason that this
> is a problem is that you want to use this state changing stuff to
> accelerate that transition.  This seems like something other regulators
> can do which we don't really take advantage of yet except in that some
> regualtors remember previous settings for voltage and can switch to them
> quickly.
> 

Correct, the problem here is twofold in my eyes;

At the point then the consumer decides that it does not need the regulator
it's in atomic context. So the regulator core and driver would need to handle
this. Further more the regulator driver uses a packet-based protocol over a
shared memory channel, so this entire path would have to be invoked in atomic
context.

We have to put the consumer into a state where we can "release" the regulator,
then we need to tell the RPM to update the state of the regulator and we have
to wait for the ack to come back before we can actually go idle.

> What this is *now* sounding like is that we need a way to say that this
> one consumer is magic and we want to essentially tell the hardware about
> settings with and without that consumer then the hardware will magically
> switch between the two when the consumer is enabled and disabled.  Does
> that sound about right?
> 

I think it sounds spot on.

> > The switch-mode regulators also needs to aggregate voltage and mode - from a
> > subset of the regulator objects/consumers.
> 
> We don't have any support at all for aggregating mode except via current
> estimation which is unused and I'd be surprised if that works
> usefully...
> 

Let's treat that as a separate topic.

> > > We already have an API for the suspend state, we just don't enable its
> > > use in DT yet other than static configuration.  I'm not sure I see the
> > > connection to the system state in the consumer API here - I thought this
> > > was pretty much just setting the state when the device is turned off
> > > which seems device specific?
> 
> > The suspend state (with the additional exposure in DT) allows us to specify a
> > static configuration of the suspend state of a regulator. Here we see a need
> > for the properties of that state to be aggregated from a subset of the
> > regulator objects.
> 
> We already have a runtime API for specifying suspend state.  It doesn't
> currently aggregate but that's a simple matter of programming.
> 

Do you mean alter properties of a state or select between the predefined
states? I've found some apis related to the latter, but not the first.

> > > > In our case, as most things change the both state (or active only if no
> > > > both/sleep), the standard regulator api would have to affect the both state.
> > > > Would we then have a separate api to modify the active state?
> 
> > > Why would we need to introduce a new API for the active state?
> 
> > It's just that I, possibly incorrectly, considered that to be the outlier and
> > the one that would be the easiest to model separately.
> 
> I'm sorry, I'm just not getting this at all.
> 

Because for the overall system the active state is the outlier here. But it
probably doesn't matter for our conclusions.

> Can I please ask that people stop giving partial pictures of what's
> going on?  There's a few reasons why this is all so hard to follow - one
> of them is that the story is coming out in dribs and drabs so every time
> I feel I understand what everyone is talking about everything shifts.
> 

Sorry, I've tried to describe the hardware setup but have probably not made a
clear enough distinction towards the downstream implementation and solution
suggestions.

> I really do fear that the bodge you're using at the minute with multiple
> regulators has poor abstraction and is hence too fragile - it seems like
> there's too much knowledge of the system spread around different drivers
> and it's all vulnerable to changes in system integration which could
> potentially be made per board.

Just to make sure we're on the same page here, the way this is expressed in
downstream is like the following:

ldo12 {
	l12: l12 {
		set-both-states;

		regulator-min-microvolt = <1800000>;
		regulator-max-microvolt = <1800000>;
	};

	l12_active: l12-active {
		set-only-active-state;

		regulator-min-microvolt = <1800000>;
		regulator-max-microvolt = <1800000>;
	};
};

dsi {
	vddio-supply = <&l12>;
};

clock-krait {
	hfpll-analog-supply = <&l12_active>;
};

All the consumers uses the standard regulator accessor functions to operate on
their respective regulator *. Further more it's only the clock driver for the
core (krait) that references the active only regulators.

So the knowledge spread out would be contained to the dt bindings things
together.

I can however not argue against you on the fact that the way this is exposed is
suboptimal. The question is if we can figure a better way to express it - note
that we do not want e.g. the dsi driver to know anything about the fact that
ldo12 is special.



What I don't like with that solution is that we above have two different rdev
and that we need to aggregate state between the various rdevs in the ldo12
grouping. (so that active only and both actually affect the active state).

Regards,
Bjorn
