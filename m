From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 12 Apr 2013 15:36:44 +0100
Subject: [RFC PATCH 01/11] Documentation: DT: arm: define CPU topology
 bindings
In-Reply-To: <20130412114457.GC6637@e102568-lin.cambridge.arm.com>
References: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
 <1365671562-2403-2-git-send-email-mark.rutland@arm.com>
 <5166D01F.5070404@gmail.com>
 <20130411155054.GA29509@e102568-lin.cambridge.arm.com>
 <20130411180125.GB2239@linaro.org>
 <20130412114457.GC6637@e102568-lin.cambridge.arm.com>
Message-ID: <20130412143644.GB2992@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 12:44:58PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Apr 11, 2013 at 07:01:25PM +0100, Dave Martin wrote:
> 
> [...]
> 
> > > > > +===========================================
> > > > > +2 - cpu-map node
> > > > > +===========================================
> > > > > +
> > > > > +The ARM CPU topology is defined within a container node, sitting at the top
> > > > > +level of the device tree (/), the cpu-map node.
> > > > > +
> > > > > +- cpu-map node
> > > > > +
> > > > > + Usage: Required to define ARM CPU topology
> > > > > +
> > > > > + Description: The cpu-map node is just a container node where its
> > > > > +              subnodes describe the CPU topology
> > > > > +
> > > > > + Node name must be "cpu-map".
> > > > > +
> > > > > + A cpu-map node's child nodes can be:
> > > > > +
> > > > > + - one or more cluster nodes
> > > > > +
> > > > > + Any other configuration is considered invalid.
> > > > > +
> > > > > +The cpu-map node can only contain three types of child nodes:
> > > > > +
> > > > > +- cluster node
> > > > > +- core node
> > > > > +- thread node
> > > > > +
> > > >
> > > > Why not put the topology in the /cpus nodes? I don't really see the
> > > > point of having a flat list of cpus and separate topology info. There is
> > > > some compatibility issue, but adding optional levels for clusters can be
> > > > handled.
> > >
> > > I thought this would break all code relying on /cpu nodes being /cpus node's
> > > children. Furthermore, I was told that the /cpus node can only have /cpu nodes
> > > as children.
> > >
> > > If you wish so, we can define the topology in the /cpus node, fine by me.
> > 
> > Can we make such extensive changes to the cpus node without violating
> > the ePAPR specification?
> > 
> > If we can, great, but I'm a but unclear on how this would be achieved.
> 
> +1
> 
> > > > > +whose bindings are described in paragraph 3.
> > > > > +
> > > > > +The nodes describing the CPU topology (cluster/core/thread) can only be
> > > > > +defined within the cpu-map node.
> > > > > +Any other configuration is consider invalid and therefore must be ignored.
> > > > > +
> > > > > +===========================================
> > > > > +2.1 - cpu-map child nodes naming convention
> > > > > +===========================================
> > > > > +
> > > > > +cpu-map child nodes must follow a naming convention where the node name
> > > > > +must be "clusterN", "coreN", "threadN" depending on the node type (ie
> > > > > +cluster/core/thread) (where N = {0, 1, ...} is the node number; nodes which
> > > > > +are siblings within a single common parent node must be given a unique and
> > > > > +sequential N value, starting from 0).
> > > > > +cpu-map child nodes which do not share a common parent node can have the same
> > > > > +name (ie same number N as other cpu-map child nodes at different device tree
> > > > > +levels) since name uniqueness will be guaranteed by the device tree hierarchy.
> > > > > +
> > > > > +===========================================
> > > > > +3 - cluster/core/thread node bindings
> > > > > +===========================================
> > > > > +
> > > > > +Bindings for cluster/cpu/thread nodes are defined as follows:
> > > > > +
> > > > > +- cluster node
> > > > > +
> > > > > +  Description: must be declared within a cpu-map node, one node
> > > > > +               per cluster. A system can contain several layers of
> > > > > +               clustering and cluster nodes can be contained in parent
> > > > > +               cluster nodes.
> > > > > +
> > > > > + The cluster node name must be "clusterN" as described in 2.1 above.
> > > > > + A cluster node can not be a leaf node.
> > > >
> > > > Follow standard conventions with "cluster at N" and a reg property with the
> > > > number.
> > >
> > > We are defining the topology to decouple the cluster/core/thread concept
> > > from the MPIDR. Having a reg property in the cluster (and core) nodes
> > > would complicate things if that reg property must correspond to an MPIDR
> > > bitfield. If it is meant to be just an enumeration at a given device tree
> > > level, I am ok with changing that.
> > 
> > As a pure enumeration, I think that works fine.  It's more verbose
> > but also more conformant to DT conventions.  I'm not sure there's
> > another difference.
> > 
> > The proposed support for C preprocessing of dts files might provide a
> > way to help debloat this to some extent in dts source, while still
> > following the DT convention of using unit addresses and reg properties.
> > This will significantly increase the size of the FDT blob if the
> > number of CPUs is large.  I don't remember offhand if we have a limit
> > on the size of FDT we can cope with.  Finding ways to relax the limit
> > is a better solution than dodging round standards, though.  We can
> > cross that bridge when/if we come to it.
> 
> Well, that's a problem by itself, certainly adding a reg property to
> the cluster nodes will make it worse, but as you said still better that
> than dodging standards.
> 
> > >
> > > > > +
> > > > > + A cluster node's child nodes must be:
> > > > > +
> > > > > + - one or more cluster nodes; or
> > > > > + - one or more core nodes
> > > > > +
> > > > > + Any other configuration is considered invalid.
> > > > > +
> > > > > +- core node
> > > > > +
> > > > > + Description: must be declared in a cluster node, one node per core in
> > > > > +              the cluster. If the system does not support SMT, core
> > > > > +              nodes are leaf nodes, otherwise they become containers of
> > > > > +              thread nodes.
> > > > > +
> > > > > + The core node name must be "coreN" as described in 2.1 above.
> > > > > +
> > > > > + A core node must be a leaf node if SMT is not supported.
> > > > > +
> > > > > + Properties for core nodes that are leaf nodes:
> > > > > +
> > > > > + - cpu
> > > > > +         Usage: required
> > > > > +         Value type: <phandle>
> > > > > +         Definition: a phandle to the cpu node that corresponds to the
> > > > > +                     core node.
> > > > > +
> > > > > + If a core node is not a leaf node (CPUs supporting SMT) a core node's
> > > > > + child nodes can be:
> > > > > +
> > > > > + - one or more thread nodes
> > > > > +
> > > > > + Any other configuration is considered invalid.
> > > > > +
> > > > > +- thread node
> > > > > +
> > > > > + Description: must be declared in a core node, one node per thread
> > > > > +              in the core if the system supports SMT. Thread nodes are
> > > > > +              always leaf nodes in the device tree.
> > > > > +
> > > > > + The thread node name must be "threadN" as described in 2.1 above.
> > > > > +
> > > > > + A thread node must be a leaf node.
> > > > > +
> > > > > + A thread node must contain the following property:
> > > > > +
> > > > > + - cpu
> > > > > +         Usage: required
> > > > > +         Value type: <phandle>
> > > > > +         Definition: a phandle to the cpu node that corresponds to
> > > > > +                     the thread node.
> > > >
> > > >
> > > > According to the ePAPR, threads are represented by an array of ids for
> > > > reg property, not another cpu node. Why the deviation.
> > >
> > > It is not a cpu node, it is a phandle property named cpu. Can you point
> > > me to the ePAPR section where threads bindings are described please ? I have
> > > not managed to find these details, I am reading version 1.0.
> > 
> > For cpu/reg:
> > 
> > [1]     If a CPU supports more than one thread (i.e. multiple streams of
> >         execution) the reg property is an array with 1 element per
> >         thread. The #address-cells on the /cpus node specifies how many
> >         cells each element of the array takes. Software can determine
> >         the number of threads by dividing the size of reg by the parent
> >         node's #address-cells.
> > 
> > I had not previously been aware of this, but I see no reason not to
> > follow this convention.
> 
> I don't see a reason either, but this changes the current cpu node bindings
> for ARM. On the upside there are no SMT ARM platforms out there, so no
> backward compatibility to worry about.

