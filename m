From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 14 May 2014 17:28:27 +0100
Subject: [PATCH v3 11/19] KVM: ARM: vgic: abstract VMCR access
In-Reply-To: <87ppjhh8vf.fsf@approximate.cambridge.arm.com>
References: <1397655591-2761-1-git-send-email-marc.zyngier@arm.com>
 <1397655591-2761-12-git-send-email-marc.zyngier@arm.com>
 <20140509140633.GL3362@lvm>
 <87ppjhh8vf.fsf@approximate.cambridge.arm.com>
Message-ID: <CAMJs5B9VJ8bx37uAM_PpL2v=6yfFoJrk12dXKcPNiERoUYpohg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 May 2014 18:43, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Fri, May 09 2014 at  3:06:33 pm BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>> On Wed, Apr 16, 2014 at 02:39:43PM +0100, Marc Zyngier wrote:
>>> Instead of directly messing with with the GICH_VMCR bits for the CPU
>>> interface save/restore code, add accessors that encode/decode the
>>> entire set of registers exposed by VMCR.
>>>
>>> Not the most efficient thing, but given that this code is only used
>>> by the save/restore code, performance is far from being critical.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  include/kvm/arm_vgic.h |  9 +++++++
>>>  virt/kvm/arm/vgic.c    | 69 ++++++++++++++++++++++++++++++++++++++------------
>>>  2 files changed, 62 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
>>> index 831b9f5..0017253 100644
>>> --- a/include/kvm/arm_vgic.h
>>> +++ b/include/kvm/arm_vgic.h
>>> @@ -81,6 +81,13 @@ struct vgic_lr {
>>>      u8      state;
>>>  };
>>>
>>> +struct vgic_vmcr {
>>> +    u32     ctlr;
>>> +    u32     abpr;
>>> +    u32     bpr;
>>> +    u32     pmr;
>>> +};
>>> +
>>>  struct vgic_ops {
>>>      struct vgic_lr  (*get_lr)(const struct kvm_vcpu *, int);
>>>      void    (*set_lr)(struct kvm_vcpu *, int, struct vgic_lr);
>>> @@ -89,6 +96,8 @@ struct vgic_ops {
>>>      u32     (*get_interrupt_status)(const struct kvm_vcpu *vcpu);
>>>      void    (*set_underflow)(struct kvm_vcpu *vcpu);
>>>      void    (*clear_underflow)(struct kvm_vcpu *vcpu);
>>> +    void    (*get_vmcr)(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
>>> +    void    (*set_vmcr)(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
>>>  };
>>>
>>>  struct vgic_dist {
>>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>>> index 13dad1f..574ca47 100644
>>> --- a/virt/kvm/arm/vgic.c
>>> +++ b/virt/kvm/arm/vgic.c
>>> @@ -100,8 +100,10 @@ static void vgic_kick_vcpus(struct kvm *kvm);
>>>  static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
>>>  static struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr);
>>>  static void vgic_set_lr(struct kvm_vcpu *vcpu, int lr, struct vgic_lr lr_desc);
>>> -static u32 vgic_nr_lr;
>>> +static void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
>>> +static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
>>>
>>> +static u32 vgic_nr_lr;
>>>  static unsigned int vgic_maint_irq;
>>>
>>>  static u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
>>> @@ -1057,6 +1059,28 @@ static void vgic_v2_clear_underflow(struct kvm_vcpu *vcpu)
>>>      vcpu->arch.vgic_cpu.vgic_v2.vgic_hcr &= ~GICH_HCR_UIE;
>>>  }
>>>
>>> +static void vgic_v2_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
>>> +{
>>> +    u32 vmcr = vcpu->arch.vgic_cpu.vgic_v2.vgic_vmcr;
>>> +
>>> +    vmcrp->ctlr = (vmcr & GICH_VMCR_CTRL_MASK) >> GICH_VMCR_CTRL_SHIFT;
>>> +    vmcrp->abpr = (vmcr & GICH_VMCR_ALIAS_BINPOINT_MASK) >> GICH_VMCR_ALIAS_BINPOINT_SHIFT;
>>> +    vmcrp->bpr  = (vmcr & GICH_VMCR_BINPOINT_MASK) >> GICH_VMCR_BINPOINT_SHIFT;
>>> +    vmcrp->pmr  = (vmcr & GICH_VMCR_PRIMASK_MASK) >> GICH_VMCR_PRIMASK_SHIFT;
>>> +}
>>> +
>>> +static void vgic_v2_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
>>> +{
>>> +    u32 vmcr;
>>> +
>>> +    vmcr  = (vmcrp->ctlr << GICH_VMCR_CTRL_SHIFT) & GICH_VMCR_CTRL_MASK;
>>> +    vmcr |= (vmcrp->abpr << GICH_VMCR_ALIAS_BINPOINT_SHIFT) & GICH_VMCR_ALIAS_BINPOINT_MASK;
>>> +    vmcr |= (vmcrp->bpr << GICH_VMCR_BINPOINT_SHIFT) & GICH_VMCR_BINPOINT_MASK;
>>> +    vmcr |= (vmcrp->pmr << GICH_VMCR_PRIMASK_SHIFT) & GICH_VMCR_PRIMASK_MASK;
>>> +
>>> +    vcpu->arch.vgic_cpu.vgic_v2.vgic_vmcr = vmcr;
>>
>> did you forget to add this field to the vgic_v2 struct as part of this patch?
>
> I don't think so, I believe it appears in patch #5.
>
right, not sure what happened here.
