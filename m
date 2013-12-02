From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 2 Dec 2013 20:25:43 +0000
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131129184341.GA25451@obsidianresearch.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
 <20131128222232.GF14689@mithrandir>
 <20131128233147.GA19387@obsidianresearch.com>
 <20131129115815.GC3136@e103592.cambridge.arm.com>
 <20131129184341.GA25451@obsidianresearch.com>
Message-ID: <20131202202543.GC2312@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 11:43:41AM -0700, Jason Gunthorpe wrote:
> On Fri, Nov 29, 2013 at 11:58:15AM +0000, Dave Martin wrote:
> > > Hopefully the ARM guys concur, this was just my impression from
> > > reviewing their patches and having recently done some design work with
> > > AXI..
> > 
> > Yes and no.  We are trying to describe a real topology here, but only
> > because there are salient features that the kernel genuinely does
> > need to know about if we want to be able to abstract this kind of thing.
> > 
> > It's not just about AXI.
> 
> Right, I brought up AXI because it is public, well documented and easy
> to talk about - every bus/interconnect (PCI, PCI-E, RapidIO,
> HyperTransport, etc) I've ever seen works in essentially the same way
> - links and 'switches'.
> 
> > The master-slave link concept is not supposed to be a new concept at
> > all: DT already has this concept.  All we are aiming to add here is
> > the ability to describe cross-links that ePAPR cannot describe
> > directly.
> 
> The main issue seems to be how to do merge the DT standard CPU-centric
> tree with a bus graph that isn't CPU-centric - eg like in that Zynq
> diagram I mentioned.
> 
> All the existing DT cases I'm aware of are able to capture the DMA bus
> topology within the CPU tree - because they are the same :)
> 
> > In axi { axi_switch {} }, are you describing two levels of bus, or
> > one?  I'm guessing one, but then the nested node looks a bit weird.
> 
> So, my attempt was to sketch a vertex list and adjacency matrix in DT.
> 
> 'axi' is the container for the graph, 'axi_switch' is a vertex and
> then 'downstream' encodes the adjacency list.
> 
> We can't use the natural DT tree hierarchy here because there is no
> natural graph root - referring to the Zynq diagram there is no vertex
> you can start at and then reach every other vertex - so a tree can't
> work, and there is no such thing as a 'bus level'
> 
> > However, there's nothing to stop a DMA controller's master side being
> > looped back so that it can access its own slave interface.  This is the
> > normal situation for coherent DMA, since the whole point there is
> > that the DMA controller should shares its system view closely with
> > the CPUs, including some levels of cache.
> 
> The DAG would only have vertexes for switches and distinct vertexes
> for 'end-ports'. So if an IP block has a master interface and a slave
> interface then it would have two DAG end-port vertexes and the DAG can
> remain acyclic.
> 
> The only way to create cycles is to connect switches in loops, and you
> can always model a group of looped switches as a single switch vertex
> to remove cycles.
> 
> If cycles really are required then it just makes the kernel's job
> harder, it doesn't break the DT representation ..
> 
> > > Right - which is why I said the usual 'soc' node should remain as-is
> > > typical today - a tree formed by viewing the AXI DAG from the CPU
> > > vertex. That 100% matches the OS perspective of the system for CPU
> > > originated MMIO.
> > 
> > Do you mean the top-level bus node in the DT and its contents, or
> > something else?
> > 
> > If so, agreed ...
> 
> Right, the DT, and the 'reg' properties should present a tree that is
> the MMIO path for the CPU. That tree should be a subset of the full
> bus graph.
> 
> If the bus is 'sane' then that tree matches the DMA graph as well,
> which is where most implementations are today.
> 
> > ... that could work, although putting the links in the natural places
> > in the DT directly feels cleaner that stashing a crib table elsewhere
> > in the DT.  That's partly cosmetic, I think both could work?
> 
> I choose to talk about this as a side table for a few reasons (touched
> on above) but perhaps the most important is where do you put switches
> that the CPU's MMIO path doesn't flow through? What is the natural
> place in the DT tree?
> 
> Again refering to the Zynq diagram, you could have a SOC node like
> this:
> 
> soc
> {
>   // Start at Cortex A9
>   scu {
>      OCM {}
>      l2cache {
>              memory {}
> 	     slave {
> 	     	   on_chip0 {reg = {}}
> 	     	   on_chip1 {reg = {}}
> 	     	   on_chip2 {reg = {}}
> 		   ...
> 	     }
>      }
>   }
> }
> 
> Where do I put a node for the 'memory interconnect' switch? How do I
> model DMA connected to the 'Cache Coherent AXI port'?
> 
> MMIO config registers for these blocks are going to fit into the MMIO
> tree someplace, but that doesn't really tell you anything about how
> they fit into the dma graph.
> 
> Easy to do with a side table:
> axi {
>     cpu {downstream = scu}
>     scu {downstream = OCM,l2cache}
>     l2cache {downstream = memory,slave interconnect}
>     slave interconnect {} // No more switches
> 
>     hp axi {downstream = memory interconnect}
>     memory interconnect {downstream = memory,OCM}
>     
>     coherent acp {downstream = scu}
> 
>     gp axi  {downstream = master interconnect}
>     master interconnect  {downstream = central interconnect}
>     central interconnect  {downstream = ocm,slave interconnect,memory}
> 
>     dma engine  {downstream = central interconnect}
> }
> 
> Which captures the switch vertex list and adjacency list.
> 
> Then you have to connect the device nodes into the AXI graph:
> 
> Perhaps:
> 
> on_chip0
> { 
>    reg = {}
>    axi_mmio_slave_port = <&slave interconnect, M0> // Vertex and edge
>    axi_bus_master_port = <&hp axi, S1>
> }
> 
> Or maybe back reference from the graph table is better:
> 
> axi {
>    hp axi {
>        downstream = memory interconnect
>        controller = &...;
>        S1 {
>           bus_master = &on_chip0;   // Vertex and edge
>        	  axi,arbitration-priority = 10;
>        }
>    }
>    slave interconnect {
>        M0 {
>           mmio_slave = &on_chip0;
>        }
>    }
> }
> 
> It sort of feels natural that you could describe the interconnect in
> under its own tidy node and the main tree remains left alone...
> 
> This might be easier to parse as well, since you know everything under
> 'axi' is related to interconnect and not jumbled with other stuff.

