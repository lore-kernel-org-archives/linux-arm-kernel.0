From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 29 Dec 2014 13:54:55 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141226170912.GI17800@sirena.org.uk>
References: <20141208180635.GB3268@sonymobile.com>
 <20141208193935.GD11764@sirena.org.uk>
 <20141208205502.GC3268@sonymobile.com>
 <20141209181652.GG11764@sirena.org.uk>
 <20141209192517.GD3268@sonymobile.com>
 <20141209202820.GK11764@sirena.org.uk>
 <20141211223653.GE3268@sonymobile.com>
 <20141215180431.GL11764@sirena.org.uk>
 <CAJAp7OjKEg1jC9aA-Y-BuP4ux7sY+YqHbC7ug4E8MAVdAJzCmg@mail.gmail.com>
 <20141226170912.GI17800@sirena.org.uk>
Message-ID: <20141229215454.GA25436@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 26 Dec 09:09 PST 2014, Mark Brown wrote:

> On Mon, Dec 15, 2014 at 10:05:54PM -0800, Bjorn Andersson wrote:
> > On Mon, Dec 15, 2014 at 10:04 AM, Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Dec 11, 2014 at 02:36:54PM -0800, Bjorn Andersson wrote:
> 
> > >> > We already have a runtime API for specifying suspend state.  It doesn't
> > >> > currently aggregate but that's a simple matter of programming.
> 
> > >> Do you mean alter properties of a state or select between the predefined
> > >> states? I've found some apis related to the latter, but not the first.
> 
> > > Hrm, indeed.  Well, duplicating the existing APIs seems like a good way
> > > forwards - the logic is all the same, it's just that we don't want to
> > > apply the changes to the state used at runtime.
> 
> > Are you suggesting that we introduce a shadow of the current API for
> > the purpose of affecting a certain state? Can you elaborate on how
> > that would look like and work?
> 
> Like the current APIs but specifying a state?
> 

So then we have two choices:

1) We make the standard API affect both our states and use the special api to
affect only the active state. Which doesn't seem completely unreasonable to
implement as we only have one special consumer and the aggregation in the
driver is trivial.

2) We make the "run queue empty" the special state and in e.g. the display
driver (DSI) we have to pair every regulator api call with a call to the
special version. So suddenly we have riddled drivers with "knowledge" about how
cpuidle works on these platforms (but not all).

> > >> Because for the overall system the active state is the outlier here. But it
> > >> probably doesn't matter for our conclusions.
> 
> > > I'd argue that for the purpose of running Linux it's the common state...
> 
> > Does "running Linux" indicate that there's instructions flowing
> > through the CPU pipeline or that the hardware overall is up and
> > running?
> 
> I think that for most practical purposes with Android (which is the
> interesting thing here) those are very much the same?
> 

While Android is not the single usecase that we have to consider it's an
excellent example of the opposite.

Take e.g. a Nexus 5, hit the power button to "wake it up" sitting in
lockscreen. You will now have pm8941_ldo12 requested enabled by the display
core (DSI) and the CPU PLLs. When the run queue empties out the display will be
kept on but the CPU no longer need ldo12. (And it might sit there for the next
15 seconds - or whatever timeout you have)


So I don't know which one is statistically more common, but both are very
common to be in.

> > > It's not just the DT binding, it's also the regulator driver that needs
> > > to do the aggregation that's being discussed and is going to assume a
> > > particular arrangement of clients.
> 
> > The downstream implementation sports 3 rdevs per regulator and their
> > requests are aggregated into the two states. So the regulator
> > implementation are not aware of the individual clients, it just
> > aggregates the 3 rdev states and programs the hardware accordingly.
> 
> To me doing that aggregation requires some knowledge.
> 

Yeah, but all the aggregations that we do can be done stepwise, so taking the
various regulator_dev* requests and aggregating them one step futhrer (with the
added knowledge about our states) is fine.

> > >> What I don't like with that solution is that we above have two different rdev
> > >> and that we need to aggregate state between the various rdevs in the ldo12
> > >> grouping. (so that active only and both actually affect the active state).
> 
> > > Yes, that's a big part of the problem - there's things going on that the
> > > core should know about but doesn't.
> 
> > The way that the aggregation of these properties works there's no
> > problems doing it in stages. But it comes with code duplication and
> > the need of the various rdevs to share common state.
> 
> To me both the sharing of state and the code duplication are problems.

I agree, but it's enough time and power cost for us to have to have a solution.

If we implement 1) above then we would need to share the system knowledge with
1 driver (the CPU clock driver) and the actual aggregation in the regulator_dev
driver would be extreemly trivial and more importantly specific.

But it's a step away from the current idea of what those states are meant to
define.


I'll make some prototyping and see how it looks.

Regards,
Bjorn
