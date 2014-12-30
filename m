From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Dec 2014 16:43:41 +0000
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141229215454.GA25436@sonymobile.com>
References: <20141208193935.GD11764@sirena.org.uk>
 <20141208205502.GC3268@sonymobile.com>
 <20141209181652.GG11764@sirena.org.uk>
 <20141209192517.GD3268@sonymobile.com>
 <20141209202820.GK11764@sirena.org.uk>
 <20141211223653.GE3268@sonymobile.com>
 <20141215180431.GL11764@sirena.org.uk>
 <CAJAp7OjKEg1jC9aA-Y-BuP4ux7sY+YqHbC7ug4E8MAVdAJzCmg@mail.gmail.com>
 <20141226170912.GI17800@sirena.org.uk>
 <20141229215454.GA25436@sonymobile.com>
Message-ID: <20141230164341.GG17800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 29, 2014 at 01:54:55PM -0800, Bjorn Andersson wrote:

Could you please fix your mailer to wrap sufficiently far before 80
characters to allow for some quoting?

> On Fri 26 Dec 09:09 PST 2014, Mark Brown wrote:
> > On Mon, Dec 15, 2014 at 10:05:54PM -0800, Bjorn Andersson wrote:

> > > Are you suggesting that we introduce a shadow of the current API for
> > > the purpose of affecting a certain state? Can you elaborate on how
> > > that would look like and work?

> > Like the current APIs but specifying a state?

> So then we have two choices:

> 1) We make the standard API affect both our states and use the special api to
> affect only the active state. Which doesn't seem completely unreasonable to
> implement as we only have one special consumer and the aggregation in the
> driver is trivial.

> 2) We make the "run queue empty" the special state and in e.g. the display
> driver (DSI) we have to pair every regulator api call with a call to the
> special version. So suddenly we have riddled drivers with "knowledge" about how
> cpuidle works on these platforms (but not all).

I think there's more options than that but whatever...

> > > Does "running Linux" indicate that there's instructions flowing
> > > through the CPU pipeline or that the hardware overall is up and
> > > running?

> > I think that for most practical purposes with Android (which is the
> > interesting thing here) those are very much the same?

> While Android is not the single usecase that we have to consider it's an
> excellent example of the opposite.

> Take e.g. a Nexus 5, hit the power button to "wake it up" sitting in
> lockscreen. You will now have pm8941_ldo12 requested enabled by the display
> core (DSI) and the CPU PLLs. When the run queue empties out the display will be
> kept on but the CPU no longer need ldo12. (And it might sit there for the next
> 15 seconds - or whatever timeout you have)

> So I don't know which one is statistically more common, but both are very
> common to be in.

So, a couple of things here.  One is that unless the system leakages are
truly spectacular I'd expect nobody is going to notice a practical
impact from leaving the CPU PLL LDO on while the display is on given
that in an idle display state the display will tend to dominate the
system power consumption, making it all a bit academic.  If you can run
the CPU without the PLL for low power but long term tasks that's more
interesting but a different problem.  The other is that you're thinking
of the common state as being the one that is running most whereas I'm
thinking of it as being the one that we have to work with the most - I'd
expect that we're going to be making more changes to the state while
we're actively running than we will be adjusting the state we're going
to go into on idle.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141230/224da6da/attachment.sig>
