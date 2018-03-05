From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Mon, 5 Mar 2018 15:54:34 +0000
Subject: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
In-Reply-To: <f382e92a-8ab5-7c93-1f39-fe6797e5c876@arm.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
 <5cdeded1-ca3c-339a-bf73-73401e7dd4ed@arm.com>
 <HE1PR0401MB24254CBDB8B6F537D08B925DE6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
 <f382e92a-8ab5-7c93-1f39-fe6797e5c876@arm.com>
Message-ID: <HE1PR0401MB2425F261CA777DAA1D41A477E6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Monday, March 05, 2018 21:07
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
> On 05/03/18 15:00, Nipun Gupta wrote:
> >
> >
> >> -----Original Message-----
> >> From: Robin Murphy [mailto:robin.murphy at arm.com]
> >> Sent: Monday, March 05, 2018 20:23
> >> To: Nipun Gupta <nipun.gupta@nxp.com>; will.deacon at arm.com;
> >> mark.rutland at arm.com; catalin.marinas at arm.com
> >> Cc: iommu at lists.linux-foundation.org; robh+dt at kernel.org; hch at lst.de;
> >> m.szyprowski at samsung.com; gregkh at linuxfoundation.org;
> joro at 8bytes.org;
> >> Leo Li <leoyang.li@nxp.com>; shawnguo at kernel.org; linux-
> >> kernel at vger.kernel.org; devicetree at vger.kernel.org; linux-arm-
> >> kernel at lists.infradead.org; linuxppc-dev at lists.ozlabs.org; Bharat Bhushan
> >> <bharat.bhushan@nxp.com>; stuyoder at gmail.com; Laurentiu Tudor
> >> <laurentiu.tudor@nxp.com>
> >> Subject: Re: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree
> binding
> >>
> >> On 05/03/18 14:29, Nipun Gupta wrote:
> >>> The existing IOMMU bindings cannot be used to specify the relationship
> >>> between fsl-mc devices and IOMMUs. This patch adds a binding for
> >>> mapping fsl-mc devices to IOMMUs, using a new iommu-parent property.
> >>
> >> Given that allowing "msi-parent" for #msi-cells > 1 is merely a
> >> backward-compatibility bodge full of hard-coded assumptions, why would
> >> we want to knowingly introduce a similarly unpleasant equivalent for
> >> IOMMUs? What's wrong with "iommu-map"?
> >
> > Hi Robin,
> >
> > With 'msi-parent' the property is fixed up to have msi-map. In this case there is
> > no fixup required and simple 'iommu-parent' property can be used, with MC
> bus
> > itself providing the stream-id's (in the code execution via FW).
> >
> > We can also use the iommu-map property similar to PCI, which will require u-
> boot
> > fixup. But then it leads to little bit complications of u-boot - kernel
> compatibility.
> 
> What needs fixing up? With a stream-map-mask in place to ignore the
> upper Stream ID bits, you just need:
> 
> 	iommu-map = <0 &smmu 0 0x80>;
> 
> to say that the lower bits of the ICID value map directly to the lower
> bits of the Stream ID value - that's the same fixed property of the
> hardware that you're wanting to assume in iommu-parent.

Makes sense. I was going in a little bit wrong direction. Thanks for correcting.
I will send v2 patchset with iommu-map property.

Regards,
Nipun

> 
> > If you suggest we can re-use the iommu-map property. What is your opinion?
> 
> I think it makes a lot more sense to directly use the property which
> already exists, than to introduce a new one to merely assume one
> hard-coded value of the existing one. Extending msi-parent to msi-map
> was a case of "oops, it turns out we need more flexibility here"; for
> the case of iommu-map I can't imagine any justification for saying
> "oops, we need less flexibility here" (saving 9 whole bytes in the DT
> really is irrelevant).
> 
> Robin.
