From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Dec 2016 17:38:03 +0100
Subject: [PATCH v9 05/11] arm/arm64: vgic: Introduce VENG0 and VENG1
 fields to vmcr struct
In-Reply-To: <df037898-57d3-93d1-e59c-4055d0f6f0b0@redhat.com>
References: <1479906118-15832-1-git-send-email-vijay.kilari@gmail.com>
 <1479906118-15832-6-git-send-email-vijay.kilari@gmail.com>
 <20161128142836.GE18170@cbox>
 <ace0aa83-aa6e-ca64-8edf-fcd2dd07585e@redhat.com>
 <20161208122115.GG4816@cbox>
 <df037898-57d3-93d1-e59c-4055d0f6f0b0@redhat.com>
Message-ID: <20161211163803.GC6352@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 01:50:43PM +0100, Auger Eric wrote:
> Hi Christoffer,
> 
> On 08/12/2016 13:21, Christoffer Dall wrote:
> > On Thu, Dec 08, 2016 at 12:52:39PM +0100, Auger Eric wrote:
> >> Hi Vijay,
> >>
> >> On 28/11/2016 15:28, Christoffer Dall wrote:
> >>> On Wed, Nov 23, 2016 at 06:31:52PM +0530, vijay.kilari at gmail.com wrote:
> >>>> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> >>>>
> >>>> ICC_VMCR_EL2 supports virtual access to ICC_IGRPEN1_EL1.Enable
> >>>> and ICC_IGRPEN0_EL1.Enable fields. Add grpen0 and grpen1 member
> >>>> variables to struct vmcr to support read and write of these fields.
> >>>>
> >>>> Also refactor vgic_set_vmcr and vgic_get_vmcr() code.
> >>>> Drop ICH_VMCR_CTLR_SHIFT and ICH_VMCR_CTLR_MASK macros and instead
> >>>> use ICH_VMCR_EOI* and ICH_VMCR_CBPR* macros
> >>>> .
> >>>> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> >>>> ---
> >>>>  include/linux/irqchip/arm-gic-v3.h |  2 --
> >>>>  virt/kvm/arm/vgic/vgic-mmio-v2.c   | 16 ----------------
> >>>>  virt/kvm/arm/vgic/vgic-mmio.c      | 16 ++++++++++++++++
> >>>>  virt/kvm/arm/vgic/vgic-v3.c        | 22 ++++++++++++++++++++--
> >>>>  virt/kvm/arm/vgic/vgic.h           |  5 +++++
> >>>>  5 files changed, 41 insertions(+), 20 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> >>>> index b4f8287..406fc3e 100644
> >>>> --- a/include/linux/irqchip/arm-gic-v3.h
> >>>> +++ b/include/linux/irqchip/arm-gic-v3.h
> >>>> @@ -404,8 +404,6 @@
> >>>>  #define ICH_HCR_EN			(1 << 0)
> >>>>  #define ICH_HCR_UIE			(1 << 1)
> >>>>  
> >>>> -#define ICH_VMCR_CTLR_SHIFT		0
> >>>> -#define ICH_VMCR_CTLR_MASK		(0x21f << ICH_VMCR_CTLR_SHIFT)
> >>>>  #define ICH_VMCR_CBPR_SHIFT		4
> >>>>  #define ICH_VMCR_CBPR_MASK		(1 << ICH_VMCR_CBPR_SHIFT)
> >>>>  #define ICH_VMCR_EOIM_SHIFT		9
> >>>> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> >>>> index 2cb04b7..ad353b5 100644
> >>>> --- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
> >>>> +++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> >>>> @@ -212,22 +212,6 @@ static void vgic_mmio_write_sgipends(struct kvm_vcpu *vcpu,
> >>>>  	}
> >>>>  }
> >>>>  
> >>>> -static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
> >>>> -{
> >>>> -	if (kvm_vgic_global_state.type == VGIC_V2)
> >>>> -		vgic_v2_set_vmcr(vcpu, vmcr);
> >>>> -	else
> >>>> -		vgic_v3_set_vmcr(vcpu, vmcr);
> >>>> -}
> >>>> -
> >>>> -static void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
> >>>> -{
> >>>> -	if (kvm_vgic_global_state.type == VGIC_V2)
> >>>> -		vgic_v2_get_vmcr(vcpu, vmcr);
> >>>> -	else
> >>>> -		vgic_v3_get_vmcr(vcpu, vmcr);
> >>>> -}
> >>>> -
> >>>>  #define GICC_ARCH_VERSION_V2	0x2
> >>>>  
> >>>>  /* These are for userland accesses only, there is no guest-facing emulation. */
> >>>> diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
> >>>> index 0d1bc98..f81e0e5 100644
> >>>> --- a/virt/kvm/arm/vgic/vgic-mmio.c
> >>>> +++ b/virt/kvm/arm/vgic/vgic-mmio.c
> >>>> @@ -416,6 +416,22 @@ int vgic_validate_mmio_region_addr(struct kvm_device *dev,
> >>>>  	return -ENXIO;
> >>>>  }
> >>>>  
> >>>> +void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
> >>>> +{
> >>>> +	if (kvm_vgic_global_state.type == VGIC_V2)
> >>>> +		vgic_v2_set_vmcr(vcpu, vmcr);
> >>>> +	else
> >>>> +		vgic_v3_set_vmcr(vcpu, vmcr);
> >>>> +}
> >>>> +
> >>>> +void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
> >>>> +{
> >>>> +	if (kvm_vgic_global_state.type == VGIC_V2)
> >>>> +		vgic_v2_get_vmcr(vcpu, vmcr);
> >>>> +	else
> >>>> +		vgic_v3_get_vmcr(vcpu, vmcr);
> >>>> +}
> >>>> +
> >>>>  /*
> >>>>   * kvm_mmio_read_buf() returns a value in a format where it can be converted
> >>>>   * to a byte array and be directly observed as the guest wanted it to appear
> >>>> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> >>>> index 9f0dae3..a3ff04b 100644
> >>>> --- a/virt/kvm/arm/vgic/vgic-v3.c
> >>>> +++ b/virt/kvm/arm/vgic/vgic-v3.c
> >>>> @@ -175,10 +175,19 @@ void vgic_v3_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
> >>>>  {
> >>>>  	u32 vmcr;
> >>>>  
> >>>> -	vmcr  = (vmcrp->ctlr << ICH_VMCR_CTLR_SHIFT) & ICH_VMCR_CTLR_MASK;
> >>>> +	/*
> >>>> +	 * Ignore the FIQen bit, because GIC emulation always implies
> >>>> +	 * SRE=1 which means the vFIQEn bit is also RES1.
> >>>> +	 */
> >>>> +	vmcr = (vmcrp->ctlr & ICC_CTLR_EL1_EOImode_MASK) >>
> >>>> +		ICC_CTLR_EL1_EOImode_SHIFT;
> >>>> +	vmcr = (vmcr << ICH_VMCR_EOIM_SHIFT) & ICH_VMCR_EOIM_MASK;
> > 
> >> I am not able to understand why we use ICC_CTLR _*macros here? Please
> >> could you explain it to me? Besides if we want to ignore the FIQen bit
> >> can't we change the ICH_VMCR_CTLR_MASK value?
> >>
> > This first statement is setting the vmcr to the ctlr's bit[1], but
> > placed in bit[0], and then the next statement is moving that bit value
> > to the corresponding place in the vmcr.  I think this is correct
> > (although a little opaque).
> Yes the question was more about the semantic of the vmcrp->ctlr field. I
> thought it was supposed to store ICH_VMCR_EL2 ctrl bits as they are and
> not with a different layout.

my understanding is that vmcrp->ctlr is a representation of the
GICC_CTLR field and its bit layout (based on the existin v2 code, unless
I misread it) and the vmcr is the vmcr field.

I don't care much either way, as long as it's clear what the semantics
are.  One problem with storing parts of the VMCR in the vmcrp->ctlr
field is that I don't think there's an architectural definition of the
concept 'ICH_VMCR_EL2 ctrl bits'.

Thanks,
-Christoffer
