From: broonie@kernel.org (Mark Brown)
Date: Fri, 26 Dec 2014 17:09:12 +0000
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <CAJAp7OjKEg1jC9aA-Y-BuP4ux7sY+YqHbC7ug4E8MAVdAJzCmg@mail.gmail.com>
References: <5480CEEF.7000906@codeaurora.org>
 <20141208180635.GB3268@sonymobile.com>
 <20141208193935.GD11764@sirena.org.uk>
 <20141208205502.GC3268@sonymobile.com>
 <20141209181652.GG11764@sirena.org.uk>
 <20141209192517.GD3268@sonymobile.com>
 <20141209202820.GK11764@sirena.org.uk>
 <20141211223653.GE3268@sonymobile.com>
 <20141215180431.GL11764@sirena.org.uk>
 <CAJAp7OjKEg1jC9aA-Y-BuP4ux7sY+YqHbC7ug4E8MAVdAJzCmg@mail.gmail.com>
Message-ID: <20141226170912.GI17800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 10:05:54PM -0800, Bjorn Andersson wrote:
> On Mon, Dec 15, 2014 at 10:04 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Dec 11, 2014 at 02:36:54PM -0800, Bjorn Andersson wrote:

> >> > We already have a runtime API for specifying suspend state.  It doesn't
> >> > currently aggregate but that's a simple matter of programming.

> >> Do you mean alter properties of a state or select between the predefined
> >> states? I've found some apis related to the latter, but not the first.

> > Hrm, indeed.  Well, duplicating the existing APIs seems like a good way
> > forwards - the logic is all the same, it's just that we don't want to
> > apply the changes to the state used at runtime.

> Are you suggesting that we introduce a shadow of the current API for
> the purpose of affecting a certain state? Can you elaborate on how
> that would look like and work?

Like the current APIs but specifying a state?

> >> Because for the overall system the active state is the outlier here. But it
> >> probably doesn't matter for our conclusions.

> > I'd argue that for the purpose of running Linux it's the common state...

> Does "running Linux" indicate that there's instructions flowing
> through the CPU pipeline or that the hardware overall is up and
> running?

I think that for most practical purposes with Android (which is the
interesting thing here) those are very much the same?

> > It's not just the DT binding, it's also the regulator driver that needs
> > to do the aggregation that's being discussed and is going to assume a
> > particular arrangement of clients.

> The downstream implementation sports 3 rdevs per regulator and their
> requests are aggregated into the two states. So the regulator
> implementation are not aware of the individual clients, it just
> aggregates the 3 rdev states and programs the hardware accordingly.

To me doing that aggregation requires some knowledge.

> >> What I don't like with that solution is that we above have two different rdev
> >> and that we need to aggregate state between the various rdevs in the ldo12
> >> grouping. (so that active only and both actually affect the active state).

> > Yes, that's a big part of the problem - there's things going on that the
> > core should know about but doesn't.

> The way that the aggregation of these properties works there's no
> problems doing it in stages. But it comes with code duplication and
> the need of the various rdevs to share common state.

To me both the sharing of state and the code duplication are problems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141226/4b243377/attachment.sig>
