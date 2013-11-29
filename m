From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 29 Nov 2013 14:13:25 +0000
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131129095711.GD22771@ulmo.nvidia.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
 <20131128222232.GF14689@mithrandir>
 <20131128233147.GA19387@obsidianresearch.com>
 <20131129095711.GD22771@ulmo.nvidia.com>
Message-ID: <20131129141325.GE3136@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 09:57:12AM +0000, Thierry Reding wrote:
> On Thu, Nov 28, 2013 at 04:31:47PM -0700, Jason Gunthorpe wrote:

[...]

> > The AXI DAG side-table would be used to resolve weirdness with 'bus
> > master' DMA programming. The OS can detect all the required
> > configuration and properties by tracing a path through the DAG from
> > the source of the DMA to the target - that tells you what IOMMUs are
> > involved, if the path is cache coherent, etc.
> 
> That all sounds like an awful amount of data to wade through. Do we
> really need all of it to do what we want? Perhaps it can be simplified
> a bit. For instance it seems like the majority of hardware where this is
> actually required will have to go through one IOMMU (or a cascade of
> IOMMUs) and the path isn't cache coherent.

The DT should describe the hardware, but only those aspects that a sane
OS should need to care about.  Some judgment is needed.

Figuring out exactly which info we ought to care about is part of the
purpose of this discussion.  There are certainly lots of hardware
integration and configuration parameters that we don't need to know.

I think that figuring out the path capabilities ought to be a one-off
step, done when the DMA client device is probed.  We need to retain
enough information to do the mapping each time a buffer needs to be
set up, but we shouldn't have to re-scan the DT each time.


In more general cases, there are still some things that really can't
be pushed into firmware for which Linux needs a fair amount of
topology information.

Our current example is things like MSIs from PCIe devices in systems
with newer GICs and SMMU.  Particularly for guests under KVM, the ways
all these link together is needed for configuring and routing MSIs to
guest CPUs.


[...]

> > eg An all-to-all bus cross bar (eg like Intel's ring bus) is engery
> > expensive compared to a purpose built muxed bus tree. Doing coherency
> > look ups on DMA traffic costs energy, etc.
> 
> I understand that these may all contribute to saving power. However what
> good is a system that's very power-efficient if it's so complex that the
> software can no longer control it?

Not a lot of good.  However, that's the extreme case.  We have to deal
with some pain for sure -- and some parts of that pain may turn out to be
too ridiculous (either too useless, or too unworkable) for it to be worth
supporting them in Linux.

This thread focuses on one of the less ridculous things: the aim is not
to describe the hardware bus architecture in full detail, just the
aspects the OS needs to know about for important, abstractable things
like DMA and IOMMU topology.

If we model the description around the actual topology, there seems
less chance of needing to bodge the bindings in the future when some
previously non-relevant aspect of the topology becomes important.

Cheers
---Dave
