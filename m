From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Apr 2013 17:57:45 +0100
Subject: [PATCH] documentation: iommu: add description of ARM System MMU
 binding
In-Reply-To: <515EFF1A.5030705@gmail.com>
References: <1365094259-24847-1-git-send-email-will.deacon@arm.com>
 <515EFF1A.5030705@gmail.com>
Message-ID: <20130405165745.GB17151@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Apr 05, 2013 at 05:43:06PM +0100, Rob Herring wrote:
> On 04/04/2013 11:50 AM, Will Deacon wrote:
> > This patch adds a description of the device tree binding for the ARM
> > System MMU architecture.
> > 
> > Cc: Rob Herring <robherring2@gmail.com>
> > Cc: Andreas Herrmann <andreas.herrmann@calxeda.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> > 
> > Hello,
> > 
> > The driver for this is still a WIP. Both Andreas and myself have prototype
> > code, but we're planning to merge that together to get something more
> > general. Deciding on the binding is a good first step.
> 
> Thanks for getting this out.

No problem.

> > All comments welcome,
> > 
> > Will
> > 
> >  .../devicetree/bindings/iommu/arm,smmu.txt         | 61 ++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > new file mode 100644
> > index 0000000..938325f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > @@ -0,0 +1,61 @@
> > +* ARM System MMU Architecture Implementation
> > +
> > +ARM SoCs may contain an implementation of the ARM System Memory
> > +Management Unit Architecture, which can be used to provide 1 or 2 stages
> > +of address translation to bus masters external to the CPU.
> > +
> > +The SMMU may also raise interrupts in response to various fault
> > +conditions.
> > +
> > +** System MMU required properties:
> > +
> > +- compatible    : Should be one of "arm,smmu-v1" or "arm,smmu-v2"
> > +                  depending on the version of the architecture
> > +                  implemented.
> 
> We can keep these, but we should have specific models like arm,smmu-400,
> etc. as well.

Ok, if distinctions need to be between MMU-400 and a v1 implementation, then
we can add those strings later.

> > +
> > +- reg           : Base address and size of the SMMU.
> > +
> > +- #global-interrupts : The number of global interrupts exposed by the
> > +                       device.
> > +
> > +- interrupts    : Interrupt list, with the first #global-irqs entries
> > +                  corresponding to the global interrupts and any
> > +                  following entries corresponding to context interrupts,
> > +                  specified in order of their indexing by the SMMU.
> > +
> > +- mmu-masters   : A list of phandles to device nodes representing bus
> > +                  masters for which the SMMU can provide a translation.
> > +
> > +- stream-ids    : A list of 16-bit values corresponding to the StreamIDs
> > +                  for the devices listed in the mmu-masters property.
> > +                  This list must be same length as mmu-masters, so
> > +                  masters with multiple stream-ids will have multiple
> > +                  entries in mmu-masters.
> 
> Your example below is actually 32-bit values in the DTB. You can
> annotate them to actually be 16-bit if you want. But I would just leave
> them as 32-bit.

I'm also parsing them as u32 in my driver, so yes, u32 it is!

> > +
> > +** System MMU optional properties:
> > +
> > +- smmu-parent   : When multiple SMMUs are chained together, this
> > +                  property can be used to provide a phandle to the
> > +                  parent SMMU (that is the next SMMU on the path going
> > +                  from the mmu-masters towards memory) node for this
> > +                  SMMU.
> 
> Does the SMMU need to know if it is coherent or not?

You mean with respect to table walks? That's actually probable from the
device (along with a whole bunch of other parameters) using SMMU_IDR0.

I'll fix up the other comments and send out a v2 next week.

Cheers for the review,

Will
