From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Aug 2014 14:14:08 +0100
Subject: [PATCH v5] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <87tx5ehr62.fsf@nvidia.com>
References: <1406803383-11601-1-git-send-email-thierry.reding@gmail.com>
 <87a9774lf5.fsf@nvidia.com> <20140815115110.GO27466@arm.com>
 <87tx5ehr62.fsf@nvidia.com>
Message-ID: <20140815131407.GS27466@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 01:29:41PM +0100, Hiroshi Doyu wrote:
> Will Deacon <will.deacon@arm.com> writes:
> > I think there's some confusion here. The ARM architected SMMU does not
> > perform any StreamID translation -- it sees an incoming ID and uses that to
> > lookup a set of translation tables. However, for hotpluggable buses (e.g.
> > PCI), we need a way to communicate the StreamIDs for a newly discovered
> > device to the SMMU. I expect that this would be described as a translation
> > from another ID (e.g. requester id for PCI), so *that* is where the
> > translation occurs.
> >
> > This translation can be described as a simple base + offset calculation,
> > e.g. StreamID = RequesterID + offset. Ideally, you'd have one offset per
> > host controller (and described in the host controller DT node), but you
> > could also imagine building tables where each RequesterID maps to a
> > different StreamID.
> >
> > The final thing to mention is that some SoCs may have device hotplug
> > architectures that aren't like PCIe, so we may well need glue code there to
> > `allocate' StreamIDs from a fixed portion of the numberspace.
> 
> Ok, I can assume that, when parsing generic IOMMU binding, SoC specific
> callback could be called from ARM,SMMU driver to assign allocated
> "StreamIDs" to thier "RequesterIDs".

The mapping should be done as part of the ->add_device callback, at the same
time as the iommu_group initialisation.

> IOW, IOMMU generic binding for ARM,SMMU can have RequresterID instead of
> StreamID.
> 
>   Not:
>   	iommus = <&{/arm-smmu} "StreamID">;
>   
>   Instead, can be:
>   	iommus = <&{/arm-smmu} "RequresterID">;
> 
> If I extend the above, even ARM,SMMU driver could have any number of
> params, which SoC requires with keeping "arm,mmu-*" compatibility?
> 
>   	iommus = <&{/arm-msmmu} param1 param2 param3 param4 .....>;
> 
> How to parse params depends on SoC. Parsing params is done at SoC
> callback, right?

No, I still don't think this is quite right. The SMMU deals with StreamIDs.
End of story. However, for a hotpluggable bus, you may need to determine
that StreamID from another dynamic ID. In the case of PCI, you can
dynamically find the RequesterID, then we'd just have an offset in the DT
node for the PCI host controller that describes how that maps to the StreamID.

So actually, we need to treat host controllers differently from end-points
in the binding, which would allow us to describe these transformations.

Will
