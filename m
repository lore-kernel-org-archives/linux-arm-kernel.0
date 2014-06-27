From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 27 Jun 2014 11:53:45 +0100
Subject: [PATCH v5 1/8] Documentation: arm: define DT idle states bindings
In-Reply-To: <20140625145849.GC15240@leverpostej>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20140625145849.GC15240@leverpostej>
Message-ID: <20140627105345.GA3626@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 03:58:49PM +0100, Mark Rutland wrote:

[...]

> > +===========================================
> > +4 - state node
> > +===========================================
> > +
> > +A state node represents an idle state description and must be defined as
> > +follows:
> > +
> > +- state node
> > +
> > +       Description: must be child of the idle-states node
> > +
> > +       The state node name shall follow standard device tree naming
> > +       rules ([5], 2.2.1 "Node names"), in particular state nodes which
> > +       are siblings within a single common parent must be given a unique name.
> > +
> > +       The idle state entered by executing the wfi instruction (idle_standby
> > +       SBSA,[3][4]) is considered standard on all ARM platforms and therefore
> > +       must not be listed.
> > +
> > +       With the definitions provided above, the following list represents
> > +       the valid properties for a state node:
> > +
> > +       - compatible
> > +               Usage: Required
> > +               Value type: <stringlist>
> > +               Definition: Must be "arm,idle-state".
> > +
> > +       - logic-state-retained
> > +               Usage: See definition
> > +               Value type: <none>
> > +               Definition: if present logic is retained on state entry,
> > +                           otherwise it is lost.
> 
> What logic state is retained? All system registers?
> 
> > +       - cache-state-retained
> > +               Usage: See definition
> > +               Value type: <none>
> > +               Definition: if present cache memory is retained on state entry,
> > +                           otherwise it is lost.
> 
> Likewise, how much of the cache hierarchy is affected? Any of it? All of
> it?
> 
> > +       - timer-state-retained
> > +               Usage: See definition
> > +               Value type: <none>
> > +               Definition: if present the timer control logic is retained on
> > +                            state entry, otherwise it is lost.
> 
> The architected generic timers? Any CPU-local timers? Or any timers
> whatsoever?

Ok, as I mentioned this timer property is a blocking point for the
entire set. I gave it more thought, and it is a very hard nut to crack,
even if we resort to power domains (tick devices do not even contain
struct device or device node pointers, even if I added a list of
phandles to timers that are lost on idle state entry I would not be able
to figure out if the tick device is lost on idle state entry).

I am reasoning in kernel terms, I know it is bad but I can't help it
in this case.

Would a boolean property like the following one be deemed acceptable, eg:

- local-timer-stop

I want to be 100% honest here, this might turn out a Linux specific
thing, or might be not, but I still think it is representative of how HW
works.

Comments welcome and would be very appreciated on this specific detail.

Thanks,
Lorenzo
