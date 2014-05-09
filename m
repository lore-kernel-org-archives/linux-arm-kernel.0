From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 9 May 2014 15:16:33 +0100
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <20140502181750.GD3179@obsidianresearch.com>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
 <6774053.rAccqTeoiQ@wuerfel>
 <20140502173120.GD3805@e103592.cambridge.arm.com>
 <20140502181750.GD3179@obsidianresearch.com>
Message-ID: <20140509141633.GD3921@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 12:17:50PM -0600, Jason Gunthorpe wrote:
> On Fri, May 02, 2014 at 06:31:20PM +0100, Dave Martin wrote:
> 
> > Note that there is no cycle through the "reg" property on iommu:
> > "reg" indicates a sink for transactions; "slaves" indicates a
> > source of transactions, and "ranges" indicates a propagator of
> > transactions.
> 
> I wonder if this might be a better naming scheme, I actually don't
> really like 'slave' for this, it really only applies well to AXI style
> unidirectional busses, and any sort of message-based bus architectures
> (HT, PCI, QPI, etc) just have the concept of an initiator and target.
> 
> Since initiator/target applies equally well to master/slave buses,
> that seems like better, clearer, naming.

Sure, I wouldn't have a problem with such a suggestion.  A more neutral
naming is less likely to cause confusion.

> Using a nomenclature where
>   'reg' describes a target reachable from the CPU initiator via the
>         natural DT hierarchy

I would say, reachable from the parent device node (which implies your
statement).  This is consistent with the way ePAPR describes device-to-
device DMA (even if Linux doesn't usually make a lot of use of that).

>   'initiator' describes a non-CPU (eg 'DMA') source of ops, and
>         travels via the path described to memory (which is the
> 	target).

CPUs are initiators only; non-mastering devices are targets only.

We might want some terminology to distinguish between mastering 
devices and bridges, both of which act as initiators and targets.

We could have a concept of a "forwarder" or "gateway".  But a bus
may still be a target as well as forwarder: if the bus contains some
control registers for example.  There is nothing to stop "reg" and
"ranges" being present on the same node.

"ranges" and "dma-ranges" both describe a node's forwarding role,
one for transactions received from the parent, and one for transactions
received from children.

>   'path' describes the route between an intitator and target, where
>         bridges along the route may alter the operation.

ok

>   'upstream' path direction toward the target, typically memory.

I'm not keen on that, because we would describe the hop between /
and /memory as downstream or upstream depending on who initiates the
transaction.  (I appreciate you weren't including CPUs in your
discussion, but if the termology works for the whole system it
would be a bonus).

>   'upstream-bridge' The next hop on a path between an initiator/target

Maybe.  I'm still not sure quite why this is considered different
from the downward path through the DT, except that you consider
the cross-links in the DT to be "upward", but I considered them
"downward" (which I think are mostly equivalent approaches).

Can you elaborate?

> 
> But I would encourage you to think about the various limitations this
> still has
>  - NUMA systems. How does one describe the path from each
>    CPU to a target regs, and target memory? This is important for
>    automatically setting affinities.

This is a good point.

Currently I had only been considering visibility, not affinity.
We actually have a similar problem with GIC, where there may
be multiple MSI mailboxes visible to a device, but one that is
preferred (due to being fewer hops away in the silicon, even though
the routing may be transparent).

I wasn't trying to solve this problem yet, and don't have a good
answer for it at present.

We could describe a whole separate bus for each CPU, with links
to common interconnect subtrees downstream.  But that might involve
a lot of duplication.  Your example below doesn't look too bad
though.

>  - Peer-to-Peer DMA, this is where a non-CPU initiator speaks to a
>    non-memory target, possibly through IOMMUs and what not. ie
>    a graphics card in a PCI-E slot DMA'ing through a QPI bus to
>    a graphics card in a PCI-E slot attached to a different socket.

Actually, I do intend to describe that and I think I achieved it :)

To try to keep the length of this mail down a bit I won't try to
give an example here, but I'm happy to follow up later if this is
still not answered elsewhere in the thread.

