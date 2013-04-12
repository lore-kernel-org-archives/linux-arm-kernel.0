From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 12 Apr 2013 12:16:49 +0100
Subject: [RFC PATCH 01/11] Documentation: DT: arm: define CPU topology
 bindings
In-Reply-To: <5166F908.9050503@gmail.com>
References: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
 <1365671562-2403-2-git-send-email-mark.rutland@arm.com>
 <5166D01F.5070404@gmail.com>
 <20130411155054.GA29509@e102568-lin.cambridge.arm.com>
 <5166F908.9050503@gmail.com>
Message-ID: <20130412111648.GA6637@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 06:55:20PM +0100, Rob Herring wrote:

[...]

> >>> +The cpu-map node can only contain three types of child nodes:
> >>> +
> >>> +- cluster node
> >>> +- core node
> >>> +- thread node
> >>> +
> >>
> >> Why not put the topology in the /cpus nodes? I don't really see the
> >> point of having a flat list of cpus and separate topology info. There is
> >> some compatibility issue, but adding optional levels for clusters can be
> >> handled.
> >
> > I thought this would break all code relying on /cpu nodes being /cpus node's
> > children. Furthermore, I was told that the /cpus node can only have /cpu nodes
> > as children.
> 
> IIRC the context, that was in regards to putting things like the PMUs
> under the /cpus node. Or are you referring to something else? I think
> this situation is a bit different.

No I am referring to:

(a) PowerPC code relying on cpu nodes to be cpus node's children
(b) code that parses the DT cpus/cpu node for ARM that does require cpu
    nodes to be cpus node's children (but that has nothing to do with
    the bindings, code can be changed)

I think that our definition of cpu nodes does not comply with ePAPR 3.7,
since an MPIDR corresponding to an SMT thread cannot be represented with
one CPU node "A cpu node represents a hardware execution block that is
sufficiently independent that it is capable of running an operating
system without interfering with other CPUs possibly running other
operating systems".

This also has consequences on the cpu node bindings I am about to post
since if we go by the definition above a cpu node representing an SMT
core should contain a list of MPIDRs.

> You will have to support existing single cluster systems without the
> hierarchy.

Well yes, that's why we used another (optional) node to define the topology.

> > If you wish so, we can define the topology in the /cpus node, fine by me.
> >
> >>> +whose bindings are described in paragraph 3.
> >>> +
> >>> +The nodes describing the CPU topology (cluster/core/thread) can only be
> >>> +defined within the cpu-map node.
> >>> +Any other configuration is consider invalid and therefore must be ignored.
> >>> +
> >>> +===========================================
> >>> +2.1 - cpu-map child nodes naming convention
> >>> +===========================================
> >>> +
> >>> +cpu-map child nodes must follow a naming convention where the node name
> >>> +must be "clusterN", "coreN", "threadN" depending on the node type (ie
> >>> +cluster/core/thread) (where N = {0, 1, ...} is the node number; nodes which
> >>> +are siblings within a single common parent node must be given a unique and
> >>> +sequential N value, starting from 0).
> >>> +cpu-map child nodes which do not share a common parent node can have the same
> >>> +name (ie same number N as other cpu-map child nodes at different device tree
> >>> +levels) since name uniqueness will be guaranteed by the device tree hierarchy.
> >>> +
> >>> +===========================================
> >>> +3 - cluster/core/thread node bindings
> >>> +===========================================
> >>> +
> >>> +Bindings for cluster/cpu/thread nodes are defined as follows:
> >>> +
> >>> +- cluster node
> >>> +
> >>> +    Description: must be declared within a cpu-map node, one node
> >>> +                 per cluster. A system can contain several layers of
> >>> +                 clustering and cluster nodes can be contained in parent
> >>> +                 cluster nodes.
> >>> +
> >>> +   The cluster node name must be "clusterN" as described in 2.1 above.
> >>> +   A cluster node can not be a leaf node.
> >>
> >> Follow standard conventions with "cluster at N" and a reg property with the
> >> number.
> >
> > We are defining the topology to decouple the cluster/core/thread concept
> > from the MPIDR. Having a reg property in the cluster (and core) nodes
> > would complicate things if that reg property must correspond to an MPIDR
> > bitfield. If it is meant to be just an enumeration at a given device tree
> > level, I am ok with changing that.
> 
> Because the cluster itself doesn't really have an id, I'm fine if its
> not linked to the mpidr. Just don't change that later.

