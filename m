From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Jun 2013 14:39:41 +0100
Subject: [PATCH 7/9] documentation: iommu: add description of ARM System
 MMU binding
In-Reply-To: <CALRxmdBxFWoRKv+bUu8VEwNNcAJUej9jM2V8N0rrqrr_Vpe8fQ@mail.gmail.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-8-git-send-email-will.deacon@arm.com>
 <CALRxmdBxFWoRKv+bUu8VEwNNcAJUej9jM2V8N0rrqrr_Vpe8fQ@mail.gmail.com>
Message-ID: <20130626133941.GD7417@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stuart,

On Tue, Jun 25, 2013 at 08:18:19PM +0100, Stuart Yoder wrote:
> On Mon, Jun 10, 2013 at 1:34 PM, Will Deacon <will.deacon@arm.com> wrote:
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > new file mode 100644
> > index 0000000..e34c6cd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > @@ -0,0 +1,70 @@
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
> > +- compatible    : Should be one of:
> > +
> > +                        "arm,smmu-v1"
> > +                        "arm,smmu-v2"
> > +                        "arm,mmu-400"
> > +                        "arm,mmu-500"
> > +
> > +                  depending on the particular implementation and/or the
> > +                  version of the architecture implemented.
> > +
> > +- reg           : Base address and size of the SMMU.
> > +
> > +- #global-interrupts : The number of global interrupts exposed by the
> > +                       device.
> > +
> > +- interrupts    : Interrupt list, with the first #global-irqs entries
> > +                  corresponding to the global interrupts
> 
> It seems like we don't have enough information here.   It's not enough
> for the OS to know that there are 2, 4, etc global interrupts, no?  It needs
> to know which hardware interrupt each corresponds to.   That kind of
> stuff is normally defined in the device binding.
> 
> What is it that determines the number of global interrupts?

I'd suggest looking at the driver I posted to get a gist of how the parsing
code works, but suffice to say that we describe both the number of
interrupts and the actual interrupt numbers here.

> > +- mmu-masters   : A list of phandles to device nodes representing bus
> > +                  masters for which the SMMU can provide a translation
> > +                  and their corresponding StreamIDs (see example below).
> > +                  Each device node linked from this list must have a
> > +                  "#stream-id-cells" property, indicating the number of
> > +                  StreamIDs associated with it.
> 
> So to find a the SMMU for a given device, I walk up the bus hierarchy
> until I find an SMMU?

Again, the code is better than any explanation I can give here, but we
basically construct a tree of masters for each SMMU in the system based on
the mmu-masters property, which we can later search.

> > +** System MMU optional properties:
> > +
> > +- smmu-parent   : When multiple SMMUs are chained together, this
> > +                  property can be used to provide a phandle to the
> > +                  parent SMMU (that is the next SMMU on the path going
> > +                  from the mmu-masters towards memory) node for this
> > +                  SMMU.
> 
> Why is an explicit phandle link needed here when you don't need a
> smmu-parent phandle in each mmu-master?    Won't walking the bus
> hierarchy identify the parent SMMU if things are chained?

What bus hierarchy? If I have two SMMU device nodes, how do I infer any
topological information without an explicit linkage?

Will
