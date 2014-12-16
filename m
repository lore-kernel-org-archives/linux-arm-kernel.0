From: bjorn@kryo.se (Bjorn Andersson)
Date: Mon, 15 Dec 2014 22:05:54 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141215180431.GL11764@sirena.org.uk>
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
 <20141215180431.GL11764@sirena.org.uk>
Message-ID: <CAJAp7OjKEg1jC9aA-Y-BuP4ux7sY+YqHbC7ug4E8MAVdAJzCmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 10:04 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Dec 11, 2014 at 02:36:54PM -0800, Bjorn Andersson wrote:
>
[..]
>> We have to put the consumer into a state where we can "release" the regulator,
>> then we need to tell the RPM to update the state of the regulator and we have
>> to wait for the ack to come back before we can actually go idle.
>
> None of which sounds like such a big deal, a bigger problem seemed to be
> trying to suppress intermediate updates of the device state that were
> being done though that can comfortably be done in the driver I think.
>

As I said previously, suppressing unnecessary updates is an
optimization - although an important one. The key question is how we
model the multiple states.

[..]

>> > We already have a runtime API for specifying suspend state.  It doesn't
>> > currently aggregate but that's a simple matter of programming.
>
>> Do you mean alter properties of a state or select between the predefined
>> states? I've found some apis related to the latter, but not the first.
>
> Hrm, indeed.  Well, duplicating the existing APIs seems like a good way
> forwards - the logic is all the same, it's just that we don't want to
> apply the changes to the state used at runtime.
>

Are you suggesting that we introduce a shadow of the current API for
the purpose of affecting a certain state? Can you elaborate on how
that would look like and work?

>> > > > > both/sleep), the standard regulator api would have to affect the both state.
>> > > > > Would we then have a separate api to modify the active state?
>
>> > > > Why would we need to introduce a new API for the active state?
>
>> > > It's just that I, possibly incorrectly, considered that to be the outlier and
>> > > the one that would be the easiest to model separately.
>
>> > I'm sorry, I'm just not getting this at all.
>
>> Because for the overall system the active state is the outlier here. But it
>> probably doesn't matter for our conclusions.
>
> I'd argue that for the purpose of running Linux it's the common state...
>

Does "running Linux" indicate that there's instructions flowing
through the CPU pipeline or that the hardware overall is up and
running?

>> > I really do fear that the bodge you're using at the minute with multiple
>> > regulators has poor abstraction and is hence too fragile - it seems like
>> > there's too much knowledge of the system spread around different drivers
>> > and it's all vulnerable to changes in system integration which could
>> > potentially be made per board.
>
>> Just to make sure we're on the same page here, the way this is expressed in
>> downstream is like the following:
>>
>> ldo12 {
>>       l12: l12 {
>
>>       l12_active: l12-active {
>
>> All the consumers uses the standard regulator accessor functions to operate on
>> their respective regulator *. Further more it's only the clock driver for the
>> core (krait) that references the active only regulators.
>
>> So the knowledge spread out would be contained to the dt bindings things
>> together.
>
> It's not just the DT binding, it's also the regulator driver that needs
> to do the aggregation that's being discussed and is going to assume a
> particular arrangement of clients.
>

The downstream implementation sports 3 rdevs per regulator and their
requests are aggregated into the two states. So the regulator
implementation are not aware of the individual clients, it just
aggregates the 3 rdev states and programs the hardware accordingly.

>> What I don't like with that solution is that we above have two different rdev
>> and that we need to aggregate state between the various rdevs in the ldo12
>> grouping. (so that active only and both actually affect the active state).
>
> Yes, that's a big part of the problem - there's things going on that the
> core should know about but doesn't.

The way that the aggregation of these properties works there's no
problems doing it in stages. But it comes with code duplication and
the need of the various rdevs to share common state.

Regards,
Bjorn
