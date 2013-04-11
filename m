From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 11 Apr 2013 19:01:25 +0100
Subject: [RFC PATCH 01/11] Documentation: DT: arm: define CPU topology
 bindings
In-Reply-To: <20130411155054.GA29509@e102568-lin.cambridge.arm.com>
References: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
 <1365671562-2403-2-git-send-email-mark.rutland@arm.com>
 <5166D01F.5070404@gmail.com>
 <20130411155054.GA29509@e102568-lin.cambridge.arm.com>
Message-ID: <20130411180125.GB2239@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 04:50:54PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Apr 11, 2013 at 04:00:47PM +0100, Rob Herring wrote:
> > On 04/11/2013 04:12 AM, Mark Rutland wrote:
> > > From: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> > > 
> > > The advent of multi-cluster ARM systems requires a mechanism to describe
> > > how in hierarchical terms CPUs are connected in ARM SoCs so that the kernel
> > > can initialize and map resources like IRQs and memory space to specific
> > > group(s) of CPUs.
> > > 
> > > The CPU topology is made up of multiple hierarchy levels whose bottom
> > > layers (aka leaf nodes in device tree syntax) contain links to the HW
> > > CPUs in the system.
> > > 
> > > The topology bindings are generic for both 32-bit and 64-bit systems and
> > > lay the groundwork on top of which affinity schemes can be built.
> > > 
> > > This patch provides the documentation in the kernel required to define the
> > > device tree bindings describing the CPU topology for ARM 32-bit and 64-bit
> > > systems.
> > 
> > I'm now very weary of continued /cpu changes after the pain of making
> > the reg property reflect the mpidr value in 3.8.
> 
> We won't change the reg property value, the code I am about to post
> provides stricter bindings, stricter semantics and extends bindings to
> cater for arm 64-bit systems.
> 
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/topology.txt | 524 +++++++++++++++++++++
> > >  1 file changed, 524 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/arm/topology.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/arm/topology.txt
> > > new file mode 100644
> > > index 0000000..07c4961
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/topology.txt
> > > @@ -0,0 +1,524 @@
> > > +===========================================
> > > +ARM topology binding description
> > > +===========================================
> > > +
> > > +===========================================
> > > +1 - Introduction
> > > +===========================================
> > > +
> > > +In an ARM system, the hierarchy of CPUs is defined through three entities that
> > > +are used to describe the layout of physical CPUs in the system:
> > > +
> > > +- cluster
> > > +- core
> > > +- thread
> > > +
> > > +The cpu nodes (bindings defined in [1]) represent the devices that
> > > +correspond to physical CPUs and are to be mapped to the hierarchy levels.
> > > +
> > > +The bottom hierarchy level sits at core or thread level depending on whether
> > > +symmetric multi-threading (SMT) is supported or not.
> > > +
> > > +For instance in a system where CPUs support SMT, "cpu" nodes represent all
> > > +threads existing in the system and map to the hierarchy level "thread" above.
> > > +In systems where SMT is not supported "cpu" nodes represent all cores present
> > > +in the system and map to the hierarchy level "core" above.
> > > +
> > > +ARM topology bindings allow one to associate cpu nodes with hierarchical groups
> > > +corresponding to the system hierarchy; syntactically they are defined as device
> > > +tree nodes.
> > > +
> > > +The remainder of this document provides the topology bindings for ARM, based
> > > +on the ePAPR standard, available from:
> > > +
> > > +http://devicetree.org
> > > +
> > > +If not stated otherwise, whenever a reference to a cpu node phandle is made its
> > > +value must point to a cpu node compliant with the cpu node bindings as
> > > +documented in [1].
> > > +A topology description containing phandles to cpu nodes that are not compliant
> > > +with bindings standardized in [1] is therefore considered invalid.
> > > +
> > > +===========================================
> > > +2 - cpu-map node
> > > +===========================================
> > > +
> > > +The ARM CPU topology is defined within a container node, sitting at the top
> > > +level of the device tree (/), the cpu-map node.
> > > +
> > > +- cpu-map node
> > > +
> > > +	Usage: Required to define ARM CPU topology
> > > +
> > > +	Description: The cpu-map node is just a container node where its
> > > +		     subnodes describe the CPU topology
> > > +
> > > +	Node name must be "cpu-map".
> > > +
> > > +	A cpu-map node's child nodes can be:
> > > +
> > > +	- one or more cluster nodes
> > > +
> > > +	Any other configuration is considered invalid.
> > > +
> > > +The cpu-map node can only contain three types of child nodes:
> > > +
> > > +- cluster node
> > > +- core node
> > > +- thread node
> > > +
> > 
> > Why not put the topology in the /cpus nodes? I don't really see the
> > point of having a flat list of cpus and separate topology info. There is
> > some compatibility issue, but adding optional levels for clusters can be
> > handled.
> 
> I thought this would break all code relying on /cpu nodes being /cpus node's
> children. Furthermore, I was told that the /cpus node can only have /cpu nodes
> as children.
> 
> If you wish so, we can define the topology in the /cpus node, fine by me.

Can we make such extensive changes to the cpus node without violating
the ePAPR specification?

If we can, great, but I'm a but unclear on how this would be achieved.

