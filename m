From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 25 Apr 2011 13:26:24 -0500
Subject: Common clock and dvfs
In-Reply-To: <alpine.DEB.2.00.1104250211000.6742@utopia.booyaka.com>
References: <BANLkTimVXbp1pFsGPcs-RPY+PTOF6ZRyoQ@mail.gmail.com>
	<alpine.DEB.2.00.1104250211000.6742@utopia.booyaka.com>
Message-ID: <BANLkTikM6N=JvNgB=KrV9bj=7+YQSZg+tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2011 at 3:33 AM, Paul Walmsley <paul@pwsan.com> wrote:
> (cc Tony, Beno?t)
>
> Hi,
>
> By way of brief introduction, I'm currently the maintainer of the OMAP
> clock code and data, as well as some other low-level OMAP kernel pieces.
>
> On Fri, 22 Apr 2011, Colin Cross wrote:
>
>> The Tegra way is to put everything dvfs related under the clock
>> framework. ?Enabling (or preparing, in the new clock world) or raising
>> the frequency calls dvfs_set_rate before touching the clock, which
>> looks up the required voltage on a voltage rail, aggregates it with
>> the other voltage requests, and passes the minimum voltage required to
>> the regulator api. ?Disabling or unpreparing, or lowering the
>> frequency changes the clock first, and then calls dvfs_set_rate. ?For
>> a generic implementation, an SoC would provide the clock/dvfs
>> framework with a list of clocks, the voltages required for each
>> frequency step on the clock, and the regulator name to change. ?The
>> frequency/voltage tables are similar to OPP, except that OPP gets
>> voltages for a device instead of a clock. ?In a few odd cases (Tegra
>> always has a few odd cases), a clock that is internal to a device and
>> not exposed to the clock framework (pclk output on the display, for
>> example) has a voltage requirement, which requires some devices to
>> manually call dvfs_set_rate directly, but with a common clock
>> framework it would probably be possible for the display driver to
>> export pclk as a real clock.
>>
>> The proposed OMAP4 way (I believe, correct me if I am wrong) is to
>> create a new api outside the clock api that calls into both the clock
>> api and the regulator api in the correct order for each operation,
>> using OPP to determine the voltage.
>
> Some people may have proposed this approach, but that's definitely not my
> perspective. ?I don't think it's a good design, and have so far declined
> to merge any DVFS code that doesn't use clk_set_rate() as its interface
> (from the device driver's perspective), at least until the proponents of
> the separate-API camp can explain why it's needed.
>
>> This has a few disadvantages (obviously, I am biased, having written
>> the Tegra code) - clocks and voltages are tied to a device, which is not
>> always the case for platforms outside of OMAP,
>
> It's not the case for OMAP either.
>
>> and drivers must know if their hardware requires voltage scaling. ?The
>> clock api becomes unsafe to use on any device that requires dvfs, as it
>> could change the frequency higher than the supported voltage.
>>
>> Is the clock api the right place to do dvfs, or should the clock api
>> be kept simple, and more complicated operations like dvfs be kept
>> outside?
>
> My personal opinion is that the clock framework is the right place for
> this, since it's a defined interface that is already exposed to drivers.

I'm concerned that the clock framework will grow far larger than any
of us expect it to right now.  We need to consider the intersection
points between a basic clock framework API, some constraints framework
that manages multiple "users" of the clock that have frequency
requirements (probably specified in a higher level "throughput-style"
constraint) as well as the child-parent "arbitration" issues that some
in this thread have referenced already.

> However, since the current clock interface doesn't anticipate that some
> code (e.g. CPUFreq) may need to change a clock's rate while some other
> code (e.g. a device driver) is currently using that clock, the clock
> interface will need to be expanded somewhat to handle this safely. ?Clock
> notifiers are needed, plus the ability for clock users to indicate when it
> is safe for an in-use clock's rate/parent to change.

Agreed.  If there are multiple users of a clock that are using a
higher-level abstraction to manage rates then some other driver
shouldn't be able to blindly change the clock rate with clk_set_rate()
without notifying/handling the other users first.  CPUfreq is one
example of a clock management API co-existing with clock framework
(and certainly making use of the clock fwk under the hood).  But also
a constraint framework that exports some throughput request will also
want to use the clock framework.  Problem here is that now there are
two different levels of APIs that are trying to achieve the same thing
and arbitration must occur (clk fwk VS constraints API VS CPUfreq VS
whatever).  Sounds messy.  Maybe everyone (drivers) can just use the
single higher level API that sits on top of the simple clock
framework?  Easier to arbitrate these requests within a single API
level than across API layers.

There is also talk of propagating rates along the tree and arbitrating
intelligently when some bad issue crops up.  Take the following
example:
    device A wants its clock X to run faster.  clock X has a divisor
of 1, so to go faster its parent clock P must run faster.
    device B has a fixed-divisor clock Y which is also parented by P.
Due to some limitation (external SD card is crappy and can't handle
fast rates) it is invalid for clock Y to run faster than it is already
running even though the hardware supports it.

In this case device A's request could use the pre-change clock
notifiers that Paul mentions and return some -ECRAP preventing the
transition.  This is probably easy enough to do in the clock framework
since only two levels of clocks are involved.  However imagine a PLL
driving a 192MHz clock that drives 3 child clocks: 96MHz, 48MHz and
12MHz clock respectively.  Now each of these last 3 clocks get divided
into module-specific functional clocks with unique dividers and in
some cases some final dividers are present which are internal to the
device which may not even by represented in the clock tree (though
they probably could be represented).

If an arbitration issue happens at the very bottom of this tree (per
the simple example above) then there are at least 4 levels of clocks
to go through while trying to find a valid combination.  The simplest
solution when a problem gets hit is to throw -ECRAP.  However the most
optimal solution would require that drivers specify "most-desired"
rates along with "rates that I can live with" and the tree gets walked
until either the first valid combo is found or no valid combo is found
and the request is rejected with -ECRAP.

This is similar to a classic travelling salesman problem for our clock
tree, but is it something we want inside the clock framework?  Perhaps
the list of "most-desired" rates and "rates I can live with" and
"rates that the HW supports but are invalid for me right now due to
constraints" should not be tracked in the clock framework but
somewhere higher up.

No solutions to this problem for now, but food for thought before
making a long-term decision.  Maybe the parent-child rate change
arbitration is over-engineered or too generic for practical use.  Let
me know what you think.

Regards,
Mike

> I'd been planning to post patches for that stuff for 2.6.40 until all of
> the recent drama started. ?I guess I should post them anyway...
>
>
> - Paul
