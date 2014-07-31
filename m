From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 31 Jul 2014 10:39:25 +0200
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140730152646.GC20162@leverpostej>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140730152646.GC20162@leverpostej>
Message-ID: <20140731083923.GA31218@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 04:26:47PM +0100, Mark Rutland wrote:
> Hi Thierry,
> 
> This looks sane to me.
> 
> I just have a few questions below which are hopefully simple/stupid.
> 
> On Fri, Jul 04, 2014 at 04:29:17PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > This commit introduces a generic device tree binding for IOMMU devices.
> > Only a very minimal subset is described here, but it is enough to cover
> > the requirements of both the Exynos System MMU and Tegra SMMU as
> > discussed here:
> > 
> >     https://lkml.org/lkml/2014/4/27/346
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v4:
> > - clarify that disabling an IOMMU DT node may not disable translation
> > - be more explicit that examples are only examples
> > - add multi-ID master example
> > 
> > Changes in v3:
> > - use #iommu-cells instead of #address-cells/#size-cells
> > - drop optional iommu-names property
> > 
> > Changes in v2:
> > - add notes about "dma-ranges" property (drop note from commit message)
> > - document priorities of "iommus" property vs. "dma-ranges" property
> > - drop #iommu-cells in favour of #address-cells and #size-cells
> > - remove multiple-master device example
> > 
> >  Documentation/devicetree/bindings/iommu/iommu.txt | 172 ++++++++++++++++++++++
> >  1 file changed, 172 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/iommu.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
> > new file mode 100644
> > index 000000000000..464a81eaaf61
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/iommu.txt
> > @@ -0,0 +1,172 @@
> > +This document describes the generic device tree binding for IOMMUs and their
> > +master(s).
> > +
> > +
> > +IOMMU device node:
> > +==================
> > +
> > +An IOMMU can provide the following services:
> > +
> > +* Remap address space to allow devices to access physical memory ranges that
> > +  they otherwise wouldn't be capable of accessing.
> > +
> > +  Example: 32-bit DMA to 64-bit physical addresses
> > +
> > +* Implement scatter-gather at page level granularity so that the device does
> > +  not have to.
> > +
> > +* Provide system protection against "rogue" DMA by forcing all accesses to go
> > +  through the IOMMU and faulting when encountering accesses to unmapped
> > +  address regions.
> > +
> > +* Provide address space isolation between multiple contexts.
> > +
> > +  Example: Virtualization
> > +
> > +Device nodes compatible with this binding represent hardware with some of the
> > +above capabilities.
> > +
> > +IOMMUs can be single-master or multiple-master. Single-master IOMMU devices
> > +typically have a fixed association to the master device, whereas multiple-
> > +master IOMMU devices can translate accesses from more than one master.
> > +
> > +The device tree node of the IOMMU device's parent bus must contain a valid
> > +"dma-ranges" property that describes how the physical address space of the
> > +IOMMU maps to memory. An empty "dma-ranges" property means that there is a
> > +1:1 mapping from IOMMU to memory.
> > +
> > +Required properties:
> > +--------------------
> > +- #iommu-cells: The number of cells in an IOMMU specifier needed to encode an
> > +  address.
> > +
> > +The meaning of the IOMMU specifier is defined by the device tree binding of
> > +the specific IOMMU. Below are a few examples of typical use-cases:
> > +
> > +- #iommu-cells = <0>: Single master IOMMU devices are not configurable and
> > +  therefore no additional information needs to be encoded in the specifier.
> > +  This may also apply to multiple master IOMMU devices that do not allow the
> > +  association of masters to be configured. Note that an IOMMU can by design
> > +  be multi-master yet only expose a single master in a given configuration.
> > +  In such cases the number of cells will usually be 1 as in the next case.
> > +- #iommu-cells = <1>: Multiple master IOMMU devices may need to be configured
> > +  in order to enable translation for a given master. In such cases the single
> > +  address cell corresponds to the master device's ID. In some cases more than
> > +  one cell can be required to represent a single master ID.
> > +- #iommu-cells = <4>: Some IOMMU devices allow the DMA window for masters to
> > +  be configured. The first cell of the address in this may contain the master
> > +  device's ID for example, while the second cell could contain the start of
> > +  the DMA window for the given device. The length of the DMA window is given
> > +  by the third and fourth cells.
> > +
> > +Note that these are merely examples and real-world use-cases may use different
> > +definitions to represent their individual needs. Always refer to the specific
> > +IOMMU binding for the exact meaning of the cells that make up the specifier.
> > +
> > +
> > +IOMMU master node:
> > +==================
> > +
> > +Devices that access memory through an IOMMU are called masters. A device can
> > +have multiple master interfaces (to one or more IOMMU devices).
> > +
> > +Required properties:
> > +--------------------
> > +- iommus: A list of phandle and IOMMU specifier pairs that describe the IOMMU
> > +  master interfaces of the device. One entry in the list describes one master
> > +  interface of the device.
> > +
> > +When an "iommus" property is specified in a device tree node, the IOMMU will
> > +be used for address translation. If a "dma-ranges" property exists in the
> > +device's parent node it will be ignored. An exception to this rule is if the
> > +referenced IOMMU is disabled, in which case the "dma-ranges" property of the
> > +parent shall take effect. Note that merely disabling a device tree node does
> > +not guarantee that the IOMMU is really disabled since the hardware may not
> > +have a means to turn off translation.
> > +
> > +
> > +Notes:
> > +======
> > +
> > +One possible extension to the above is to use an "iommus" property along with
> > +a "dma-ranges" property in a bus device node (such as PCI host bridges). This
> > +can be useful to describe how children on the bus relate to the IOMMU if they
> > +are not explicitly listed in the device tree (e.g. PCI devices). However, the
> > +requirements of that use-case haven't been fully determined yet. Implementing
> > +this is therefore not recommended without further discussion and extension of
> > +this binding.
> > +
> > +
> > +Examples:
> > +=========
> > +
> > +Single-master IOMMU:
> > +--------------------
> > +
> > +	iommu {
> > +		#iommu-cells = <0>;
> > +	};
> > +
> > +	master {
> > +		iommus = <&/iommu>;
> 
> Nit: this should be iommus = <&{/iommu}>, or it's not valid dts syntax.

Done.

> > +	};
> > +
> > +Multiple-master IOMMU with fixed associations:
> > +----------------------------------------------
> > +
> > +	/* multiple-master IOMMU */
> > +	iommu {
> > +		/*
> > +		 * Masters are statically associated with this IOMMU and
> > +		 * address translation is always enabled.
> > +		 */
> > +		#iommu-cells = <0>;
> 
> I don't follow why translation being always enabled is relevant to the
> example; that would seem to be independent from the binding.
> 
> Surely the key point is that with no way to distinguish devices, they
> presumably share the same translations?

Both aspects are important I think. For #iommu-cells = <0> there is no
way for the IOMMU driver to know how to enable translation for a given
device. So it must be either always on or always off.

I guess one could say that this is implicit if all masters share the
same translations. And I guess translations don't always have to be on
or off technically. Let me try to rephrase this:

		/*
		 * Masters are statically associated with this IOMMU and share
		 * the same address translations because the IOMMU does not
		 * have sufficient information to distinguish between masters.
		 *
		 * Consequently address translation is always on or off for
		 * all masters at any given point in time.
		 */

Does that sound better?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/8ff6544c/attachment.sig>
