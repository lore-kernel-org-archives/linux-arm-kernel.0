From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 30 Nov 2012 01:13:58 -0500
Subject: [PATCH v4 07/14] KVM: ARM: Inject IRQs and FIQs from userspace
In-Reply-To: <20121119162122.GI3205@mudshark.cambridge.arm.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154259.2836.49857.stgit@chazy-air>
 <20121119145546.GZ3205@mudshark.cambridge.arm.com>
 <CANM98qJmkZZ2H+y8sdxBoT6WRgzcFSmKkTPWQnONDhezx5GEQQ@mail.gmail.com>
 <20121119152629.GH3205@mudshark.cambridge.arm.com>
 <CANM98q+ts0s1DJO8CxjSDorh1wztjKKU5WdkoAGeWRrSUNi9DA@mail.gmail.com>
 <20121119162122.GI3205@mudshark.cambridge.arm.com>
Message-ID: <CANM98q+vZbtJ5-xsfbRhpd8QZt+Pb5-Oh2_ujhtH6PJo+PmRkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 11:21 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Nov 19, 2012 at 04:09:06PM +0000, Christoffer Dall wrote:
>> On Mon, Nov 19, 2012 at 10:26 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Mon, Nov 19, 2012 at 03:04:38PM +0000, Christoffer Dall wrote:
>> In all seriousness, I will unite myself with an alcoholic beverage one
>> of these evenings and try to see what I can do about it, maybe split
>> it up somehow, I'll give it a shot.
>
> So this might be to do with the way you've split up the patches (likely I'll
> have similar complaints against the vGIC code, but at least it will make
> sense there!)...
>
>> >> >> +int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level)
>> >> >> +{
>> >> >> +       u32 irq = irq_level->irq;
>> >> >> +       unsigned int irq_type, vcpu_idx, irq_num;
>> >> >> +       int nrcpus = atomic_read(&kvm->online_vcpus);
>> >> >> +       struct kvm_vcpu *vcpu = NULL;
>> >> >> +       bool level = irq_level->level;
>> >> >> +
>> >> >> +       irq_type = (irq >> KVM_ARM_IRQ_TYPE_SHIFT) & KVM_ARM_IRQ_TYPE_MASK;
>> >> >> +       vcpu_idx = (irq >> KVM_ARM_IRQ_VCPU_SHIFT) & KVM_ARM_IRQ_VCPU_MASK;
>> >> >> +       irq_num = (irq >> KVM_ARM_IRQ_NUM_SHIFT) & KVM_ARM_IRQ_NUM_MASK;
>> >> >> +
>> >> >> +       trace_kvm_irq_line(irq_type, vcpu_idx, irq_num, irq_level->level);
>> >> >> +
>> >> >> +       if (irq_type == KVM_ARM_IRQ_TYPE_CPU ||
>> >> >> +           irq_type == KVM_ARM_IRQ_TYPE_PPI) {
>> >> >> +               if (vcpu_idx >= nrcpus)
>> >> >> +                       return -EINVAL;
>> >> >> +
>> >> >> +               vcpu = kvm_get_vcpu(kvm, vcpu_idx);
>> >> >> +               if (!vcpu)
>> >> >> +                       return -EINVAL;
>> >> >> +       }
>> >> >> +
>> >> >> +       switch (irq_type) {
>> >> >> +       case KVM_ARM_IRQ_TYPE_CPU:
>> >> >> +               if (irq_num > KVM_ARM_IRQ_CPU_FIQ)
>> >> >> +                       return -EINVAL;
>> >> >> +
>> >> >> +               return vcpu_interrupt_line(vcpu, irq_num, level);
>> >> >> +       }
>> >> >> +
>> >> >> +       return -EINVAL;
>> >> >> +}
>
> This obviously doesn't handle PPIs, which is where the confusion lies. You
> can just as easily write it as:
>
> int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level)
> {
>         u32 irq = irq_level->irq;
>         unsigned int irq_type, vcpu_idx, irq_num;
>         int nrcpus = atomic_read(&kvm->online_vcpus);
>         struct kvm_vcpu *vcpu = NULL;
>         bool level = irq_level->level;
>
>         irq_type = (irq >> KVM_ARM_IRQ_TYPE_SHIFT) & KVM_ARM_IRQ_TYPE_MASK;
>         vcpu_idx = (irq >> KVM_ARM_IRQ_VCPU_SHIFT) & KVM_ARM_IRQ_VCPU_MASK;
>         irq_num = (irq >> KVM_ARM_IRQ_NUM_SHIFT) & KVM_ARM_IRQ_NUM_MASK;
>
>         trace_kvm_irq_line(irq_type, vcpu_idx, irq_num, irq_level->level);
>
>         if (irq_type != KVM_ARM_IRQ_TYPE_CPU)
>                 return -EINVAL;
>
>         if (vcpu_idx >= nrcpus)
>                 return -EINVAL;
>
>         vcpu = kvm_get_vcpu(kvm, vcpu_idx);
>         if (!vcpu)
>                 return -EINVAL;
>
>         if (irq_num > KVM_ARM_IRQ_CPU_FIQ)
>                 return -EINVAL;
>
>         return vcpu_interrupt_line(vcpu, irq_num, level);
> }
>
> Then add all the IRQ complexity in a later patch!
>
that was pretty constructive, I did just that. Thanks.
