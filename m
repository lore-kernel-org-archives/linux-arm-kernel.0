From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 29 Nov 2013 11:43:41 -0700
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131129115815.GC3136@e103592.cambridge.arm.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
 <20131128222232.GF14689@mithrandir>
 <20131128233147.GA19387@obsidianresearch.com>
 <20131129115815.GC3136@e103592.cambridge.arm.com>
Message-ID: <20131129184341.GA25451@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 11:58:15AM +0000, Dave Martin wrote:
> > Hopefully the ARM guys concur, this was just my impression from
> > reviewing their patches and having recently done some design work with
> > AXI..
> 
> Yes and no.  We are trying to describe a real topology here, but only
> because there are salient features that the kernel genuinely does
> need to know about if we want to be able to abstract this kind of thing.
> 
> It's not just about AXI.

Right, I brought up AXI because it is public, well documented and easy
to talk about - every bus/interconnect (PCI, PCI-E, RapidIO,
HyperTransport, etc) I've ever seen works in essentially the same way
- links and 'switches'.

> The master-slave link concept is not supposed to be a new concept at
> all: DT already has this concept.  All we are aiming to add here is
> the ability to describe cross-links that ePAPR cannot describe
> directly.

The main issue seems to be how to do merge the DT standard CPU-centric
tree with a bus graph that isn't CPU-centric - eg like in that Zynq
diagram I mentioned.

All the existing DT cases I'm aware of are able to capture the DMA bus
topology within the CPU tree - because they are the same :)

> In axi { axi_switch {} }, are you describing two levels of bus, or
> one?  I'm guessing one, but then the nested node looks a bit weird.

So, my attempt was to sketch a vertex list and adjacency matrix in DT.

'axi' is the container for the graph, 'axi_switch' is a vertex and
then 'downstream' encodes the adjacency list.

We can't use the natural DT tree hierarchy here because there is no
natural graph root - referring to the Zynq diagram there is no vertex
you can start at and then reach every other vertex - so a tree can't
work, and there is no such thing as a 'bus level'

> However, there's nothing to stop a DMA controller's master side being
> looped back so that it can access its own slave interface.  This is the
> normal situation for coherent DMA, since the whole point there is
> that the DMA controller should shares its system view closely with
> the CPUs, including some levels of cache.

The DAG would only have vertexes for switches and distinct vertexes
for 'end-ports'. So if an IP block has a master interface and a slave
interface then it would have two DAG end-port vertexes and the DAG can
remain acyclic.

The only way to create cycles is to connect switches in loops, and you
can always model a group of looped switches as a single switch vertex
to remove cycles.

If cycles really are required then it just makes the kernel's job
harder, it doesn't break the DT representation ..

> > Right - which is why I said the usual 'soc' node should remain as-is
> > typical today - a tree formed by viewing the AXI DAG from the CPU
> > vertex. That 100% matches the OS perspective of the system for CPU
> > originated MMIO.
> 
> Do you mean the top-level bus node in the DT and its contents, or
> something else?
> 
> If so, agreed ...

Right, the DT, and the 'reg' properties should present a tree that is
the MMIO path for the CPU. That tree should be a subset of the full
bus graph.

If the bus is 'sane' then that tree matches the DMA graph as well,
which is where most implementations are today.

> ... that could work, although putting the links in the natural places
> in the DT directly feels cleaner that stashing a crib table elsewhere
> in the DT.  That's partly cosmetic, I think both could work?

I choose to talk about this as a side table for a few reasons (touched
on above) but perhaps the most important is where do you put switches
that the CPU's MMIO path doesn't flow through? What is the natural
place in the DT tree?

Again refering to the Zynq diagram, you could have a SOC node like
this:

soc
{
  // Start at Cortex A9
  scu {
     OCM {}
     l2cache {
             memory {}
	     slave {
	     	   on_chip0 {reg = {}}
	     	   on_chip1 {reg = {}}
	     	   on_chip2 {reg = {}}
		   ...
	     }
     }
  }
}

Where do I put a node for the 'memory interconnect' switch? How do I
model DMA connected to the 'Cache Coherent AXI port'?

MMIO config registers for these blocks are going to fit into the MMIO
tree someplace, but that doesn't really tell you anything about how
they fit into the dma graph.

Easy to do with a side table:
axi {
    cpu {downstream = scu}
    scu {downstream = OCM,l2cache}
    l2cache {downstream = memory,slave interconnect}
    slave interconnect {} // No more switches

    hp axi {downstream = memory interconnect}
    memory interconnect {downstream = memory,OCM}
    
    coherent acp {downstream = scu}

    gp axi  {downstream = master interconnect}
    master interconnect  {downstream = central interconnect}
    central interconnect  {downstream = ocm,slave interconnect,memory}

    dma engine  {downstream = central interconnect}
}

Which captures the switch vertex list and adjacency list.

Then you have to connect the device nodes into the AXI graph:

Perhaps:

on_chip0
{ 
   reg = {}
   axi_mmio_slave_port = <&slave interconnect, M0> // Vertex and edge
   axi_bus_master_port = <&hp axi, S1>
}

Or maybe back reference from the graph table is better:

axi {
   hp axi {
       downstream = memory interconnect
       controller = &...;
       S1 {
          bus_master = &on_chip0;   // Vertex and edge
       	  axi,arbitration-priority = 10;
       }
   }
   slave interconnect {
       M0 {
          mmio_slave = &on_chip0;
       }
   }
}

It sort of feels natural that you could describe the interconnect in
under its own tidy node and the main tree remains left alone...

This might be easier to parse as well, since you know everything under
'axi' is related to interconnect and not jumbled with other stuff.

Cheers,
Jason
