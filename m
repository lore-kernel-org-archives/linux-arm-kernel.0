From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 2 May 2014 12:17:50 -0600
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <20140502173120.GD3805@e103592.cambridge.arm.com>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
 <6774053.rAccqTeoiQ@wuerfel>
 <20140502173120.GD3805@e103592.cambridge.arm.com>
Message-ID: <20140502181750.GD3179@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 06:31:20PM +0100, Dave Martin wrote:

> Note that there is no cycle through the "reg" property on iommu:
> "reg" indicates a sink for transactions; "slaves" indicates a
> source of transactions, and "ranges" indicates a propagator of
> transactions.

I wonder if this might be a better naming scheme, I actually don't
really like 'slave' for this, it really only applies well to AXI style
unidirectional busses, and any sort of message-based bus architectures
(HT, PCI, QPI, etc) just have the concept of an initiator and target.

Since initiator/target applies equally well to master/slave buses,
that seems like better, clearer, naming.

Using a nomenclature where
  'reg' describes a target reachable from the CPU initiator via the
        natural DT hierarchy
  'initiator' describes a non-CPU (eg 'DMA') source of ops, and
        travels via the path described to memory (which is the
	target).
  'path' describes the route between an intitator and target, where
        bridges along the route may alter the operation.
  'upstream' path direction toward the target, typically memory.
  'upstream-bridge' The next hop on a path between an initiator/target

But I would encourage you to think about the various limitations this
still has
 - NUMA systems. How does one describe the path from each
   CPU to a target regs, and target memory? This is important for
   automatically setting affinities.
 - Peer-to-Peer DMA, this is where a non-CPU initiator speaks to a
   non-memory target, possibly through IOMMUs and what not. ie
   a graphics card in a PCI-E slot DMA'ing through a QPI bus to
   a graphics card in a PCI-E slot attached to a different socket.

These are already use-cases happening on x86.. and the same underlying
hardware architectures this tries to describe for DMA to memory is at
work for the above as well.

Basically, these days, interconnect is a graph. Pretending things are
a tree is stressful :)

Here is a basic attempt using the above language, trying to describe
an x86ish system with two sockets, two DMA devices, where one has DMA
target capabable memory (eg a GPU)

// DT tree is the view from the SMP CPU complex down to regs
smp_system {
   socket0 {
       cpu0 at 0 {}
       cpu1 at 0 {}
       memory at 0: {}
       interconnect0: {targets = <&memory@0,interconnect1>;}
       interconnect0_control: {
             ranges;
             peripheral at 0 {
   		regs = <>;
                intiator1 {
                        ranges = < ... >;
                        // View from this DMA initiator back to memory
                        upstream-bridge = <&interconnect0>;
                };
		/* For some reason this peripheral has two DMA
		   initiation ports. */
                intiator2 {
                        ranges = < ... >;
                        upstream-bridge = <&interconnect0>;
                };
             };
        };
   }
   socket1 {
       cpu0 at 1 {}
       cpu1 at 1 {}
       memory at 1: {}
       interconnect1: {targets = <&memory at 1,&interconnect0,&peripheral@1/target>;}
       interconnect1_control: {
             ranges;
             peripheral at 1 {
                ranges = < ... >;
   		regs = <>;
                intiator {
                        ranges = < ... >;
                        // View from this DMA initiator back to memory
                        upstream-bridge = <&interconnect1>;
                };
                target {
		        reg = <..>
                        /* This peripheral has integrated memory!
                           But notice the CPU path is
                             smp_system -> socket1 -> interconnect1_control -> target
			   While a DMA path is
                             intiator1 -> interconnect0 -> interconnect1 -> target
			 */
                };
            };
            peripheral2 at 0 {
   		regs = <>;

		// Or we can write the simplest case like this.
		dma-ranges = <>;
		upstream-bridge = <&interconnect1>;
                /* if upstream-bridge is omitted then it defaults to
	           &parent, eg interconnect1_control */
       }
}

It is computable that ops from initator2 -> target flow through
interconnect0, interconnect1, and then are delivered to target.

It has a fair symmetry with the interrupt-parent mechanism..

Jason
