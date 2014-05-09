From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 9 May 2014 11:10:19 -0600
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <20140509141633.GD3921@e103592.cambridge.arm.com>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
 <6774053.rAccqTeoiQ@wuerfel>
 <20140502173120.GD3805@e103592.cambridge.arm.com>
 <20140502181750.GD3179@obsidianresearch.com>
 <20140509141633.GD3921@e103592.cambridge.arm.com>
Message-ID: <20140509171019.GA16780@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 03:16:33PM +0100, Dave Martin wrote:
> On Fri, May 02, 2014 at 12:17:50PM -0600, Jason Gunthorpe wrote:

> > I wonder if this might be a better naming scheme, I actually don't
> > really like 'slave' for this, it really only applies well to AXI style
> > unidirectional busses, and any sort of message-based bus architectures
> > (HT, PCI, QPI, etc) just have the concept of an initiator and target.
> > 
> > Since initiator/target applies equally well to master/slave buses,
> > that seems like better, clearer, naming.
> 
> Sure, I wouldn't have a problem with such a suggestion.  A more neutral
> naming is less likely to cause confusion.
> 
> > Using a nomenclature where
> >   'reg' describes a target reachable from the CPU initiator via the
> >         natural DT hierarchy
> 
> I would say, reachable from the parent device node (which implies your
> statement).  This is consistent with the way ePAPR describes device-to-
> device DMA (even if Linux doesn't usually make a lot of use of that).

Trying to simplify, but yes, that is right..

> >   'initiator' describes a non-CPU (eg 'DMA') source of ops, and
> >         travels via the path described to memory (which is the
> > 	target).
> 
> CPUs are initiators only; non-mastering devices are targets only.
> 
> We might want some terminology to distinguish between mastering 
> devices and bridges, both of which act as initiators and targets.

I was hoping to simplify a bit. What the kernel needs, really, is the
node that initates a transaction, the node that is the ultimate
completing target of that transaction and the path through all
intervening (transformative or not) components.

The fact a bridge is bus-level slave on one side and a bus-level
master on another is not relevant to the above - a bridge is not an
initiator and it is not a completing target.

> We could have a concept of a "forwarder" or "gateway".  But a bus
> may still be a target as well as forwarder: if the bus contains some
> control registers for example.  There is nothing to stop "reg" and
> "ranges" being present on the same node.

Then the node is a 'target', and a 'bridge'. The key is to carefully
define how the DT properties are used for each view-point.

> >   'upstream' path direction toward the target, typically memory.
> 
> I'm not keen on that, because we would describe the hop between /
> and /memory as downstream or upstream depending on who initiates the
> transaction.  (I appreciate you weren't including CPUs in your
> discussion, but if the termology works for the whole system it
> would be a bonus).

I'm just using the word 'upstream' as meaning 'moving closer to the
completing target'.

It isn't a great word, 'forward path' would do better to borrow
a networking term.

Then we have the 'return path' which, on message based busses is the
path a completion message from 'completing target' travels to reach
the 'initiator'.

They actually can be asymmetric in some situations, but I'm not sure
that is worth considering in DT, we can just assume completions travel
a reverse path that hits every transformative bridge.

> >   'upstream-bridge' The next hop on a path between an initiator/target
> 
> Maybe.  I'm still not sure quite why this is considered different
> from the downward path through the DT, except that you consider
> the cross-links in the DT to be "upward", but I considered them
> "downward" (which I think are mostly equivalent approaches).
> 
> Can you elaborate?

Let us not worry about upstream/downstream and just talk about the
next bridge on the 'forward path' toward the 'completing target'.

> > But I would encourage you to think about the various limitations this
> > still has
> >  - NUMA systems. How does one describe the path from each
> >    CPU to a target regs, and target memory? This is important for
> >    automatically setting affinities.
> 
> This is a good point.
> 
> Currently I had only been considering visibility, not affinity.
> We actually have a similar problem with GIC, where there may
> be multiple MSI mailboxes visible to a device, but one that is
> preferred (due to being fewer hops away in the silicon, even though
> the routing may be transparent).

Really, the MSI affinity isn't handled by the architecture like x86?
Funky.
 
> We could describe a whole separate bus for each CPU, with links
> to common interconnect subtrees downstream.  But that might involve
> a lot of duplication.  Your example below doesn't look too bad
> though.

Unfortunately my example ignores the ePAPR scheme of having a /cpu
node, I didn't think too hard to fix that though.

> >  - Peer-to-Peer DMA, this is where a non-CPU initiator speaks to a
> >    non-memory target, possibly through IOMMUs and what not. ie
> >    a graphics card in a PCI-E slot DMA'ing through a QPI bus to
> >    a graphics card in a PCI-E slot attached to a different socket.
> 
> Actually, I do intend to describe that and I think I achieved it :)
> 
> To try to keep the length of this mail down a bit I won't try to
> give an example here, but I'm happy to follow up later if this is
> still not answered elsewhere in the thread.

I think you got most of it, if I understand properly. The tricky bit I
was concerned with, is where the CPU and DMA paths are not the same.

