From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Dec 2014 18:04:31 +0000
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141211223653.GE3268@sonymobile.com>
References: <CAJAp7OgBepNL6j4D6_MvXJ5PTRDUFNt6paskkP=q=h8W_YNP_Q@mail.gmail.com>
 <20141128201613.GB7712@sirena.org.uk>
 <5480CEEF.7000906@codeaurora.org>
 <20141208180635.GB3268@sonymobile.com>
 <20141208193935.GD11764@sirena.org.uk>
 <20141208205502.GC3268@sonymobile.com>
 <20141209181652.GG11764@sirena.org.uk>
 <20141209192517.GD3268@sonymobile.com>
 <20141209202820.GK11764@sirena.org.uk>
 <20141211223653.GE3268@sonymobile.com>
Message-ID: <20141215180431.GL11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 02:36:54PM -0800, Bjorn Andersson wrote:

> At the point then the consumer decides that it does not need the regulator
> it's in atomic context. So the regulator core and driver would need to handle
> this. Further more the regulator driver uses a packet-based protocol over a
> shared memory channel, so this entire path would have to be invoked in atomic
> context.

> We have to put the consumer into a state where we can "release" the regulator,
> then we need to tell the RPM to update the state of the regulator and we have
> to wait for the ack to come back before we can actually go idle.

None of which sounds like such a big deal, a bigger problem seemed to be
trying to suppress intermediate updates of the device state that were
being done though that can comfortably be done in the driver I think.

> > What this is *now* sounding like is that we need a way to say that this
> > one consumer is magic and we want to essentially tell the hardware about
> > settings with and without that consumer then the hardware will magically
> > switch between the two when the consumer is enabled and disabled.  Does
> > that sound about right?

> I think it sounds spot on.


> > We already have a runtime API for specifying suspend state.  It doesn't
> > currently aggregate but that's a simple matter of programming.

> Do you mean alter properties of a state or select between the predefined
> states? I've found some apis related to the latter, but not the first.

Hrm, indeed.  Well, duplicating the existing APIs seems like a good way
forwards - the logic is all the same, it's just that we don't want to
apply the changes to the state used at runtime.

> > > > > both/sleep), the standard regulator api would have to affect the both state.
> > > > > Would we then have a separate api to modify the active state?

> > > > Why would we need to introduce a new API for the active state?

> > > It's just that I, possibly incorrectly, considered that to be the outlier and
> > > the one that would be the easiest to model separately.

> > I'm sorry, I'm just not getting this at all.

> Because for the overall system the active state is the outlier here. But it
> probably doesn't matter for our conclusions.

I'd argue that for the purpose of running Linux it's the common state...

> > I really do fear that the bodge you're using at the minute with multiple
> > regulators has poor abstraction and is hence too fragile - it seems like
> > there's too much knowledge of the system spread around different drivers
> > and it's all vulnerable to changes in system integration which could
> > potentially be made per board.

> Just to make sure we're on the same page here, the way this is expressed in
> downstream is like the following:
> 
> ldo12 {
> 	l12: l12 {

> 	l12_active: l12-active {

> All the consumers uses the standard regulator accessor functions to operate on
> their respective regulator *. Further more it's only the clock driver for the
> core (krait) that references the active only regulators.

> So the knowledge spread out would be contained to the dt bindings things
> together.

It's not just the DT binding, it's also the regulator driver that needs
to do the aggregation that's being discussed and is going to assume a
particular arrangement of clients.

> What I don't like with that solution is that we above have two different rdev
> and that we need to aggregate state between the various rdevs in the ldo12
> grouping. (so that active only and both actually affect the active state).

Yes, that's a big part of the problem - there's things going on that the
core should know about but doesn't.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141215/23b963f3/attachment.sig>