That is true, but I do have a concern that bolting more and more
info onto the side of DT may leave us with a mess, while the "main"
tree becomes increasingly fictional.

You make a lot of good points -- apologies for not responding in detail
to all of them yet, but I tie myself in knots trying to say too many
different things at the same time.


For comparison, here's what I think is the main alternative approach.
My discussion touches obliquely on some of the issues you raise...


My basic idea is that DT allows us to express master/slave relationships
like this already:

	master_device {
		slave_device {
			reg = < ... >;
			ranges = < ... >;
			dma-ranges = < ... >;
		};
	};

(dma-ranges is provided by ePAPR to describe the reverse mappings for
slave_device to master back on master_device).

In a multi-master system this isn't enough, because a node might have
to have multiple parents in order to express all the master/slave
relationships.

In that case, we can choose one of the parents as the canonical one
(e.g., the immediate master on the path from the coherent CPUs), or if
there is no obvious canonical parent the child node can be a
freestanding node in the tree (i.e., with no reg or ranges properties,
either in the / { } junkyard, or in some location that makes topological
sense for the device in question).  The DT herarchy retains real
meaning since the direction of master/slave relationships is fixed,
but the DT becomes a tree of connected trees, rather than a single tree.

So, some master/slave relationships will not be child/parent any more,
and we need another way to express the linkage.


My idea now, building on Will's suggestion is to keep the existing
abstractions unchanged, but create an alternate "detached"
representation of each relationship, to use in multi-master
situations.


In the following, the #address-cells and #size-cells properties of a
and b (where applicable) control the parsing of REG or RANGE in
precisely the same way for both forms.

SLAVE-PORT is required for slave buses with multiple masters, but it
is only needed in systems where the ports need to be identified
distinctly.  DT has no traditional way to describe this, so we'd need
to add another property ("parent-master" in my example) if we want to
describe that in tree form.  For now, I assume that a device (i.e., a
slave that is not a bus) does not need to need to distinguish between
different slave ports -- if it did need to do so, additional
properties could be added to describe that, but we have no example of
this today(?)

Drivers for buses that use SLAVE-PORT could still work with a DT that
does not provide the SLAVE-PORT information, but might have restricted
functionality in that case (no per-port control, profiling, etc.)


Note also that:

	{ #slave-cells = <0>; } is equivalent to { // no #slave-cells }
	{ parent-master = <>; } is equivalent to { // no parent-master }

...which gives the correct interpretation for traditional DTs.


We then have the following transformations:


Slave device mapping, tree form:
	a {
		b {
			reg = < REG >;
		};
	};

Slave device mapping, detached form:
	a {
		slave-reg = < &b REG >;
	};

	b {
	};


Slave passthrough bus mapping, tree form:
	a {
		b {
			#slave-cells = < SLAVE-PORT-CELLS >;
			parent-master = < SLAVE-PORT >;

			ranges;
		};
	};

Slave passthrough bus mapping, detached form:
	a {
		slave = < &b SLAVE-PORT >;
	};

	b {
		#slave-cells = < SLAVE-PORT-CELLS >;
	};


Remapped slave bus mapping, tree form:
	a {
		b {
			#slave-cells = < SLAVE-PORT-CELLS >;
			parent-master = < SLAVE-PORT >;

			ranges = < RANGE >;
		};
	};

Remapped slave bus mapping, detached form:
	a {
		slave = < &b SLAVE-PORT RANGE >;
	};

	b {
		#slave-cells = < SLAVE-PORT-CELLS >;
	};


There are no dma-ranges properties here, because in this context "DMA"
is just a master/slave relationship where the master isn't a CPU.
The added properties actually allow us to describe that just fine, but
in a more explicit and general way.


Some new code will be required to parse this, but it is just a new
more flexible _mechanism_ for expressing an old relationship, extended
with a straightforward slave-port identifier which is a simple array of
cells, we should have a good chance of burying the change under
abstracted interfaces.

Existing DTs should not need to change, because we have a well-defined
mapping between the two representations in the non-multi-master case.

I may try to come up with a partial description of the Zync SoC, but
I was getting myself confused when I tried it earlier ;)

Cheers
---Dave
