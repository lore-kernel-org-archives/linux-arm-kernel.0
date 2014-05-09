From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 9 May 2014 11:45:26 +0100
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <4187263.LG1S8D1FYU@wuerfel>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
 <6555552.UqkKQIAsih@wuerfel> <5363EA31.3000509@wwwdotorg.org>
 <4187263.LG1S8D1FYU@wuerfel>
Message-ID: <20140509104506.GA3921@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 09:02:20PM +0200, Arnd Bergmann wrote:
> On Friday 02 May 2014 12:55:45 Stephen Warren wrote:
> > On 05/02/2014 09:19 AM, Arnd Bergmann wrote:
> > > On Friday 02 May 2014 15:23:29 Thierry Reding wrote:
> > ...
> > >> To some degree this also depends on how we want to handle IOMMUs. If
> > >> they should remain transparently handled via dma_map_ops, then it makes
> > >> sense to set this up at device instantiation time. But how can we handle
> > >> this in situations where one device needs to master on two IOMMUs at the
> > >> same time? Or if the device needs physically contiguous memory for
> > >> purposes other than device I/O. Using dma_map_ops we can't control which
> > >> allocations get mapped via the IOMMU and which don't.
> > > 
> > > I still hope we can handle this in common code by selecting the right
> > > dma_map_ops when the devices are instantiated, at least for 99% of the
> > > cases. I'm not convinced we really need to handle the 'multiple IOMMUs
> > > on one device' case in a generic way. If there are no common use cases
> > > for that, we can probably get away with having multiple device nodes
> > > and an ugly driver for the exception, instead of making life complicated
> > > for everybody.
> > 
> > By "multiple device nodes", I assume you mean device tree nodes? I'm not
> > sure I like the sound of that.
> > 
> > I believe that DT should represent the structure of the HW in terms of
> > HW modules or blocks. If there's a single cohesive HW module that
> > happens to talk to multiple MMUs, or indeed has any kind of unusual case
> > at all, I don't think that should force the DT representation to be
> > broken up into multiple nodes. We should have a DT node for that HW
> > module, and it should be up to the device driver to make the internal SW
> > representation work correctly.

This is rather fuzzy.  On-SoC, it is often non-obvious what counts as a
single component and what counts as a collection of multiple components.

For DT, we are concerned whether there is anything configurable in the
relationship between the components, or how each component connects to
the rest of the system that it is worthwhile to abstract.

> I agree we should in general try our best to have the DT representation
> match exactly what the hardware looks like. However we already have some
> areas where we violate that, typically when things are not trees.

The DT is an abstraction: it needs to describe all the OS-relevant
aspects of platform *behaviour* that can vary between configurations.

The most reliable way to describe behaviour perfectly is to describe the
hardware exactly in every detail, but it's not much help to an OS
because the useful information is spread all over the place and not in a
usable form.

I deliberately went hard down the "describe the hardware" route to
get the discussion going, but this doesn't always mean it is the best
answer.

We have to trade off the false economy of not describing enough against
the pointless expense of describing too much...

> If there is no real use case but only a theoretical possibility, I don't
> have a problem with being less strict about the general rule on hardware
> representation.

I agree that this is all a bit hypothetical -- good for batting ideas
around, but not so good for reaching practical conclusions.

I'll try to come up with something a bit more concrete.

Cheers
---Dave
