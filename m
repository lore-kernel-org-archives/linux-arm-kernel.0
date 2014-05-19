From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 19 May 2014 22:59:46 +0200
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <14622654.QO8kH1AoTT@wuerfel>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <4391809.OTRCiJQXS4@wuerfel> <20140519125336.GA9466@ulmo>
 <14622654.QO8kH1AoTT@wuerfel>
Message-ID: <20140519205945.GE30737@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 08:34:07PM +0200, Arnd Bergmann wrote:
> On Monday 19 May 2014 14:53:37 Thierry Reding wrote:
> > On Mon, May 19, 2014 at 12:26:35PM +0200, Arnd Bergmann wrote:
> > > On Friday 16 May 2014 14:23:18 Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > > 
> > > > This commit introduces a generic device tree binding for IOMMU devices.
> > > > Only a very minimal subset is described here, but it is enough to cover
> > > > the requirements of both the Exynos System MMU and Tegra SMMU as
> > > > discussed here:
> > > > 
> > > >     https://lkml.org/lkml/2014/4/27/346
> > > > 
> > > > More advanced functionality such as the dma-ranges property can easily
> > > > be added in a backwards-compatible way. In the absence of a dma-ranges
> > > > property it should be safe to default to the whole address space.
> > > > 
> > > 
> > > The basic binding looks fine, but I'd like it to be more explicit
> > > about dma-ranges. Most importantly, what does "the whole address space"
> > > mean?
> > 
> > The whole point was to leave out any mention of dma-ranges from the
> > binding until we've figured out more of the puzzle.
> > 
> > So what I was trying to avoid was another lengthy discussion on the
> > topic of dma-ranges. Oh well... =)
> 
> I think that can't work, because we need a way to specify the
> ranges for some iommu drivers. We have to make sure we at least
> don't prevent it from working.

That was precisely why I wanted to let this out of the binding for now
so that we can actually focus on making existing hardware work rather
than speculate about what we may or may not need.

If you think the current minimal binding will cause future use-cases to
break, then we should change it to avoid that. What you're proposing is
to make the binding more complex on the assumption that we'll get it
right.

Wouldn't it be safer to keep things to the bare minimum necessary to
represent hardware that we have access to and understand now, rather
than speculating about what may be necessary at some point. I'd much
prefer to add complexity on an as-needed basis and when we have a better
understand of where we're headed.

> > > Finally, it makes no sense to use the dma-ranges property of the master's
> > > parent bus, because that bus isn't actually involved in the translation.
> > 
> > My understanding here is mostly based on the OpenFirmware working group
> > proposal for the dma-ranges property[0]. I'll give another example to
> > try and clarify how I had imagined this to work:
> > 
> > 	/ {
> > 		#address-cells = <2>;
> > 		#size-cells = <2>;
> > 
> > 		iommu {
> > 			/*
> > 			 * This is somewhat unusual (or maybe not) in that we
> > 			 * need 2 cells to represent the size of an address
> > 			 * space that is 32 bits long.
> > 			 */
> > 			#address-cells = <1>;
> > 			#size-cells = <2>;
> 
> You should never need #size-cells > #address-cells

That was always my impression as well. But how then do you represent the
full 4 GiB address space in a 32-bit system? It starts at 0 and ends at
4 GiB - 1, which makes it 4 GiB large. That's:

	<0 1 0>

With #address-cells = <1> and #size-cells = <1> the best you can do is:

	<0 0xffffffff>

but that's not accurate.

> > 			#iommu-cells = <1>;
> > 		};
> > 
> > 		master {
> > 			iommus = <&/iommu 42>;
> > 			/*
> > 			 * Map I/O addresses 0 - 4 GiB to physical addresses
> > 			 * 2 GiB - 6 GiB.
> > 			 */
> > 			dma-ranges = <0x00000000 0 0x80000000 1 0>;
> > 		};
> > 	};
> > 
> > This is somewhat incompatible with [0] in that #address-cells used to
> > parse the child address must be taken from the iommu node rather than
> > the child node. But that seems to me to be the only reasonable thing
> > to do, because after all the IOMMU creates a completely new address
> > space for the master.
> > 
> > [0]: http://www.openfirmware.org/ofwg/proposals/Closed/Accepted/410-it.txt
> 
> I don't think you can have a dma-ranges without a #address-cells and
> #size-cells property in the same node. In your example, I'd also expect
> a child node below 'master' that then interprets the address space
> made up by dma-ranges.

Okay, so what Dave and you have been saying strongly indicates that
dma-ranges isn't the right thing to use here.

> As a comment on the numbers in your example, I don't expect to ever
> see a 4GB IOMMU address space that doesn't start at an offset. Instead
> I'd expect either addresses that encode a device ID, or those that
> are just a subset of the parent address space, with non-overlapping
> bus addresses for each master.

As I understand the Tegra SMMU allows each of the clients to be assigned
a separate address space (4 GiB on earlier generations and 16 GiB on new
generations) and all addresses in each address space can be mapped to
arbitrary physical addresses.

> > > My preferred option would be to always put the address range into
> > > the iommu descriptor, using the iommu's #address-cells.
> > 
> > That could become impossible to parse. I'm not sure if such hardware
> > actually exists, but if for some reason we have to split the address
> > range into two, then there's no longer any way to determine the size
> > needed for the specifier.
> > 
> > On the other hand what you propose makes it easy to represent multiple
> > master interfaces on a device. With a separate dma-ranges property how
> > can you define which ranges apply to which of the master interfaces?
> 
> Well, you could have multiple links to the same IOMMU if you want to 
> do that, and define that there must be at least one dma-ranges entry
> for each IOMMU entry (although not necessarily the other way round,
> you could have direct ranges in addition to translated ones.
> 
> > Then again if address ranges can't be broken up in the first place, then
> > dma-ranges could be considered to be one entry per IOMMU in the iommus
> > property.
> 
> Let me do another example, with the address merged into the iommu
> references:
> 
> / {
> 	#address-cells = <2>; // 64-bit address
> 	#size-cells = <2>;
> 
> 	iommu at a {
> 		#address-cells = <2>; // 1 cell ID, 1 cell address
> 		#size-cells = <1>;
> 
> 		// no need for #iommu-cells
> 	};
> 
> 
> 	master at b {
> 		iommus = <&/iommu@a // iommu
> 			0x23  	     // ID
> 			0x40000000   // window start
> 			0x10000000>; //window size
> 	};
> };
> 
> A disadvantage of this model would be that for all ARM SMMU users, we'd
> have to always list a 4GB address space, which is kind of redundant.

Isn't that the equivalent of the "whole address space" default that I
mentioned in the commit message? Could this be handled with
#address-cells = <1> and #size-cells = <0> in the iommu node? That way
the only cell that needs to be specified in iommus would be the ID and
the redundant address space could be simply omitted from DT since it
would be implied by the compatible string.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140519/d1d25a4b/attachment-0001.sig>
