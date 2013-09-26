From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 25 Sep 2013 19:49:27 -0700
Subject: [PATCH 8/8] KVM: arm-vgic: Support CPU interface reg access
In-Reply-To: <CEC73A07-C13E-420E-AE3C-49D30BEAB156@suse.de>
References: <1377285606-15692-1-git-send-email-christoffer.dall@linaro.org>
 <1377285606-15692-9-git-send-email-christoffer.dall@linaro.org>
 <05BF567A-DD8A-4226-A51F-0D661F4D7EB2@suse.de>
 <20130925211150.GH32311@cbox>
 <BD74C365-718A-4946-AC27-21BADEF6F0DC@suse.de>
 <20130926005437.GI32311@cbox>
 <CEC73A07-C13E-420E-AE3C-49D30BEAB156@suse.de>
Message-ID: <20130926024927.GJ32311@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 03:15:47AM +0200, Alexander Graf wrote:
> 
> On 26.09.2013, at 02:54, Christoffer Dall wrote:
> 
> > On Thu, Sep 26, 2013 at 12:37:03AM +0200, Alexander Graf wrote:
> >> 
> >> On 25.09.2013, at 23:30, Christoffer Dall wrote:
> >> 
> >>> On Sun, Aug 25, 2013 at 04:24:20PM +0100, Alexander Graf wrote:
> >>>> 
> >>>> On 23.08.2013, at 20:20, Christoffer Dall wrote:
> >>>> 
> >>>>> Implement support for the CPU interface register access driven by MMIO
> >>>>> address offsets from the CPU interface base address.  Useful for user
> >>>>> space to support save/restore of the VGIC state.
> >>>>> 
> >>>>> This commit adds support only for the same logic as the current VGIC
> >>>>> support, and no more.  For example, the active priority registers are
> >>>>> handled as RAZ/WI, just like setting priorities on the emulated
> >>>>> distributor.
> >>>>> 
> >>>>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> >>>>> ---
> >>>>> virt/kvm/arm/vgic.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++----
> >>>>> 1 file changed, 62 insertions(+), 4 deletions(-)
> >>>>> 
> >>>>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> >>>>> index d44b5a1..257dbae 100644
> >>>>> --- a/virt/kvm/arm/vgic.c
> >>>>> +++ b/virt/kvm/arm/vgic.c
> >>>>> @@ -1684,9 +1684,67 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
> >>>>> static bool handle_cpu_mmio_misc(struct kvm_vcpu *vcpu,
> >>>>> 				 struct kvm_exit_mmio *mmio, phys_addr_t offset)
> >>>>> {
> >>>>> -	return true;
> >>>>> +	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> >>>>> +	u32 reg, mask = 0, shift = 0;
> >>>>> +	bool updated = false;
> >>>>> +
> >>>>> +	switch (offset & ~0x3) {
> >>>>> +	case GIC_CPU_CTRL:
> >>>>> +		mask = GICH_VMCR_CTRL_MASK;
> >>>>> +		shift = GICH_VMCR_CTRL_SHIFT;
> >>>>> +		break;
> >>>>> +	case GIC_CPU_PRIMASK:
> >>>>> +		mask = GICH_VMCR_PRIMASK_MASK;
> >>>>> +		shift = GICH_VMCR_PRIMASK_SHIFT;
> >>>>> +		break;
> >>>>> +	case GIC_CPU_BINPOINT:
> >>>>> +		mask = GICH_VMCR_BINPOINT_MASK;
> >>>>> +		shift = GICH_VMCR_BINPOINT_SHIFT;
> >>>>> +		break;
> >>>>> +	case GIC_CPU_ALIAS_BINPOINT:
> >>>>> +		mask = GICH_VMCR_ALIAS_BINPOINT_MASK;
> >>>>> +		shift = GICH_VMCR_ALIAS_BINPOINT_SHIFT;
> >>>>> +		break;
> >>>>> +	}
> >>>>> +
> >>>>> +	if (!mmio->is_write) {
> >>>>> +		reg = (vgic_cpu->vgic_vmcr & mask) >> shift;
> >>>>> +		memcpy(mmio->data, &reg, sizeof(reg));
> >>>>> +	} else {
> >>>>> +		memcpy(&reg, mmio->data, sizeof(reg));
> >>>>> +		reg = (reg << shift) & mask;
> >>>>> +		if (reg != (vgic_cpu->vgic_vmcr & mask))
> >>>>> +			updated = true;
> >>>>> +		vgic_cpu->vgic_vmcr &= ~mask;
> >>>>> +		vgic_cpu->vgic_vmcr |= reg;
> >>>>> +	}
> >>>>> +	return updated;
> >>>>> +}
> >>>>> +
> >>>>> +static bool handle_mmio_abpr(struct kvm_vcpu *vcpu,
> >>>>> +			     struct kvm_exit_mmio *mmio, phys_addr_t offset)
> >>>>> +{
> >>>>> +	return handle_cpu_mmio_misc(vcpu, mmio, GIC_CPU_ALIAS_BINPOINT);
> >>>>> +}
> >>>>> +
> >>>>> +static bool handle_cpu_mmio_ident(struct kvm_vcpu *vcpu,
> >>>>> +				  struct kvm_exit_mmio *mmio,
> >>>>> +				  phys_addr_t offset)
> >>>>> +{
> >>>>> +	u32 reg;
> >>>>> +
> >>>>> +	if (mmio->is_write)
> >>>>> +		return false;
> >>>>> +
> >>>>> +	reg = 0x0002043B;
> >>>> 
> >>>> This wants a comment and probably also a #define :).
> >>>> 
> >>> 
> >>> Marc, where does the 0x4b0 product id code come from for the distributor
> >>> IIDR?
> >>> 
> >>> Would this be satisfying?
> 
> ^
> 
> >>> 
> >>> 
> >>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> >>> index 5214424..558be38 100644
> >>> --- a/virt/kvm/arm/vgic.c
> >>> +++ b/virt/kvm/arm/vgic.c
> >>> @@ -71,6 +71,9 @@
> >>> #define VGIC_ADDR_UNDEF		(-1)
> >>> #define IS_VGIC_ADDR_UNDEF(_x)  ((_x) == VGIC_ADDR_UNDEF)
> >>> 
> >>> +#define GIC_PRODUCT_ID		0x4b0
> >> 
> >> This is a specific GIC version. PL390 for example is 0x3b0:
> >> 
> >>  http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0416b/Beiggeba.html
> >> 
> >> That should be reflected in the #define. If it means "GICv2" then it should be GICV2_PRODUCT_ID for example.
> >> 
> > 
> > I know what field in the register it is thanks :)
> > 
> > But I couldn't find 0x4b0 anywhere in the docs, so I'm asking
> > Marc where he got it from.  I don't believe it means GICv2, but a
> 
> Ah, ok. Then the answer to your question above is a simple "no" as the name doesn't really tell us everything we want to know yet :).
> 
> > specific implementation of a GICv2, and once I have more info I can
> > change the define name, I suspect this is potentially something made-up
> > to indicate that this is the KVM VGIC...
> 
> Hrm, makes sense. So that also explains why there's a special version field.
> 
> > 
> >>> +#define ARM_JEP106_IMPLEMENTER	0x43b
> >> 
> >> I think naming this JEP106_IMPLEMENTER_ARM makes it more obvious that we're talking about the implementer code for ARM. Or maybe just only IMPLEMENTER_ARM.
> >> 
> > 
> > ok
> > 
> >>> +
> >>> /* Physical address of vgic virtual cpu interface */
> >>> static phys_addr_t vgic_vcpu_base;
> >>> 
> >>> @@ -331,7 +334,7 @@ static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
> >>> 		break;
> >>> 
> >>> 	case 8:			/* IIDR */
> >>> -		reg = 0x4B00043B;
> >>> +		reg = (GIC_PRODUCT_ID << 20) | ARM_JEP106_IMPLEMENTER;
> >>> 		vgic_reg_access(mmio, &reg, word_offset,
> >>> 				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
> >>> 		break;
> >>> @@ -1734,7 +1737,7 @@ static bool handle_cpu_mmio_ident(struct kvm_vcpu *vcpu,
> >>> 	if (mmio->is_write)
> >>> 		return false;
> >>> 
> >>> -	reg = 0x0002043B;
> >>> +	reg = (GIC_PRODUCT_ID << 20) | (0x2 << 16) | ARM_JEP106_IMPLEMENTER;
> >> 
> >> What is the 0x2 here?
> >> 
> >> 
> > 
> > GICv2, and now you're going to tell me to create a define for it right?
> > 
> > Which of course I can, but it's getting a bit silly, because then you
> > can ask me what is the field shifted at 16 bits, and the next question
> > is what is the GICC_IIDR, and at some point you're just going to have to
> > look up the definition of this specific register in the GIC specs.
> 
> The main point I'm trying to make is that someone should be able to figure out what these things mean without constantly having the spec next to him.
> 
> Having names to shifts helps with that too, yes. In other cases we try to use structs to make it easier for readers to understand what's going on, but that's quite hard with a u32 number :).
> 
> In fact, I even asked you despite having the spec open next to me. So yes, defines for the shifts do make sense.
> 
> I don't quite see the connection on why I would ask you what GICC_IIDR is though. I can easily google that or search in the spec for it. I can however not google 0x43b or 0x2 << 16.
> 
So, this essentially boils down to your "what a mess" comment in the
other e-mail.  If there were some generic or consistent or clear
approach to this, or these values could be used elsewhere in the kernel
or would tell anyone reading the code a lot about the functionality,
api, etc. by introducing the defines or adding comments, you know I'm
the first to advocate this.

However, these two specific registers are super low-level thingys,
with fields and values defined in the spec, and are simply returning ID
registers that we don't even have an OS that checks for, afaict.
Therefore, it's not like you'll see, VARIANT_SHIFT, and go, oh,
therefore group-x interrrupts does FIQs (made-up stupid example), but
the only take away here is that, hmm, this is an ID register, I wonder
what the scheme is, let me look it up anyways.

My point about what IIDR is just that we have to draw the line
somewhere, and I actually was OK with the hard-coded value because this
is arcane and specific by the nature of the beast, and apparently the
other people who reviewed the GICD_IIDR code before was of some similar
state of mind.

The most helpful thing actually, would be to put a pointer in the
comment to the document where you can read this, and explain the
product id thingy.  But then again, if you can't lookup the IIDR bit
fields, then you have much bigger problems if you try to understand this
code :)

This is, by the way, getting a bit out hand.  I'll see what the story
behind the product id is tomorrow, and see if Marc wants to chip in
here, and then I will add as many defines for shifts and values as I can
possibly think of for these value for v2;)  Sound good?

PS: I have a cold.

-Christoffer