> >                 intiator1 {
> >                         ranges = < ... >;
> >                         // View from this DMA initiator back to memory
> >                         upstream-bridge = <&interconnect0>;
> >                 };
> > 		/* For some reason this peripheral has two DMA
> > 		   initiation ports. */
> >                 intiator2 {
> >                         ranges = < ... >;
> >                         upstream-bridge = <&interconnect0>;
> >                 };
> 
> Describing separate masters within a device in this way looks quite nice.
> 
> Understanding what to do with them can still be left up to the driver
> for the parent node (peripheral at 0 in this case).

I was thinking the DMA API could learn to have a handle to the
initiator, with no handle it assumes the device node is itself the
initiator (eg dma-rages case)

> >              peripheral at 1 {
> >                 ranges = < ... >;
> >    		regs = <>;
> >                 intiator {
> >                         ranges = < ... >;
> >                         // View from this DMA initiator back to memory
> >                         upstream-bridge = <&interconnect1>;
> >                 };
> >                 target {
> > 		        reg = <..>
> >                         /* This peripheral has integrated memory!
> >                            But notice the CPU path is
> >                              smp_system -> socket1 -> interconnect1_control -> target
> > 			   While a DMA path is
> >                              intiator1 -> interconnect0 -> interconnect1 -> target
> > 			 */
> >                 };
> 
> By hiding slaves (as opposed to masters) inside subnodes, can DT do
> generic reachability analysis?  Maybe the answer is "yes".  I know
> devices hanging of buses whose compatible string is not "simple-bus" are
> not automatically probed, but there are other reasons for that, such as
> bus-specific power-on and probing methods.

Again, in this instance, it becomes up to the driver for peripheral at 1
to do something sensible with the buried nodes.

The generic DT machinery will happily convert the reg of target into a
CPU address for you.

> >             };
> >             peripheral2 at 0 {
> >    		regs = <>;
> > 
> > 		// Or we can write the simplest case like this.
> > 		dma-ranges = <>;
> > 		upstream-bridge = <&interconnect1>;
> >                 /* if upstream-bridge is omitted then it defaults to
> > 	           &parent, eg interconnect1_control */
> 
> This doesn't seem so different from my approach, though I need to
> think about it a bit more.

This is how I was thinking to unify the language with the existing
syntax.
 - dma-ranges alone in an initiator context is equivalent to using an
   implicit buried node:
    initiator {
       ranges == dma_ranges
       upstream-bridge = <&parent>;
    }
 - While in a bridge context it it attached to the
   'forward path edge'.

Now we have a very precise definition for dma-ranges in the same
language as the rest, and we can identify every involved node as
'initiator', 'target' or 'bridge'

> > It is computable that ops from initator2 -> target flow through
> > interconnect0, interconnect1, and then are delivered to target.
> > 
> > It has a fair symmetry with the interrupt-parent mechanism..
> 
> Although that language is rather different from mine, I think my
> proposal could describe this.  

Yes, I think it did, I was mostly thinking to tighten up the language.

> It doesn't preclude multi-rooted trees etc.; we could give a CPU a
> "slaves" property to override the default child for transaction
> rooting (which for CPUs is / -- somewhat illogical, but that's the
> way ePAPR has it).

Right..

> There's no reason why buses can't be cross-connected using slaves
> properties.  I'd avoided such things so far, because it introduces
> new cycle risks, such as
> socket at 0 -> cross -> socket at 1 -> cross -> socket at 0 in the following.

That is actually really how hardware works though. The socket-routers
are configured to not have cycles on an address-by-address basis, but
the actual high level topology is cyclic.

> / {
> 	cpus {
> 		cpu at 0 {
> 			slaves = <&socket0_interconnect>;
> 		};
> 		cpu at 1 {
> 			slaves = <&socket0_interconnect>;
> 		};
> 		cpu at 2 {
> 			slaves = <&socket1_interconnect>;
> 		};
> 		cpu at 3 {
> 			slaves = <&socket1_interconnect>;
> 		};
> 	};
> 

So, this has dis-aggregated the sockets, which looses the coherent
address view.

I feel it is important to have a single top level node that represents
the start point for *any* CPU issued transaction. This is the coherent
memory space of the system. The DT tree follows a representative
physical topology, eg from the cpu0, socket 0 view.

Knowing affinity should be computable later on top of that.

> Of course, nothing about this tells an OS anything about affinity,
> except what it can guess from the number of nodes that must be traversed
> between two points -- which may be misleading, particular if extra nodes
> are inserted in order to describe mappings and linkages.

Right, now you have to start adding a 'cost' to edges in the graph :)

Or maybe this is wrong headed and nodes should simply have an
 affinity = <&cpu0 &cpu1 &memory0 &memory1>

> Cycles could be avoided via the cross-connector ranges properties -- I
> would sincerely hope that the hardware really does something
> equivalent -- but then you cannot answer questions like "is the path
> from X to Y cycle-free" without also specifying an address.

Correct, and that is how HW works.

The DT description for a bridge might actually need to include address
based routing :(

next-hop = <BASE SIZE &target
            BASE SIZE &memory>

> The downside of this approach is that the DT is unparseable to any
> parser that doesn't understand the new concepts.

This is why I feel the top level 'coherent view' node is so
important. It retains the compatability.

Or go back to the suggestion I gave last time - keep the DT tree
basically as-is today and store a graph edge list separately.

Jason