Eh, the cluster does have an id, that depends on the MPIDR du jour.
I will give it more thought.

> >>> +
> >>> +   A cluster node's child nodes must be:
> >>> +
> >>> +   - one or more cluster nodes; or
> >>> +   - one or more core nodes
> >>> +
> >>> +   Any other configuration is considered invalid.
> >>> +
> >>> +- core node
> >>> +
> >>> +   Description: must be declared in a cluster node, one node per core in
> >>> +                the cluster. If the system does not support SMT, core
> >>> +                nodes are leaf nodes, otherwise they become containers of
> >>> +                thread nodes.
> >>> +
> >>> +   The core node name must be "coreN" as described in 2.1 above.
> >>> +
> >>> +   A core node must be a leaf node if SMT is not supported.
> >>> +
> >>> +   Properties for core nodes that are leaf nodes:
> >>> +
> >>> +   - cpu
> >>> +           Usage: required
> >>> +           Value type: <phandle>
> >>> +           Definition: a phandle to the cpu node that corresponds to the
> >>> +                       core node.
> >>> +
> >>> +   If a core node is not a leaf node (CPUs supporting SMT) a core node's
> >>> +   child nodes can be:
> >>> +
> >>> +   - one or more thread nodes
> >>> +
> >>> +   Any other configuration is considered invalid.
> >>> +
> >>> +- thread node
> >>> +
> >>> +   Description: must be declared in a core node, one node per thread
> >>> +                in the core if the system supports SMT. Thread nodes are
> >>> +                always leaf nodes in the device tree.
> >>> +
> >>> +   The thread node name must be "threadN" as described in 2.1 above.
> >>> +
> >>> +   A thread node must be a leaf node.
> >>> +
> >>> +   A thread node must contain the following property:
> >>> +
> >>> +   - cpu
> >>> +           Usage: required
> >>> +           Value type: <phandle>
> >>> +           Definition: a phandle to the cpu node that corresponds to
> >>> +                       the thread node.
> >>
> >>
> >> According to the ePAPR, threads are represented by an array of ids for
> >> reg property, not another cpu node. Why the deviation.
> >
> > It is not a cpu node, it is a phandle property named cpu. Can you point
> > me to the ePAPR section where threads bindings are described please ? I have
> > not managed to find these details, I am reading version 1.0.
> >
> You should get 1.1.
> 
> From the reg prop description:
> 
> If a CPU supports more than one thread (i.e. multiple streams of
> execution) the reg property is an array with 1 element per thread. The
> #address-cells on the /cpus node specifies how many cells each element
> of the array takes. Software can determine the number of threads by
> dividing the size of reg by the parent node's #address-cells.

See above, I need to investigate what this implies.

> If a CPU/thread can be the target of an external interrupt the "reg"
> property value must be a unique CPU/thread id that is addressable by
> the interrupt controller.

I am not sure what "external" means here, but basically it looks like
our DT cpu bindings are non-compliant, the interrupt controller cannot
address a cpu by using an MPIDR (yet).

> If a CPU/thread cannot be the target of an external interrupt, then "reg"
> must be unique and out of bounds of the range addressed by the
> interrupt controller
> If a CPU/thread's PIR is modifiable, a client program should modify
> PIR to match the "reg" property value. If PIR cannot be modified and
> the PIR value is distinct from the interrupt controller numberspace, the
> CPUs binding may define a binding-specific representation of PIR
> values if desired.
> 
> 
> There is also this statement:
> 
> Hardware threads that share an MMU would generally be represented under
> one cpu node. If other
> more complex CPU topographies are designed, the binding for the CPU must
> describe the topography
> (e.g. threads that don't share an MMU).

Again, see above, HW threads do share an MMU so we have to make a
decision here, either we make ARM comply with ePAPR or change the
bindings for ARM.

Lorenzo
