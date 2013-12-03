From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 2 Dec 2013 17:07:40 -0700
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131202202543.GC2312@e103592.cambridge.arm.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
 <20131128222232.GF14689@mithrandir>
 <20131128233147.GA19387@obsidianresearch.com>
 <20131129115815.GC3136@e103592.cambridge.arm.com>
 <20131129184341.GA25451@obsidianresearch.com>
 <20131202202543.GC2312@e103592.cambridge.arm.com>
Message-ID: <20131203000740.GA30818@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 08:25:43PM +0000, Dave Martin wrote:
> > This might be easier to parse as well, since you know everything under
> > 'axi' is related to interconnect and not jumbled with other stuff.
> 
> That is true, but I do have a concern that bolting more and more
> info onto the side of DT may leave us with a mess, while the "main"
> tree becomes increasingly fictional.
> 
> You make a lot of good points -- apologies for not responding in detail
> to all of them yet, but I tie myself in knots trying to say too many
> different things at the same time.

I think the main point is to observe that we are encoding a directed
graph onto DT, so long as the original graph can be extracted the
DT encoding can be whatever people like :)

> In a multi-master system this isn't enough, because a node might have
> to have multiple parents in order to express all the master/slave
> relationships.

Right, DT is a tree, not a graph - and this is already a minor problem
we've seen modeling some IP blocks on the Marvell chips. They also
have multiple ports into the various system busses.

> In that case, we can choose one of the parents as the canonical one
> (e.g., the immediate master on the path from the coherent CPUs), or if
> there is no obvious canonical parent the child node can be a
> freestanding node in the tree (i.e., with no reg or ranges properties,
> either in the / { } junkyard, or in some location that makes topological
> sense for the device in question).  The DT herarchy retains real
> meaning since the direction of master/slave relationships is fixed,
> but the DT becomes a tree of connected trees, rather than a single
> tree.

I'm not sure this will really be a problem in practice:

Consider:
 - All IP blocks we care about are going to have a CPU MMIO port for
   control.
 - The 'soc' tree is the MMIO hierarchy from the CPU perspective
 - IP blocks should try to DT model as a single node when possible

In that case, the location of a DT node for a multiport IP is now well
defined: It is the path from the CPU to the MMIO port, expressed in
DT.

Further, every 'switch' is going to have MMIO to control the switch,
so the switch node DT locations are also well defined.

Basically, I think the main 'soc' tree's layout is mostly unambiguous
and covers all the relevant blocks.

You woun't get a forest of DT trees because every block must be MMIO
reachable.

It is also the same core DT tree with my suggestion or yours.

Your edge encoding also makes sense, but I think this is where I would
disagree the most:

> Slave device mapping, tree form:
> 	a {
> 		b {
> 			reg = < REG >;
> 		};
> 	};
> 
> Slave device mapping, detached form:
> 	a {
> 		slave-reg = < &b REG >;
> 	};
> 
> 	b {
> 	};

This now requires the OS to parse this dataset just to access standard
MMIO, and you have to change the standard existing code that parses
ranges and reg to support this extended format.

Both of those reasons seem like major downsides to me. If the OS
doesn't support advanced features (IOMMU, power management, etc) it
should not require DT parsing beyond the standard items. This may
become relevant when re-using a kernel DT in uboot for instance.

On the other hand, this is a great way to actually express the correct
address mapping path for every reg window - but isn't that a separate
issue from the IOMMU/DMA problem? You still need to describe the DMA
bus mastering ports on IP directly.

The side-table concept would keep the parsing completely contained
within the IOMMU/etc drivers, and not have it leak out into existing
core DT code, but it doesn't completely tidy multiple slave ports.

Also, I was thinking after I sent the last email that this is a good
time to be thinking about a future need for describing NUMA affinites
in DT. That is basically the same directed graph we are talking about
here. Trying some modeling samples with that in mind would be a good
idea..

You should also think about places to encode parameters like
master/slave QOS and other edge-specific tunables..

> I may try to come up with a partial description of the Zync SoC, but
> I was getting myself confused when I tried it earlier ;)

The Zynq is interesting because all the information is public - and it
is a good example of the various AXI building blocks. Imagine some
IOMMUs in there and you have a complete scenario to talk about..

It even has a coherent AXI port available for IP to hook up to. :)

Regards,
Jason