> > > +whose bindings are described in paragraph 3.
> > > +
> > > +The nodes describing the CPU topology (cluster/core/thread) can only be
> > > +defined within the cpu-map node.
> > > +Any other configuration is consider invalid and therefore must be ignored.
> > > +
> > > +===========================================
> > > +2.1 - cpu-map child nodes naming convention
> > > +===========================================
> > > +
> > > +cpu-map child nodes must follow a naming convention where the node name
> > > +must be "clusterN", "coreN", "threadN" depending on the node type (ie
> > > +cluster/core/thread) (where N = {0, 1, ...} is the node number; nodes which
> > > +are siblings within a single common parent node must be given a unique and
> > > +sequential N value, starting from 0).
> > > +cpu-map child nodes which do not share a common parent node can have the same
> > > +name (ie same number N as other cpu-map child nodes at different device tree
> > > +levels) since name uniqueness will be guaranteed by the device tree hierarchy.
> > > +
> > > +===========================================
> > > +3 - cluster/core/thread node bindings
> > > +===========================================
> > > +
> > > +Bindings for cluster/cpu/thread nodes are defined as follows:
> > > +
> > > +- cluster node
> > > +
> > > +	 Description: must be declared within a cpu-map node, one node
> > > +		      per cluster. A system can contain several layers of
> > > +		      clustering and cluster nodes can be contained in parent
> > > +		      cluster nodes.
> > > +
> > > +	The cluster node name must be "clusterN" as described in 2.1 above.
> > > +	A cluster node can not be a leaf node.
> > 
> > Follow standard conventions with "cluster at N" and a reg property with the
> > number.
> 
> We are defining the topology to decouple the cluster/core/thread concept
> from the MPIDR. Having a reg property in the cluster (and core) nodes
> would complicate things if that reg property must correspond to an MPIDR
> bitfield. If it is meant to be just an enumeration at a given device tree
> level, I am ok with changing that.

As a pure enumeration, I think that works fine.  It's more verbose
but also more conformant to DT conventions.  I'm not sure there's
another difference.

The proposed support for C preprocessing of dts files might provide a
way to help debloat this to some extent in dts source, while still
following the DT convention of using unit addresses and reg properties.
This will significantly increase the size of the FDT blob if the 
number of CPUs is large.  I don't remember offhand if we have a limit
on the size of FDT we can cope with.  Finding ways to relax the limit
is a better solution than dodging round standards, though.  We can
cross that bridge when/if we come to it.

> 
> > > +
> > > +	A cluster node's child nodes must be:
> > > +
> > > +	- one or more cluster nodes; or
> > > +	- one or more core nodes
> > > +
> > > +	Any other configuration is considered invalid.
> > > +
> > > +- core node
> > > +
> > > +	Description: must be declared in a cluster node, one node per core in
> > > +		     the cluster. If the system does not support SMT, core
> > > +		     nodes are leaf nodes, otherwise they become containers of
> > > +		     thread nodes.
> > > +
> > > +	The core node name must be "coreN" as described in 2.1 above.
> > > +
> > > +	A core node must be a leaf node if SMT is not supported.
> > > +
> > > +	Properties for core nodes that are leaf nodes:
> > > +
> > > +	- cpu
> > > +		Usage: required
> > > +		Value type: <phandle>
> > > +		Definition: a phandle to the cpu node that corresponds to the
> > > +			    core node.
> > > +
> > > +	If a core node is not a leaf node (CPUs supporting SMT) a core node's
> > > +	child nodes can be:
> > > +
> > > +	- one or more thread nodes
> > > +
> > > +	Any other configuration is considered invalid.
> > > +
> > > +- thread node
> > > +
> > > +	Description: must be declared in a core node, one node per thread
> > > +		     in the core if the system supports SMT. Thread nodes are
> > > +		     always leaf nodes in the device tree.
> > > +
> > > +	The thread node name must be "threadN" as described in 2.1 above.
> > > +
> > > +	A thread node must be a leaf node.
> > > +
> > > +	A thread node must contain the following property:
> > > +
> > > +	- cpu
> > > +		Usage: required
> > > +		Value type: <phandle>
> > > +		Definition: a phandle to the cpu node that corresponds to
> > > +			    the thread node.
> > 
> > 
> > According to the ePAPR, threads are represented by an array of ids for
> > reg property, not another cpu node. Why the deviation.
> 
> It is not a cpu node, it is a phandle property named cpu. Can you point
> me to the ePAPR section where threads bindings are described please ? I have
> not managed to find these details, I am reading version 1.0.

For cpu/reg:

[1]     If a CPU supports more than one thread (i.e. multiple streams of
        execution) the reg property is an array with 1 element per
        thread. The #address-cells on the /cpus node specifies how many
        cells each element of the array takes. Software can determine
        the number of threads by dividing the size of reg by the parent
        node's #address-cells.

I had not previously been aware of this, but I see no reason not to
follow this convention.


Also:
[2]     If other more complex CPU topographies are designed, the binding
        for the CPU must describe the topography


That's rather less helpful, but the suggestion is clear enough in that
such information should be in the cpu node and specific to that CPU's
binding.  For ARM, we can have some global extensions to the CPU node.

The problems start when you want to refer to clusters and groups of
CPUs from other nodes.  Only individual cpu nodes can be places in
the cpus node, so there is no node for a phandle to point at.

If you want to describe how other things like power, clock and
coherency domains map to clusters and larger entities, things could
get pretty awkward.

Keeping the topology description separate allows all topological entities
to appear as addressable entities in the DT; otherwise, a cryptic
convention is needed.


Hybrid approaches might be possible, putting cpu nodes into /cpus, and
giving them a "parent" property where appropriate pointing at the
relevant cluster node, which we put elsewhere in the DT.

I'm not sure whether any of these approaches is an awful lot less ugly
or more easy to handle than what it currently proposed though.

The global binding for all ARM CPUs would specify that the topology
is described by /cpu-map and its associated binding.  For my
interpretation of [2], this is a compliant approach.  ePAPR does not
specify _how_ the cpu node binding achieves a description of the
topography, just that it must achieve it.  There's no statement to
say that it must not involve other nodes or bindings.

Cheers
---Dave
