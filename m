From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 15 May 2014 22:37:31 +0200
Subject: [PATCH v12 11/31] documentation: iommu: add binding document of
 Exynos System MMU
In-Reply-To: <4780885.JaktFvJeC7@wuerfel>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <6544270.ddFBoY6LMm@wuerfel> <20140428111802.GI19455@ulmo>
 <4780885.JaktFvJeC7@wuerfel>
Message-ID: <20140515203729.GA7136@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 02:05:30PM +0200, Arnd Bergmann wrote:
[...]
> let me clarify by example:
> 
> 	iommu at 1 {
> 		compatible = "some,simple-iommu";
> 		reg = <1>;
> 		#iommu-cells = <0>; /* supports only one master */
> 	};
> 
> 	iommu at 2 {
> 		compatible = "some,other-iommu";
> 		reg = <3>;
> 		#iommu-cells = <1>; /* contains master ID */
> 	};
> 
> 	iommu at 3 {
> 		compatible = "some,windowed-iommu";
> 		reg = <2>;
> 		#iommu-cells = <2>; /* contains dma-window */
> 	};
> 
> 	device at 4 {
> 		compatible = "some,ethernet";
> 		iommus = <&/iommu@1>;
> 	};
> 
> 	device at 5 {
> 		compatible = "some,dmaengine";
> 		iommus = <&/iommu@2 0x40000000 0x1000000>,
> 			 <&/iommu@3 0x101>;
> 	};
> 
> The device at address 4 has a one-one relationship with iommu at 1, so there
> is no need for any data. device at 5 has two master ports. One is connected to
> an IOMMU that has a per-device aperture, device at 5 can only issue transfers
> to the 256MB area at 0x40000000, and the IOMMU will have to put entries for
> this device into that address. The second master port is connected to
> iommu at 3, which uses a master ID that gets passed along with each transfer,
> so that needs to be put into the IOTLBs.

iommu at 3 and the second port of device at 5 seem to match what we need for
Tegra (and as I understand also Exynos). Can we settle on this for now
so that Hiroshi and Cho can go update their drivers for this binding?

> A variation would be to not use #iommu-cells at all, but provide a
> #address-cells / #size-cells pair in the IOMMU, and have a translation
> as we do for dma-ranges. This is probably most flexible.

The remainder of this discussion seems to indicate that #iommu-cells and
dma-ranges don't have to be mutually exclusive. For some IOMMUs it might
make sense to use both.

In fact perhaps we should require every IOMMU user to also specify a
dma-ranges property, even if for some cases the range would be simply
the complete physical address space. Perhaps in analogy to the ranges
property an empty dma-ranges property could be taken to mean all of the
physical address space.

I'm aware that this doesn't cover any of the more exotic cases out
there, but the fact is that we have real devices out there that ship
with some variations of these simple IOMMUs and I don't think we're
doing ourselves a favour by blocking support for these to be added on
the hope of merging the perfect solution that covers all use-cases.
Patches for Tegra have already been around for close to half a year.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/4fe81178/attachment.sig>