Actually, I've had second thoughts about this, from discussion with Mark
et al.

The extent to which threads share stuff is not really architecturally
visible on ARM.  It will be visible in performance terms (i.e., scheduling
two threads of the same process on threads of on CPU will give better
performance than scheduling threads of different processes), but in
architectural terms still look like fully-fledged, independent CPUs.

I don't know enough about how SMT scheduling currently works in the
kernel to know how best to describe this situation to the kernel...


Anyway, for the ARM case, there is not much architectural difference
between threads within a CPU, and CPUs in a cluster.  At both topological
levels the siblings are independent.  At both levels, there is an advantage
in scheduling related threads topologically close to each other -- though
probably more so for threads in a CPU than CPUs in a cluster.

Also, threads are independent interrupt destinations.  If we want to
put flat lists of SMT threads inside CPU nodes, then we need an
extra means of describing interrupt affinities, different from the
way this is described for CPUs and clusters.  This is definitely
complexity.  I'm not sure if there is a related benefit.


> This would reduce the topology problem to where cluster nodes should be
> defined, either in the cpus node or a separate node (ie cpu-map :-)).
> 
> > Also:
> > [2]     If other more complex CPU topographies are designed, the binding
> >         for the CPU must describe the topography
> > 
> > 
> > That's rather less helpful, but the suggestion is clear enough in that
> > such information should be in the cpu node and specific to that CPU's
> > binding.  For ARM, we can have some global extensions to the CPU node.
> > 
> > The problems start when you want to refer to clusters and groups of
> > CPUs from other nodes.  Only individual cpu nodes can be places in
> > the cpus node, so there is no node for a phandle to point at.
> > 
> > If you want to describe how other things like power, clock and
> > coherency domains map to clusters and larger entities, things could
> > get pretty awkward.
> > 
> > Keeping the topology description separate allows all topological entities
> > to appear as addressable entities in the DT; otherwise, a cryptic
> > convention is needed.
> > 
> > 
> > Hybrid approaches might be possible, putting cpu nodes into /cpus, and
> > giving them a "parent" property where appropriate pointing at the
> > relevant cluster node, which we put elsewhere in the DT.
> 
> That's what I did, with a couple of twists:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/080873.html
> 
> I have no preference, time to make a decision though.

With the arguments above, I'm not sure this is really better than the
current proposal...

> 
> > I'm not sure whether any of these approaches is an awful lot less ugly
> > or more easy to handle than what it currently proposed though.
> 
> +1
> 
> > The global binding for all ARM CPUs would specify that the topology
> > is described by /cpu-map and its associated binding.  For my
> > interpretation of [2], this is a compliant approach.  ePAPR does not
> > specify _how_ the cpu node binding achieves a description of the
> > topography, just that it must achieve it.  There's no statement to
> > say that it must not involve other nodes or bindings.
> 
> Again, I think it all boils down to deciding where cluster nodes should
> live.

If we want to be able to describe affinities and other hardware linkages,
describing the real hardware units as nodes still feels "right".
ePAPR doesn't insist upon how this is done, so we do have choice.

The older/hybrid proposals seem to require different means of describing
linkage depending on whether the target is a topological leaf or not.

I guess the question should be "what advantage is gained from describing
this stuff in the cpus node?"

Cheers
---Dave