> 
> These are already use-cases happening on x86.. and the same underlying
> hardware architectures this tries to describe for DMA to memory is at
> work for the above as well.
> 
> Basically, these days, interconnect is a graph. Pretending things are
> a tree is stressful :)
> 
> Here is a basic attempt using the above language, trying to describe
> an x86ish system with two sockets, two DMA devices, where one has DMA
> target capabable memory (eg a GPU)
> 
> // DT tree is the view from the SMP CPU complex down to regs
> smp_system {
>    socket0 {
>        cpu0 at 0 {}
>        cpu1 at 0 {}
>        memory at 0: {}
>        interconnect0: {targets = <&memory@0,interconnect1>;}
>        interconnect0_control: {
>              ranges;
>              peripheral at 0 {
>    		regs = <>;
>                 intiator1 {
>                         ranges = < ... >;
>                         // View from this DMA initiator back to memory
>                         upstream-bridge = <&interconnect0>;
>                 };
> 		/* For some reason this peripheral has two DMA
> 		   initiation ports. */
>                 intiator2 {
>                         ranges = < ... >;
>                         upstream-bridge = <&interconnect0>;
>                 };

Describing separate masters within a device in this way looks quite nice.

Understanding what to do with them can still be left up to the driver
for the parent node (peripheral at 0 in this case).

>              };
>         };
>    }
>    socket1 {
>        cpu0 at 1 {}
>        cpu1 at 1 {}
>        memory at 1: {}
>        interconnect1: {targets = <&memory at 1,&interconnect0,&peripheral@1/target>;}
>        interconnect1_control: {
>              ranges;
>              peripheral at 1 {
>                 ranges = < ... >;
>    		regs = <>;
>                 intiator {
>                         ranges = < ... >;
>                         // View from this DMA initiator back to memory
>                         upstream-bridge = <&interconnect1>;
>                 };
>                 target {
> 		        reg = <..>
>                         /* This peripheral has integrated memory!
>                            But notice the CPU path is
>                              smp_system -> socket1 -> interconnect1_control -> target
> 			   While a DMA path is
>                              intiator1 -> interconnect0 -> interconnect1 -> target
> 			 */
>                 };

By hiding slaves (as opposed to masters) inside subnodes, can DT do
generic reachability analysis?  Maybe the answer is "yes".  I know
devices hanging of buses whose compatible string is not "simple-bus" are
not automatically probed, but there are other reasons for that, such as
bus-specific power-on and probing methods.

>             };
>             peripheral2 at 0 {
>    		regs = <>;
> 
> 		// Or we can write the simplest case like this.
> 		dma-ranges = <>;
> 		upstream-bridge = <&interconnect1>;
>                 /* if upstream-bridge is omitted then it defaults to
> 	           &parent, eg interconnect1_control */

This doesn't seem so different from my approach, though I need to
think about it a bit more.

>        }
> }
> 
> It is computable that ops from initator2 -> target flow through
> interconnect0, interconnect1, and then are delivered to target.
> 
> It has a fair symmetry with the interrupt-parent mechanism..

Although that language is rather different from mine, I think my
proposal could describe this.  It doesn't preclude multi-rooted trees etc.;
we could give a CPU a "slaves" property to override the default child
for transaction rooting (which for CPUs is / -- somewhat illogical, but
that's the way ePAPR has it).

There's no reason why buses can't be cross-connected using slaves
properties.  I'd avoided such things so far, because it introduces
new cycle risks, such as
socket at 0 -> cross -> socket at 1 -> cross -> socket at 0 in the following.

(This cycle is also present in your example, with different syntax,
via interconnectX { targets = < ... &interconnectY >; };  I probably
misunderstood some aspects of your example -- feel free to put me right.)

/ {
	cpus {
		cpu at 0 {
			slaves = <&socket0_interconnect>;
		};
		cpu at 1 {
			slaves = <&socket0_interconnect>;
		};
		cpu at 2 {
			slaves = <&socket1_interconnect>;
		};
		cpu at 3 {
			slaves = <&socket1_interconnect>;
		};
	};


socket0_interconnect: socket at 0 {
		slaves = <&socket0_cross_connector &common_bus>;

		memory {
			reg = < ... >;
		};

socket0_cross_connector: cross {
			ranges = < ... >;
		};
	};

socket1_interconnect: socket at 1 {
		slaves = <&socket1_cross_connector &common_bus>;

		memory {
			reg = < ... >;
		};

socket0_cross_connector: cross {
			ranges = < ... >;
		};
	};

	common_bus {
		ranges;

		...
	};
};

(This very slapdash, but hopefully you get the idea.)

Of course, nothing about this tells an OS anything about affinity,
except what it can guess from the number of nodes that must be traversed
between two points -- which may be misleading, particular if extra nodes
are inserted in order to describe mappings and linkages.

Cycles could be avoided via the cross-connector ranges properties -- I
would sincerely hope that the hardware really does something
equivalent -- but then you cannot answer questions like "is the path
from X to Y cycle-free" without also specifying an address.

Of course, if we make a rule that the DT must be cycle-free for all
transactions we could make it the author's responsibility, with a dumb,
brute-force limit in the parser on the number of nodes permitted in
any path.


The downside of this approach is that the DT is unparseable to any
parser that doesn't understand the new concepts.

For visibility that's acceptable, because if ePAPR doesn't allow for
a correct describtion of visibility then a correct DT could not
be interpreted comprehensively in any case.

For affinity, I feel that we should structure the DT in a way that
still describes reachability and visibility correctly, even when
processed by a tool that doesn't understand the affinity concepts.
But I don't see how to do that yet.

Let me know if you have any ideas!

Cheers
---Dave
