From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Mon, 5 Mar 2018 15:00:37 +0000
Subject: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
In-Reply-To: <5cdeded1-ca3c-339a-bf73-73401e7dd4ed@arm.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
 <5cdeded1-ca3c-339a-bf73-73401e7dd4ed@arm.com>
Message-ID: <HE1PR0401MB24254CBDB8B6F537D08B925DE6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Monday, March 05, 2018 20:23
> To: Nipun Gupta <nipun.gupta@nxp.com>; will.deacon at arm.com;
> mark.rutland at arm.com; catalin.marinas at arm.com
> Cc: iommu at lists.linux-foundation.org; robh+dt at kernel.org; hch at lst.de;
> m.szyprowski at samsung.com; gregkh at linuxfoundation.org; joro at 8bytes.org;
> Leo Li <leoyang.li@nxp.com>; shawnguo at kernel.org; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linuxppc-dev at lists.ozlabs.org; Bharat Bhushan
> <bharat.bhushan@nxp.com>; stuyoder at gmail.com; Laurentiu Tudor
> <laurentiu.tudor@nxp.com>
> Subject: Re: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
> 
> On 05/03/18 14:29, Nipun Gupta wrote:
> > The existing IOMMU bindings cannot be used to specify the relationship
> > between fsl-mc devices and IOMMUs. This patch adds a binding for
> > mapping fsl-mc devices to IOMMUs, using a new iommu-parent property.
> 
> Given that allowing "msi-parent" for #msi-cells > 1 is merely a
> backward-compatibility bodge full of hard-coded assumptions, why would
> we want to knowingly introduce a similarly unpleasant equivalent for
> IOMMUs? What's wrong with "iommu-map"?

Hi Robin,

With 'msi-parent' the property is fixed up to have msi-map. In this case there is
no fixup required and simple 'iommu-parent' property can be used, with MC bus
itself providing the stream-id's (in the code execution via FW).

We can also use the iommu-map property similar to PCI, which will require u-boot
fixup. But then it leads to little bit complications of u-boot - kernel compatibility.

If you suggest we can re-use the iommu-map property. What is your opinion?

Thanks,
Nipun

> 
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > ---
> >   .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 31
> ++++++++++++++++++++++
> >   1 file changed, 31 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > index 6611a7c..011c7d6 100644
> > --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > @@ -9,6 +9,24 @@ blocks that can be used to create functional hardware
> objects/devices
> >   such as network interfaces, crypto accelerator instances, L2 switches,
> >   etc.
> >
> > +For an overview of the DPAA2 architecture and fsl-mc bus see:
> > +drivers/staging/fsl-mc/README.txt
> > +
> > +As described in the above overview, all DPAA2 objects in a DPRC share the
> > +same hardware "isolation context" and a 10-bit value called an ICID
> > +(isolation context id) is expressed by the hardware to identify
> > +the requester.
> 
> IOW, precisely the case for which "{msi,iommu}-map" exist. Yes, I know
> they're currently documented under bindings/pci, but they're not really
> intended to be absolutely PCI-specific.
> 
> Robin.
> 
> > +The generic 'iommus' property is cannot be used to describe the relationship
> > +between fsl-mc and IOMMUs, so an iommu-parent property is used to define
> > +the same.
> > +
> > +For generic IOMMU bindings, see
> > +Documentation/devicetree/bindings/iommu/iommu.txt.
> > +
> > +For arm-smmu binding, see:
> > +Documentation/devicetree/bindings/iommu/arm,smmu.txt.
> > +
> >   Required properties:
> >
> >       - compatible
> > @@ -88,14 +106,27 @@ Sub-nodes:
> >                 Value type: <phandle>
> >                 Definition: Specifies the phandle to the PHY device node associated
> >                             with the this dpmac.
> > +Optional properties:
> > +
> > +- iommu-parent: Maps the devices on fsl-mc bus to an IOMMU.
> > +  The property specifies the IOMMU behind which the devices on
> > +  fsl-mc bus are residing.
> >
> >   Example:
> >
> > +        smmu: iommu at 5000000 {
> > +               compatible = "arm,mmu-500";
> > +               #iommu-cells = <1>;
> > +               stream-match-mask = <0x7C00>;
> > +               ...
> > +        };
> > +
> >           fsl_mc: fsl-mc at 80c000000 {
> >                   compatible = "fsl,qoriq-mc";
> >                   reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
> >                         <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
> >                   msi-parent = <&its>;
> > +                iommu-parent = <&smmu>;
> >                   #address-cells = <3>;
> >                   #size-cells = <1>;
> >
> >
