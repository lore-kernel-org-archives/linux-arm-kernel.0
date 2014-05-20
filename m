From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 20 May 2014 13:05:37 +0200
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <5759340.gycj7cP1t3@wuerfel>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <14622654.QO8kH1AoTT@wuerfel> <20140519205945.GE30737@mithrandir>
 <5759340.gycj7cP1t3@wuerfel>
Message-ID: <20140520110536.GA10302@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 12:04:54PM +0200, Arnd Bergmann wrote:
> On Monday 19 May 2014 22:59:46 Thierry Reding wrote:
> > On Mon, May 19, 2014 at 08:34:07PM +0200, Arnd Bergmann wrote:
> > > On Monday 19 May 2014 14:53:37 Thierry Reding wrote:
> > > > On Mon, May 19, 2014 at 12:26:35PM +0200, Arnd Bergmann wrote:
> > > > > On Friday 16 May 2014 14:23:18 Thierry Reding wrote:
> > > > > > From: Thierry Reding <treding@nvidia.com>
[...]
> > > > > Finally, it makes no sense to use the dma-ranges property of the master's
> > > > > parent bus, because that bus isn't actually involved in the translation.
> > > > 
> > > > My understanding here is mostly based on the OpenFirmware working group
> > > > proposal for the dma-ranges property[0]. I'll give another example to
> > > > try and clarify how I had imagined this to work:
> > > > 
> > > > 	/ {
> > > > 		#address-cells = <2>;
> > > > 		#size-cells = <2>;
> > > > 
> > > > 		iommu {
> > > > 			/*
> > > > 			 * This is somewhat unusual (or maybe not) in that we
> > > > 			 * need 2 cells to represent the size of an address
> > > > 			 * space that is 32 bits long.
> > > > 			 */
> > > > 			#address-cells = <1>;
> > > > 			#size-cells = <2>;
> > > 
> > > You should never need #size-cells > #address-cells
> > 
> > That was always my impression as well. But how then do you represent the
> > full 4 GiB address space in a 32-bit system? It starts at 0 and ends at
> > 4 GiB - 1, which makes it 4 GiB large. That's:
> > 
> > 	<0 1 0>
> > 
> > With #address-cells = <1> and #size-cells = <1> the best you can do is:
> > 
> > 	<0 0xffffffff>
> > 
> > but that's not accurate.
> 
> I think we've done both in the past, either extended #size-cells or
> taken 0xffffffff as a special token. Note that in your example,
> the iommu actually needs #address-cells = <2> anyway.

But it needs #address-cells = <2> only to encode an ID in addition to
the address. If this was a single-master IOMMU then there'd be no need
for the ID.

This really isn't specific to IOMMUs though. It really applies to all
cases where #address-cells and #size-cells are parsed. While it's way
too late to change the semantics of standard properties, perhaps for
properties that are introduced it would make more sense to encode this
as a <start limit> pair, both of length #address-cells, to avoid this
type of corner case.

On the other hand doing so would make it inconsistent with existing
bindings which may not be desirable either.

But since it seems like we're headed for something completely different
for IOMMUs, perhaps it would be worth considering to describe the IOMMU
range as <start limit>. Since it will likely use #iommu-cells rather
than #address-cells we have an opportunity to change the semantics.

> > > Let me do another example, with the address merged into the iommu
> > > references:
> > > 
> > > / {
> > > 	#address-cells = <2>; // 64-bit address
> > > 	#size-cells = <2>;
> > > 
> > > 	iommu at a {
> > > 		#address-cells = <2>; // 1 cell ID, 1 cell address
> > > 		#size-cells = <1>;
> > > 
> > > 		// no need for #iommu-cells
> > > 	};
> > > 
> > > 
> > > 	master at b {
> > > 		iommus = <&/iommu@a // iommu
> > > 			0x23  	     // ID
> > > 			0x40000000   // window start
> > > 			0x10000000>; //window size
> > > 	};
> > > };
> > > 
> > > A disadvantage of this model would be that for all ARM SMMU users, we'd
> > > have to always list a 4GB address space, which is kind of redundant.
> > 
> > Isn't that the equivalent of the "whole address space" default that I
> > mentioned in the commit message? Could this be handled with
> > #address-cells = <1> and #size-cells = <0> in the iommu node? That way
> > the only cell that needs to be specified in iommus would be the ID and
> > the redundant address space could be simply omitted from DT since it
> > would be implied by the compatible string.
> 
> Yes, that's right. After giving it some more thought, I agree that the
> #size-cells case makes sense as an indicator for cases where the master
> doesn't have to care about the address at all and no further translation
> with dma-ranges is possible.
> 
> Back to my example with dma-ranges, the simplest case would an IOMMU
> that has an ID per bus, with multiple masters sharing that ID:
> 
> / {
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 
> 	iommu {
> 		#address-cells = <2>; // ID, address
> 		#size-cells = <2>;
> 	};
> 
> 	master at a {
> 		iommus = <& {/iommu} 0xa 0x0  0x1 0x0>; // 4GB ID '0xa'
> 	}
> 
> 	bus1 {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		ranges;
> 		iommus = <& {/iommu} 0 0   0x100 0>; // all IDs
> 		dma-ranges = <0  0xb 0  1 0>; // child devices use ID '0xb'
> 
> 		anothermaster {
> 			// no iommus link, implied by dma-ranges above
> 		};
> 	};
> };
> 
> If you set #size-cells=<0>, you can't really do that but instead would
> require an iommus property in each master, which is not a big concern
> either.

I'm not sure I understand the need for 0x100 (all IDs) entry above. If
bus1's iommus property applies to all devices on the bus, why can't the
ID 0xb be listed in the iommus property?

	bus1 {
		#address-cells = <1>;
		#size-cells = <1>;
		ranges;
		iommus = <&{/iommu} 0xb 0  0x1 0x0>; // 4GB ID '0xb'
		dma-ranges = <0  0xb 0  0x1 0x0>;

		anothermaster {
			...
		};
	};

In which case I guess dma-ranges would be redundant.

> The main advantage I think would be for IOMMUs that use the PCI b/d/f
> numbers as IDs. These can have #address-cells=<3>, #size-cells=<2>
> and have an empty dma-ranges property in the PCI host bridge node,
> and interpret this as using the same encoding as the PCI BARs in
> the ranges property.

I'm somewhat confused here, since you said earlier:

> After giving the ranges stuff some more thought, I have come to the
> conclusion that using #iommu-cells should work fine for almost
> all cases, including windowed iommus, because the window is not
> actually needed in the device, but only in the iommu, wihch is of course
> free to interpret the arguments as addresses.

But now you seem to be saying that we should still be using the
#address-cells and #size-cells properties in the IOMMU node to determine
the length of the specifier.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/54105368/attachment-0001.sig>
