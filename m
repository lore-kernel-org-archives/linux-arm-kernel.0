From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 12 Apr 2013 17:59:44 +0100
Subject: [RFC PATCH 01/11] Documentation: DT: arm: define CPU topology
 bindings
In-Reply-To: <20130412143644.GB2992@linaro.org>
References: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
 <1365671562-2403-2-git-send-email-mark.rutland@arm.com>
 <5166D01F.5070404@gmail.com>
 <20130411155054.GA29509@e102568-lin.cambridge.arm.com>
 <20130411180125.GB2239@linaro.org>
 <20130412114457.GC6637@e102568-lin.cambridge.arm.com>
 <20130412143644.GB2992@linaro.org>
Message-ID: <20130412165944.GA8778@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 03:36:44PM +0100, Dave Martin wrote:

[...]

> > > > > According to the ePAPR, threads are represented by an array of ids for
> > > > > reg property, not another cpu node. Why the deviation.
> > > >
> > > > It is not a cpu node, it is a phandle property named cpu. Can you point
> > > > me to the ePAPR section where threads bindings are described please ? I have
> > > > not managed to find these details, I am reading version 1.0.
> > >
> > > For cpu/reg:
> > >
> > > [1]     If a CPU supports more than one thread (i.e. multiple streams of
> > >         execution) the reg property is an array with 1 element per
> > >         thread. The #address-cells on the /cpus node specifies how many
> > >         cells each element of the array takes. Software can determine
> > >         the number of threads by dividing the size of reg by the parent
> > >         node's #address-cells.
> > >
> > > I had not previously been aware of this, but I see no reason not to
> > > follow this convention.
> >
> > I don't see a reason either, but this changes the current cpu node bindings
> > for ARM. On the upside there are no SMT ARM platforms out there, so no
> > backward compatibility to worry about.
> 
> Actually, I've had second thoughts about this, from discussion with Mark
> et al.
> 
> The extent to which threads share stuff is not really architecturally
> visible on ARM.  It will be visible in performance terms (i.e., scheduling
> two threads of the same process on threads of on CPU will give better
> performance than scheduling threads of different processes), but in
> architectural terms still look like fully-fledged, independent CPUs.
> 
> I don't know enough about how SMT scheduling currently works in the
> kernel to know how best to describe this situation to the kernel...
> 
> 
> Anyway, for the ARM case, there is not much architectural difference
> between threads within a CPU, and CPUs in a cluster.  At both topological
> levels the siblings are independent.  At both levels, there is an advantage
> in scheduling related threads topologically close to each other -- though
> probably more so for threads in a CPU than CPUs in a cluster.
> 
> Also, threads are independent interrupt destinations.  If we want to
> put flat lists of SMT threads inside CPU nodes, then we need an
> extra means of describing interrupt affinities, different from the
> way this is described for CPUs and clusters.  This is definitely
> complexity.  I'm not sure if there is a related benefit.

Yes, I agree, I think the bindings we came up with are neater than
having threads as multiple reg properties in cpu nodes and adding cluster
nodes (within cpus node or elsewhere). On the interrupt affinity side I think
that it should still be feasible since cpu nodes would become containers
of threads, and cluster nodes containers (or pointed at by) of cpu nodes, but
it is true that the description won't be uniform anymore.

I prefer our solution :-)

> > This would reduce the topology problem to where cluster nodes should be
> > defined, either in the cpus node or a separate node (ie cpu-map :-)).
> >
> > > Also:
> > > [2]     If other more complex CPU topographies are designed, the binding
> > >         for the CPU must describe the topography
> > >
> > >
> > > That's rather less helpful, but the suggestion is clear enough in that
> > > such information should be in the cpu node and specific to that CPU's
> > > binding.  For ARM, we can have some global extensions to the CPU node.
> > >
> > > The problems start when you want to refer to clusters and groups of
> > > CPUs from other nodes.  Only individual cpu nodes can be places in
> > > the cpus node, so there is no node for a phandle to point at.
> > >
> > > If you want to describe how other things like power, clock and
> > > coherency domains map to clusters and larger entities, things could
> > > get pretty awkward.
> > >
> > > Keeping the topology description separate allows all topological entities
> > > to appear as addressable entities in the DT; otherwise, a cryptic
> > > convention is needed.
> > >
> > >
> > > Hybrid approaches might be possible, putting cpu nodes into /cpus, and
> > > giving them a "parent" property where appropriate pointing at the
> > > relevant cluster node, which we put elsewhere in the DT.
> >
> > That's what I did, with a couple of twists:
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/080873.html
> >
> > I have no preference, time to make a decision though.
> 
> With the arguments above, I'm not sure this is really better than the
> current proposal...
>

I am not sure either, that's why I would like to hear other opinions as well.

> > > I'm not sure whether any of these approaches is an awful lot less ugly
> > > or more easy to handle than what it currently proposed though.
> >
> > +1
> >
> > > The global binding for all ARM CPUs would specify that the topology
> > > is described by /cpu-map and its associated binding.  For my
> > > interpretation of [2], this is a compliant approach.  ePAPR does not
> > > specify _how_ the cpu node binding achieves a description of the
> > > topography, just that it must achieve it.  There's no statement to
> > > say that it must not involve other nodes or bindings.

I agree with you, the SMT thread specification in the ePAPR would become
a bit confusing though for ARM, we must make sure that what we are doing
and the ePAPR spec evolve in concert otherwise this will become unmanageable
in the long run.

> > Again, I think it all boils down to deciding where cluster nodes should
> > live.
> 
> If we want to be able to describe affinities and other hardware linkages,
> describing the real hardware units as nodes still feels "right".
> ePAPR doesn't insist upon how this is done, so we do have choice.
> 
> The older/hybrid proposals seem to require different means of describing
> linkage depending on whether the target is a topological leaf or not.
> 
> I guess the question should be "what advantage is gained from describing
> this stuff in the cpus node?"

We do not need phandles (pointers to cpu nodes) to describe the topology,
I guess, is the only answer.
Backward compatibility is still my main worry as far as the ePAPR is
concerned, so I am still looking forward to getting feedback from powerPC
and DT people on our proposal.

Thanks a lot,
Lorenzo
