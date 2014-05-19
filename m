From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 19 May 2014 14:53:37 +0200
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <4391809.OTRCiJQXS4@wuerfel>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <4391809.OTRCiJQXS4@wuerfel>
Message-ID: <20140519125336.GA9466@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 12:26:35PM +0200, Arnd Bergmann wrote:
> On Friday 16 May 2014 14:23:18 Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > This commit introduces a generic device tree binding for IOMMU devices.
> > Only a very minimal subset is described here, but it is enough to cover
> > the requirements of both the Exynos System MMU and Tegra SMMU as
> > discussed here:
> > 
> >     https://lkml.org/lkml/2014/4/27/346
> > 
> > More advanced functionality such as the dma-ranges property can easily
> > be added in a backwards-compatible way. In the absence of a dma-ranges
> > property it should be safe to default to the whole address space.
> > 
> 
> The basic binding looks fine, but I'd like it to be more explicit
> about dma-ranges. Most importantly, what does "the whole address space"
> mean?

The whole point was to leave out any mention of dma-ranges from the
binding until we've figured out more of the puzzle.

So what I was trying to avoid was another lengthy discussion on the
topic of dma-ranges. Oh well... =)

> A lot of IOMMUs have only 32-bit bus addresses when targetted
> by a bus master, it would also be normal for some to be smaller and
> some might even support 64-bit.
> 
> For the upstream side, I'd hope we always have access to the full
> physical memory, but since this is a brand-new binding, it should
> be straightforward to just ask for upstream dma-ranges properties
> to be set all the way up to the root to confirm that.
> 
> For downstream, we don't actually have a good place to put the
> dma-ranges property.

I'm not sure I understand what you mean by upstream and downstream in
this context.

> We can't put it into the iommu node, because  that would imply translating
> to the iommu's parent bus, not the iommu's own bus space.

My understanding was that the purpose of dma-ranges was to define a
mapping from one bus to another. So the general form of

	child-address  parent-address  child-size

Would be used to translate a region of size <child-size> from the
<child-address> (the I/O address space created by the IOMMU) to the
<parent-address> (physical address space).

> We also can't put it into the master, because dma-ranges is supposed to be
> in the parent bus.

I don't understand. From the above I would think that the master's node
is precisely where it belongs.

> Finally, it makes no sense to use the dma-ranges property of the master's
> parent bus, because that bus isn't actually involved in the translation.

My understanding here is mostly based on the OpenFirmware working group
proposal for the dma-ranges property[0]. I'll give another example to
try and clarify how I had imagined this to work:

	/ {
		#address-cells = <2>;
		#size-cells = <2>;

		iommu {
			/*
			 * This is somewhat unusual (or maybe not) in that we
			 * need 2 cells to represent the size of an address
			 * space that is 32 bits long.
			 */
			#address-cells = <1>;
			#size-cells = <2>;

			#iommu-cells = <1>;
		};

		master {
			iommus = <&/iommu 42>;
			/*
			 * Map I/O addresses 0 - 4 GiB to physical addresses
			 * 2 GiB - 6 GiB.
			 */
			dma-ranges = <0x00000000 0 0x80000000 1 0>;
		};
	};

This is somewhat incompatible with [0] in that #address-cells used to
parse the child address must be taken from the iommu node rather than
the child node. But that seems to me to be the only reasonable thing
to do, because after all the IOMMU creates a completely new address
space for the master.

[0]: http://www.openfirmware.org/ofwg/proposals/Closed/Accepted/410-it.txt

> My preferred option would be to always put the address range into
> the iommu descriptor, using the iommu's #address-cells.

That could become impossible to parse. I'm not sure if such hardware
actually exists, but if for some reason we have to split the address
range into two, then there's no longer any way to determine the size
needed for the specifier.

On the other hand what you propose makes it easy to represent multiple
master interfaces on a device. With a separate dma-ranges property how
can you define which ranges apply to which of the master interfaces?

Then again if address ranges can't be broken up in the first place, then
dma-ranges could be considered to be one entry per IOMMU in the iommus
property.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140519/4288a7e6/attachment-0001.sig>
