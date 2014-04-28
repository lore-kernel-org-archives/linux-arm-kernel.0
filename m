From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Apr 2014 21:55 +0200
Subject: [PATCH v12 11/31] documentation: iommu: add binding document of
 Exynos System MMU
In-Reply-To: <20140428193056.GD22135@arm.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <4780885.JaktFvJeC7@wuerfel> <20140428193056.GD22135@arm.com>
Message-ID: <5242619.ZKgCdLW1L4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 April 2014 20:30:56 Will Deacon wrote:
> Hi Arnd,
> 
> [and thanks Thierry for CCing me -- I have been tangled up with this before
> :)]
> 
> On Mon, Apr 28, 2014 at 01:05:30PM +0100, Arnd Bergmann wrote:
> > On Monday 28 April 2014 13:18:03 Thierry Reding wrote:
> > > There still has to be one cell to specify which master. Unless perhaps
> > > if they can be arbitrarily assigned. I guess even if there's a fixed
> > > mapping that applies to one SoC generation, it might be good to still
> > > employ a specifier and have the mapping in DT for flexibility.
> > 
> > let me clarify by example:
> > 
> > 	iommu at 1 {
> > 		compatible = "some,simple-iommu";
> > 		reg = <1>;
> > 		#iommu-cells = <0>; /* supports only one master */
> > 	};
> > 
> > 	iommu at 2 {
> > 		compatible = "some,other-iommu";
> > 		reg = <3>;
> > 		#iommu-cells = <1>; /* contains master ID */
> > 	};
> > 
> > 	iommu at 3 {
> > 		compatible = "some,windowed-iommu";
> > 		reg = <2>;
> > 		#iommu-cells = <2>; /* contains dma-window */
> > 	};
> > 
> > 	device at 4 {
> > 		compatible = "some,ethernet";
> > 		iommus = <&/iommu@1>;
> > 	};
> > 
> > 	device at 5 {
> > 		compatible = "some,dmaengine";
> > 		iommus = <&/iommu@2 0x40000000 0x1000000>,
> > 			 <&/iommu@3 0x101>;
> > 	};
> > 
> > The device at address 4 has a one-one relationship with iommu at 1, so there
> > is no need for any data. device at 5 has two master ports. One is connected to
> > an IOMMU that has a per-device aperture, device at 5 can only issue transfers
> > to the 256MB area at 0x40000000, and the IOMMU will have to put entries for
> > this device into that address. The second master port is connected to
> > iommu at 3, which uses a master ID that gets passed along with each transfer,
> > so that needs to be put into the IOTLBs.
> 
> I think this is definitely going in the right direction, but it's not clear
> to me how the driver for device at 5 knows how to configure the two ports.
> We're still lacking topology information (unless that's implicit in the
> ordering of the properties) to say how the mastering capabilities of the
> device are actually routed and configured.

It would be helpful to have a concrete example of a device that has multiple
masters. I have heard people mention this multiple times, and I can understand
how it might be wired up in hardware, but I don't know what it's good for,
or who would actually do it.

> > A variation would be to not use #iommu-cells at all, but provide a
> > #address-cells / #size-cells pair in the IOMMU, and have a translation
> > as we do for dma-ranges. This is probably most flexible.
> 
> That would also allow us to describe ranges of master IDs, which we need for
> things like PCI RCs on the ARM SMMU. Furthermore, basic transformations of
> these ranges could also be described like this, although I think Dave (CC'd)
> has some similar ideas in this area.

Good point.

	ARnd
