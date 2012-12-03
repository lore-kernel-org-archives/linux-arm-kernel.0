From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 03 Dec 2012 19:22:45 +0000
Subject: [PATCH v4 09/13] ARM: KVM: VGIC interrupt injection
In-Reply-To: <CANM98qJbU=Nfs86nmwRBtw8m-sL-j3NVXJ1-+pZGQ3_Ax8ZoVQ@mail.gmail.com>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154518.3061.69353.stgit@chazy-air>
 <20121203132543.GE20074@mudshark.cambridge.arm.com>
 <50BCB55B.3070000@arm.com>
 <CANM98qJbU=Nfs86nmwRBtw8m-sL-j3NVXJ1-+pZGQ3_Ax8ZoVQ@mail.gmail.com>
Message-ID: <50BCFC05.107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/12 19:13, Christoffer Dall wrote:
> On Mon, Dec 3, 2012 at 9:21 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 03/12/12 13:25, Will Deacon wrote:
>>> On Sat, Nov 10, 2012 at 03:45:18PM +0000, Christoffer Dall wrote:
>>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>>>
>>>> Plug the interrupt injection code. Interrupts can now be generated
>>>> from user space.
>>>>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>>>> ---
>>>>  arch/arm/include/asm/kvm_vgic.h |    8 +++
>>>>  arch/arm/kvm/arm.c              |   29 +++++++++++++
>>>>  arch/arm/kvm/vgic.c             |   90 +++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 127 insertions(+)
>>>>
>>>> diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
>>>> index 7229324..6e3d303 100644
>>>> --- a/arch/arm/include/asm/kvm_vgic.h
>>>> +++ b/arch/arm/include/asm/kvm_vgic.h
>>>> @@ -241,6 +241,8 @@ struct kvm_exit_mmio;
>>>>  int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr);
>>>>  void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu);
>>>>  void kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu);
>>>> +int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
>>>> +                    bool level);
>>>>  int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
>>>>  bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>>                    struct kvm_exit_mmio *mmio);
>>>> @@ -271,6 +273,12 @@ static inline void kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu) {}
>>>>  static inline void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu) {}
>>>>  static inline void kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu) {}
>>>>
>>>> +static inline int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid,
>>>> +                                  const struct kvm_irq_level *irq)
>>>> +{
>>>> +    return 0;
>>>> +}
>>>> +
>>>>  static inline int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
>>>>  {
>>>>      return 0;
>>>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>>>> index 3ac1aab..f43da01 100644
>>>> --- a/arch/arm/kvm/arm.c
>>>> +++ b/arch/arm/kvm/arm.c
>>>> @@ -764,10 +764,31 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level)
>>>>
>>>>      switch (irq_type) {
>>>>      case KVM_ARM_IRQ_TYPE_CPU:
>>>> +            if (irqchip_in_kernel(kvm))
>>>> +                    return -ENXIO;
>>>> +
>>>>              if (irq_num > KVM_ARM_IRQ_CPU_FIQ)
>>>>                      return -EINVAL;
>>>>
>>>>              return vcpu_interrupt_line(vcpu, irq_num, level);
>>>> +#ifdef CONFIG_KVM_ARM_VGIC
>>>> +    case KVM_ARM_IRQ_TYPE_PPI:
>>>> +            if (!irqchip_in_kernel(kvm))
>>>> +                    return -ENXIO;
>>>> +
>>>> +            if (irq_num < 16 || irq_num > 31)
>>>> +                    return -EINVAL;
>>>
>>> It's our favourite two numbers again! :)
>>
>> I already fixed a number of them. Probably missed this one though.
>>
>>>> +
>>>> +            return kvm_vgic_inject_irq(kvm, vcpu->vcpu_id, irq_num, level);
>>>> +    case KVM_ARM_IRQ_TYPE_SPI:
>>>> +            if (!irqchip_in_kernel(kvm))
>>>> +                    return -ENXIO;
>>>> +
>>>> +            if (irq_num < 32 || irq_num > KVM_ARM_IRQ_GIC_MAX)
>>>> +                    return -EINVAL;
>>>> +
>>>> +            return kvm_vgic_inject_irq(kvm, 0, irq_num, level);
>>>> +#endif
>>>>      }
>>>>
>>>>      return -EINVAL;
>>>> @@ -849,6 +870,14 @@ long kvm_arch_vm_ioctl(struct file *filp,
>>>>      void __user *argp = (void __user *)arg;
>>>>
>>>>      switch (ioctl) {
>>>> +#ifdef CONFIG_KVM_ARM_VGIC
>>>> +    case KVM_CREATE_IRQCHIP: {
>>>> +            if (vgic_present)
>>>> +                    return kvm_vgic_create(kvm);
>>>> +            else
>>>> +                    return -EINVAL;
>>>
>>> ENXIO? At least, that's what you use when setting the GIC addresses.
>>
>> -EINVAL seems to be one of the values other archs are using. -ENXIO is
>> not one of them for KVM_CREATE_IRQCHIP. Doesn't mean they are right, but
>> for the sake of keeping userspace happy, I'm not really inclined to
>> change this.
>>
> 
> We don't have user space code relying on this, and EINVAL is
> misleading, so let's use ENXIO to be consistent with
> SET_DEVICE_ADDRESS. No error values are specified in the API docs, so
> we should use the most appropriate one.
> 
> You fix?

Yes, I'll fix it as part the whole vgic series.

	M.
-- 
Jazz is not dead. It just smells funny...
