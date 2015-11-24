From: juri.lelli@arm.com (Juri Lelli)
Date: Tue, 24 Nov 2015 10:54:23 +0000
Subject: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
In-Reply-To: <20151124020631.GA15165@rob-hp-laptop>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-3-git-send-email-juri.lelli@arm.com>
 <20151124020631.GA15165@rob-hp-laptop>
Message-ID: <20151124105423.GM26372@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23/11/15 20:06, Rob Herring wrote:
> On Mon, Nov 23, 2015 at 02:28:35PM +0000, Juri Lelli wrote:
> > ARM systems may be configured to have cpus with different power/performance
> > characteristics within the same chip. In this case, additional information
> > has to be made available to the kernel (the scheduler in particular) for it
> > to be aware of such differences and take decisions accordingly.
> > 
> > Therefore, this patch aims at standardizing cpu capacities device tree
> > bindings for ARM platforms. Bindings define cpu capacity parameter, to
> > allow operating systems to retrieve such information from the device tree
> > and initialize related kernel structures, paving the way for common code in
> > the kernel to deal with heterogeneity.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > Cc: Kumar Gala <galak@codeaurora.org>
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> > ---
> >  .../devicetree/bindings/arm/cpu-capacity.txt       | 227 +++++++++++++++++++++
> >  Documentation/devicetree/bindings/arm/cpus.txt     |  17 ++
> >  2 files changed, 244 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > new file mode 100644
> > index 0000000..2a00af0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > @@ -0,0 +1,227 @@
> > +==========================================
> > +ARM CPUs capacity bindings
> > +==========================================
> > +
> > +==========================================
> > +1 - Introduction
> > +==========================================
> > +
> > +ARM systems may be configured to have cpus with different power/performance
> > +characteristics within the same chip. In this case, additional information
> > +has to be made available to the kernel (the scheduler in particular) for
> > +it to be aware of such differences and take decisions accordingly.
> > +
> > +==========================================
> > +2 - CPU capacity definition
> > +==========================================
> > +
> > +CPU capacity is a number that provides the scheduler information about CPUs
> > +heterogeneity. Such heterogeneity can come from micro-architectural differences
> > +(e.g., ARM big.LITTLE systems) or maximum frequency at which CPUs can run
> > +(e.g., SMP systems with multiple frequency domains). Heterogeneity in this
> > +context is about differing performance characteristics; this binding tries to
> > +capture a first-order approximation of the relative performance of CPUs.
> > +
> > +One simple way to estimate CPU capacities is to iteratively run a well-known
> > +CPU user space benchmark (e.g, sysbench, dhrystone, etc.) on each CPU at
> > +maximum frequency and then normalize values w.r.t.  the best performing CPU.
> > +One can also do a statistically significant study of a wide collection of
> > +benchmarks, but pros of such an approach are not really evident at the time of
> > +writing.
> > +
> > +==========================================
> > +3 - capacity-scale
> > +==========================================
> > +
> > +CPUs capacities are defined with respect to capacity-scale property in the cpus
> > +node [1]. The property is optional; if not defined a 1024 capacity-scale is
> > +assumed. This property defines both the highest CPU capacity present in the
> > +system and granularity of CPU capacity values.
> 
> I don't really see the point of this vs. having an absolute scale.
> 

IMHO, we need this for several reasons, one being to address one of your
concerns below: vendors are free to choose their scale without being
forced to publish absolute data. Another reason is that it might make
life easier in certain cases; for example, someone could implement a
system with a few clusters of, say, A57s, but some run at half the clock
of the others (e.g., you have a 1.2GHz cluster and a 600MHz cluster); in
this case I think it is just easier to define capacity-scale as 1200 and
capacities as 1200 and 600. Last reason that I can think of right now is
that we don't probably want to bound ourself to some particular range
from the beginning, as that range might be enough now, but it could
change in the future (as in, right now [1-1024] looks fine for
scheduling purposes, but that might change).

> > +
> > +==========================================
> > +4 - capacity
> > +==========================================
> > +
> > +capacity is an optional cpu node [1] property: u32 value representing CPU
> > +capacity, relative to capacity-scale. It is required and enforced that capacity
> > +<= capacity-scale.
> 
> I think you need something absolute and probably per MHz (like 
> dynamic-power-coefficient property). Perhaps the IPC (instructions per 
> clock) value?
> 
> In other words, I want to see these numbers have a defined method 
> of determining them and don't want to see random values from every 
> vendor. ARM, Ltd. says core X has a value of Y would be good enough for 
> me. Vendor X's A57 having a value of 2 and Vendor Y's A57 having a 
> value of 1024 is not what I want to see. Of course things like cache 
> sizes can vary the performance, but is a baseline value good enough? 
> 

A standard reference baseline is what we advocate with this set, but
making this baseline work for every vendor's implementation is hardly
achievable, IMHO. I don't think we can come up with any number that
applies to each and every implementation; you can have different
revisions of the same core and vendors might make implementation choices
that end up with different peak performance. 

> However, no vendor will want to publish their values if these are 
> absolute values relative to other vendors.
> 

Right. That is why I think we need to abstract numbers, as we do with
capacity-scale.

> If you expect these to need frequent tuning, then don't put them in DT.
> 

I expect that it is possible to come up with a sensible baseline number
for a specific platform implementation, so there is value in
standardizing how we specify this value and how it is then consumed.
Finer grained tuning might then happen both offline (with changes to the
mainline DT) and online (using the sysfs interface), but that should
only apply to a narrow set of use cases.

Thanks,

- Juri
